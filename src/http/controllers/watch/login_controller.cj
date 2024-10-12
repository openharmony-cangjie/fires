package fires.http.controllers.watch

import light.auto
import light.web.annotation.{Controller, GetMapping, PostMapping}
import light.web.{Request, Response}
import light.log
import light.data.Map
import light.json.annotation.Json

@Controller["watch-public"]
public class LoginController {
    @PostMapping
    public func login(response: Response, username: String, password: String) {
        if (username != "admin") {
            return response.fail(501, "测试账号是 admin")
        }
        if (password != "123456") {
            return response.fail(502, "测试密码是 123456")
        }
        
        // 返回一个 token
        let token = "123456"

        let dto = Map()
        dto["token"] = token
        dto["role"] = "watch"

        // 补充一个 session; 一个小时后过期
        response.cookie("Auth", token, 3600)

        return dto
    }
}