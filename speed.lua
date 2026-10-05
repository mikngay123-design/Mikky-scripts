local P=game.Players.LocalPlayer
local G=Instance.new("ScreenGui",P.PlayerGui)
G.ResetOnSpawn=false

local F=Instance.new("Frame",G)
F.Size=UDim2.fromScale(.42,.4)
F.Position=UDim2.fromScale(.29,.3)
F.BackgroundColor3=Color3.fromRGB(25,15,45)
Instance.new("UICorner",F).CornerRadius=UDim.new(0,16)

local T=Instance.new("TextLabel",F)
T.Size=UDim2.fromScale(1,.22)
T.BackgroundTransparency=1
T.Text="⚡ SPEED LOBBY ⚡"
T.TextColor3=Color3.fromRGB(220,160,255)
T.TextScaled=true
T.Font=Enum.Font.GothamBold

local S=Instance.new("TextBox",F)
S.Size=UDim2.fromScale(.8,.17)
S.Position=UDim2.fromScale(.1,.25)
S.Text="1000"
S.PlaceholderText="Speed 1-1000"
S.TextScaled=true

local Fly=Instance.new("TextButton",F)
Fly.Size=UDim2.fromScale(.8,.17)
Fly.Position=UDim2.fromScale(.1,.47)
Fly.Text="🪽 FLY : OFF"
Fly.TextScaled=true
Fly.BackgroundColor3=Color3.fromRGB(100,45,180)
Fly.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",Fly).CornerRadius=UDim.new(0,10)

local Close=Instance.new("TextButton",F)
Close.Size=UDim2.fromScale(.8,.14)
Close.Position=UDim2.fromScale(.1,.72)
Close.Text="CLOSE"
Close.TextScaled=true
Instance.new("UICorner",Close).CornerRadius=UDim.new(0,10)

local Open=Instance.new("TextButton",G)
Open.Size=UDim2.fromOffset(65,65)
Open.Position=UDim2.fromScale(.05,.5)
Open.Text="⚡"
Open.TextScaled=true
Open.BackgroundColor3=Color3.fromRGB(120,50,220)
Instance.new("UICorner",Open).CornerRadius=UDim.new(1,0)

Close.MouseButton1Click:Connect(function()
	F.Visible=false
	Open.Visible=true
end)

Open.MouseButton1Click:Connect(function()
	F.Visible=true
	Open.Visible=false
end)

local flying=false
local bv,bg

Fly.MouseButton1Click:Connect(function()
	flying=not flying
	Fly.Text=flying and "🪽 FLY : ON" or "🪽 FLY : OFF"

	local C=P.Character or P.CharacterAdded:Wait()
	local Root=C:WaitForChild("HumanoidRootPart")

	if flying then
		bv=Instance.new("BodyVelocity",Root)
		bg=Instance.new("BodyGyro",Root)
		bv.MaxForce=Vector3.new(1e5,1e5,1e5)
		bg.MaxTorque=Vector3.new(1e5,1e5,1e5)

		task.spawn(function()
			while flying and Root.Parent do
				local cam=workspace.CurrentCamera
				local speed=math.clamp(tonumber(S.Text) or 1000,1,1000)
				bv.Velocity=cam.CFrame.LookVector*speed
				bg.CFrame=cam.CFrame
				task.wait()
			end
		end)
	else
		if bv then bv:Destroy() bv=nil end
		if bg then bg:Destroy() bg=nil end
	end
end)
