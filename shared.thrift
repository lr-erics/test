namespace cpp2 hqth.trader
namespace py hqth.trader
namespace csharp hqth.trader

struct Item {
1: string stock_id  //股票id
2: i32 rank         //预测排序
}

struct SortResult {
1: list<Item> res
}

exception Exception {
1: string message
}
