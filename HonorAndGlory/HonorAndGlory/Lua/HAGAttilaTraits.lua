--------------------------------------------------------------
-- HAGAttilaTraits
--------------------------------------------------------------
include("CitySupport");

-- Lua�C�x���g��@�����߂̂��܂��Ȃ�
ExposedMembers.LuaEvents = LuaEvents

-- �s�s���ח��������Ƃ�
function OnCityConquered(iVictoriousPlayer, iNewCityID)
	local pVictoriousPlayer = Players[iVictoriousPlayer]
	if not pVictoriousPlayer then
		return
	end
	local playerConfig = PlayerConfigurations[iVictoriousPlayer]
	local leaderType = playerConfig:GetLeaderTypeName()
	if (leaderType == "LEADER_HAG_ATTILA") then
		local pThisCity = CityManager.GetCity(iVictoriousPlayer, iNewCityID)
		if (not pThisCity) then
			return
		end
		if (pThisCity:GetOriginalOwner() ~= iVictoriousPlayer) then
			-- �s�s��j�󂷂�
			local tDidRazeComplete = {}
			tDidRazeComplete[0] = false
			LuaEvents.HAGAttila_GameplayScriptCalled(iVictoriousPlayer, iNewCityID, tDidRazeComplete);
			if (tDidRazeComplete[0] == true) then
				-- �j�󂵂��s�s�̐l���ɉ������S�[���h(�Q�[���X�s�[�h�ˑ�)����肵�ċ����j��
				-- ���̂Ƃ��Q�Ƃ����l���͓s�s���ח����Č�������̂���
				local pVictorPlayer = Players[iVictoriousPlayer]
				local eGameSpeed = GameConfiguration.GetGameSpeedType();
				local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier;
				print("iSpeedCostMultiplier: "..tostring(iSpeedCostMultiplier))
				-- iSpeedCostMultiplier
				-- * �I�����C���F50
				-- * �W���@�@�@�F100
				-- * ���ɒx���F300
				population = pThisCity:GetPopulation()
				print("City Population: "..tostring(population))
				gold = population * iSpeedCostMultiplier * 2
				print("Get gold: "..tostring(gold))
				pVictorPlayer:GetTreasury():ChangeGoldBalance(gold);
				Game.AddWorldViewText(0, "[COLOR_FLOAT_GOLD]+"..gold.." [ICON_Gold][ENDCOLOR]", pThisCity:GetX(), pThisCity:GetY(), 3)
			end
		end
	end
end

-- �n�`���P��Index���擾
function GetGameInfoIndex(table_name, type_name)
	local index;local table = GameInfo[table_name];
	if(table) then
		local t = table[type_name];
		if(t) then
			index = t.Index;
		end
	end
	-- �ؑ��̖�c�n:0���Ԃ�
	-- ���Z���̏W��:9���Ԃ�
	return index;
end

-- ���Z���̏W��or�ؑ��̖�c�n�Ƀ��j�b�g���d�˂��Ƃ�
function OnImprovementActivated(iX, iY, PlayerID, iUnitID, iImprovementIndex, iImprovementOwner,iActivationType1, ActivationType2)
	local victorConfig = PlayerConfigurations[PlayerID]

	if (victorConfig ~= nil) and (victorConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA") then
		print("Player # " .. PlayerID.. " : activated of " .. iImprovementIndex)
		if iImprovementIndex == GetGameInfoIndex("Improvements", "IMPROVEMENT_BARBARIAN_CAMP") then
			-- �ؑ��̖�c�n�Ȃ炻�̋ߕӂɊJ��҂�POP������
			UnitManager.InitUnitValidAdjacentHex(PlayerID, "UNIT_SETTLER", iX, iY, 1);
		end
	end
end

-- �C�x���g�Ɂ��̊֐�����������
Events.CityInitialized.Add(OnCityConquered)
Events.ImprovementActivated.Add(OnImprovementActivated);

print("HAGAttilaTraits.lua loaded successfully.")