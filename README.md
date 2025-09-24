# ccinit (Claude Code Init)

提供完整的中文 Claude Code 增强功能。

## 🚀 快速安装

```bash
# 克隆并安装
git clone https://github.com/kedoupi/ccinit.git
cd ccinit
./install.sh

# 配置 Claude Desktop：将自定义指令路径设置为 ~/.claude
```

## 📚 主要特性

通过三大核心功能定制 Claude Code 的行为：

- **命令**：以 `/` 开头的自定义命令
- **角色**：专家视角的角色设置
- **Hooks**：在特定时机自动执行脚本

---

## 功能列表

### 命令

存储为 `/commands` 目录中的 Markdown 文件。通过在 `/` 后输入文件名来执行。

| 命令 | 描述 |
| :--- | :--- |
| `/plan` | 激活实施计划模式，制定详细的实施策略 |
| `/refactor` | 执行安全的逐步代码重构，评估 SOLID 原则遵循情况 |
| `/pr-create` | 基于 Git 变更分析实现高效的 Pull Request 工作流程 |
| `/pr-review` | 通过系统性审查确保代码质量和架构合理性 |
| `/pr-auto-update` | 自动更新 Pull Request |
| `/pr-feedback` | PR 反馈处理 |
| `/pr-issue` | 列出项目问题清单 |
| `/pr-list` | 显示 Pull Request 列表 |
| `/pr-merge` | 合并 Pull Request |
| `/tech-debt` | 分析项目技术债务并创建优先级改进计划 |
| `/fix-error` | 基于错误消息建议代码修复方案 |
| `/smart-review` | 执行高级审查以提升代码质量 |
| `/semantic-commit` | 将大变更分解为有意义的最小单元并依次提交 |
| `/commit-message` | 生成符合规范的提交信息 |
| `/analyze-dependencies` | 分析项目依赖关系 |
| `/analyze-performance` | 分析系统性能 |
| `/check-fact` | 事实检查验证 |
| `/check-github-ci` | GitHub CI 监控 |
| `/check-prompt` | 提示词检查 |
| `/context7` | 上下文管理工具 |
| `/design-patterns` | 设计模式分析 |
| `/explain-code` | 代码解释说明 |
| `/multi-role` | 多角色协作 |
| `/role-debate` | 角色辩论模式 |
| `/role-help` | 角色帮助说明 |
| `/role` | 切换专家角色 |
| `/screenshot` | 截图分析 |
| `/search-gemini` | Gemini 网络搜索 |
| `/sequential-thinking` | 序列思考模式 |
| `/show-plan` | 显示执行计划 |
| `/spec` | 规范生成 |
| `/style-ai-writting` | AI 写作风格检查 |
| `/task` | 任务管理 |
| `/team-collab` | 团队协作工具 |
| `/ultrathink` | 深度思考模式 |
| `/update-dart-doc` | 更新 Dart 文档 |
| `/update-doc-string` | 更新文档字符串 |
| `/update-flutter-deps` | 更新 Flutter 依赖 |
| `/update-node-deps` | 更新 Node.js 依赖 |
| `/update-rust-deps` | 更新 Rust 依赖 |

### 角色

定义在 `agents/roles/` 目录的 Markdown 文件中。为 Claude 提供专家视角以获得更准确的答案。

| 角色 | 描述 |
| :--- | :--- |
| `/role analyzer` | 根因分析专家，使用 5Why 方法和系统思维解决复杂问题 |
| `/role architect` | 软件架构师，审查和提出设计方案 |
| `/role frontend` | 前端开发专家，专注 UI/UX 和现代前端技术 |
| `/role mobile` | 移动开发专家，专注 iOS/Android 平台优化 |
| `/role performance` | 性能优化专家，建议速度和内存使用改进 |
| `/role qa` | 质量保证专家，制定测试策略和自动化方案 |
| `/role reviewer` | 代码审查员，从可读性和可维护性角度评估代码 |
| `/role security` | 安全专家，指出漏洞和安全风险 |

### Hooks

在 `settings.json` 中配置以自动化开发工作。

| 执行脚本 | 事件 | 描述 |
| :--- | :--- | :--- |
| `deny-check.sh` | `PreToolUse` | 防止执行 `rm -rf /` 等危险命令 |
| `check-ai-commit.sh` | `PreToolUse` | 当提交消息包含 AI 签名时报错 |
| `preserve-file-permissions.sh` | `PreToolUse` / `PostToolUse` | 保持文件权限不变 |
| `auto-comment.sh` | `PostToolUse` | 创建新文件或重大编辑时提示添加文档字符串 |
| `zh-space-format.sh` | `PostToolUse` | 保存文件时自动格式化中文与字母数字字符间的空格 |
| `check-continue.sh` | `Stop` | 检查是否需要继续执行任务 |
| `append_ultrathink.py` | `UserPromptSubmit` | 用户提交提示时自动添加深度思考模式 |
| 通知音效 | `Notification` / `Stop` | 操作完成时播放音效并显示系统通知 |

---

## 安装

1. 克隆仓库
2. 运行安装脚本：`./install.sh`
3. 在 Claude Desktop 中设置自定义指令路径为 `~/.claude`
4. 重启 Claude Desktop 开始使用

## 使用示例

```bash
# 创建实施计划
/plan
"为用户认证功能创建实施计划"

# 代码重构
/refactor
"重构这个复杂的函数"

# 安全审查
/role security
"对这个项目进行安全检查"

# 架构评估
/role architect
"评估当前系统架构"
```

## 许可证

MIT
