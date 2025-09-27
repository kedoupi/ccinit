## Explain Code

### 核心作用
以读者友好的方式解构代码：说明执行流程、关键数据结构、设计意图及潜在问题，便于快速理解陌生模块或复杂逻辑。

### 适用场景
- 接手新模块，需要全局或逐行说明
- 学习语言特性（所有权、并发、异步流程等）
- 评审时为他人补充注释、技术背景、风险提示

### 快速用法
```bash
cat src/complex_function.py | /explain-code
```
或
```bash
cat async_handler.ts
"请逐步解释该异步流程，指出并发/异常处理细节"
```

### 推荐提示语
- "Explain this file line by line for a beginner"
- "Summarize the control flow and key data structures"
- "Identify performance or security concerns in this snippet"
- "Describe the design pattern being used and why"

### 输出结构（示例）
```
代码理解报告
━━━━━━━━━━━━━━━━━━━━━━
概览
- 语言 / 框架 / 上下文
- 该模块负责的业务

执行流程
1. 初始化：...
2. 主逻辑：...
3. 清理与异常：...

关键概念
- 数据结构 / 状态机 / 并发模型
- 设计模式或架构约定

潜在风险与建议
- 性能 / 安全 / 可维护性问题
- 改进思路或示例
```

### 与 Claude 协作技巧
- 在解释请求前，用 `ls`、`tree`、`cat` 等命令提供必要上下文。
- 想深入特定主题（性能、安全、模式）时，直接在提示中给出子问题列表。
- 若需要图示，可要求 ASCII 流程图或状态图帮助理解。

### 注意事项
- 对较大的文件可先定位重点片段再请求解释，减少噪音。
- 解释结果仍需结合实际运行环境、依赖版本确认。
- 若涉及敏感信息，请先脱敏再分享代码。
