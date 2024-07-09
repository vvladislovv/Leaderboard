local DataStoreLeaderStats = {}
local DataStoreService = game:GetService("DataStoreService")

DataStoreLeaderStats.TotalHoney = function()
    local Table = {
        Name = "TotalHoney",
        APIKEY = "LeaderboardStore1",
        APIDSS = nil
    }
    Table.APIDSS = DataStoreService:GetOrderedDataStore(Table.Name..Table.APIKEY)
    return Table.APIDSS
end

return DataStoreLeaderStats