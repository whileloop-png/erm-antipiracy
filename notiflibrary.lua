local WindowsError = {}
WindowsError.__index = WindowsError

local activeErrors          = {} --//track amount of active errors
local originalPos           = UDim2.new(0.5, -150, 0.5, -100)--//original position no offset
local stackOffset           = Vector2.new(20, 20)--//stacking offset

function WindowsError.new(warningText, errorMessage)
    local self              = setmetatable({}, WindowsError)

    local offset            = #activeErrors * stackOffset
    local position          = UDim2.new(
                            originalPosition.X.Scale,
                            originalPosition.X.Offset + offset.X,
                            originalPosition.Y.Scale,
                            originalPosition.Y.Offset + offset.Y
                            )
    local response = request({
        Url = "https://raw.githubusercontent.com/whileloop-png/proj/main/youtube_RCkUxdRSuEk_audio.mp3",
        Method = "GET"
    })

    if response then
        local fileName = "youtube_RCkUxdRSuEk_audio.mp3"
        writefile(fileName, response.Body)
        local asset = getcustomasset(fileName)

        local Sound = Instance.new("Sound")
        Sound.SoundId = asset
        Sound.Volume = 1
        Sound.Parent = game:GetService("SoundService")
        Sound:Play()
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local FrameImage = Instance.new("ImageLabel")
    local CloseButton = Instance.new("TextButton")
    local ErrorText = Instance.new("TextLabel")
    local WarningTxt = Instance.new("TextLabel")

    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.Size = UDim2.new(0, 300, 0, 200)

    FrameImage.Name = "FrameImage"
    FrameImage.Parent = Frame
    FrameImage.BackgroundTransparency = 1
    FrameImage.Size = UDim2.new(1, 0, 1, 0)
    FrameImage.Image = "http://www.roblox.com/asset/?id=5835708699"

    ErrorText.Parent = Frame
    ErrorText.BackgroundTransparency = 1
    ErrorText.Text = errorMessage or "Error" --//if no error message then default to "error"
    ErrorText.Font = Enum.Font.Arial
    ErrorText.TextSize = 14
    ErrorText.TextColor3 = Color3.fromRGB(0, 0, 0)
    ErrorText.Position = UDim2.new(0, 70, 0, 80)
    ErrorText.Size = UDim2.new(0, 160, 0, 50)
    ErrorText.TextWrapped = true

    WarningTxt.Parent = Frame
    WarningTxt.BackgroundTransparency = 1
    WarningTxt.Text = warningText or "Error" --//if no error message then default to "error"
    WarningTxt.Font = Enum.Font.SourceSansBold
    WarningTxt.TextSize = 14
    WarningTxt.Position = UDim2.new(0, 5, 0, 3)
    WarningTxt.Size = UDim2.new(0, 100, 0, 25)
    WarningTxt.TextWrapped = true
    WarningTxt.TextXAlignment = Enum.TextXAlignment.Left
    WarningTxt.TextYAlignment = Enum.TextYAlignment.Top

    if WarningTxt.Text == "Error" then
        WarningTxt.TextColor3 = Color3.fromRGB(255, 0, 0) --//red
    elseif WarningTxt.Text == "Warning" then
        WarningTxt.TextColor3 = Color3.fromRGB(255, 165, 0) --//orange
    elseif WarningTxt.Text == "Alert" then
        WarningTxt.TextColor3 = Color3.fromRGB(255, 255, 0) --//yellow
    else
        WarningTxt.TextColor3 = Color3.fromRGB(255, 255, 255) --//default white
    end

    CloseButton.Parent = Frame
    CloseButton.Text = "OK"
    CloseButton.Font = Enum.Font.SourceSans
    CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
    CloseButton.BorderSizePixel = 1
    CloseButton.TextSize = 14
    CloseButton.Position = UDim2.new(0.5, -40, 0.85, -15)
    CloseButton.Size = UDim2.new(0, 80, 0, 25)

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.Parent = CloseButton
    CloseCorner.CornerRadius = UDim.new(0, 1.5)

    local CloseStroke = Instance.new("UIStroke")
    CloseStroke.Parent = CloseButton
    CloseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    CloseStroke.Color = Color3.fromRGB(3, 9, 120)
    CloseStroke.Thickness = 2

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        table.remove(activeErrors, table.find(activeErrors, self))
    end)

    self.Gui = ScreenGui
    self.Frame = Frame

    table.insert(activeErrors, self)

    return self
end

return WindowsError
