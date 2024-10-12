package fires.provider

import light.auto
import light.log
import light.bean.annotation.Bean
import light.bean.Boot
import std.collection.HashMap
import jorm
import mysql

/**
 * 这里是 jorm 框架的链接初始化和提供注入服务
 * 使用方式:
 *   var db = auto.get<DB>("mysql")
 */
@Bean["mysql"]
public class MysqlProvider <: Boot & auto.ProviderAny {
    // 读取所有的数据配置
    var config = auto.get<HashMap<String, Any>>("config", "database.mysql")
    // var config = HashMap<String, Any>()

    var db: jorm.DB = jorm.DB()

    public func boot() {
        this.initMysql(config)
    }

    private func initMysql(m: HashMap<String, Any>) {
        let host = (m["host"] as String).getOrThrow()
        let username = (m["username"] as String).getOrThrow()
        let password = (m["password"] as String).getOrThrow()
        let database = (m["database"] as String).getOrThrow()
        let port = (m["port"] as Int64).getOrThrow()

        // 初始化数据库驱动
        let mysqlDriver = mysql.MysqlDriver("mysql")
        // 通过connectionString和选项打开数据源
        let datasource: mysql.MysqlDatasource = mysqlDriver.open(
            "${username}:${password}@tcp(${host}:${port})/${database}",
            Array<(String, String)>()
        )

        jorm.SetDefaultConnection(datasource.connect())

        log.debug("mysql 数据库初始化完成")
    }

    public func getAny(alias: String): Any {
        return this.db
    }
}