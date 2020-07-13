namespace cpp2 hqth.trader
namespace py hqth.trader

cpp_include "<unordered_map>"

 enum ReqType {
 NORMAL = 0,    //正常买卖请求
 SPSL   = 1,    //止盈止损例行请求 stop profit and stop loss
 }
 
 struct PredictorReq {
 1: string uuid          //用于标示一次唯一请求，可追溯问题。
 2: string sender_ip     //请求方ip，方便追溯问题
 3: bool is_ready        //因子数据是否准备好。
 4: i64 timestamp        //当前最新可用的因子集合的时间
 5: ReqType type         //
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
