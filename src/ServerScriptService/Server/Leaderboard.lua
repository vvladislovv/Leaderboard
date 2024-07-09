local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Libary = ReplicatedStorage.Modules.Libary
local Template = ReplicatedStorage.FrameLeaderBoard
local GetLeadBoard = workspace.LeaderBoardBig.SettingsScreens.Scroller.SurfaceGui.ScrollingFrame
local TimetLeadboard = workspace.LeaderBoardBig.SettingsScreens.Timer
local Cooldown = 30
local Restart = false
--! Get Libary 
local Players = game:GetService("Players")
local Utils = require(Libary.Utils)
local GloableTable = require(Libary.GloableTable)
local TweenModule = require(Libary.TweenModule) --! write scritp 
local DataStoreLeaderStats = require(script.Parent.DataStoreTest)
local Leaderboard = {}

--! написать таймер и также чтобы внизу надпись какое место 
function CleadBoard()
    for _, Index in next, (GetLeadBoard:GetChildren()) do
        if not Index:IsA('UIListLayout') then
            TweenModule.DestroyLeaderboard(Index)
            task.wait(0.3)
            Index:Destroy()
        end
    end
end

function StartBoard()
    coroutine.wrap(function()
        for _, Index in next, (GetLeadBoard:GetChildren()) do
            if not Index:IsA('UIListLayout') then
                TweenModule.StartLibary(Index)
            end
        end
    end)()
end

function RestartLeaderboard()
    local Sucees, Error = pcall(function()
        local Pages = DataStoreLeaderStats.TotalHoney():GetSortedAsync(false,100)
        local TopTen = Pages:GetCurrentPage()
        for _, index in next, (TopTen) do
            DataStoreLeaderStats.TotalHoney():RemoveAsync(index)
        end
        Restart = true
        --CleadBoard()
        task.wait(0.5)
        Restart = false
        TimerStart()
    end)

    if Error then
        warn(Error)
    end

end

function TimerStart() -- 68400 -- 86399new
    local targetDate = os.time() + 86399 

    coroutine.wrap(function()
        while true do
            local Time = os.date("!*t", os.time() + 3* 60 * 60)  -- Change - 5 to whatever your timezone is (EG. New York = - 5)
            --print(Time)
            local currentDate = os.time()
            local secondsLeft = targetDate - currentDate
            print(Utils:FormatTime(secondsLeft))
            if Utils:FormatTime(secondsLeft) == "00:00" then
                warn('Restart Leaderboard')
                TimetLeadboard.SurfaceGui.TextLabel.Text = "Updating!"
                RestartLeaderboard()
                break
            else
                TimetLeadboard.SurfaceGui.TextLabel.Text = Utils:FormatTime(secondsLeft)
            end
                task.wait(1)
            end
    end)()
end


function DescFrame(NewFramePlayer : string ,key : number, Index : number, PlayerIcon,PlayerName : string)
    NewFramePlayer.BackgroundColor3 = GloableTable.ColorLiderBoard[key]['Color'..1]
    NewFramePlayer.Icon.BackgroundColor3 = GloableTable.ColorLiderBoard[key]['Color'..2]
    NewFramePlayer.Frame.BackgroundColor3 = GloableTable.ColorLiderBoard[key]['Color'..2]
    NewFramePlayer.Icon.ImageLabel.Image = PlayerIcon
    NewFramePlayer.Honey.Text = Utils:CommaNumber(Index.value) -- Utils:Addprefixes
    NewFramePlayer.Nick.Text = PlayerName
    NewFramePlayer.Number.Text = "#"..key
end

function Leaderboard.UpdateBoard()
    local Pages = DataStoreLeaderStats.TotalHoney():GetSortedAsync(false,100)
    local TopTen = Pages:GetCurrentPage()   

    coroutine.wrap(function()
        for _, Player in next, (Players:GetPlayers()) do
            ReplicatedStorage.Remotes.LeaderCleint:FireClient(Player,TopTen,"Top 100 Honey Markers") -- 3 Argiments 
        end
    end)()

    CleadBoard()

    for key,Index in next, (TopTen) do
        local PlayerName = Players:GetNameFromUserIdAsync(Index.key)
        local PlayerIcon = Players:GetUserThumbnailAsync(Index.key, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        
        if Index.value > 0 then
            local NewFramePlayer = Template:Clone()
            NewFramePlayer.Parent = GetLeadBoard
            coroutine.wrap(function()
                StartBoard()
            end)()

            if key >= 1 and key <= 5 then
                DescFrame(NewFramePlayer,key, Index, PlayerIcon,PlayerName)
            else
                if math.random(1,100) > 50 then
                    DescFrame(NewFramePlayer,key, Index, PlayerIcon,PlayerName)
                else
                    DescFrame(NewFramePlayer,key, Index, PlayerIcon,PlayerName)
                end
            end
        end

    end
end

TimerStart()

coroutine.wrap(function()
    while true do task.wait()
        for _, Player in next, (Players:GetPlayers()) do
            -- local PData = Data:Get(Player)
            local Currency = Player.leaderstats.Honey.value
            local Sucees, Erro = pcall(function()
                if not GloableTable.BlackList[Player.UserId] and not Restart then
                    DataStoreLeaderStats.TotalHoney():SetAsync(Player.UserId, math.floor(Currency))
                else
                    DataStoreLeaderStats.TotalHoney():SetAsync(Player.UserId, 0)
                end
            end)

            if Erro then
                warn(Erro)
            end
        end

        coroutine.wrap(function()
            Leaderboard.UpdateBoard()
        end)()

        task.wait(Cooldown)
    end
end)()


return Leaderboard