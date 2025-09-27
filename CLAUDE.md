# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

ccinit (Claude Code Init) 是专为中文开发者打造的 Claude Code 增强工具包，通过智能命令、专家角色和自动化脚本提供完整的开发工作流支持。

### 核心架构

**三层架构模式**：
- **Commands 层** (`commands/`): 40+ 个智能命令，覆盖完整开发生命周期
- **Agents 层** (`agents/roles/`): 8 个专业角色，提供专业领域的深度分析
- **Scripts 层** (`scripts/`): 10+ 个自动化脚本，确保质量和安全

### 项目结构

```
ccinit/
├── commands/           # 智能命令库 (40+ .md 文件)
├── agents/roles/      # 专家角色定义 (8个角色)
├── scripts/           # 自动化脚本 (bash 脚本)
├── hooks/             # Hook 脚本 (Python/Bash)
├── assets/            # 静态资源
├── install.sh         # 本地安装脚本
└── CLAUDE.md          # 全局指令文件
```

## 常用开发命令

### 安装和设置

```bash
# 运行安装脚本
chmod +x install.sh
./install.sh

# 可选参数
./install.sh --model gemini     # 使用不同的 AI 模型
./install.sh --dry-run          # 预览安装（不做实际更改）
./install.sh --no-verify       # 跳过安装验证
```

### 脚本权限管理

```bash
# 设置脚本权限
chmod +x scripts/*.sh

# 查看当前脚本权限
ls -la scripts/

# 验证可执行脚本
find scripts/ -name "*.sh" -exec bash -n {} \;
```

### 测试和验证

```bash
# 验证命令文件语法
find commands/ -name "*.md" -print

# 验证角色文件结构
find agents/roles/ -name "*.md" -print

# 检查脚本语法
bash -n scripts/deny-check.sh
bash -n scripts/check-ai-commit.sh

# 测试 Hook 脚本
python3 hooks/UserPromptSubmit/append_ultrathink.py

# 验证安装完整性
./install.sh --dry-run
```

## 代码架构和设计模式

### 命令系统设计

**文件命名约定**：`commands/{功能名称}.md`

**命令文件结构**：
```markdown
---
name: command-name
description: "命令描述"
---

# 命令实现内容
```

**命令分类**（共27个命令）：

**核心工作流命令**（6个）：
- 项目管理：`/plan`, `/spec`, `/task`, `/show-plan`
- 任务验证：`/check-fact`, `/check-prompt`

**代码质量命令**（6个）：
- 代码改进：`/refactor`, `/fix-error`, `/design-patterns`
- 代码分析：`/analyze-performance`, `/analyze-dependencies`, `/tech-debt`
- 代码审查：`/smart-review`, `/explain-code`

**专家角色命令**（4个）：
- 角色系统：`/role`, `/multi-role`, `/role-debate`, `/role-help`

**Git/PR 工作流**（4个）：
- PR 管理：`/pr-create`, `/pr-review`, `/pr-merge`
- 提交管理：`/commit-message`

**项目维护命令**（4个）：
- 文档维护：`/update-doc`
- 依赖维护：`/update-deps`
- 代码规范：`/style-ai-writting`

**AI 增强命令**（3个）：
- 深度思考：`/think`
- 网页搜索：`/search-gemini`

### 角色系统设计

**角色文件结构**：
```markdown
---
name: role-name
description: "角色描述"
model: opus
tools:
  - Read
  - Write
---

# 角色定义和行为规范
```

**专家角色分类**：
- 架构与设计：`architect`, `analyzer`
- 开发与优化：`frontend`, `mobile`, `performance`
- 质量与安全：`security`, `qa`, `reviewer`

### 自动化脚本系统

**安全防护脚本**：
- `deny-check.sh`: 阻止危险命令执行
- `check-ai-commit.sh`: AI 签名检查，防止泄露
- `preserve-file-permissions.sh`: 维持文件权限一致性

**格式化脚本**：
- `zh-space-format.sh`: 中文格式化处理
- `auto-comment.sh`: 自动添加文档提醒

**流程控制脚本**：
- `check-continue.sh`: 任务连续性检查
- `statusline.sh`: 状态行配置

## Hook 系统

### UserPromptSubmit Hook

**文件**: `hooks/UserPromptSubmit/append_ultrathink.py`

**功能**: 自动为用户输入添加深度思考提示
- **触发时机**: 用户提交提示时
- **作用**: 在用户输入后自动追加 UltraThink 分析框架
- **智能过滤**: 跳过简单问候（hello, hi, 你好等）和帮助命令
- **专注中文**: 仅支持中文提示，符合项目定位

**UltraThink 分析框架**:
1. 问题本质分析
2. 多角度考虑（技术、业务、用户体验）
3. 潜在风险识别
4. 最佳实践参考
5. 替代方案探索

## 安全和权限控制

### 危险操作防护

项目内置多层安全防护：

1. **命令拦截** (`deny-check.sh`): 使用 glob 模式匹配阻止危险命令
2. **AI 签名检测** (`check-ai-commit.sh`): 防止 AI 生成的提交信息泄露
3. **权限保护** (`preserve-file-permissions.sh`): 确保文件权限一致性

### 配置管理

**模型配置** (`.env` 文件，按需自建)：
- 支持 PPINFRA、Gemini 等模型后端
- 统一维护 API 密钥与默认模型
- 仅在需要外部模型时创建并填入真实密钥

**权限配置** (`settings.json`):
- 中文本地化设置
- 工具权限控制
- 通知消息配置

## 开发工作流

### 新命令开发

1. 在 `commands/` 创建 `.md` 文件
2. 按照既定格式编写命令内容
3. 重启 Claude Code 即可使用

### 新角色开发

1. 在 `agents/roles/` 创建角色文件
2. 定义专业领域和工具
3. 设置触发条件和行为模式

### 脚本开发

1. 在 `scripts/` 创建 `.sh` 文件
2. 遵循现有的错误处理模式
3. 设置合适的可执行权限

## 扩展和自定义

### 模块化设计原则

- **命令独立性**: 每个命令文件独立运行
- **角色专业化**: 每个角色专注特定领域
- **脚本原子化**: 每个脚本执行单一职责

### 插件化扩展

支持通过文件系统的热插拔扩展：
- 添加新的 `.md` 文件即可扩展命令
- 修改角色文件即可调整专家行为
- 新增脚本文件即可添加自动化功能

### 中文优先设计

- 专为中文开发者设计，界面和交互全中文
- Hook 系统仅支持中文，无多语言负担
- 错误消息和提示全部中文化

## 注意事项

### 开发约束

- 优先编辑现有文件而非创建新文件
- 禁止使用 WebSearch 工具，改用 `gemini --prompt "WebSearch: <query>"`
- 所有脚本必须通过安全检查
- 遵循中文优先的用户体验设计

### 质量保证

- TDD 驱动的开发流程
- 多重安全检查机制
- 自动化格式化和代码审查
- 基于证据的技术决策

### 兼容性

- 支持 macOS, Linux, Windows (WSL)
- 适配多种开发语言和框架
- 与 Claude Desktop 完全集成
- 向后兼容现有工作流
