## Search Gemini

### 核心作用
通过 Gemini CLI 执行 Web 搜索，获取最新资料、官方文档或解决方案，并将结果交给 Claude 总结、比对与验证。

### 快速用法
```bash
gemini --prompt "WebSearch: React 19 新特性"
gemini --prompt "WebSearch: TypeError cannot read property of undefined solution"
```

> 注意：禁止直接使用 Claude 自带的 WebSearch，统一通过 `gemini --prompt "WebSearch: ..."` 执行。

### 使用场景
- 获取最新框架更新、RFC、社区讨论
- 查找报错、性能问题的最新修复思路
- 对比技术方案、搜集案例或安全公告

### 与 Claude 协作
```bash
# 搜索并总结
query="WebSearch: Next.js 14 App Router"
gemini --prompt "$query"
"请汇总搜索结果，列出主要变化与注意事项"

# 错误排查
grep -i error app.log | tail -20 > /tmp/error.log
gemini --prompt "WebSearch: $(cat /tmp/error.log | head -3) solution"
"结合搜索结果给出修复建议，并标出可信来源"
```

### 提示示例
- "WebSearch: site:developer.android.com Compose performance best practices"
- "WebSearch: Rust vs Go benchmark 2024 multiple sources"
- "WebSearch: CVE-2024-12345 impact mitigation"

### 最佳实践
1. 搜索后请要求 Claude 标注来源、区分官方与社区观点。
2. 关键信息（安全、合规）需再到官方文档二次验证。
3. 若需要多源交叉验证，可在提示中注明“multiple sources”“compare”。

### 常见问题
- 网络不可用或 CLI 未安装时请先运行 `install.sh --model gemini` 或检查配置。
- 搜索结果可能存在时效性，必要时添加关键词如 “2025” 或 “latest”。
