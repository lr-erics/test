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
}

exception Exception {
1: string message
}

enum StockType {
NORMAL = 1,
ST = 2,        //special treatment
To_DELIST = 3, //未来(N天内)即将退市股票
}

enum AccountType {
GENERAL_ACCOUNT = 1,
CREDIT_ACCOUNT = 2,
}

struct ExecuteItem {
1: string account_id   //交易账号id
2: string stock_id     //明文股票id
3: double ratio        //买入比例
4: i32 buy_in_out      //买入卖出方向，0不变 -1 卖出 1 买入
}

struct ExecuteResult {
1: list<ExecuteItem> res
}

struct HoldingItem {
1: string stock_id     //明文股票id
2: StockType type      
3: double market_value
4: i32 shares
}

// 基金交易账户持仓信息
struct FundAccountInfo {
1: list<HoldingItem> items
2: double balance
3: AccountType type    
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
CommanderRsp execute(1: CommanderReq req) throws (1: Exception e)
} 
