---
name: role
description: "切换到指定专家角色，以专业视角执行分析"
---

# Role 命令

切换至专业角色模式，使用 Task 工具调用对应的专家子代理：

**可用角色**：
- `security` - 安全审计专家 (OWASP、漏洞分析、合规检查)
- `performance` - 性能优化专家 (瓶颈分析、指标评估)
- `analyzer` - 根因分析专家 (5 Whys、系统思维)
- `frontend` - 前端专家 (UI/UX、可访问性、组件化)
- `mobile` - 移动端专家 (iOS/Android、跨平台)
- `architect` - 架构师 (系统设计、技术选型)
- `reviewer` - 代码审查专家 (Clean Code、可维护性)
- `qa` - 质量保证专家 (测试策略、自动化)

**使用方式**：
```bash
/role security    # 切换到安全专家
/role default     # 返回默认模式
```

配合 `/smart-review` 自动选择合适角色，或使用 `/multi-role` 进行多角色分析。
