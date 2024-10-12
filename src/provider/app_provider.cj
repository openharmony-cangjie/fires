package fires.provider

import light.auto
import light.annotation.GetInstance
import light.bean.annotation.Bean
import light.bean.Server
import light.provider.*
import light.debug.watch.WatchProviderInstance

/**
 * 整个应用启动前进行引导
 */
@Bean
public class AppProvider {
    /**
     * 汇总所有的子引导
     * 声明在这里的引导才会被执行; 在这里控制引导的开启和关闭.
     * 在这里注册的"服务提供者"允许使用别名方式注入
     *  var port = auto.get<Int>("config" ,"mysql.port")
     */
    public init() {
        // 如果命名为config目录 会和 cjpm udpate 命令冲突
        configPath = "/yaml"
        
        // 必需的提供者
        @GetInstance(ConfigProvider()) // 提供 yaml 配置格式; 自动读取根目录 config
        @GetInstance(LogProvider())    // 提供 log 服务初始化, 本身不提供具体服务


        // 非必需的提供者
        //@GetInstance(MysqlProvider()) // jorm 初始化
        WatchProviderInstance() // 调试监控
    }

    // 统一启动所有独立服务
    public func server(servers: Array<Server>) {
        auto.runAllBoot()
        
        for (i in 0..(servers.size - 1)) {
            spawn {
                servers[i].run()
            }
        }
        // 最后一个服务阻塞
        servers[servers.size - 1].run()
    }
}