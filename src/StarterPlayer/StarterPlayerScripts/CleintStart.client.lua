local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Module = ReplicatedStorage:WaitForChild('Modules')


local success,Erro = pcall(function()
    for _, index in next, (Module:GetDescendants()) do
        if index:IsA('ModuleScript') then
            require(index)
        end        
    end
end)


coroutine.wrap(function()
    if success then
        print("All Scripts Start")
    else
        warn(`{Erro}`)
    end
end)()