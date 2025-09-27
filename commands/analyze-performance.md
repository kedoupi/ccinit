## Analyze Performance

### 核心作用
结合代码、架构与运行指标定位性能瓶颈，评估技术债对性能的影响，并输出可验证的优化方案。

### 适用场景
- 页面/接口响应变慢、负载升高、资源消耗异常
- 需要确认算法、数据库、缓存、前端加载等是否存在热点
- Release 前进行性能健康检查或长期性能治理

### 快速用法
```bash
/analyze-performance
"请检查该项目的性能瓶颈并给出优化方案"
```

可配合以下命令提供上下文：
```bash
npm run build 2>&1 | tail -100
node --prof app.js
EXPLAIN ANALYZE SELECT ...;
```

### 关注指标
- **代码级**：算法复杂度、阻塞式 I/O、重复计算、内存泄漏
- **系统级**：CPU/内存/磁盘/网络利用率、线程/连接池配置
- **数据库**：慢查询、缺失索引、N+1、缓存策略
- **前端**：Core Web Vitals、bundle 体积、懒加载、资源压缩

### 推荐流程
1. 收集性能数据：日志、Profile、Slow Query、监控指标。
2. 快速分类严重度：🔴 会导致故障、🟡 影响体验、🟢 可优化即可。
3. 定位根因：算法、架构、依赖、部署设置等。
4. 输出建议：预估收益、实施成本、验证方法。

### 输出结构
```
性能分析报告
━━━━━━━━━━━━━━━━━━━━━━
总体评级：Excellent / Good / Needs Improvement / Problematic
关键指标：响应时间 / 吞吐量 / 资源占用

【瓶颈定位】
- 位置：...
  影响：...
  根因：...

【优化建议】
优先级 High：...
  预期提升：...
  实施步骤：...
  风险：...

【验证方案】
- Benchmark / Profiling / 监控指标
```

### 常用工具提示
- **Node/JS**：`node --prof`、Clinic.js、`webpack-bundle-analyzer`
- **数据库**：`EXPLAIN (ANALYZE)`、慢查询日志、连接池监控
- **前端**：Lighthouse、WebPageTest、Chrome DevTools Performance
- **系统**：`top`/`htop`、`perf`、APM（Datadog/New Relic等）

### 与 Claude 协作
- 将日志、profile、分析报告粘贴给 Claude，请其归纳问题与排序优先级。
- 结合 `/plan` 或 `/task` 制定渐进式性能优化路线。
- 需要脚本或监控方案时，可让 Claude 生成验证脚本、CI 任务或报警规则。

### 注意事项
- 优化前务必先确定基线与目标，避免盲目调优。
- 每项建议需包含验证步骤和回滚策略。
- 对安全、稳定性有影响的改动，需同步相关团队评估。
