local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    local LeaderFolder = Instance.new('Folder', player)
    LeaderFolder.Name = 'leaderstats'

    local Honey = Instance.new("IntValue",LeaderFolder)
    Honey.Name = "Honey"
    Honey.Value = 100000


end)
