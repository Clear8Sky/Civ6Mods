--------------------------------------------------------------
-- HAGCityNameHuns
--------------------------------------------------------------
function OnCityBuilt( playerID: number, cityID : number, cityX : number, cityY : number )	
	local playerConfig = PlayerConfigurations[playerID]

	if playerConfig:GetCivilizationTypeName() == "CIVILIZATION_HAG_HUNS" then
		local pPlayer = Players[playerID]
		local pBuiltCity = CityManager.GetCity(playerID, cityID);
		local pCapitalCity = pPlayer:GetCities():GetCapitalCity()
		
		print(tostring(cityID))
		-- ���������鏈��
		if (pCapitalCity == nil) then
			print("this is capital city.")
		else
			print("this is not capital city.")

			local results	:table;
			local name		:string;
			-- DB���@���Ŏ��g�̕����ȊO�̓s�s���������_����1����Ă���
			results = DB.Query("SELECT CityName FROM CityNames WHERE CivilizationType != 'CIVILIZATION_HAG_HUNS' ORDER BY RANDOM() LIMIT 1");
			for i, row in ipairs(results) do
				name = row.CityName;
				break;
			end
			print(Locale.Lookup(name))
			pBuiltCity:SetName(Locale.Lookup(name));
		end
	end
end

-- �Q�[���C�x���g�Ɂ��̊֐�����������
-- ��CityBuilt()�͓s�s�𗎂Ƃ����Ƃ��ɂ��������A�Q�[���̐i�s�ɉe�����Ȃ��̂ŋC�ɂ��Ȃ����ƂƂ���
GameEvents.CityBuilt.Add(OnCityBuilt);
