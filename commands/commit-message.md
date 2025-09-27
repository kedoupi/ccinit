---
name: commit-message
description: "基于暂存改动生成符合规范的提交信息"
---

# Commit Message 命令

智能生成符合 Conventional Commits 规范的提交信息：

**生成流程**：
1. **分析改动** - 通过 `git diff --staged` 分析暂存变更
2. **检测规范** - 自动识别项目的提交信息格式
3. **生成建议** - 提供主要和备选的提交信息
4. **交互确认** - 用户选择或自定义提交信息

**支持格式**：
- Conventional Commits (`feat:`, `fix:`, `docs:`)
- 中文格式支持
- 破坏性变更检测 (`BREAKING CHANGE`)
- 自定义项目规范

**前置要求**：
- 使用 `git add` 暂存改动
- 项目根目录可访问 git 历史

使用 Bash 工具执行 `git commit` 相关命令。
