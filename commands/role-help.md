## Role Help

### 核心作用
当不确定使用哪个专家角色时，提供情境化的选择指南、角色对比与组合建议，帮助快速进入正确的分析模式。

### 快速用法
```bash
/role-help                              # 查看所有角色摘要
/role-help "API 安全担忧"                # 根据场景推荐角色
/role-help compare frontend,mobile      # 对比两个角色的差异
```

### 角色索引
| 角色 | 适用场景 | 常用命令 |
| ---- | -------- | -------- |
| `security` | 登录/权限、安全扫描、合规、LLM 安全 | `/role security`
| `architect` | 架构评估、技术选型、限界上下文、技术债 | `/role architect`
| `performance` | 系统/数据库/前端性能优化 | `/role performance`
| `analyzer` | 根因分析、事故复盘、日志挖掘 | `/role analyzer`
| `frontend` | UI/UX、可访问性、设计系统 | `/role frontend`
| `mobile` | iOS/Android、跨端架构、上架合规 | `/role mobile`
| `reviewer` | 代码审查、风格一致性、可维护性 | `/role reviewer`
| `qa` | 测试策略、覆盖率、自动化、质量门禁 | `/role qa`

### 情境推荐
- **安全相关**：身份认证、敏感数据、合规 → `security`
- **架构设计**：微服务拆分、限界上下文、技术选型 → `architect`
- **性能瓶颈**：响应慢、N+1、资源过载 → `performance`
- **复杂故障**：日志排查、异常分析、跨模块影响 → `analyzer`
- **前端体验**：可用性、响应式、无障碍要求 → `frontend`
- **移动端**：触控体验、离线策略、商店审核 → `mobile`
- **代码质量**：PR 审查、重构建议、团队规范 → `reviewer`
- **测试质量**：测试金字塔、CI 稳定性、Flaky → `qa`

### 组合与对比
- **并行分析**：`/multi-role security,performance`（安全×性能）、`/multi-role frontend,mobile`（跨端体验）。
- **立场辩论**：`/role-debate architect,security,performance` 适合有明显取舍的问题。
- **角色对比**：`/role-help compare frontend,mobile` 输出优势、适用边界、协作方式。

### 使用建议
- 提前提供上下文（目录结构、日志、需求背景），提升推荐准确度。
- 如果需求跨多个领域，可先使用 `/smart-review` 再结合 `/role-help` 选择角色。
- 角色建议不是强制，若结果不符合预期，可补充信息重新执行。
