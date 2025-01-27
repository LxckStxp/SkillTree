-- NetworkManager.lua

local NetworkManager = {}

function NetworkManager.Init(SkillTree) SkillTree.GlobalData.NetworkStatus = "Connected" end

function NetworkManager.SendData(data) SkillTree.Logger.Log("NetworkManager", "Sending data: " .. data) end

function NetworkManager.ReceiveData() SkillTree.Logger.Log("NetworkManager", "Receiving data"); return "Received data" end

return NetworkManager
 
