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
2: i32 holding_time
}

exception Exception {
1: string message
}

enum StockType {
NORMAL = 1,
ST = 2,           //special treatment
TO_DELIST = 3,    //未来(N天内)即将退市股票
LIMIT_UP = 4,    //涨停
LIMIT_DOWN = 5,  // 跌停
}

struct Stock {
1: string stock_id
2: StockType type
}

struct StockCandidates {
1: list<Stock> candidates
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
1: string stock_id       //明文股票id
2: StockType type        
3: double market_value   // 总市值
4: i32 shares            // 总持仓量
5: map<string, i32> (cpp.template = "std::unordered_map") holding_details  // 策略id->持仓量
}

// 策略关联交易账户的持仓信息
struct FundAccountInfo {
1: string account_id
2: list<HoldingItem> items
3: double balance
4: AccountType type    
}

struct StrategyObject {
1: map<string, list<FundAccountInfo>> (cpp.template = "std::unordered_map") details; 
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
