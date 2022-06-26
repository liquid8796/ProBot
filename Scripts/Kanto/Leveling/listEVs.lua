local ev = {}

local SpAtk = 
{
'Abra',
'Magnemite',
'Oddish',
'Gastly',
'Haunter',
'Venomoth',
'Budew',
}
local Atk = 
{
'Machop',
'Mankey',
'Nidoran M',
'Teddiursa',
}
function ev.getListEVs(EVtype)
	if EVtype == "SpAtk" then
		return SpAtk
	end
	if EVtype == "Atk" then
		return Atk
	end
end

return ev