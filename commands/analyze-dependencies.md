---
name: analyze-dependencies
description: "扫描依赖关系，识别循环依赖和架构风险"
---

# Analyze Dependencies 命令

扫描项目依赖关系，识别架构风险：

**分析类型**：
- 循环依赖检测
- 层级违规分析
- 耦合度评估
- 孤儿模块识别
- 巨石模块发现

**输出内容**：
- 依赖关系图谱
- 问题模块清单
- 重构优先级建议
- 架构改进方案

**适用场景**：
- 架构健康检查
- 重构前风险评估
- 代码库维护性分析

支持全量分析、循环依赖检测等多种模式。
```

### 可选参数
- `--visual`：输出可视化依赖（ASCII 图或链接）
- `--depth <N>`：限制分析深度（默认 3）
- `--focus <路径>`：聚焦特定模块/目录
- `--rules <file>`：加载自定义架构规则
- `--compare <gitref>`：对比历史版本依赖差异

### 输出结构
```
依赖分析报告
━━━━━━━━━━━━━━━━━━━━━━
概览指标
- 模块总数 / 平均依赖数 / 最大深度 / 循环数量

违规与风险
- 级别：[HIGH/MED/LOW]
  位置：模块 A → 模块 B
  说明：违反分层 / 循环依赖 / 耦合过高
  建议：...

推荐行动
1. ...
2. ...
```

### 分析要点
- **Dependency Matrix**：直接/间接依赖、扇入扇出、深度
- **Architecture Violations**：分层倒置、循环、超高耦合、孤立模块
- **Clean Architecture 校验**：领域层独立性、接口隔离、用例流向是否正确

### 高级玩法
```bash
/analyze-dependencies --circular --fail-on-violation        # CI 阶段阻断循环
/analyze-dependencies --rules .architecture-rules.yml        # 校验自定义分层规则
/analyze-dependencies --compare HEAD~10                      # 追踪 10 次提交内的变化
```

### 配置示例（.architecture-rules.yml）
```yaml
rules:
  - name: Domain Independence
    source: src/domain/**
    forbidden:
      - src/infra/**
      - src/api/**

thresholds:
  max_dependencies: 8
  max_depth: 4
  coupling_threshold: 0.7

ignore:
  - **/test/**
  - **/mocks/**
```

### 与 Claude 协作
- 提供 `package.json`、依赖图或架构文档，请 Claude 对比实现与设计。
- 针对指定目录运行命令，让 Claude 解释耦合原因、列出拆分策略。
- 搭配 `/plan` 或 `/refactor` 制定分阶段整改计划。

### 使用建议
- 项目根目录执行，避免遗漏依赖。
- 大型仓库需耐心等待分析完成，可按模块分批处理。
- 循环依赖应优先修复；其它风险可结合业务影响排序。

### 最佳实践
1. 定期（如每周）执行，监控趋势。
2. 将分层/耦合规则写入配置，纳入 CI。
3. 拆分工作量大时分阶段治理，记录每次整改结果。
