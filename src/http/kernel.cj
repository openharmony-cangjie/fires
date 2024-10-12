package fires.http

import light.auto
import light.web.annotation.HttpApplication
import light.web.HttpServer
import light.web.*
import light.debug.watch.WatchMiddleware
import fires.http.middleware.*
// 引入控制器
import fires.http.controllers
// 引入独立目录的控制器
import fires.http.controllers.watch

/**
 * HttpKernel 会扫描指定路径下的所有控制器，并自动注册路由
*/
@HttpApplication["/src/http/controllers/"]
public class HttpKernel <: HttpServer {
    /**
     * 在这里管理非宏路由
     * 设置中间件信息
    */
    public func register(): Unit {
        // 全局中间件, 所有路由生效
        // 如果强制全部路由都执行的中间件, 必须在最前注册
        this.use(ResetMiddleware())

        // 监控工具设置
        this.group("watch-public").prefix("/watch")
        this.group("watch-login").prefix("/watch")

        // API监控工具, 虽然调用全局设置, 但因为在watch分组之后设置, 所以对watch不生效
        this.use(WatchMiddleware(), LogMiddleware())

        // 指定路由分组使用的中间件
        this.group("login").prefix("/api").middleware(LoginMiddleware())
        
        // 简易路由 http://127.0.0.1:8080/temp/张三
        this.get("/temp/:name", {
            req, rsp => rsp.text("OK get(name) = ${req.get("name")}")
        })
    }
}