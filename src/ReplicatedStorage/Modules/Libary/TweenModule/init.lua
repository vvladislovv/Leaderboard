local TweenService = game:GetService("TweenService")

local TweenModule = {}

TweenModule.TableTweenInfo = {
    --['TweenDestroy'] = TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out,1,true)
}

function TweenModule.DestroyLeaderboard(Frame)
    Frame:TweenSize(UDim2.new(0,0,0,0), "Out", "Quad", 0.5, true)
    task.wait(0.5)
end

function TweenModule.StartLibary(Frame)
    Frame:TweenSize(UDim2.new(1, 0,0.125, 0), "Out", "Quad", 0.5, true)
    task.wait(0.5)
end

function TweenModule.OpenUiLeaderstast(UI)
    UI:TweenPosition(UDim2.new(0.5, 0,0.932, 0), 'Out', 'Quad', 0.5, true)
end

function TweenModule.CloseUiLeaderstast(UI)
    UI:TweenPosition(UDim2.new(0.5, 0,1.5, 0), 'Out', 'Quad', 0.5, true)
end


return TweenModule