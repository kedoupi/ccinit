---
name: pr-create
description: "分析分支改动，自动生成符合规范的Pull Request"
---

# PR Create 命令

智能创建 Pull Request，自动分析改动并生成规范描述：

**核心功能**：
1. **分析改动** - 通过 git diff 分析代码变更
2. **生成描述** - 按模板自动填写 PR 描述
3. **智能标签** - 根据文件类型和关键词匹配标签
4. **规范创建** - 默认创建 Draft PR，通过验证后转为 Ready

**标签策略**：
- 文档改动 → `documentation`
- 测试相关 → `test`
- Bug 修复 → `bug`, `fix`
- 新功能 → `feature`, `enhancement`
- 性能优化 → `performance`
- 安全相关 → `security`

**前置要求**：
- 分支已推送到远程仓库
- 存在 PR 模板文件
- 具备仓库的 PR 创建权限

使用 Bash 工具执行 `gh pr create` 相关命令。
