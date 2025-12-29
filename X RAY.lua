-- X RAY BUTTON + KEY (X)

local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 120, 0, 45)
Button.Position = UDim2.new(0.1, 0, 0.4, 0)
Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
Button.Text = "X RAY : OFF"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 18
Button.BorderSizePixel = 0
Button.Active = true
Button.Draggable = true

-- Variables
local xray = false
local savedParts = {}

-- Function
local function setXRay(state)
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and not obj:IsDescendantOf(Player.Character) then
			if state then
				if not savedParts[obj] then
					savedParts[obj] = obj.Transparency
				end
				obj.Transparency = 0.6
			else
				if savedParts[obj] then
					obj.Transparency = savedParts[obj]
				end
			end
		end
	end
end

-- Toggle
local function toggleXRay()
	xray = not xray
	if xray then
		Button.Text = "X RAY : ON"
		Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		setXRay(true)
	else
		Button.Text = "X RAY : OFF"
		Button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
		setXRay(false)
	end
end

-- Button click
Button.MouseButton1Click:Connect(toggleXRay)

-- Keybind (X)
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.X then
		toggleXRay()
	end
end)
