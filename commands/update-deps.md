## Update Deps

### 核心作用
识别并安全更新项目依赖，自动检测技术栈（Node.js、Flutter、Rust、Python 等），评估升级风险并给出验证建议。

### 快速用法
```bash
/update-deps                 # 自动检测项目类型并给出更新建议
/update-deps --type node     # 指定技术栈
/update-deps --check-only    # 仅检查不修改
/update-deps --safe-only     # 仅执行补丁/次版本更新
```

### 流程概览
1. **识别生态**：根据 `package.json`、`pubspec.yaml`、`Cargo.toml`、`pyproject.toml` 等判断包管理器。
2. **收集信息**：调用 `npm outdated`、`flutter pub outdated`、`cargo audit` 等命令获取最新版本。
3. **风险分级**：
   - 🟢 Patch（1.2.3 → 1.2.4）
   - 🟡 Minor（1.2.3 → 1.3.0）
   - 🔴 Major（1.2.3 → 2.0.0）
4. **生成建议**：列出升级收益、潜在破坏性、更改点与测试建议。
5. **执行更新**（可选）：按照安全等级或交互式选择进行升级。

### 输出结构（示例）
```
依赖更新报告（Node.js）
━━━━━━━━━━━━━━━━━━━━━━
包名        当前 → 最新   风险  说明
lodash      4.17.15 → 4.17.21  🟢  修复 CVE-2021-23337
react       17.0.2 → 18.3.1    🔴  需适配新 Root API

建议
1. 先执行 safe-only 更新并回归测试
2. 评估 React 18 迁移指南，拆分成独立任务
3. 更新后运行 npm test & npm run lint
```

### 常用参数
- `--interactive`：列出可升级列表，由用户选择。
- `--type <stack>`：强制指定栈（`node`/`flutter`/`rust`/`python`）。
- `--check-only`：仅输出报告，不改动文件。

### 与 Claude 协作
- 提供 `npm outdated`、`cargo tree` 等结果，让 Claude 解释差异与风险。
- 请求生成升级后的测试计划或迁移笔记。
- 对 Major 更新可要求 Claude 总结官方迁移指南关键步骤。

### 注意事项
- 更新前确保工作区干净（`git status`），必要时创建新分支。
- 升级后务必执行完整测试、lint、构建流程。
- Major 升级建议独立规划，避免与其他变更混合。
