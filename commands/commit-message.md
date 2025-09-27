## 提交 Message

智能分析暂存的变更内容生成提交信息，并提供交互式确认直接提交代码。

### 用法

```bash
/commit-message [options]
```

### Options

- `--format <format>` : 选择消息格式 (conventional, gitmoji, angular)
- `--lang <language>` : 明确设置语言 (en, zh)
- `--breaking` : 包含破坏性更改检测
- `--auto` : 自动提交（跳过确认步骤）

### 基础示例

```bash
# 从暂存变更生成消息（自动检测语言）
# 推荐最佳消息并询问是否提交
/commit-message

# 明确指定语言
/commit-message --lang zh
/commit-message --lang en

# 包含破坏性更改检测
/commit-message --breaking

# 自动提交（跳过确认）
/commit-message --auto
```

### Prerequisites

**Important**: This command only works with staged changes. Run `git add` first to stage your changes.

```bash
# If nothing is staged, you'll see:
$ /commit-message
No staged changes found. Please run git add first.
```

### 交互式提交功能

推荐最佳提交信息后，会询问是否立即提交：

```
✨ 推荐的提交信息:
feat: 实现JWT身份验证系统

📋 备选方案:
1. feat: 添加基于JWT的用户认证
2. fix: 修复认证中间件的令牌验证错误
3. refactor: 将认证逻辑提取到独立模块

❓ 是否使用推荐的提交信息提交代码？ (Y/n):
```

**交互选项**:
- `Y` 或 `y` 或直接回车: 使用推荐信息立即提交
- `1`, `2`, `3`: 使用对应的备选方案提交
- `n` 或 `N`: 取消提交，仅复制到剪贴板
- `e` 或 `edit`: 进入编辑模式自定义提交信息

### Automatic Project Convention Detection

**Important**: If project-specific conventions exist, they take priority.

#### 1. CommitLint Configuration Check

Automatically detects settings from the following files:

- `commitlint.config.js`
- `commitlint.config.mjs`
- `commitlint.config.cjs`
- `commitlint.config.ts`
- `.commitlintrc.js`
- `.commitlintrc.json`
- `.commitlintrc.yml`
- `.commitlintrc.yaml`
- `package.json` with `commitlint` section

```bash
# Search for configuration files
find . -name "commitlint.config.*" -o -name ".commitlintrc.*" | head -1
```

#### 2. Custom Type Detection

Example of project-specific types:

```javascript
// commitlint.config.mjs
export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', 'fix', 'docs', 'style', 'refactor', 'test', 'chore',
        'wip',      // work in progress
        'hotfix',   // urgent fix
        'release',  // release
        'deps',     // dependency update
        'config'    // configuration change
      ]
    ]
  }
}
```

#### 3. Detecting Language Settings

```javascript
// When project uses 中文 messages
export default {
  rules: {
    'subject-case': [0],  // Disabled for 中文 support
    'subject-max-length': [2, 'always', 72]  // Adjusted character limit for 中文
  }
}
```

#### 4. Existing Commit History Analysis

```bash
# Learn patterns from recent commits
git log --oneline -50 --pretty=format:"%s"

# Type usage statistics
git log --oneline -100 --pretty=format:"%s" | \
grep -oE '^[a-z]+(\([^)]+\))?' | \
sort | uniq -c | sort -nr
```

### Automatic Language Detection

Automatically switches between 中文/English based on:

1. **CommitLint configuration** language settings
2. **git log analysis** automatic detection
3. **Project file** language settings
4. **Changed file** comment and string analysis

Default is English. Generates in 中文 if detected as 中文 project.

### Message Format

#### Conventional Commits (Default)

```
<type>: <description>
```

**Important**: Always generates single-line commit messages. Does not generate multi-line messages.

**Note**: Project-specific conventions take priority if they exist.

### Standard Types

**Required Types**:

- `feat`: New feature (user-visible feature addition)
- `fix`: Bug fix

**Optional Types**:

- `build`: Build system or external dependency changes
- `chore`: Other changes (no release impact)
- `ci`: CI configuration files and scripts changes
- `docs`: Documentation only changes
- `style`: Changes that don't affect code meaning (whitespace, formatting, semicolons, etc.)
- `refactor`: Code changes without bug fixes or feature additions
- `perf`: Performance improvements
- `test`: Adding or fixing tests

### 输出示例（英文项目）

```bash
$ /commit-message

📝 提交信息建议
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ 推荐的提交信息:
feat: implement JWT-based authentication system

📋 备选方案:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. refactor: extract auth logic into separate module

❓ 是否使用推荐的提交信息提交代码？ (Y/n): Y

✅ 正在提交...
[main 1a2b3c4] feat: implement JWT-based authentication system
 3 files changed, 45 insertions(+), 2 deletions(-)

🎉 提交成功！
```

### 输出示例（取消提交）

```bash
❓ 是否使用推荐的提交信息提交代码？ (Y/n): n

📋 已复制到剪贴板: git commit -m "feat: implement JWT-based authentication system"
ℹ️  您可以稍后手动运行该命令
```

### 输出示例（选择备选方案）

```bash
❓ 是否使用推荐的提交信息提交代码？ (Y/n): 2

✅ 正在提交...
[main 5f6g7h8] fix: resolve token validation error in auth middleware
 1 file changed, 8 insertions(+), 3 deletions(-)

🎉 提交成功！
```

### Output Example (中文 Project)

```bash
$ /commit-message

📝 Commit Message Suggestions
━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Main Candidate:
feat: JWT authentication system implemented

📋 Alternatives:
1. feat: add user authentication with JWT tokens
2. fix: resolve token validation error in auth middleware
3. docs: separate auth logic into different module

✅ `git commit -m "feat: JWT authentication system implemented"` copied to clipboard
```

### 操作流程

1. **分析**: 分析 `git diff --staged` 的内容
2. **生成**: 生成合适的提交信息和备选方案
3. **交互**: 询问用户是否立即提交
4. **执行**: 根据用户选择执行提交或复制到剪贴板

**工作模式**:
- **标准模式**: 提供交互式确认
- **自动模式** (`--auto`): 直接使用推荐信息提交
- **取消模式**: 仅生成信息，复制到剪贴板

### Smart Features

#### 1. Automatic Change Classification (Staged Files Only)

- New file addition → `feat`
- Error fix patterns → `fix`
- Test files only → `test`
- Configuration file changes → `chore`
- README/docs updates → `docs`

#### 2. Automatic Project Convention Detection

- `.gitmessage` file
- Conventions in `CONTRIBUTING.md`
- Past commit history patterns

#### 3. Language Detection Details (Staged Changes Only)

```bash
# Detection criteria (priority order)
1. Detect language from git diff --staged content
2. Comment analysis of staged files
3. Language analysis of git log --oneline -20
4. Project main language settings
```

#### 4. Staging Analysis Details

Information used for analysis (read-only):

- `git diff --staged --name-only` - Changed file list
- `git diff --staged` - Actual change content
- `git status --porcelain` - File status

### Breaking Change Detection

For breaking API changes:

**English**:

```bash
feat!: change user API response format

BREAKING CHANGE: user response now includes additional metadata
```

Or:

```bash
feat(api)!: change authentication flow
```

**中文**:

```bash
feat!: change user API response format

BREAKING CHANGE: response now includes additional metadata
```

Or:

```bash
feat(api)!: change authentication flow
```

### Best Practices

1. **Match project**: Follow existing commit language
2. **Conciseness**: Clear within 50 characters
3. **Consistency**: Don't mix languages (stay consistent in English)
4. **OSS**: English recommended for open source
5. **Single line**: Always single-line commit message (supplement with PR for detailed explanations)

### Common Patterns

**English**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

**中文**:

```
feat: add user registration endpoint
fix: resolve memory leak in cache manager
docs: update API documentation
```

### 与 Claude 协作

```bash
# 使用暂存变更
git add -p  # 交互式暂存
/commit-message
"生成最佳提交信息并询问是否提交"

# 暂存并分析特定文件
git add src/auth/*.js
/commit-message --lang zh
"为认证相关变更生成提交信息"

# 破坏性更改检测和处理
git add -A
/commit-message --breaking
"检测破坏性更改并适当标记"

# 自动模式（跳过确认）
git add .
/commit-message --auto
"直接使用推荐信息提交"
```

### 安全检查

在执行提交前会进行以下检查：

1. **暂存区检查**: 确保有暂存的变更
2. **冲突检查**: 检查是否有未解决的合并冲突
3. **Hook 检查**: 确认 pre-commit hooks 可以正常运行
4. **分支检查**: 确认当前分支状态

如果检查失败，会显示错误信息并取消提交。

### 重要说明

- **前提条件**: 必须先使用 `git add` 暂存变更
- **限制**: 不会分析未暂存的变更
- **建议**: 首先检查项目现有的提交约定
- **安全**: 提交前会进行多项检查确保代码安全
