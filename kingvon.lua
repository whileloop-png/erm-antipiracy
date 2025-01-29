if not writefile then             warn(getexecutorname() .. " doesnt support writefile")
elseif not getcustomasset then    warn(getexecutorname() .. " doesnt support getcustomasset")
elseif not delfile then           warn(getexecutorname() .. " doesnt support delfile") end
local plrgui                 = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local vidgui                 = Instance.new("ScreenGui") vidgui.Parent = plrgui
local vidframe               = Instance.new("VideoFrame")
vidframe.Name                = "video_frame"
vidframe.Size                = UDim2.new(1, 0, 1.1, 0)
vidframe.Position            = UDim2.new(0, 0, -0.05, 0)
vidframe.BackgroundColor3    = Color3.new(0, 0, 0)
vidframe.Video               = ""
vidframe.Parent              = vidgui
local response               = nil

    response                 = request({
    Url                      = "https://raw.githubusercontent.com/whileloop-png/proj/main/videoplayback%20(1).mp4",
    Method                   = "GET"})

if response and response.Body then
    local file_name          = "videoplayback.mp4"
    writefile(file_name, response.Body)
    local custom_asset       = getcustomasset(file_name)
    vidframe.Video           = custom_asset
    vidframe:Play()
    vidframe.Ended:Connect(function()
        delfile(file_name)
        video_gui:Destroy()
    end)
else
    vidgui:Destroy()
end
