local activated = false
local gui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
local frame = Instance.new("Frame",gui)
frame.Size = UDim2.new(0,150,0,150)
frame.BackgroundTransparency = 1
frame.Position = UDim2.new(0, 0,0.3, 0)
local button = Instance.new("TextButton",frame)
button.Size = UDim2.new(1,0,1,0)
button.Text = "Disabled"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextScaled = true
button.BackgroundTransparency = 0.7
button.Font = "SciFi"
button.BackgroundColor3 = Color3.new(0, 0, 0)


local frame2 = Instance.new("Frame",frame)
frame2.Size = UDim2.new(0,150,0,50)
frame2.BackgroundTransparency = 1
frame2.Position = UDim2.new(0, 0,1, 0)
local box = Instance.new("TextBox",frame2)
box.BackgroundTransparency = 0.7
box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
box.Size = UDim2.new(1,0,1,0)
box.Text = 65
box.TextScaled = true
box.TextColor3 = Color3.fromRGB(255, 255, 255)


local frame2 = Instance.new("Frame",frame)
frame2.Size = UDim2.new(0,150,0,50)
frame2.BackgroundTransparency = 0.7
frame2.Position = UDim2.new(0, 0,1.4, 0)
frame2.BackgroundColor3 = Color3.new(0, 0, 0)
local text = Instance.new("TextLabel",frame2)
text.Size = UDim2.new(1,0,1,0)
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.BackgroundTransparency = 1
text.Position = UDim2.new(0, 0,0, 0)
text.TextScaled = true
text.Text = "AutoLock"


local frame2 = Instance.new("Frame",frame)
frame2.Size = UDim2.new(0,150,0,50)
frame2.BackgroundTransparency = 1
frame2.Position = UDim2.new(0, 0,1.75, 0)
local boxplayer = Instance.new("TextBox",frame2)
boxplayer.BackgroundTransparency = 0.7
boxplayer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
boxplayer.PlaceholderText = "Player Name"
boxplayer.Size = UDim2.new(1,0,1,0)
boxplayer.Text = ""
boxplayer.TextScaled = true
boxplayer.TextColor3 = Color3.fromRGB(255, 255, 255)



function onClicked()
	if activated == false then
		activated = true
		button.Text = "Enabled"
	else
		activated = false
		button.Text = "Disabled"
	end
end

button.MouseButton1Down:connect(onClicked)

local lastpressed = nil
game:GetService("UserInputService").InputBegan:Connect(function(inputObject,gpe)
	if inputObject.KeyCode == Enum.KeyCode.W and not gpe then
		lastpressed = "w"
	elseif inputObject.KeyCode == Enum.KeyCode.S and not gpe then
		lastpressed = "s"
	elseif inputObject.KeyCode == Enum.KeyCode.A and not gpe then
		lastpressed = "a"
	elseif inputObject.KeyCode == Enum.KeyCode.D and not gpe then
		lastpressed = "d"
	end	
end)
game.Players.LocalPlayer.Character.HumanoidRootPart.ChildAdded:Connect(function(descendant)
	local distance = tonumber(box.Text)
	if descendant:IsA("BodyPosition") and activated == true then
		if lastpressed == "w" then
			local IgnoreList = {}
			local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * distance)
			local part, position = workspace:FindPartOnRayWithWhitelist(ray, IgnoreList)
			descendant.Position = position
		elseif lastpressed == "a" then
			local IgnoreList = {}
			local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * -distance)
			local part, position = workspace:FindPartOnRayWithWhitelist(ray, IgnoreList)
			descendant.Position = position
		elseif lastpressed == "d" then
			local IgnoreList = {}
			local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.RightVector * distance)
			local part, position = workspace:FindPartOnRayWithWhitelist(ray, IgnoreList)
			descendant.Position = position
		elseif lastpressed == "s" then
			local IgnoreList = {}
			local ray = Ray.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector * -distance)
			local part, position = workspace:FindPartOnRayWithWhitelist(ray, IgnoreList)
			descendant.Position = position
		end
	end
end)
local focusing = true
game:GetService("UserInputService").InputBegan:Connect(function(inputObject,gpe)
	if (inputObject.KeyCode == Enum.KeyCode.LeftControl) then	
		if focusing == false then
			focusing = true
			game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		elseif focusing == true and game.Players:FindFirstChild(boxplayer.Text) and game.Players:FindFirstChild(boxplayer.Text).Character:FindFirstChild("HumanoidRootPart") then
			focusing = false
			game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		end
	end
end)
task.spawn(function()
	while game:GetService("RunService").RenderStepped:Wait() do
		if focusing == false and game.Players:FindFirstChild(boxplayer.Text) and game.Players:FindFirstChild(boxplayer.Text).Character:FindFirstChild("HumanoidRootPart") then
			if game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
				focusing = false
				break
			end

			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position,Vector3.new(game.Players:FindFirstChild(boxplayer.Text).Character.HumanoidRootPart.Position.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,game.Players:FindFirstChild(boxplayer.Text).Character.HumanoidRootPart.Position.Z))
			game.Workspace.CurrentCamera.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.new(Vector3.new(7.5,2.5,10))
		end	
	end
end)
script.Parent = gui
local clone = gui:Clone()
clone.Parent = game.StarterGui

game.Players.LocalPlayer.CharacterAdded:Connect(function(Character)
	clone:Clone().Parent = game.Players.LocalPlayer.PlayerGui
end)
