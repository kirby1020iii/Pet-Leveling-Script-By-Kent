local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PetAutoAgeGUI"
gui.ResetOnSpawn = false

-- Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0.05, 0, 0.6, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "Pet Auto Age 50"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 16
title.Parent = frame

-- Status Label
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -10, 0, 30)
status.Position = UDim2.new(0, 5, 0, 35)
status.BackgroundTransparency = 1
status.Text = "Holding: None"
status.TextColor3 = Color3.new(1,1,1)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

-- Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 75)
button.Text = "Age 50"
button.Font = Enum.Font.GothamBold
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(90, 160, 90)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = frame

-- Get current tool
local function getHeldTool()
    local char = player.Character
    if not char then return nil end
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            return tool
        end
    end
    return nil
end

-- Rename Tool (replace existing Age)
local function renameToolWithAge(tool)
    local name = tool.Name
    if string.find(name, "%[Age:? ?%d+%]") then
        name = name:gsub("%[Age:? ?%d+%]", "[Age: 50]")
    else
        name = name .. " [Age: 50]"
    end
    tool.Name = name
end

-- Update tool display
task.spawn(function()
    while true do
        local tool = getHeldTool()
        if tool then
            status.Text = "Holding: " .. tool.Name
        else
            status.Text = "Holding: None"
        end
        wait(0.3)
    end
end)

-- Button logic
local running = false

button.MouseButton1Click:Connect(function()
    if running then return end

    local tool = getHeldTool()
    if not tool then
        status.Text = "❌ No tool held!"
        return
    end

    running = true
    button.Active = false
    button.Text = "Aging..."
    button.BackgroundColor3 = Color3.fromRGB(180, 130, 50)

    for i = 50, 1, -1 do
        button.Text = "Aging... " .. i .. "s"
        wait(1)
    end

    renameToolWithAge(tool)

    status.Text = "✅ Tool is now [Age: 50]"
    button.Text = "Age 50"
    button.BackgroundColor3 = Color3.fromRGB(90, 160, 90)
    button.Active = true
    running = false
end)
