#!/bin/bash

# ccinit (Claude Code Init) 安装程序
# Version: 1.0.0
# 专为 ccinit 项目设计的简化安装脚本

# Enable strict error handling
set -euo pipefail

# Error trap for better debugging
trap 'echo "错误发生在第 $LINENO 行。退出代码：$?" >&2' ERR

# ============================================================================
# 全局变量和配置
# ============================================================================

SCRIPT_VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

# 默认配置
DRY_RUN=false
SHOW_HELP=false
BACKUP_EXISTING=true
VERIFY_INSTALL=true

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ============================================================================
# 工具函数
# ============================================================================

# 打印彩色输出
print_info() {
    echo -e "${BLUE}[信息]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

print_error() {
    echo -e "${RED}[错误]${NC} $1"
}

# ============================================================================
# 安装功能函数
# ============================================================================

# 显示安装横幅
show_banner() {
    local title="ccinit (Claude Code Init)"
    local version_text="版本 $SCRIPT_VERSION"

    echo ""
    echo -e "${CYAN}╔════════════════════════════════════════════════╗${NC}"
    printf "${CYAN}║ %-46s ║${NC}\n" "$title"
    printf "${CYAN}║ %-46s ║${NC}\n" "$version_text"
    echo -e "${CYAN}╚════════════════════════════════════════════════╝${NC}"
    echo ""
}

# 检查系统依赖
check_dependencies() {
    print_info "检查依赖项..."
    local missing_deps=()

    # 检查必需工具
    local required_tools=("git" "find" "cp" "mv")
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_deps+=("$tool")
        fi
    done

    # 检查写权限
    if [[ ! -w "$(dirname "$CLAUDE_DIR")" ]]; then
        print_error "权限被拒绝：$(dirname "$CLAUDE_DIR")"
        exit 1
    fi

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_error "缺少必需的依赖项：${missing_deps[*]}"
        exit 1
    fi

    print_success "依赖项检查通过"
}

# 备份现有安装
backup_existing() {
    if [[ ! -d "$CLAUDE_DIR" ]]; then
        return
    fi

    print_warning "发现现有的 .claude 目录"

    local backup_name=".claude_backup_$(date +%Y%m%d_%H%M%S)"
    local backup_path="$HOME/$backup_name"

    # 检查是否通过管道执行（如 curl | bash）
    if [[ -t 0 ]]; then
        # 标准输入可用，可以交互
        read -p "是否要备份现有的 .claude 目录？(y/n): " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            mv "$CLAUDE_DIR" "$backup_path"
            print_success "备份创建成功：$backup_path"
        else
            rm -rf "$CLAUDE_DIR"
            print_info "已移除现有的 .claude 目录"
        fi
    else
        # 非交互模式，默认备份
        print_info "非交互模式：自动备份现有目录"
        mv "$CLAUDE_DIR" "$backup_path"
        print_success "备份创建成功：$backup_path"
    fi
}

# 生成设置文件
generate_settings_json() {
    local template_file="$SCRIPT_DIR/settings.json.template"
    local output_file="$CLAUDE_DIR/settings.json"

    if [[ ! -f "$template_file" ]]; then
        print_error "设置模板未找到：$template_file"
        return 1
    fi

    print_info "生成 settings.json 配置文件..."

    # 设置中文参数
    sed -e "s/{{CLAUDE_LANGUAGE}}/zh/g" \
        -e "s/{{NOTIFICATION_WAITING}}/等待确认/g" \
        -e "s/{{NOTIFICATION_COMPLETED}}/任务完成/g" \
        "$template_file" > "$output_file"

    if [[ $? -eq 0 ]]; then
        print_success "settings.json 生成成功"
    else
        print_error "生成 settings.json 失败"
        return 1
    fi
}

# 执行安装
install_ccinit() {
    print_info "开始安装 ccinit..."

    # 创建目标目录
    mkdir -p "$CLAUDE_DIR"

    # 复制核心目录
    local core_dirs=("commands" "agents" "scripts" "hooks")
    for dir in "${core_dirs[@]}"; do
        if [[ -d "$SCRIPT_DIR/$dir" ]]; then
            print_info "复制 $dir 目录..."
            cp -r "$SCRIPT_DIR/$dir" "$CLAUDE_DIR/"
        fi
    done

    # 复制核心文件
    local core_files=("CLAUDE.md")
    for file in "${core_files[@]}"; do
        if [[ -f "$SCRIPT_DIR/$file" ]]; then
            print_info "复制 $file..."
            cp "$SCRIPT_DIR/$file" "$CLAUDE_DIR/"
        fi
    done

    # 复制资产目录
    if [[ -d "$SCRIPT_DIR/assets" ]]; then
        print_info "复制 assets 目录..."
        cp -r "$SCRIPT_DIR/assets" "$CLAUDE_DIR/"
    fi

    # 生成设置文件
    generate_settings_json

    # 设置脚本权限
    if [[ -d "$CLAUDE_DIR/scripts" ]]; then
        chmod +x "$CLAUDE_DIR/scripts"/*.sh 2>/dev/null || true
    fi

    if [[ -d "$CLAUDE_DIR/hooks" ]]; then
        find "$CLAUDE_DIR/hooks" -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
        find "$CLAUDE_DIR/hooks" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    fi

    print_success "安装完成！"
}

# 验证安装
verify_installation() {
    if [[ "$VERIFY_INSTALL" != true ]]; then
        return
    fi

    print_info "验证安装..."
    local checks_passed=true

    # 检查目录结构
    local required_dirs=("commands" "agents" "hooks")
    for dir in "${required_dirs[@]}"; do
        if [[ ! -d "$CLAUDE_DIR/$dir" ]]; then
            print_error "缺少目录：$dir"
            checks_passed=false
        fi
    done

    if $checks_passed; then
        print_success "安装验证成功！"

        # 统计安装项目
        local cmd_count=$(find "$CLAUDE_DIR/commands" -name "*.md" -type f 2>/dev/null | wc -l)
        local role_count=0
        if [[ -d "$CLAUDE_DIR/agents/roles" ]]; then
            role_count=$(find "$CLAUDE_DIR/agents/roles" -name "*.md" -type f 2>/dev/null | wc -l)
        fi
        local script_count=0
        if [[ -d "$CLAUDE_DIR/scripts" ]]; then
            script_count=$(find "$CLAUDE_DIR/scripts" -name "*.sh" -type f 2>/dev/null | wc -l)
        fi

        echo ""
        echo "已安装组件："
        echo "  • 命令：$cmd_count 个"
        echo "  • 角色：$role_count 个"
        echo "  • 脚本：$script_count 个"
    else
        print_error "安装验证失败"
        exit 1
    fi
}

# ============================================================================
# 帮助和参数解析
# ============================================================================

# 显示帮助信息
show_help() {
    cat << EOF
ccinit (Claude Code Init) 安装程序 v$SCRIPT_VERSION

用法:
    $0 [选项]

选项:
    --target <路径>           目标目录（默认：$HOME/.claude）
    --dry-run                预览模式，不做任何更改
    --no-verify              跳过安装后验证
    --help, -h               显示此帮助信息
    --version                显示版本信息

示例:
    # 默认安装
    $0

    # 开发设置（预览模式）
    $0 --target ./test-install --dry-run

    # 静默安装（无验证）
    $0 --no-verify

更多信息请访问:
    https://github.com/kedoupi/ccinit
EOF
}

# 解析命令行参数
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --target)
                CLAUDE_DIR="$2"
                shift 2
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --no-verify)
                VERIFY_INSTALL=false
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            --version)
                echo "ccinit (Claude Code Init) 安装程序 v$SCRIPT_VERSION"
                exit 0
                ;;
            *)
                print_error "未知选项：$1"
                echo "使用 --help 查看用法信息。"
                exit 1
                ;;
        esac
    done
}

# 显示完成信息
finish_banner() {
    echo ""
    echo "════════════════════════════════════════════════"
    print_success "安装成功完成！"
    echo ""
    echo "位置：$CLAUDE_DIR"
    echo "语言：中文"
    echo ""
    echo "下一步："
    echo "1. 打开 Claude Desktop → 设置 → 开发者"
    echo "2. 设置自定义指令路径：$CLAUDE_DIR"
    echo ""
    echo "开始使用 ccinit！🎉"
    echo "════════════════════════════════════════════════"
    echo ""
}

# ============================================================================
# 主安装流程
# ============================================================================

# 主函数
main() {
    # 解析命令行参数
    parse_arguments "$@"

    # 显示横幅
    show_banner

    # 显示预览模式通知
    if [[ "$DRY_RUN" == true ]]; then
        print_info "预览模式 - 不会进行任何更改"
        echo ""
    fi

    # 检查环境和依赖
    check_dependencies

    echo ""
    print_info "准备安装到：$CLAUDE_DIR"
    echo ""

    if [[ "$DRY_RUN" != true ]]; then
        # 备份现有安装
        backup_existing

        # 执行安装
        install_ccinit

        # 验证安装
        echo ""
        verify_installation
    else
        print_info "预览：将安装到 $CLAUDE_DIR"
    fi

    # 显示完成信息
    finish_banner
}

# ============================================================================
# 脚本执行
# ============================================================================

# 运行主函数
main "$@"
