package fires

import light.annotation.GetInstance
import light.App
import light.log
import fires.provider
import fires.http

main(): Int64 {
    // 创建一个APP实例
    // 引导服务在 provider 目录，并且由 AppProvider 进行引导
    // 如果需要新增一些[mysql、cache、s3]等待类似的服务，可以在 provider 目录下新增一个 s3_provider进行引导
    let app = @GetInstance(provider.AppProvider())

    // 独立服务需要在这里进行逐一赋值
    // 内部会对每个应用 server 进行初始化
    app.server([
        // web 应用
        @GetInstance(http.HttpKernel())
        // crond 应用
        // @GetInstance(CrondKernel())
        // queue 应用
        // @GetInstance(QueueKernel())
    ])

    return 0
}