package fires.http.controllers

import light.auto
import light.web.annotation.{Controller, GetMapping, PostMapping}
import light.web.{Request, Response}
import fires.service.UserService

/**
 * 限制登录的控制器, login 是一个路由分组, 多个控制器可以使用相同的分组
*/
@Controller["login"]
public class UsersController {
    // 无需手动管理UserService构建, 直接使用
    let userService = auto.inject<UserService>()

    @GetMapping["/user/:id"]
    public func index(request: Request, response: Response) {
        let id = request.get("id")
        response.text("执行成功, 你的请求存在请求头; id = ${id}")
    }
}