## AI Writing Check

### 核心作用
识别文档中常见的“AI 口吻”或机械化表达，并给出更自然、准确的中文改写建议，可选自动修复模式提升文档可读性。

### 快速用法
```bash
cat README.md | /ai-writing-check
/ai-writing-check --file docs/guide.md
/ai-writing-check --dir docs --severity high
/ai-writing-check --file report.md --fix
```

### 检测维度
1. **机械化清单**：重复使用表情、粗体模板、过度强调等。
2. **夸张陈述**：绝对化、营销式语气，如“彻底解决”“革命性”。
3. **模糊或冗余**：含糊措辞（尽量、适当）、赘述、缺乏具体数字。
4. **术语/语气不一致**：同一概念多种写法、敬语混用等。

### 输出示例
```
AI Writing 检查结果（docs/intro.md）
━━━━━━━━━━━━━━━━━━━━━━
1. 行 24 机械化强调
   原文：**Important**: 这是极其重要的事项
   建议：重要事项：… （去除模板式强调）

2. 行 38 夸张表达
   原文：这项技术彻底改变行业
   建议：这项技术显著改善 …
```

### 参数说明
- `--file` / `--dir`：指定文件或目录，默认分析当前输入文本。
- `--severity all|high|medium`：控制输出级别。
- `--fix`：尝试自动修正检测到的问题，并给出 diff/统计。

### 与 Claude 协作
- 先运行 `rg` 等工具筛选目标文件，再把文本传给 `/ai-writing-check`。
- 可要求 Claude 输出改写建议表格、优先级矩阵或 CI 报告。
- 检查完成后结合 `/update-doc` 或 `/task` 追踪需要手动确认的项。

### 最佳实践
- 技术文档优先强调准确、具体，用数据替代笼统形容。
- 针对博客/营销材料，可保留必要情感词，但仍需符合品牌语气。
- `--fix` 产生的改动仍需人工复核，确保不改变原意。

### 参考
基于 [textlint-rule-preset-ai-writing](https://github.com/textlint-ja/textlint-rule-preset-ai-writing) 规则集扩展，适配中文场景并加入常见本地化规范。
