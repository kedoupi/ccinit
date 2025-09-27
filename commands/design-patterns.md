## Design Patterns

### 核心作用
分析代码中现有设计模式与 SOLID 原则的落实情况，推荐合适的模式或重构方案，并提醒常见反模式和技术债。

### 适用场景
- 评估项目是否符合既定架构、分层规范
- 规划重构/模块化拆分，想借助经典模式提升结构
- 检查是否存在 God Object、循环依赖、职责混乱等问题

### 快速用法
```bash
/design-patterns                          # 综合建议（默认 recommend）
/design-patterns --analyze                # 仅分析已使用模式
/design-patterns src/services/user.ts     # 针对特定文件
/design-patterns --solid                  # 检查 SOLID 违规
/design-patterns --anti-patterns          # 寻找反模式
```

### 可选参数
- `--suggest`：推荐适用模式（默认启用）
- `--refactor`：基于模式输出重构步骤与示例代码
- `--impact-analysis <pattern>`：评估引入某模式的影响
- `--combine --context "API with caching"`：推荐组合模式

### 分析维度
1. **创建设计模式**：Factory、Builder、Singleton、Prototype 等。
2. **结构型模式**：Adapter、Decorator、Facade、Proxy、Composite 等。
3. **行为型模式**：Strategy、Observer、Command、State、Iterator 等。
4. **SOLID 原则**：单一职责、开放封闭、里氏替换、接口隔离、依赖倒置。
5. **反模式警报**：God Object、Spaghetti Code、Copy-Paste、Magic Number、Callback Hell 等。

### 输出结构
```
设计模式分析
━━━━━━━━━━━━━━━━━━━━━━
已识别模式
- Observer：src/events/** （12 处）
- Factory：src/services/factory.ts

推荐模式
- [HIGH] Repository → 位置/原因/示例
- [MED] Strategy → ...

SOLID 违规
- S：UserService 同时承担认证与授权
- D：EmailService 依赖具体实现

反模式警告
- God Object：src/core/Application.ts 2000+ 行

建议与下一步
1. ...
2. ...
```

### 示例：策略模式重构流程
1. 找出条件分支、算法切换等策略点。
2. 定义 `Strategy` 接口，拆分不同实现。
3. 在调用方注入抽象，配合 Factory/DI 管理实例。
4. 补充测试与文档，说明扩展方式。

### 与 Claude 协作
- 提供相关文件后执行 `/design-patterns --solid`，让 Claude 指出违规与受影响模块。
- 使用 `--refactor` 获取示例代码，再手动整合到项目。
- 结合 `/plan`、`/task` 制定分阶段重构、技术债清理计划。

### 使用建议
- 模式用于解决实际问题，而非“为了模式而模式”。
- 先验证重构收益与风险，必要时准备回滚方案。
- 新模式落地后要同步 ADR、文档与培训材料。
