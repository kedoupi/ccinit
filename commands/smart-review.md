## Smart Review

### 核心作用
自动扫描指定文件或目录，判断当前问题所属领域，并推荐最合适的专家角色或协作模式（单角色、多角色、辩论），帮助你迅速进入正确的分析流程。

### 适用场景
- 不确定应该使用哪个角色处理当前任务
- 同时涉及安全、性能、架构等多个维度，需要策略建议
- 想要自动发现潜在风险并选择合适的工作流

### 快速用法
```bash
/smart-review                  # 分析当前目录
/smart-review <路径或关键词>   # 针对目标进行分析
```

### 推荐提示语
- "Suggest the best role for reviewing ..."
- "Scan this log and tell me which workflow to run"
- "Need advice on handling this architecture decision"

### 自动识别逻辑
- **文件类型**：`package.json`、`*.tsx`、`*.scss` → Frontend；`Dockerfile`、`*.yaml` → Architect；`*.test.*` → QA。
- **安全敏感**：`auth/`、`jwt`、`.env`、认证中间件等 → Security（可能与 Frontend/Architect 联动）。
- **性能相关**：`performance/`、慢查询日志、`webpack.config.js` → Performance。
- **移动端**：`*.swift`、`*.kt`、`react-native/` → Mobile；与 Web 组件同时出现时推荐 Mobile + Frontend。
- **错误日志**：堆栈、崩溃、性能告警 → Analyzer，必要时搭配 Performance 或 Security。

### 决策与建议
1. **优先级排序**：安全 > 致命错误 > 架构 > 性能 > 前端/移动 > QA。
2. 当涉及 3 个以上角色，或存在安全/性能拉锯、跨端设计问题时，优先推荐 `/role-debate`。
3. 针对单一领域问题，推荐 `/role <name>` 快速定位；多维问题提供 `/multi-role` 组合选项。

### 典型输出
```
Smart Review 建议
━━━━━━━━━━━━━━━━━━━━━━
检测结果：身份认证相关、包含安全与前端改动
推荐方案：
1. /role security   （默认）
2. /multi-role security,frontend
3. /role-debate security,frontend

理由：涉及登录表单与 JWT 校验，需要平衡安全与 UX。
是否自动执行推荐项？ [y] 是 / [n] 否 / [s] 选择其它
```

### 使用指南
- 接到建议后可直接输入推荐命令，或要求查看更多上下文再决定。
- 如建议不匹配，可输入补充信息再次执行 `/smart-review` 获得新的推荐。
- 对安全、合规类建议务必由专责角色复核后再继续下一步。

### 注意事项
- 建议仅供参考，最终决策仍由你确认。
- 辩论模式适合复杂折中场景，单角色适合快速处理。
- 输出中若包含敏感文件路径，请注意权限控制。
