package fires.http.middleware

import light.web.Middleware
import light.web.Request
import light.web.Response
import light.log

/**
 * 请求打印中间件
*/
public class LogMiddleware <: Middleware {
    public func handle(r: Request, w: Response, next: (Request, Response)->Unit): Unit {
        log.debug("${r.httpContext.request.method}: ${r.httpContext.request.url}")
        
        next(r, w)
    }
}