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
		-- ��s���Ȃ��Ƃ��͉������Ȃ�(��ԍŏ��Ɍ��Ă��Ƃ�)
		if (pCapitalCity == nil) then
			print("this is first built.")
			return
		end
		-- ���͑������̓s�s�������ꍇ���������Ȃ�
		-- (�s�s�j��O�̐�̔��莞�B��s�ȊO�͎����j��A��s�������ꍇ�͏������������Ȃ����ƂƂ���)
		if (pBuiltCity:GetOriginalOwner() ~= pBuiltCity:GetOwner()) then
			print("original owner is not you.")
			return
		end

		-- ���������鏈��
		print("Rename city.")

		local results	:table;
		local name		:string;
		-- DB���@���Ŏ��g�̕����ȊO�̓s�s���������_����1����Ă���
		-- ��SQLite�ɂ�����ORDER BY RANDOM()�͔��ɒx���̂����A
		--   MOD���ʂɓ��ꂽ��Ԃł��x���Ƃ͊����Ȃ��̂łƂ肠�������͂Ȃ�����
		results = DB.Query("SELECT CityName FROM CityNames WHERE CivilizationType != 'CIVILIZATION_HAG_HUNS' ORDER BY RANDOM() LIMIT 1");
		for i, row in ipairs(results) do
			name = row.CityName;
			break;
		end
		print(Locale.Lookup(name))
		pBuiltCity:SetName(Locale.Lookup(name));
	end
end

-- �Q�[���C�x���g�Ɂ��̊֐�����������
-- ��CityBuilt()�͓s�s�𗎂Ƃ����Ƃ��ɂ������B�����Ō��Ă��s�s��D�҂����ꍇ�ɂ����삵�Ă��܂����d�l�Ƃ���B
GameEvents.CityBuilt.Add(OnCityBuilt);

print("HAGCityNameHuns.lua loaded successfully.")
