---
name: multi-role
description: "并行调度多个专家角色，整合不同视角的分析结果"
---

# Multi Role 命令

同时调用多个专家角色，从不同角度分析同一目标：

**工作流程**：
1. **并行分析** - 各角色独立输出发现和建议
2. **冲突梳理** - 识别共识、矛盾和依赖关系
3. **综合报告** - 整合优先级和实施路线

**常见组合**：
- `security,performance` - 安全与性能权衡
- `frontend,mobile` - 跨端体验优化
- `architect,qa` - 架构设计与测试策略

**使用方式**：
```bash
/multi-role security,performance    # 基础模式
/multi-role frontend,mobile --agent # 子代理模式
```

使用 Task 工具并行调用对应的专家子代理，最后整合成综合分析报告。
