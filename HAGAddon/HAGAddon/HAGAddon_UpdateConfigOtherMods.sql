-- ����SQL�t�@�C���͎���̑�MOD�ɑ΂��Ė{MOD�̎d�l�ɍ��킹���ޏ������s���Ă���B
--
-- ��Ƃ��Đ������̍X�V�Ȃ̂�SQL�ɂ���K�v�͂Ȃ��̂����AGameplay���ɍ��킹���B

-- ========== ����/���� ==========
UPDATE PlayerItems
SET Description = 'LOC_UNIT_UNIQUE_BATTLESHIP_NAGATO_HAGA_DESCRIPTION'
WHERE CivilizationType = 'CIVILIZATION_PEOPLESOFTHESEA' AND LeaderType = 'LEADER_YNL_NAGATO' AND Type = 'UNIT_UNIQUE_BATTLESHIP_NAGATO';

UPDATE PlayerItems
SET Description = 'LOC_UNIT_UNIQUE_BATTLESHIP_NAGATO_HAGA_DESCRIPTION'
WHERE CivilizationType = 'CIVILIZATION_PEOPLESOFTHESEA' AND LeaderType = 'LEADER_YNL_MUTSU' AND Type = 'UNIT_UNIQUE_BATTLESHIP_NAGATO';
