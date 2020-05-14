namespace cpp2 hqth.trader
namespace py hqth.trader

cpp_include "<unordered_map>"

struct PredictorReq {
1: string uuid          //用于标示一次唯一请求，可追溯问题。
2: string sender_ip     //请求方ip，方便追溯问题
3: bool is_ready        //因子数据是否准备好。
4: i64 timestamp        //当前最新可用的因子集合的时间
}

struct Item {
1: string stock_id  //股票id
2: i32 rank         //预测排序
}

struct SortResult {
1: list<Item> res
}

struct ExecuteItem {
1: string stock_id  //股票id
2: i32 shares       //预测排序
3: bool buyInOut     //买卖方向
}

struct ExecuteResult {
1: list<ExecuteItem> res
}

exception Exception {
1: string message
}

struct PredictorRsp {
1: string uuid
2: string responder_id
3: string data_version
4: map<string, SortResult> (cpp.template = "std::unordered_map") SortResults   //一个模型对应一个结果
}

struct CommanderReq{
1: string uuid
2: string sender_ip
3: map<string, SortResult> (cpp.template = "std::unordered_map") SortResults   //一个模型对应一个结果
}

struct CommanderRsp{
1: string uuid
2: string responder_ip
3: map<string, ExecuteResult> (cpp.template = "std::unordered_map") ExecuteResults   //一个模型对应一个结果
}

service PredictorService {
oneway void predict(1: PredictorReq req)
}

service CommanderService {
CommanderRsp execute(1: CommanderReq req)throws (1: Exception e)
} 

