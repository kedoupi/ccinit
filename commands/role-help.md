---
name: role-help
description: "提供专家角色选择指南和情境推荐"
---

# Role Help 命令

角色选择助手，帮助快速找到合适的专家角色：

**功能模式**：
- 查看所有角色摘要
- 根据场景推荐角色
- 对比角色差异和适用边界

**角色概览**：
- `security` - 安全审计、合规检查
- `architect` - 架构设计、技术选型
- `performance` - 性能优化、瓶颈分析
- `analyzer` - 根因分析、故障排查
- `frontend` - UI/UX、可访问性
- `mobile` - 移动端、跨平台
- `reviewer` - 代码审查、质量控制
- `qa` - 测试策略、自动化

**使用方式**：
```bash
/role-help                        # 角色总览
/role-help "API 安全问题"         # 场景推荐
/role-help compare frontend,mobile # 角色对比
```

配合 `/smart-review` 使用可自动匹配最佳角色。
