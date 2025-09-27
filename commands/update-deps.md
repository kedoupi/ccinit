## 更新依赖

安全地更新项目中的依赖包，支持多种技术栈自动检测。

### 用法

```bash
# 自动检测项目类型并更新依赖
/update-deps

# 指定特定技术栈
/update-deps --type node
/update-deps --type flutter
/update-deps --type rust
/update-deps --type python

# 仅检查不更新
/update-deps --check-only
```

### Options

- `--type <stack>` : 指定技术栈 (node, flutter, rust, python)
- `--check-only` : 仅检查依赖状态，不执行更新
- `--safe-only` : 仅更新安全的版本（避免主版本升级）
- `--interactive` : 交互式选择要更新的依赖

### 项目类型自动检测

命令会自动检测项目类型：

- **Node.js**: `package.json` 存在 → 使用 npm/yarn/pnpm
- **Flutter**: `pubspec.yaml` 存在 → 使用 flutter pub
- **Rust**: `Cargo.toml` 存在 → 使用 cargo
- **Python**: `requirements.txt` 或 `pyproject.toml` 存在 → 使用 pip/poetry

### 基础示例

#### Node.js 项目

```bash
# 检查当前依赖
npm outdated
/update-deps --type node
"分析此 Node.js 项目的依赖并告诉我哪些包可以更新"

# 安全更新（避免破坏性更改）
/update-deps --type node --safe-only
"更新可以安全升级的包，避免主版本升级"
```

#### Flutter 项目

```bash
# 检查当前依赖
flutter pub deps --style=compact
/update-deps --type flutter
"分析此 Flutter 项目的依赖并告诉我哪些包可以更新"

# 预演更新
flutter pub upgrade --dry-run
/update-deps --check-only
"检查此计划升级中是否有破坏性更改"
```

#### Rust 项目

```bash
# 检查当前依赖
cargo tree
/update-deps --type rust
"分析此 Rust 项目的依赖并告诉我哪些 crate 可以更新"

# 预演更新
cargo update --dry-run
/update-deps --check-only
"分析更新这些 crate 的风险级别"
```

### 智能分析流程

1. **项目检测**: 自动识别技术栈和包管理器
2. **依赖分析**: 检查过期依赖和可用更新
3. **风险评估**: 分析每个更新的风险级别
4. **变更建议**: 提供必要的代码更改建议
5. **执行更新**: 生成更新后的依赖文件

### 风险评估标准

- 🟢 **安全**: 补丁版本更新 (1.2.3 → 1.2.4)
- 🟡 **注意**: 次版本更新 (1.2.3 → 1.3.0)
- 🔴 **危险**: 主版本更新 (1.2.3 → 2.0.0)

### 与 Claude 协作

```bash
# 综合依赖更新分析
cat package.json  # 或 pubspec.yaml、Cargo.toml
/update-deps
"分析依赖并执行以下操作：
1. 研究每个包的最新版本
2. 检查破坏性更改
3. 评估风险级别（安全、注意、危险）
4. 建议必要的代码更改
5. 生成更新后的依赖文件"

# 渐进式安全更新
/update-deps --safe-only
"仅更新可以安全升级的包，避免主版本升级"

# 特定包的影响分析
"告诉我将 react 更新到最新版本的影响和必要更改"
```

### 技术栈特定命令

#### Node.js
```bash
# 检查工具
npm outdated
npm audit
yarn outdated
pnpm outdated

# 更新命令
npm update
yarn upgrade
pnpm update
```

#### Flutter
```bash
# 检查工具
flutter pub deps --style=compact
flutter pub upgrade --dry-run

# 更新命令
flutter pub upgrade
flutter pub get
```

#### Rust
```bash
# 检查工具
cargo tree
cargo update --dry-run
cargo audit

# 更新命令
cargo update
cargo upgrade
```

#### Python
```bash
# 检查工具
pip list --outdated
poetry show --outdated

# 更新命令
pip install --upgrade
poetry update
```

### 安全检查

更新前会进行以下检查：

1. **备份检查**: 确认 git 工作区干净
2. **安全扫描**: 检查已知安全漏洞
3. **兼容性检查**: 验证版本兼容性
4. **测试建议**: 推荐更新后的测试流程

### 注意事项

- **备份重要**: 更新前请确保代码已提交到 git
- **测试必要**: 更新后请运行完整测试套件
- **渐进更新**: 建议分批更新，而非一次性全部更新
- **文档查看**: 查看各包的变更日志和迁移指南