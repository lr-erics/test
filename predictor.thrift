namespace cpp2 hqth.trader
namespace py hqth.trader

cpp_include "<unordered_map>"

struct PredictorReq {
1: string uuid          //用于标示一次唯一请求，可追溯问题。
2: string sender_ip     //请求方ip，方便追溯问题
3: bool is_ready        //因子数据是否准备好。
4: i64 timestamp        //当前最新可用的因子集合的时间
}

//struct PredictorRsp{
//1: string uuid
//2: string responder_id
//3: string data_version
//4: map<string, SortResult> (cpp.template = "std::unordered_map") SortResults   //一个模型对应一个结果
//}

service PredictorService {
oneway void predict(1: PredictorReq req)
} 
