local player_gui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local video_gui = Instance.new("ScreenGui")
video_gui.Name = "video_gui"
video_gui.Parent = player_gui

local video_frame = Instance.new("VideoFrame")
video_frame.Name = "video_frame"
video_frame.Size = UDim2.new(1, 0, 1.1, 0)
video_frame.Position = UDim2.new(0, 0, -0.05, 0)
video_frame.BackgroundColor3 = Color3.new(0, 0, 0)
video_frame.Video = ""
video_frame.Parent = video_gui

local response = request({
    Url = "https://raw.githubusercontent.com/whileloop-png/proj/main/videoplayback%20(1).mp4",
    Method = "GET"
})

if response and response.Body then
    local file_name = "videoplayback.mp4"
    writefile(file_name, response.Body)
    local custom_asset = getcustomasset(file_name)
    video_frame.Video = custom_asset
    video_frame:Play()
    video_frame.Ended:Connect(function()
        delfile(file_name)
        video_gui:Destroy()
    end)
else
    video_gui:Destroy()
end
