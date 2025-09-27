## Refactor

### 核心作用
在保持行为不变的前提下，清理代码异味、落实 SOLID 原则，逐步提升可维护性、可测试性与可扩展性。

### 适用场景
- 发现长函数、重复代码、巨石类、复杂条件等典型 Code Smell
- 需要为后续功能或性能优化扫清结构障碍
- 准备把经验沉淀到重构计划、最佳实践中

### 快速用法
```bash
# 定位问题
rg "TODO|FIXME|HACK" --glob '!node_modules'
rg "if .* if .* if" src --type js

# 请求重构建议
"请基于上述结果给出分阶段重构方案，强调验证步骤"
```

### 推荐步骤
1. **观察现状**：统计复杂度、重复率、依赖关系，列出优先级。
2. **设定目标**：明确希望解决的痛点（可读性、解耦、测试覆盖等）。
3. **小步迭代**：一次处理一个 smell，保持可回滚，变化粒度 15–30 分钟。
4. **持续验证**：运行测试、静态检查、基准测试，确保行为未变。

### 常见技法
- **Extract Method/Class**：拆分长函数、单体类。
- **Replace Conditional with Polymorphism**：消除多重 `if/switch`。
- **Introduce Interface/Repository**：引入抽象实现依赖倒置。
- **Encapsulate Collection/Record**：规范数据访问与校验。

### SOLID 检查点
- `S` 单一职责：一个模块只有一种变更原因。
- `O` 开闭原则：新增功能优先扩展，避免修改核心逻辑。
- `L` 里氏替换：子类/实现应无条件替换父类/接口。
- `I` 接口隔离：避免胖接口，把关注点拆分。
- `D` 依赖倒置：高层依赖抽象，实现细节向下沉。

### 输出结构（示例）
```
重构建议
━━━━━━━━━━━━━━━━━━━━━━
问题定位
- God Object：src/services/UserService.ts (420 行)
- 重复逻辑：validator.ts / controller.ts

分阶段方案
1. 拆分验证逻辑 → 引入 Validator 类
2. 引入 Repository 接口，移除直接 DB 调用
3. 补充单元测试，覆盖新增抽象

验证步骤
- npm run test
- npm run lint
- 对关键接口跑一次 smoke 测试
```

### 与 Claude 协作
- 先提供 `git diff`、`rg`、`complexity-report` 等结果，让 Claude 帮忙聚焦重点。
- 执行 `/refactor` 后，可让 Claude 生成 Todo 清单或 `/task` 追踪项。
- 对大型重构，结合 `/plan` 制定阶段路线、风险与回滚策略。

### 注意事项
- 任何重构都需要测试兜底；没有测试时优先补齐。
- 控制改动范围，避免在同一次提交里混入行为变更。
- 若涉及多团队模块，提前沟通接口变化和迁移时间表。
