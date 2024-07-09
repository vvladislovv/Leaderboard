local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Modules.Libary.TweenModule)
local Utils = require(ReplicatedStorage.Modules.Libary.Utils)

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local ClientLeaderboard = {}

local LeaderModel = workspace.LeaderBoardBig
local UI = PlayerGui:WaitForChild('ScreenGui').Frame
local FreameOpen = false
local debounce = false 

function UIStart()
    task.wait()
    if FreameOpen then
        TweenModule.OpenUiLeaderstast(UI)
    else
        TweenModule.CloseUiLeaderstast(UI)
    end
end

function SettingsFrame(TopTen : table, LeaderBoardName : string)
    task.spawn(function()
        if TopTen == nil then
            repeat task.wait()
                return TopTen
            until TopTen ~= nil
        end
    end)

    for Number, Index in next, (TopTen) do
        UI.Frame.Currency.Text = `{Utils:CommaNumber(Index.value)} Honey (#{Number})`
        print(LeaderBoardName)
        UI.Frame.Namer.Text = LeaderBoardName
    end

end

LeaderModel.TouchedPart.Touched:Connect(function(hit) -- maybe error
    if Player and Player.Character and hit.Parent == Player.Character and not debounce then
        FreameOpen = true
        debounce = true
        UIStart()
        task.wait(1)  
        LeaderModel.TouchedPart.TouchEnded:Connect(function(hit)
            FreameOpen = false
            debounce = false  
            UIStart()
        end)
    end
end)

ReplicatedStorage.Remotes.LeaderCleint.OnClientEvent:Connect(SettingsFrame)

return ClientLeaderboard