-- ����SQL�t�@�C���͎���̑�MOD�ɑ΂��Ė{MOD�̎d�l�ɍ��킹���ޏ������s���Ă���B
-- 
-- Update���̓L�[���Ȃ���΍X�V���ꂸ�ɏI��邪�AINSERT���̓L�[���Ȃ���΃G���[�ɂȂ�B
-- ������������ɂ�WHERE EXISTS��p���ăL�[�ƂȂ���̂����݂���ꍇ�̂�INSERT�Ƃ����`�ɂ��Ȃ���΂Ȃ�Ȃ��B
-- XML�ł͂��̂悤�ȋL�q�͂ł��Ȃ��Ǝv����B�����SQL�������B

-- ========== �`�p���P ==========
-- �[�C���b���m�͂�{MOD�̎d�l�ɍ��킹��
INSERT INTO UnitAiInfos('UnitType', 'AiType')
SELECT * FROM (SELECT 'UNIT_YNL_ARMORED_CRUISER', 'UNITTYPE_RANGED') AS TMP
WHERE EXISTS (SELECT Type FROM Types WHERE Type = 'UNIT_YNL_ARMORED_CRUISER');

UPDATE Units
SET Combat = 63, RangedCombat = 63, Range = 2, PromotionClass = 'PROMOTION_CLASS_NAVAL_RANGED'
WHERE UnitType = 'UNIT_YNL_ARMORED_CRUISER';

-- ========== ���k�O�o�� ==========
-- ���񂾋|�R����UG��ύX
UPDATE UnitUpgrades
Set UpgradeUnit ='UNIT_CROSSBOWMAN'
WHERE Unit = 'UNIT_ZUNKO_HORSE_ARCHER';

-- ========== ����/���� ==========
-- ��X��͂ƃ~�T�C�����m�͂̎d�l�ύX������̂ŁA�L�q�̕K�v����
