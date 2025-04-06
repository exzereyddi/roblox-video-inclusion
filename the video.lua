local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VideoMenu"
screenGui.Parent = game.Players.LocalPlayer.PlayerGui
screenGui.ResetOnSpawn = true

local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 400, 0, 400)
menuFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
menuFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
menuFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Text = "Video Menu"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.Parent = menuFrame

local videoFrame = Instance.new("VideoFrame")
videoFrame.Size = UDim2.new(1, 0, 0.6, 0)
videoFrame.Position = UDim2.new(0, 0, 0.1, 0)
videoFrame.BackgroundColor3 = Color3.new(0, 0, 0)
videoFrame.Parent = menuFrame

-- Предустановленные видео
local videos = {
    ["Little drive"] = "rbxassetid://5670799859",
    ["Fight Loop"] = "rbxassetid://5608368298",
    ["Pizza Ad"] = "rbxassetid://5608304953"
}

local currentAspectRatio = "16:9" -- Текущее соотношение сторон
local buttonsHeight = 0 

local function playVideo(videoId)
    videoFrame.Video = videoId
    videoFrame:Play()
    updateVideoSize()
end

local function updateVideoSize()

  local videoAspectRatio
  if currentAspectRatio == "16:9" then
    videoAspectRatio = 16/9
  elseif currentAspectRatio == "4:3" then
    videoAspectRatio = 4/3
  elseif currentAspectRatio == "1:1" then
    videoAspectRatio = 1/1
  elseif currentAspectRatio == "21:9" then
    videoAspectRatio = 21/9
  end
    local videoHeight = menuFrame.Size.X.Offset * (0.6) / videoAspectRatio
    menuFrame.Size = UDim2.new(0, 400, 0, videoHeight + 30 + buttonsHeight)
end

local i = 0
for name, id in pairs(videos) do
    i = i + 1
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.Position = UDim2.new(0, 0, 0.6 + (i * 0.1), 0)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = name
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Parent = menuFrame
    buttonsHeight = buttonsHeight + 30
    button.MouseButton1Click:Connect(function()
        playVideo(id)
    end)
end

-- Кнопки для выбора соотношения сторон
local aspectRatios = {"16:9", "4:3", "1:1", "21:9"}
for i, ratio in ipairs(aspectRatios) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 60, 0, 25)
    button.Position = UDim2.new(1 + (i-1) * 0.15, 0, 0.0 , 0)
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = ratio
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Parent = menuFrame
    
    button.MouseButton1Click:Connect(function()
        currentAspectRatio = ratio
        updateVideoSize()
    end)
end

-- Реализация перетаскивания меню
local dragging = false
local dragStartPos

menuFrame.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = input.Position
    end
end)

menuFrame.InputEnded:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input, gameProcessedEvent)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartPos
        local newPosition = menuFrame.Position + UDim2.new(0, delta.X, 0, delta.Y)
        menuFrame.Position = newPosition
        dragStartPos = input.Position
    end
end)