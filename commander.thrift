namespace cpp2 hqth.trader
namespace py hqth.trader
namespace csharp hqth.trader

include “predictor.thrift"

cpp_include "<unordered_map>"

struct ExecuteItem {
1: string account_id   //交易账号id
2: string stock_id     //股票id
3: float ratio         //买入比例
4. i32 buy_in_out      //买入卖出方向，0不变 -1 卖出 1 买入
}

struct ExecuteResult {
1: list<ExecuteItem> res
}

struct HoldingItem {
1：string stock_id
2: i32 stock_type      // 0 normal； 1 ST； 2 未来N天内待退市股票。
3: float market_value
4: i32 shares
}

// 基金交易账户持仓信息
struct FundAccountInfo {
1. list<HoldingItem> items
2. float balance
3. i32 account_type    // 0 普通账号，1 信用账号
}

exception Exception {
1: string message
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


service CommanderService {
CommanderRsp execute(1: CommanderReq req)throws (1: Exception e)
} 
