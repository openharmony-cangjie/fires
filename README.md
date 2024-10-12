# light fires 小小的火焰

这是 light 引导框架的使用例子

- [x] 路由
- [x] 中间件
- [x] 配置管理
- [x] 注入系统
- [ ] TODO log 待兼容官方接口
- [ ] TODO 监控体系
- [ ] TODO 信息总线

# 快速入门

```
// 简易路由 http://127.0.0.1:8080/temp/张三
this.get("/temp/:name", {
  req, rsp => rsp.text("OK get(name) = ${req.get("name")}")
})
```

# 运行

```sql
cjpm update
cjpm run
```

## 文档

查看根目录的 docs 目录
