## Commit Message

### 核心作用
基于当前已暂存的改动自动生成符合项目规范的提交信息，同时提供备选方案、破坏性检查和交互式确认，避免手写失误。

### 前置要求
- `git add` 后再执行命令；如无暂存内容会直接提醒。
- 自动检测项目使用的 CommitLint、git 历史、语言偏好与自定义类型。

### 快速用法
```bash
/commit-message                     # 自动识别语言与规范
/commit-message --lang zh           # 明确要求中文
/commit-message --format conventional
/commit-message --breaking          # 额外检查破坏性改动
/commit-message --auto              # 自动提交（跳过确认）
```

### 交互流程
```
✨ 推荐提交信息
feat: 实现 JWT 鉴权流程

备选：
1. feat: 添加基于 JWT 的认证
2. fix: 修复 token 校验逻辑
3. refactor: 重构认证中间件

是否直接提交？ [Y/n/1/2/3/e]
```
- `Y/回车` 使用推荐信息提交。
- 输入数字选用对应备选方案。
- `n` 仅复制信息，不提交。
- `e` 进入编辑模式自定义内容。

### 检测与适配
1. **规范识别**：读取 `commitlint.config.*`、`.commitlintrc.*`、`package.json` 中的配置。
2. **类型推断**：统计近期 `git log`，继承自定义 type（如 `wip`、`deps`、`release`）。
3. **语言判断**：结合配置、提交历史和改动文件内容选择中文或英文。
4. **破坏性改动**：启用 `--breaking` 时标记 `!` 或在描述中提示重大变更。

### 默认输出格式
遵循 Conventional Commits：
```
<type>: <description>
```
常用 type：`feat`、`fix`、`docs`、`style`、`refactor`、`perf`、`test`、`chore`、`ci`、`build` 等。若项目自定义类型，会优先匹配。

### 使用建议
- 在提交前结合 `/smart-review`、`/plan` 确认改动背景，便于生成更贴切描述。
- 若信息较多，可先 `--auto` 提交，再使用 `/update-doc` 或 `/task` 生成后续文档与任务。
- 破坏性更改需配合 CHANGELOG 或发布说明，避免遗漏通知。

### 常见问题
- 无暂存内容 → 先 `git add`。
- 多语言项目 → 使用 `--lang` 指定输出语言。
- 提交规范过于严格 → 请检查 CommitLint 配置是否允许生成的格式。
