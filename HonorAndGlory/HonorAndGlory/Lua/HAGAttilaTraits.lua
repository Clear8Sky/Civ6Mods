--------------------------------------------------------------
-- HAGAttilaTraits
--------------------------------------------------------------
-- �s�s���ח��������Ƃ�
function CityWasConquered(VictorID, LoserID, CityID, iCityX, iCityY)
	local playerConfig = PlayerConfigurations[VictorID]

	if playerConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA" then
		local pPlayer = Players[VictorID]
		local pCity =  pPlayer:GetCities():FindID(CityID)
		local sCity_LOC = pCity:GetName()
		print("Player # " .. VictorID.. " : captured the city of " .. Locale.Lookup(sCity_LOC))
		print("Player # " .. LoserID .. " lost the city")
		print("The city is located at (or used to be located at) grid X" .. iCityX .. ", Y" .. iCityY )

		-- �s�s�̐l���ɉ������S�[���h(�Q�[���X�s�[�h�ˑ�)����肵�ċ����j��
		-- ���̂Ƃ��Q�Ƃ����l���͓s�s���ח����Č�������̂���
		local eGameSpeed = GameConfiguration.GetGameSpeedType();
		local iSpeedCostMultiplier = GameInfo.GameSpeeds[eGameSpeed].CostMultiplier;
		print("iSpeedCostMultiplier: "..tostring(iSpeedCostMultiplier))
		-- iSpeedCostMultiplier
		-- * �I�����C���F50
		-- * �W���@�@�@�F100
		-- * ���ɒx���F300
		population = pCity:GetPopulation()
		print("City Population: "..tostring(population))
		gold = population * iSpeedCostMultiplier
		print("Get gold: "..tostring(gold))
		pPlayer:GetTreasury():ChangeGoldBalance(gold);
		
		if pPlayer == Game.GetLocalPlayer() then
			--�v���C���[���쎞�̏ꍇ�AUI�o�����܂܂��ƃA�N�Z�X�ᔽ���ł���ۂ��̂œs�s�I�����������Ă����
			UI.DeselectAllCities();
			CityManager.DestroyCity(pCity)
			UI.PlaySound("RAZE_CITY");
		else
			CityManager.DestroyCity(pCity)
		end
		print("Destroy City: ".. Locale.Lookup(sCity_LOC))
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
	local playerConfig = PlayerConfigurations[PlayerID]

	if playerConfig:GetLeaderTypeName() == "LEADER_HAG_ATTILA" then
		print("Player # " .. PlayerID.. " : activated of " .. iImprovementIndex)
		if iImprovementIndex == GetGameInfoIndex("Improvements", "IMPROVEMENT_BARBARIAN_CAMP") then
			-- �ؑ��̖�c�n�Ȃ炻�̋ߕӂɊJ��҂�POP������
			UnitManager.InitUnitValidAdjacentHex(PlayerID, "UNIT_SETTLER", iX, iY, 1);
		end
	end
end

-- �C�x���g�Ɂ��̊֐�����������
Events.ImprovementActivated.Add(OnImprovementActivated);
GameEvents.CityConquered.Add(CityWasConquered)
