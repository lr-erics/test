namespace cpp2 hqth.trader
namespace py hqth.trader
namespace csharp hqth.trader

cpp_include "<unordered_map>"

struct Item {
1: string stock_id  //加密股票id
2: i32 rank         //预测排序
}

struct SortResult {
1: list<Item> res
2: i32 holding_seconds     //持仓时间，秒数为单位, 86400s * N 
3: i32 max_holding_count   // 该策略最多选多少只股票
}

exception Exception {
1: string message
}

struct ExecuteItem {
1: string uuid         //执行计划唯一ID 
2: string account_id   //交易账号id
3: string stock_id     //明文股票id
4: double buy_ratio    //买入资金比例
5: i32 sell_shares     //卖出股数
6: i32 buy_or_sell     //1 买入 0 不变 -1 卖出 
}

struct ExecuteResult {
1: list<ExecuteItem> res
}

struct CommanderReq{
1: string uuid
2: string sender_ip
3: map<string, SortResult> (cpp.template = "std::unordered_map") SortResults   //策略id -> 排序结果
}

struct CommanderRsp{
1: string uuid
2: string responder_ip
3: map<string, ExecuteResult> (cpp.template = "std::unordered_map") ExecuteResults   //策略id -> 一组交易指令
}


service CommanderService {
CommanderRsp execute(1: CommanderReq req) throws (1: Exception e)
} 
