## Multi Role

### 核心作用
同时调度多个专家角色，从不同视角分析同一目标，并整合为一份综合报告，帮助快速识别协同机会、冲突点与优先级。

### 适用场景
- 复杂议题需要安全、性能、架构等多方评估
- 前后端、移动/桌面等跨界优化，需要统一路线
- 想比较不同角色的意见并整合行动计划

### 快速用法
```bash
/multi-role security,performance
"审查该 API 的风险与性能"

/multi-role frontend,mobile,performance --agent
"评估此页面在跨端体验与性能上的改进方案"
```

> `--agent` / `-a`：以子代理并行执行，适合大规模分析。必须紧跟角色列表，如 `/multi-role qa,architect --agent ...`。

### 工作流程
1. **并行分析**：每个角色独立出具结果（发现、评分、建议）。
2. **冲突梳理**：合并输出，指出共识、矛盾与依赖关系。
3. **综合报告**：给出优先级、实施路线、权衡说明。

### 报告结构（示例）
```
多角色综合分析：Security + Performance
━━━━━━━━━━━━━━━━━━━━━━
目标：/api/users

角色结论
- Security：...
- Performance：...

交叉观察
- 协同机会：...
- 潜在冲突：...

优先级建议
1. ...
2. ...

实施路线
Week 1: ...
Week 2: ...
```

### 常见组合
- **安全导向**：`security,architect`（认证设计）、`security,frontend`（登录页面）。
- **性能导向**：`performance,architect`（扩展性）、`performance,frontend`（加载速度）。
- **体验导向**：`frontend,mobile`（跨端 UI）、`frontend,performance`（体验与性能权衡）。

### 与 Claude 协作
- 先说明业务目标或提供相关文件，再执行 `/multi-role` 提升结论质量。
- 若结果存在冲突，可追加 `/role-debate` 深入讨论重点矛盾。
- 可结合 `/task`、`/plan` 将综合结论拆解为可执行任务。

### 注意事项
- 角色数量建议 2~3 个，过多会增加整合成本。
- 并行执行需要时间，请耐心等待或添加上下文缩小范围。
- 若涉及敏感数据，请确保输入已脱敏。
