package fires.http.middleware

import light.web.Middleware
import light.web.Request
import light.web.Response
import light.log

/**
 * 异常捕获
*/
public class ResetMiddleware <: Middleware {
    public func handle(r: Request, w: Response, next: (Request, Response)->Unit): Unit {
        try {
            next(r, w)   
        } catch (e: Exception) {
            e.printStackTrace()
            // let stacks = e.getStackTrace()
            // var trace = ""
            // for (stack in stacks) {
            //     trace += "at ${stack.methodName} (${stack.fileName}:${stack.lineNumber})\n"
            // }
            // log.error("请求发生错误: ${trace}")
            w.fail(500, e.toString())
        }
    }
}