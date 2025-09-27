---
name: smart-review
description: "智能分析问题领域，推荐最合适的专家角色"
---

# Smart Review 命令

智能分析当前问题或代码，自动推荐最合适的专家角色：

**识别逻辑**：
- 文件类型自动匹配 (`.tsx` → Frontend, `Dockerfile` → Architect)
- 安全敏感关键词检测 (`auth/`, `jwt`, `.env`)
- 性能相关模式识别 (`performance/`, 慢查询日志)
- 错误日志分析 (堆栈、崩溃、告警)

**推荐策略**：
1. 单一领域问题 → `/role <name>`
2. 多维度复杂问题 → `/multi-role`
3. 冲突需要权衡 → `/role-debate`

**优先级**：安全 > 致命错误 > 架构 > 性能 > 前端/移动 > QA

分析完成后提供具体的命令建议和执行理由。
