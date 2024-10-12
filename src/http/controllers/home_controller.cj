package fires.http.controllers

import light.auto
import light.web.annotation.{Controller, GetMapping, PostMapping}
import light.web.{Request, Response}
import light.json.annotation.Json
import light.log
import jorm

@Controller
public class HomeController {
    // 这里读取的是 app.yaml[name]
    let name = auto.get<String>("config", "app.name")

    /**
     * 默认首页
    */
    @GetMapping['/']
    public func index(response: Response) {
        response.text("""
${name} <br> <a href="http://127.0.0.1:8080/watch/login.html" target="_blank">访问开发工具</a>
""")
    }

    /**
     * 自动注入对应的参数
     *  ?name 可选参数
    */
    @GetMapping['/home']
    public func home(name: ?String) {
        log.warn("name = ${name}")
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

    @GetMapping["/log"]
    public func logs() {
        log.trace("关注度最低的日志, 例如网络堆栈")
        log.debug("关注度较低的日志, 日常调试")
        log.info("重要的业务过程日志, 例如支付过程")
        log.warn("可能错误的日志, 可以不处理的警告")
        log.error("错误日志, 错误信息, 异常信息")
        return "OK"
    }

    @PostMapping["/admin/login"]
    public func login(response: Response) {
        response.json('{"code": 0, "msg": "ok", "data": {"token": "token"}}')
    }

    @GetMapping["/examination/:school/:class/:student"]
    public func examination(request: Request, response: Response) {
        let schoolID = request.get("school")
        let classID = request.get("class")
        let studentID = request.get("student")
        response.text("模拟多级参数; schoolID = ${schoolID} classID = ${classID} studentID = ${studentID}")
    }
}

// 测试对象
@Json
class User {
    var name: String = ""
}