package fires.provider

import light.auto
import light.bean.annotation.Bean
import light.log
import log.LogLevel
import std.console.Console

@Bean
public class LogProvider {
    // 这里读取的是 app.yaml[name]
    let name = auto.get<String>("config", "app.name")

    public init() {
        // 设置日志级别
        log.setDefaultLog(log.TextLogger(Console.stdOut, LogLevel.TRACE))

        log.debug(name)
    }
}