#!/bin/bash
set -euo pipefail

# 中文与半角英数字之间插入半角空格

# 获取文件路径
if [ -n "${1:-}" ]; then
  file_path="$1"
else
  file_path=$(jq -r '.tool_input.file_path // empty' <<<"${CLAUDE_TOOL_INPUT:-$(cat)}")
fi

# 基本检查
[ -z "$file_path" ] || [ ! -f "$file_path" ] || [ ! -r "$file_path" ] || [ ! -w "$file_path" ] && exit 0

# 排除列表
EXCLUSIONS_FILE="$(dirname "${BASH_SOURCE[0]}")/zh-space-exclusions.json"

# 临时文件处理
temp_file=$(mktemp)

# 读取排除列表
exclusions=""
if [ -f "$EXCLUSIONS_FILE" ]; then
  exclusions=$(jq -r '.exclusions[]' "$EXCLUSIONS_FILE" 2>/dev/null | tr '\n' '|' | sed 's/|$//')
fi

# 应用中文空格格式化
sed -E '
  # 中文后接英文数字，添加空格
  s/([一-龯])([A-Za-z0-9])/\1 \2/g
  # 英文数字后接中文，添加空格
  s/([A-Za-z0-9])([一-龯])/\1 \2/g
  # 中文后接左括号，添加空格
  s/([一-龯])(\()/\1 \2/g
  # 右括号后接中文，添加空格
  s/(\))([一-龯])/\1 \2/g
' "$file_path" > "$temp_file"

# 如果有变化则覆盖原文件
if ! cmp -s "$file_path" "$temp_file"; then
  cp "$temp_file" "$file_path"
fi

rm -f "$temp_file"