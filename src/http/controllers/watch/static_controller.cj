package fires.http.controllers.watch

import light.auto
import light.web.annotation.{Controller, GetMapping}
import light.web.{Request, Response}
import light.log
import std.fs.{File, OpenOption, Path}
import std.collection.HashMap
import light.common.GetPwd

let sfc = """
import { loadModule } from 'vue3-sfc-loader'
import * as request from "request";

const options = {
    moduleCache: { vue: Vue, request: request },
    getFile: () => `<template></template>`,
    addStyle(textContent) {
        const style = Object.assign(document.createElement('style'), { textContent });
        const ref = document.head.getElementsByTagName('style')[0] || null;
        document.head.insertBefore(style, ref);
    },
}

export default Vue.defineAsyncComponent(() => loadModule('auto.vue', options))
"""

/**
 * 静态资源控制器
*/
@Controller["watch-public"]
public class StaticController {
    // 非静态编译, 指定读取目录, pwd + root 访问
    let root: String = "/resources/watch"

    public init() {
        log.debug("启动了watch静态服务, 使用 host/watch/* 进行访问")
    }
    
    @GetMapping["/"]
    public func ui(response: Response) {
        response.status(302)
        response.header("Location", "/watch/index.html")
    }

    @GetMapping["/*"]
    public func index(request: Request, response: Response): Unit {
        // 对路由切割
        let pathStr: String = GetPwd() + this.root +"/"+ request.httpContext.request.url.path["/watch/".size..]
        let filePath: Path = Path(pathStr)
        if (!File.exists(filePath)) {
            log.warn("找不到静态资源 ${filePath}")
            response.body("Not Found")
            response.status(404)
        } else if(filePath.extensionName == "vue") {
            var code = String.fromUtf8(File.readFrom(filePath))
            code = code.replace("$", "\\$")
            code = code.replace("`", "\\`")
            
            let vueCode = sfc.replace("<template></template>", code)

            response.header("Content-Type", "application/javascript; charset=utf-8")
            response.body(vueCode)
        } else {
            match (filePath.extensionName) {
                case Some("html") => response.header("Content-Type", "text/html; charset=utf-8")
                case Some("js") => response.header("Content-Type", "application/javascript; charset=utf-8")
                case Some("css") => response.header("Content-Type", "text/css; charset=utf-8")
                case Some("png") => response.header("Content-Type", "image/png")
                case Some("jpg") | Some("jpeg") => response.header("Content-Type", "image/jpeg")
                case Some("gif") => response.header("Content-Type", "image/gif")
                case Some("svg") => response.header("Content-Type", "image/svg+xml")
                case Some("json") => response.header("Content-Type", "application/json; charset=utf-8")
                case Some("txt") => response.header("Content-Type", "text/plain; charset=utf-8")

                case Some("ttf") => response.header("Content-Type", "application/font-sfnt")
                case Some("otf") => response.header("Content-Type", "font/otf")
                case Some("woff") => response.header("Content-Type", "application/font-woff")
                case Some("woff2") => response.header("Content-Type", "application/font-woff2")

                case _ => response.header("Content-Type", "application/octet-stream")
            }
            response.body(File.readFrom(filePath))
            return;
        }
    }

    private func loadVueView() {
        
    }
}