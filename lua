local InputConnect
local AddedConnect
local PressedConnect
local function Stuff(char)
	local GUI = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
	GUI.Name = "IncreaserGUI"
	local frame = Instance.new("Frame",GUI)
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
	script.Name = "Increaser"
	local activated = false
	PressedConnect = button.MouseButton1Down:Connect(function()
		if activated == false then
			activated = true
			button.Text = "Enabled"
		else
			activated = false
			button.Text = "Disabled"
		end
	end)

	local lastpressed = nil
	InputConnect = game:GetService("UserInputService").InputBegan:Connect(function(inputObject,gpe)
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
	AddedConnect = char:WaitForChild("HumanoidRootPart").ChildAdded:Connect(function(descendant)
		print("added")
		local distance = tonumber(box.Text)
		if descendant:IsA("BodyPosition") and descendant.Name == "Dash" and activated == true then
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
end
Stuff(game.Players.LocalPlayer.Character)
game.Players.LocalPlayer.CharacterAdded:Connect(function(Character)
	PressedConnect:Disconnect()
	AddedConnect:Disconnect()
	InputConnect:Disconnect()
	Stuff(Character)
end)
