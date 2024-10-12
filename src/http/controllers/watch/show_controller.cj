package fires.http.controllers.watch

import light.auto
import light.web.annotation.{Controller, GetMapping, PostMapping}
import light.web.{Request, Response}
import light.log
import light.data.Map
import light.json.annotation.Json
import light.debug.watch
import std.collection.ArrayList
import light.data.WriterValue
import encoding.json.*

@Controller["watch-login"]
public class ShowController {
    @GetMapping["/show/request"]
    public func login(last: ?String) {
        // 模型统一生成 jj gen:entity -database=watch -out=./src/debug/watch  -packageName=light.debug.watch -outDB=watch
        var model = watch.LogModel().whereWatch("request").limit(50).orderBy("id desc")
        if (let Some(lastID) <- last) {
            model = model.whered("id", "<", lastID)
        }
        let dto = Map()
        let list = ArrayList<Map>()
        for (entity in model.get()) {
            let context = JsonObject.fromStr(entity.content).asObject()
            
            let m = Map()
            m["id"] = entity.id
            m["method"] = context.get("method").getOrThrow().toString()
            m["status"] = "200"
            m["uri"] = entity.message
            list.append(m)
        }
        dto["list"] = list.toArray()
        return dto
    }
}