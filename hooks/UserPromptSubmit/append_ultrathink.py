#!/usr/bin/env python3
"""
UserPromptSubmit Hook - Append UltraThink
为用户提示添加 UltraThink 机制，增强思考深度
"""

import sys
import json
import os

def get_ultrathink_prompt() -> str:
    """返回中文 UltraThink 提示"""
    return """

<ultrathink>
在回答之前，请深入思考以下几个方面：

1. **问题本质**：这个问题的核心是什么？是否还有隐含的需求？
2. **多角度分析**：从技术、业务、用户体验等不同角度考虑
3. **潜在风险**：可能存在哪些问题或风险点？
4. **最佳实践**：业界的最佳实践是什么？
5. **替代方案**：还有其他可能的解决方案吗？

请基于这些思考给出深度的回答。
</ultrathink>"""

def main():
    """主函数：处理用户输入并添加 UltraThink 提示"""
    try:
        # 读取 Claude 工具输入
        tool_input = os.environ.get('CLAUDE_TOOL_INPUT', '{}')

        if tool_input == '{}':
            # 如果没有工具输入，从 stdin 读取
            tool_input = sys.stdin.read().strip()

        if not tool_input:
            sys.exit(0)

        # 解析 JSON 输入
        try:
            data = json.loads(tool_input)
        except json.JSONDecodeError:
            # 如果不是 JSON，直接处理为纯文本
            data = {"user_prompt": tool_input}

        # 获取用户提示
        user_prompt = data.get('user_prompt', data.get('prompt', ''))

        if not user_prompt.strip():
            sys.exit(0)

        # 检查是否已经包含 ultrathink 标签
        if '<ultrathink>' in user_prompt.lower():
            # 已经包含，不重复添加
            print(json.dumps(data))
            sys.exit(0)

        # 检查是否是简单的问候或短命令
        simple_patterns = ['hello', 'hi', 'hey', '你好', '嗨', '/help', '--help']
        if any(pattern in user_prompt.lower() for pattern in simple_patterns):
            # 对于简单问候，不添加 UltraThink
            print(json.dumps(data))
            sys.exit(0)

        # 添加 UltraThink 提示
        ultrathink_prompt = get_ultrathink_prompt()

        # 更新用户提示
        enhanced_prompt = user_prompt + ultrathink_prompt

        # 更新数据
        if 'user_prompt' in data:
            data['user_prompt'] = enhanced_prompt
        elif 'prompt' in data:
            data['prompt'] = enhanced_prompt
        else:
            data = {"user_prompt": enhanced_prompt}

        # 输出增强后的提示
        print(json.dumps(data, ensure_ascii=False))

    except Exception as e:
        # 出错时，直接输出原始输入
        sys.stderr.write(f"UltraThink Hook Error: {str(e)}\n")
        if 'data' in locals():
            print(json.dumps(data, ensure_ascii=False))
        else:
            print(tool_input)
        sys.exit(0)

if __name__ == "__main__":
    main()