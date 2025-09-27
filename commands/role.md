## Role

### 核心作用
切换到指定专家角色，以专业视角执行分析或行动。每个角色都有独立的检查清单、输出模板与约束，可针对不同问题快速进入状态。

### 快速用法
```bash
/role <角色名>
/role security
/role architect --agent    # 大型分析时以子代理模式运行
/role default              # 返回默认模式
```

> `--agent`/`-a` 会启用更积极的自动委派，适合长流程分析。

### 角色总览
| 角色 | 领域 | 关键词 |
| ---- | ---- | ------ |
| `security` | 安全审计、OWASP、攻防评估、LLM 安全 | 漏洞、注入、权限、合规 |
| `performance` | 性能优化、指标分析、ROI 评估 | Core Web Vitals、N+1、Profiling |
| `analyzer` | 根因分析、系统思维、复盘 | 5 Whys、证据优先、事件追踪 |
| `frontend` | UI/UX、可访问性、设计系统 | WCAG、组件化、用户研究 |
| `mobile` | iOS/Android、跨平台策略 | HIG、Material、离线、审核 |
| `architect` | 架构设计、技术选型、演进路线 | DDD、限界上下文、技术债 |
| `reviewer` | 代码审查、可维护性评估 | Clean Code、PR Review |
| `qa` | 测试策略、自动化、质量门禁 | Test Pyramid、Flaky、CI |

### 示例
```bash
/role security
"请审查 src/auth/ 中潜在的安全问题"

/role performance
"分析该接口的性能瓶颈并提供验证方案"

/role qa
"为新功能设计测试策略并指出缺失的覆盖"
```

### 与其它命令搭配
- 不确定角色时先 `/role-help` 或 `/smart-review` 获取建议。
- 多维度分析使用 `/multi-role` 并在必要时 `/role-debate` 深入权衡。
- 角色分析完成后，可结合 `/plan`、`/task` 输出执行计划。

### 使用建议
- 提前提供上下文（文件路径、日志、文档）提高分析质量。
- 角色切换后若需回到常规对话，执行 `/role default`。
- 角色文档位于 `agents/roles/*.md`，可按需自定义或扩展。
