# WEB 应用

web 应用由注解 @HttpApplication 驱动, 文件存放目录不强制要求. 端口配置存放到 app.yaml 中.

这里是一个例子

```cangjie
@HttpApplication["/src/http/controllers/"]
public class HttpKernel <: HttpServer {
    /**
     * 在这里管理非宏路由
     * 设置中间件信息
    */
    public func register() {
        // 全局中间件, 所有路由生效
        this.use(CorsMiddleware())

        // 指定路由分组使用的中间件
        this.group("login").prefix("/api").middleware(LoginMiddleware())

        // 简易路由 http://127.0.0.1:8080/temp/张三
        this.get("/temp/:name", {
            req, rsp => rsp.text("OK get(name) = ${req.get("name")}")
        })
    }
}

```

### 路由

简易路由

```cangjie
// 简易路由 http://127.0.0.1:8080/temp/张三
this.get("/temp/:name", {
    req, rsp => rsp.text("OK get(name) = ${req.get("name")}")
})
// 和上面是两个不同路由
this.post("/temp/:name", {
    req, rsp => rsp.text("OK get(name) = ${req.get("name")}")
})

```

注解路由

由`@Controller`扫描引导到框架; 支持自定义分组`@Controller["login"] `, 分组使用的中间件和统一前缀由`HttpKernel`设置

```cangjie
package fires.http.controllers

import light.auto
import light.web.annotation.{Controller, GetMapping, PostMapping}
import light.web.{Request, Response}
import light.json.annotation.Json
import light.log
import jorm

@Controller
public class HomeController {
    // 注入数据库对象
    let db = auto.get<jorm.DB>("mysql")

    // 这里读取的是 app.yaml[name]
    let name = auto.get<String>("config", "app.name")

    /**
     * 默认首页
    */
    @GetMapping['/']
    public func index(response: Response) {
        response.text("应用名称: ${name}")
    }

    /**
     * 默认首页
     * 获取请求封装request和response; 自行获取具体参数
    */
    @GetMapping['/request']
    public func index(request: Request, response: Response) {
        response.text("请求参数 name: $${request.get("name")}")
    }

    /**
     * 自动注入对应的参数
     *  ?name 可选参数
    */
    @GetMapping['/home']
    public func home(name: ?String) {
        log.wran("name = ${name}")
         "Hello, ${name}!";
    }

    /**
     * 自动注入对应的参数, 并且格式化到对象中
     * 当前只支持json的解析
    */
    @PostMapping['/data']
    public func data(user: User) {
         user.name = "哈哈"

         return user
    }
}

// 测试对象
@Json
class User {
    var name: String = ""
}

```

## 便捷的响应结构

```
import light.data.Map

@PostMapping
public func test(response: Response) {
    let dto = Map()
    dto["token"] = 123456
    dto["role"] = "watch"
    return dto
}
```

## 资源静态编译

把 html 等资源静态编译到二进制中

```
import light.annotation.CompileStatic

@CompileStatic["path"]
let files = HashMap<String, String>()
```

## 统一的响应结构

如果需要自定结构, 你应该覆盖 light.web.successResponse

```cangjie
// response.fail(502, "测试密码是 123456")
response.success(dto)
// 输出
{
    "code": 0,
    "data": {
        "token": "123456",
        "role": "watch"
    }
}
```
