## PR Create

### 核心作用
梳理当前分支改动，自动生成符合项目模板与标签规范的 Pull Request 草稿，并在准备就绪时协助切换为 Ready for Review。

### 适用场景
- 功能/修复开发完成后，需要快速写出高质量 PR 描述
- 希望自动匹配标签、引用模板、提示破坏性修改
- 想将创建 PR 的步骤标准化、减少遗漏

### 前置检查
1. 当前分支已与 `main` 同步，并完成提交 (`git push -u origin <branch>`)。
2. 项目根目录存在 `.github/PULL_REQUEST_TEMPLATE.md` 或默认模板。
3. 需要自动选择标签时，请先同步仓库中可用标签。

### 快速用法
```bash
"请根据当前分支创建 PR：
1. 分析 git diff
2. 按模板填写描述
3. 自动挑选最多 3 个标签
4. 以 Draft 状态创建"
```

可选参数示例：
- `--breaking`：标记破坏性更改并添加提醒。
- `--ready`：在验证通过后改为 Ready for Review。

### 标准流程
1. **准备分支**：`git checkout -b feat-user-profile` → `git push -u origin`。
2. **生成描述**：读取模板或现有 PR 内容，补充变更摘要、测试、关联任务等。
3. **自动打标签**：依据文件类型/关键词匹配（文档、测试、bug、feature、perf、security 等，最多 3 个）。
4. **创建 Draft PR**：保留模板 HTML 注释，禁止生成新标签。
5. **CI 通过后**：执行 `gh pr ready` 或请求 Claude 协助切换状态。

### 输出结构（示例）
```
PR 草稿已生成
━━━━━━━━━━━━━━━━━━━━━━
标题：feat: 实现用户档案管理
标签：feature, documentation

描述：
## Summary
- ...

## Testing
- [x] npm test

## Checklist
- [x] 更新文档
- [ ] 需要产品确认
```

### 自动标签策略
| 场景 | 调用关键词 | 对应标签示例 |
| ---- | ---------- | ------------- |
| 文档 | `*.md`, `docs/` | documentation, docs |
| 测试 | `*_test.*`, `spec` | test, testing |
| Bug 修复 | commit/改动包含 `fix`, `bug`, `hotfix` | bug, fix |
| 新功能 | `feat`, `feature`, `add` | feature, enhancement |
| 性能 | `perf`, `optimize` | performance |
| 安全 | `security`, `auth`, `jwt` | security |

> 仅匹配仓库现有标签，并控制数量 ≤ 3。

### 与 Claude 协作
- 可请求 Claude 先运行 `git diff --stat`、`git diff | head` 帮你确认变更范围。
- 需要保留原模板结构时，提醒“保留 HTML 注释，仅填空”。
- CI 通过、评审完成后，让 Claude 协助准备发布说明或后续任务。

### 注意事项
- 所有 PR 默认以 Draft 提交，确认质量后再改为 Ready for Review。
- 分支命名建议 `{type}-{subject}`，如 `feat-user-profile`。
- 提交信息推荐使用 Conventional Commits，与 `/commit-message` 保持一致。
- 创建 PR 时若涉及敏感配置/密钥，请先脱敏。
