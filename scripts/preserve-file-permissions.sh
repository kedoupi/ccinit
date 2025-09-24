#!/bin/bash

# 调试日志
DEBUG_LOG="/tmp/claude_permissions_debug.log"

# 保存权限的临时文件
PERMISSIONS_CACHE="/tmp/claude_file_permissions.txt"

# 从标准输入读取 JSON
input_json=$(cat)

# 从 JSON 中提取必要信息
hook_type=$(echo "$input_json" | jq -r '.hook_event_name // ""')
tool_name=$(echo "$input_json" | jq -r '.tool_name // ""')
file_path=$(echo "$input_json" | jq -r '.tool_input.file_path // ""')

# 记录调试信息
echo "[$(date)] Hook: $hook_type, Tool: $tool_name, File: $file_path" >>"$DEBUG_LOG"

# 仅针对文件操作相关工具
case "$tool_name" in
Write | Edit | MultiEdit) ;;
*)
  # 直接通过，不做任何操作
  echo "$input_json"
  exit 0
  ;;
esac

# 如果文件路径为空则直接通过
if [ -z "$file_path" ]; then
  echo "$input_json"
  exit 0
fi

if [ "$hook_type" = "PreToolUse" ]; then
  # 如果文件存在，记录当前权限
  if [ -f "$file_path" ]; then
    # 获取权限（八进制格式）
    current_perms=$(stat -f "%OLp" "$file_path" 2>/dev/null || stat -c "%a" "$file_path" 2>/dev/null)
    if [ -n "$current_perms" ]; then
      # 保存文件路径和权限
      echo "${file_path}:${current_perms}" >>"$PERMISSIONS_CACHE"
      echo "Saved permissions for $file_path: $current_perms" >&2
      echo "[$(date)] PreToolUse: Saved $file_path with permissions $current_perms" >>"$DEBUG_LOG"
    fi
  fi

elif [ "$hook_type" = "PostToolUse" ]; then
  # 如果有保存的权限则恢复
  if [ -f "$PERMISSIONS_CACHE" ]; then
    # 搜索对应文件的权限
    saved_entry=$(grep "^${file_path}:" "$PERMISSIONS_CACHE" | tail -1)
    if [ -n "$saved_entry" ]; then
      saved_perms=$(echo "$saved_entry" | cut -d: -f2)
      if [ -n "$saved_perms" ] && [ -f "$file_path" ]; then
        chmod "$saved_perms" "$file_path" 2>/dev/null
        if [ $? -eq 0 ]; then
          echo "Restored permissions for $file_path: $saved_perms" >&2
          echo "[$(date)] PostToolUse: Restored $file_path to permissions $saved_perms" >>"$DEBUG_LOG"

          # 后台等待3秒后再次设置权限
          (
            sleep 3
            chmod "$saved_perms" "$file_path" 2>/dev/null
            if [ $? -eq 0 ]; then
              echo "[$(date)] PostToolUse: Re-restored $file_path to permissions $saved_perms (delayed 3s)" >>"$DEBUG_LOG"
            fi
          ) &

          # 从缓存中删除对应条目
          grep -v "^${file_path}:" "$PERMISSIONS_CACHE" >"${PERMISSIONS_CACHE}.tmp" || true
          mv "${PERMISSIONS_CACHE}.tmp" "$PERMISSIONS_CACHE" 2>/dev/null || true
        else
          echo "Failed to restore permissions for $file_path" >&2
        fi
      fi
    fi
  fi
fi

# 原样输出输入内容（无修改）
echo "$input_json"
