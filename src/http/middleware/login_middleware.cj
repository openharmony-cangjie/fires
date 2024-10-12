package fires.http.middleware

import light.web.Middleware
import light.web.Request
import light.web.Response
import light.log

/**
 * 这是鉴权的请求头演示
*/
public class LoginMiddleware <: Middleware {
    public func handle(r: Request, w: Response, next: (Request, Response)->Unit): Unit {
        let token = r.header("Authorization")
        if (token.isEmpty()) {
            log.error("没有登录信息")
            w.status(401)
            w.text("Not Login")
        } else {
            // TODO 对 token 进行解析并保存结果

            // 后续各个路由分组中间件无需重复解析
            r.setContext("role", "admin")
            r.setContext("user_id", 1)

            // 允许执行
            next(r, w)   
        }
    }
}

