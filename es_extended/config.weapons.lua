Config.DefaultWeaponTints = {
	[0] = _U('tint_default'),
	[1] = _U('tint_green'),
	[2] = _U('tint_gold'),
	[3] = _U('tint_pink'),
	[4] = _U('tint_army'),
	[5] = _U('tint_lspd'),
	[6] = _U('tint_orange'),
	[7] = _U('tint_platinum')
}

Config.AmmoTypes = {
	[`AMMO_M18_SM`]		        = 'AMMO_M18_SM',
	[`AMMO_PISTOL`]				= 'AMMO_PISTOL',
	[`AMMO_SMG`]				= 'AMMO_SMG',
	[`AMMO_RIFLE`]				= 'AMMO_RIFLE',
	[`AMMO_MG`]					= 'AMMO_MG',
	[`AMMO_SHOTGUN`]			= 'AMMO_SHOTGUN',
	[`AMMO_STUNGUN`]			= 'AMMO_STUNGUN',
	[`AMMO_SNIPER`]				= 'AMMO_SNIPER',
	[`AMMO_FLARE`]				= 'AMMO_FLARE',
	[`AMMO_MOLOTOV`]			= 'AMMO_MOLOTOV',
	[`AMMO_SMOKEGRENADE`]		= 'AMMO_SMOKEGRENADE',
	[`AMMO_FIREEXTINGUISHER`]	= 'AMMO_FIREEXTINGUISHER',
	[`AMMO_PETROLCAN`]			= 'AMMO_PETROLCAN',
	[`AMMO_MINIGUN`]			= 'AMMO_MINIGUN',
}

Config.Weapons = {
	{
        name = 'WEAPON_MADCLOWN',
        label = ('MADCLOWN'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_madclown_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_madclown_mag2') },
        }
    },
	{
        name = 'WEAPON_RAYSMG_MK_2',
        label = ('RAYSMG MK2'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_raysmg_mk_2_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_raysmg_mk_2_mag2') },
        }
    },
	{
        name = 'WEAPON_SCARL_GODZILLA',
        label = ('SCARL_GODZILLA'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scarl_godzilla_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scarl_godzilla_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scarl_godzilla_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_scarl_godzilla_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_scarl_godzilla_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_scarl_godzilla_flsh' },
        }
    },
	{
        name = 'WEAPON_SCIFI_RIFLE',
        label = ('SCIFI_RIFLE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scifi_rifle_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scifi_rifle_mag2') },
        }
    },
	{
        name = 'WEAPON_PAINFUL_STAR',
        label = ('PAINFUL_STAR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_star_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_star_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_star_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_star_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_star_grip')},
        }
    },
	{
        name = 'WEAPON_GRACIER_AKM',
        label = ('GRACIER_AKM'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gracier_akm_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gracier_akm_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_gracier_akm_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_gracier_akm_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_gracier_akm_grip')},
        }
    },
	{
        name = 'WEAPON_YANDERE',
        label = ('YANDERE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_yandere_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_yandere_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_yandere_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_yandere_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_yandere_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_yandere_flsh' },
        }
    },
	{
        name = 'WEAPON_M4_DRAGON',
        label = ('M4_DRAGON'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4_dragon_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4_dragon_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4_dragon_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4_dragon_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4_dragon_grip')},
        }
    },
	{
		name = 'WEAPON_PISTOL',
		label = _U('weapon_pistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE')}
		}
	},
	{
		name = 'WEAPON_M82A3',
		label = ('M82A3'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		components = {
			{ name = 'clip_default', 		label = _U('component_clip_default'), 		hash = GetHashKey('w_sr_m82a3_mag1')},
			{ name = 'clip_extended', 		label = _U('component_clip_extended'), 		hash = GetHashKey('w_sr_m82a3_mag2')},
			{ name = 'rounds_incendiary', 	label = _U('component_round_incendiary'), 	hash = GetHashKey('w_sr_m82a3_mag_inc')},
			{ name = 'rounds_piercing', 	label = _U('component_round_piercing'), 	hash = GetHashKey('w_sr_m82a3_mag_ap')},
			{ name = 'rounds_fullmetal', 	label = _U('component_round_fullmetal'), 	hash = GetHashKey('w_sr_m82a3_mag_fmj')},
			{ name = 'rounds_explosive', 	label = _U('component_round_explosive'), 	hash = GetHashKey('w_sr_m82a3_mag_ap_2')},
			{ name = 'grip', 				label = _U('component_grip'), 				hash = GetHashKey('w_at_sr_m82a3_bipod')},
			{ name = 'suppressor', 			label = _U('component_suppressor'), 		hash = GetHashKey('w_at_sr_m82a3_supp')},
			{ name = 'scope_large', 		label = _U('component_scope_medium'), 		hash = GetHashKey('w_at_sr_m82a3_scope_large')},
			{ name = 'scope_zoom', 			label = _U('component_scope_zoom'), 		hash = GetHashKey('w_at_sr_m82a3_scope_max')},
			{ name = 'scope_nightvision', 	label = _U('component_scope_nightvision'), 	hash = GetHashKey('w_at_sr_m82a3_scope_nv')},
			{ name = 'barrel', 				label = _U('component_barrel'), 			hash = GetHashKey('w_at_sr_m82a3_barrel_1')},
			{ name = 'barrel_heavy', 		label = _U('component_barrel_heavy'), 		hash = GetHashKey('w_at_sr_m82a3_barrel_2')},			
			{ name = 'muzzle_squared', 		label = _U('component_muzzle_squared'), 	hash = GetHashKey('w_at_sr_m82a3_muzzle_1')},
			{ name = 'muzzle_bellend', 		label = _U('component_muzzle_split'), 		hash = GetHashKey('w_at_sr_m82a3_muzzle_2')},			
			{ name = 'skin_camo', 			label = _U('component_skin_camo'), 			hash = GetHashKey('w_at_sr_m82a3_camo1')},
			{ name = 'skin_brushstroke', 	label = _U('component_skin_brushstroke'), 	hash = GetHashKey('w_at_sr_m82a3_camo2')},
			{ name = 'skin_woodland', 		label = _U('component_skin_woodland'), 		hash = GetHashKey('w_at_sr_m82a3_camo3')},
			{ name = 'skin_skull', 			label = _U('component_skin_skull'), 		hash = GetHashKey('w_at_sr_m82a3_camo4')},
			{ name = 'skin_sessanta', 		label = _U('component_skin_sessanta'), 		hash = GetHashKey('w_at_sr_m82a3_camo5')},
			{ name = 'skin_perseus', 		label = _U('component_skin_perseus'), 		hash = GetHashKey('w_at_sr_m82a3_camo6')},
			{ name = 'skin_leopard', 		label = _U('component_skin_leopard'), 		hash = GetHashKey('w_at_sr_m82a3_camo7')},
			{ name = 'skin_zebra', 			label = _U('component_skin_zebra'), 		hash = GetHashKey('w_at_sr_m82a3_camo8')},
			{ name = 'skin_geometric', 		label = _U('component_skin_geometric'), 	hash = GetHashKey('w_at_sr_m82a3_camo9')},
			{ name = 'skin_boom', 			label = _U('component_skin_boom'), 			hash = GetHashKey('w_at_sr_m82a3_camo10')},
		}
	},
	{
		name = 'WEAPON_COMBATPISTOL',
		label = _U('weapon_combatpistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = _U('weapon_appistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = _U('weapon_pistol50'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = _U('weapon_snspistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER')}
		}
	},

	


	{
		name = 'WEAPON_HEAVYPISTOL',
		label = _U('weapon_heavypistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = _U('weapon_vintagepistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = _U('weapon_machinepistol'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')}
		}
	},

	{name = 'WEAPON_REVOLVER', label = _U('weapon_revolver'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_MARKSMANPISTOL', label = _U('weapon_marksmanpistol'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_DOUBLEACTION', label = _U('weapon_doubleaction'), components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_NAVYREVOLVER', label = 'Navy Revolver', components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')}},
	{name = 'WEAPON_GADGETPISTOL', label = 'Perico Pistol', components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')}},

	{
		name = 'WEAPON_SMG',
		label = _U('weapon_smg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = _U('weapon_assaultsmg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = _U('weapon_microsmg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = _U('weapon_minismg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02')}
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = _U('weapon_combatpdw'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')}
		}
	},

	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = _U('weapon_pumpshotgun'),
		ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = _U('weapon_sawnoffshotgun'),
		ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = _U('weapon_assaultshotgun'),
		ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = _U('weapon_bullpupshotgun'),
		ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = _U('weapon_heavyshotgun'),
		ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')}
		}
	},

	{name = 'WEAPON_DBSHOTGUN', label = _U('weapon_dbshotgun'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_AUTOSHOTGUN', label = _U('weapon_autoshotgun'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_shells'), hash = GetHashKey('AMMO_SHOTGUN')}},
	{name = 'WEAPON_MUSKET', label = _U('weapon_musket'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SHOTGUN')}},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = _U('weapon_assaultrifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = _U('weapon_carbinerifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02')},
			{name = 'clip_box', label = _U('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SMG_MK2',
		label = _U('weapon_smgmk2'),
		components = {}
	},

	{
		name = 'WEAPON_CARBINERIFLE_MK2',
		label = _U('weapon_carbinerifle_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_MK2_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'holographic', label = _U('component_holographic'), hash = GetHashKey('COMPONENT_AT_SIGHTS')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP_02')},
		}

	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = _U('weapon_advancedrifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = _U('weapon_specialcarbine'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = _U('weapon_bullpuprifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW')}
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = _U('weapon_compactrifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02')},
			{name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03')}
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = _U('weapon_combatmg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER')}
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = _U('weapon_gusenberg'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MG')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02')},
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = _U('weapon_sniperrifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = _U('weapon_heavysniper'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE')},
			{name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX')}
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = _U('weapon_marksmanrifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02')},
			{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP')},
			{name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE')}
		}
	},

	{
		name = 'WEAPON_PISTOL_MK2',
		label = _U('weapon_pistol_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = 'COMPONENT_PISTOL_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_PISTOL_MK2_CLIP_02' },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_PI_FLSH' },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_PI_SUPP_02' },
		
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_PISTOL_MK2_CLIP_TRACER' },
			{ name = 'rounds_hollow', label = _U('component_round_hollow'), hash = 'COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_PISTOL_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_PISTOL_MK2_CLIP_FMJ' },
		
			{ name = 'compensator', label = _U('component_compensator'), hash = 'COMPONENT_AT_PI_COMP' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_PISTOL_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_PISTOL_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_PISTOL_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_PISTOL_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_PISTOL_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_PISTOL_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_PISTOL_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_PISTOL_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_PISTOL_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_PISTOL_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_PISTOL_MK2_CAMO_IND_01' },
		}
	},

	{	
		name = 'WEAPON_REVOLVER_MK2',
		label = _U('weapon_revolver_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_REVOLVER_MK2_CLIP_01' },
			
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_REVOLVER_MK2_CLIP_TRACER' },
			{ name = 'rounds_hollow', label = _U('component_round_hollow'), hash = 'COMPONENT_REVOLVER_MK2_CLIP_HOLLOWPOINT' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_REVOLVER_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_REVOLVER_MK2_CLIP_FMJ' },


			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_PI_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_MK2' },
			{ name = 'scope_small', label = _U('component_scope_small'), hash = 'COMPONENT_AT_SCOPE_SMALL_MK2' },
			
			{ name = 'compensator', label = _U('component_compensator'), hash = 'COMPONENT_AT_PI_COMP_03' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_REVOLVER_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_REVOLVER_MK2_CAMO_IND_01' },
		}
	},

	{	
		name = 'WEAPON_SNSPISTOL_MK2',
		label = 'SNS Pistol Mk II',
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_02' },

			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_TRACER' },
			{ name = 'rounds_hollow', label = _U('component_round_hollow'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_HOLLOWPOINT' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_SNSPISTOL_MK2_CLIP_FMJ' },


			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_PI_FLSH' },

			{ name = 'scope_mounted', label = _U('component_scope_mounted'), hash = 'COMPONENT_AT_PI_RAIL_02' },
			
			{ name = 'compensator', label = _U('component_compensator'), hash = 'COMPONENT_AT_PI_COMP_02' },
			
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_PI_SUPP_02' },

			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_boom'), hash = 'COMPONENT_SNSPISTOL_MK2_CAMO_IND_01_SLIDE' },
		}
	},

	{	
		name = 'WEAPON_PUMPSHOTGUN_MK2',
		label = _U('weapon_pumpshotgun_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SHOTGUN')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_01' },
			
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_hollow', label = _U('component_round_hollow'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_HOLLOWPOINT' },
			{ name = 'rounds_explosive', label = _U('component_round_explosive'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_EXPLOSIVE' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CLIP_INCENDIARY' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_MK2' },
			{ name = 'scope_small', label = _U('component_scope_small'), hash = 'COMPONENT_AT_SCOPE_SMALL_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_SC_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_SC_BARREL_02' },
			
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_SR_SUPP_03' },
			
			{ name = 'muzzle_flat', label = _U('component_muzzle_squared'), hash = 'COMPONENT_AT_MUZZLE_08' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01' },
		}
	},

	{	
		name = 'WEAPON_ASSAULTRIFLE_MK2',
		label = _U('weapon_assaultrifle_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_02' },
			
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CLIP_FMJ' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_MK2' },
			{ name = 'scope_medium', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_MEDIUM_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_SC_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_SC_BARREL_02' },
			
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_AR_SUPP_02' },
			
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01' },
		}
	},

	{	
		name = 'WEAPON_CARBINERIFLE_MK2',
		label = _U('weapon_carbinerifle_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_02' },
			
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_CARBINERIFLE_MK2_CLIP_FMJ' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_MK2' },
			{ name = 'scope_medium', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_MEDIUM_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_CR_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_CR_BARREL_02' },
			
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_AR_SUPP_02' },
			
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01' },
		}
	},

	{	
		name = 'WEAPON_SPECIALCARBINE_MK2',
		label = _U('weapon_specialcarbine_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip', label = _U('component_clip_default'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_02' },
			
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CLIP_FMJ' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_MK2' },
			{ name = 'scope_medium', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_MEDIUM_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_SC_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_SC_BARREL_02' },
			
			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_AR_SUPP_02' },
			
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01' },
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE_MK2',
		label = _U('weapon_bullpuprifle_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_02' },
			
			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CLIP_FMJ' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_macro', label = _U('component_scope_macro'), hash = 'COMPONENT_AT_SCOPE_MACRO_02_MK2' },
			{ name = 'scope_small', label = _U('component_scope_small'), hash = 'COMPONENT_AT_SCOPE_SMALL_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_BP_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_BP_BARREL_02' },
			
			{ name = 'suppressor', label = _U('component_scope'), hash = 'COMPONENT_AT_AR_SUPP' },
			
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01' },
		}
	},

	{
		name = 'WEAPON_COMBATMG_MK2',
		label = 'Combat MG Mk II',
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = 'COMPONENT_COMBATMG_MK2_CLIP_02' },

			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_COMBATMG_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_COMBATMG_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_COMBATMG_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_COMBATMG_MK2_CLIP_FMJ' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_medium', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_MEDIUM_MK2' },
			{ name = 'scope_small', label = _U('component_scope_small'), hash = 'COMPONENT_AT_SCOPE_SMALL_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_MG_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_MG_BARREL_02' },
					
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
						
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_COMBATMG_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_COMBATMG_MK2_CAMO_IND_01' },
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER_MK2',
		label = _U('weapon_heavysniper_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_02' },

			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_FMJ' },
			{ name = 'rounds_explosive', label = _U('component_round_explosive'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CLIP_EXPLOSIVE' },

			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_SR_SUPP_03' },

			{ name = 'scope_large', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_LARGE_MK2' },
			{ name = 'scope_zoom', label = _U('component_scope_zoom'), hash = 'COMPONENT_AT_SCOPE_MAX' },
			{ name = 'scope_nightvision', label = _U('component_scope_nightvision'), hash = 'COMPONENT_AT_SCOPE_NV' },
			{ name = 'scope_thermal', label = _U('component_scope_nightvision'), hash = 'COMPONENT_AT_SCOPE_THERMAL' },


			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_SR_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_SR_BARREL_02' },
					
			{ name = 'muzzle_squared', label = _U('component_muzzle_squared'), hash = 'COMPONENT_AT_MUZZLE_08' },
			{ name = 'muzzle_bellend', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_SR_BARREL_01' },
			
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01' },
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE_MK2',
		label = _U('weapon_marksmanrifle_mk2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_01' },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_02' },

			{ name = 'rounds_tracer', label = _U('component_round_tracer'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_TRACER' },
			{ name = 'rounds_incendiary', label = _U('component_round_incendiary'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_INCENDIARY' },
			{ name = 'rounds_piercing', label = _U('component_round_piercing'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_ARMORPIERCING' },
			{ name = 'rounds_fullmetal', label = _U('component_round_fullmetal'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CLIP_FMJ' },
			
			{ name = 'grip', label = _U('component_grip'), hash = 'COMPONENT_AT_AR_AFGRIP_02' },
			
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'COMPONENT_AT_AR_FLSH' },

			{ name = 'suppressor', label = _U('component_suppressor'), hash = 'COMPONENT_AT_AR_SUPP' },

			{ name = 'scope', label = _U('component_scope'), hash = 'COMPONENT_AT_SIGHTS' },
			{ name = 'scope_medium', label = _U('component_scope_medium'), hash = 'COMPONENT_AT_SCOPE_MEDIUM_MK2' },
			{ name = 'scope_zoom', label = _U('component_scope_zoom'), hash = 'COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2' },

			{ name = 'barrel', label = _U('component_barrel'), hash = 'COMPONENT_AT_MRFL_BARREL_01' },
			{ name = 'barrel_heavy', label = _U('component_barrel_heavy'), hash = 'COMPONENT_AT_MRFL_BARREL_02' },
					
			{ name = 'muzzle_flat', label = _U('component_muzzle_flat'), hash = 'COMPONENT_AT_MUZZLE_01' },
			{ name = 'muzzle_tatical', label = _U('component_muzzle_tatical'), hash = 'COMPONENT_AT_MUZZLE_02' },
			{ name = 'muzzle_fat', label = _U('component_muzzle_fat'), hash = 'COMPONENT_AT_MUZZLE_03' },
			{ name = 'muzzle_precision', label = _U('component_muzzle_precision'), hash = 'COMPONENT_AT_MUZZLE_04' },
			{ name = 'muzzle_heavy', label = _U('component_muzzle_heavy'), hash = 'COMPONENT_AT_MUZZLE_05' },
			{ name = 'muzzle_slanted', label = _U('component_muzzle_slanted'), hash = 'COMPONENT_AT_MUZZLE_06' },
			{ name = 'muzzle_split', label = _U('component_muzzle_split'), hash = 'COMPONENT_AT_MUZZLE_07' },
			
			
			{ name = 'skin_camo', label = _U('component_skin_camo'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO' },
			{ name = 'skin_brushstroke', label = _U('component_skin_brushstroke'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_02' },
			{ name = 'skin_woodland', label = _U('component_skin_woodland'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_03' },
			{ name = 'skin_skull', label = _U('component_skin_skull'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_04' },
			{ name = 'skin_sessanta', label = _U('component_skin_sessanta'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_05' },
			{ name = 'skin_perseus', label = _U('component_skin_perseus'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_06' },
			{ name = 'skin_leopard', label = _U('component_skin_leopard'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_07' },
			{ name = 'skin_zebra', label = _U('component_skin_zebra'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_08' },
			{ name = 'skin_geometric', label = _U('component_skin_geometric'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_09' },
			{ name = 'skin_boom', label = _U('component_skin_boom'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_10' },
			{ name = 'skin_patriotic', label = _U('component_skin_patriotic'), hash = 'COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01' },
		}
	},

	{    
		name = 'WEAPON_45ACP',
		label = ('45ACP'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_45acp_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_45acp_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_45acp_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_45acp_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_AK47',
		label = ('AK47'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ak47_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ak47_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ak47_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_ak47_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_ak47_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_AKM',
		label = ('AKM'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_akm_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_akm_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_akm_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_akm_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_akm_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_AN94',
		label = ('AN94'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_an94_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_an94_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_an94_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_an94_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_an94_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_ARC15',
		label = ('ARC15'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_arc15_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_arc15_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_arc15_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_arc15_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_arc15_grip') },
		}
	},
	--
	    --
		{
			name = 'WEAPON_YANDERE_PANOS',
			label = ('YANDERE_PANOS'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_yandere_panos_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_yandere_panos_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_yandere_panos_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_yandere_panos_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_yandere_panos_grip')},
				{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_yandere_panos_flsh' },
			}
		},
		--
		{
			name = 'WEAPON_YANDERE_REFORMED',
			label = ('YANDERE_REFORMED'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_yandere_reformed_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_yandere_reformed_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_yandere_reformed_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_yandere_reformed_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_yandere_reformed_grip')},
				{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_yandere_reformed_flsh' },
			}
		},
		--
		{
			name = 'WEAPON_PAINFUL_MONTE_DELORA',
			label = ('PAINFUL_MONTE_DELORA'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_monte_delora_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_monte_delora_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_monte_delora_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_monte_delora_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_monte_delora_grip')},
			}
		},
		--
		{
			name = 'WEAPON_PAINFUL_BRATVA_RU',
			label = ('PAINFUL_BRATVA_RU'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_bratva_ru_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_bratva_ru_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_bratva_ru_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_bratva_ru_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_bratva_ru_grip')},
			}
		},
		--
		{
			name = 'WEAPON_FORTNITE_SCARL_CDB',
			label = ('FORTNITE_SCARL_CDB'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fortnite_scarl_cdb_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fortnite_scarl_cdb_mag2') },
			}
		},
		--
	--
	{    
		name = 'WEAPON_ASM1',
		label = ('ASM1'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_asm1_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_asm1_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_asm1_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_asm1_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_asm1_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_AUG',
		label = ('AUG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_aug_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_aug_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_aug_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_aug_supp') },
		}
	},
	{
        name = 'WEAPON_SANT_M47',
        label = ('SANT_M47'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sant_m47_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sant_m47_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sant_m47_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sant_m47_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sant_m47_grip')},
        }
    },
	{
        name = 'WEAPON_LTDRIFLE_HERMANOS',
        label = ('LTDRIFLE_HERMANOS'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ltdrifle_hermanos_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ltdrifle_hermanos_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ltdrifle_hermanos_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ltdrifle_hermanos_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ltdrifle_hermanos_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_ltdrifle_hermanos_flsh' },
        }
    },
	{
        name = 'WEAPON_CFS_JIMAKOS',
        label = ('CFS_JIMAKOS'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_cfs_jimakos_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_cfs_jimakos_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_cfs_jimakos_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_cfs_jimakos_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_cfs_jimakos_grip')},
        }
    },
	--
	{    
		name = 'WEAPON_BEOWULF',
		label = ('BEOWULF'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_beowulf_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_beowulf_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_beowulf_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_beowulf_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_beowulf_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_CBQ',
		label = ('CBQ'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_cbq_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_cbq_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_cbq_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_cbq_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_cbq_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_FNFAL',
		label = ('FNFAL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fnfal_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fnfal_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_fnfal_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_fnfal_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_fnfal_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_FNFALCMG',
		label = ('FNFALCMG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fnfalcmg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fnfalcmg_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_fnfalcmg_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_fnfalcmg_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_fnfalcmg_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_FOOL',
		label = ('FOOL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fool_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fool_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_fool_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_fool_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_fool_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_G36C',
		label = ('G36C'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_g36c_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_g36c_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_g36c_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_g36c_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_g36c_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_G36K',
		label = ('G36K'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_g36k_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_g36k_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_g36k_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_g36k_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_g36k_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_GRAU',
		label = ('GRAU'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_grau_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_grau_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_grau_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_grau_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_grau_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_GROZA',
		label = ('GROZA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_groza_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_groza_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_groza_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_groza_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_HBR',
		label = ('HBR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hbr_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hbr_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hbr_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_hbr_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_hbr_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_HK33',
		label = ('HK33'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hk33_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hk33_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hk33_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_hk33_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_hk33_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_HK416',
		label = ('HK416'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hk416_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hk416_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hk416_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_hk416_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_hk416_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_HOWA',
		label = ('HOWA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_howa_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_howa_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_howa_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_howa_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_howa_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_ICEDRAKE',
		label = ('ICEDRAKE'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_icedrake_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_icedrake_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_icedrake_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_icedrake_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_icedrake_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_ISY',
		label = ('ISY'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_isy_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_isy_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_isy_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_isy_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_isy_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_KRISSVECT',
		label = ('KRISSVECT'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_krissvect_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_krissvect_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_krissvect_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_krissvect_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_LVOAC',
		label = ('LVOAC'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_lvoac_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_lvoac_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_lvoac_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_lvoac_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_lvoac_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_M4A4',
		label = ('M4A4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4a4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4a4_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4a4_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m4a4_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m4a4_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_M4A5',
		label = ('M4A5'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4a5_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4a5_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4a5_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m4a5_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m4a5_grip') },
		}
	},
	--

	--
	{    
		name = 'WEAPON_M9',
		label = ('M9'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_m9_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_m9_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_pi_m9_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_M16A1',
		label = ('M16A1'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m16a1_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m16a1_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m16a1_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m16a1_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m16a1_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_M203',
		label = ('M203'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m203_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m203_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m203_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m203_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m203_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_MAC10',
		label = ('MAC10'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mac10_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mac10_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mac10_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mac10_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MAC101',
		label = ('MAC101'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mac101_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mac101_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mac101_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mac101_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MALYUK',
		label = ('MALYUK'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_malyuk_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_malyuk_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_malyuk_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_malyuk_supp') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_MCX',
		label = ('MCX'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mcx_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mcx_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mcx_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mcx_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MP5A1',
		label = ('MP5A1'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp5a1_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp5a1_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp5a1_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp5a1_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MP5SD',
		label = ('MP5SD'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp5sd_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp5sd_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp5sd_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp5sd_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MP7',
		label = ('MP7'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp7_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp7_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp7_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp7_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MP7X',
		label = ('MP7X'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp7x_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp7x_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp7x_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp7x_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MP40',
		label = ('MP40'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp40_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp40_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp40_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp40_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_MPX',
		label = ('MPX'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_mpx_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_mpx_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_mpx_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_mpx_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_mpx_grip') },
		}
	},
	--
	{
		name = 'WEAPON_SAR',
		label = ('SAR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sar_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sar_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sar_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sar_supp')},
		}
	},
	--
	{
		name = 'WEAPON_HFSMG',
		label = ('HFSMG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_hfsmg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_hfsmg_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_hfsmg_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_hfsmg_supp')},
		}
	},
	--
	--
	{
		name = 'WEAPON_MS32',
		label = ('MS32'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_ms32_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_ms32_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_ms32_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_ms32_supp')},
		}
	},
	--
	{
		name = 'WEAPON_M416P',
		label = ('M416P'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m416p_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m416p_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m416p_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m416p_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m416p_grip')},
		}
	},
	--
	{
		name = 'WEAPON_ARS',
		label = ('ARS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ars_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ars_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ars_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ars_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ars_grip')},
		}
	},
	--
	{
		name = 'WEAPON_M16A3',
		label = ('M16A3'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m16a3_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m16a3_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m16a3_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m16a3_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m16a3_grip')},
		}
	},
	--
	--
	{
		name = 'WEAPON_FMR',
		label = ('FMR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fmr_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fmr_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_fmr_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_fmr_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_fmr_grip')},
		}
	},
	--
	{
		name = 'WEAPON_M16ARS',
		label = ('M16ARS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m16ars_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m16ars_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m16ars_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m16ars_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m16ars_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SLR15',
		label = ('SLR15'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_slr15_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_slr15_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_slr15_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_slr15_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_slr15_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SB4S',
		label = ('SB4S'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_sb4s_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_sb4s_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_sb4s_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_sb4s_supp')},
		}
	},
	--
	--
	{
		name = 'WEAPON_HBAN',
		label = ('HBAN'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hban_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hban_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hban_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_hban_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_hban_grip')},
		}
	},
	--

	--
	{
		name = 'WEAPON_H2SMG',
		label = ('H2 SMG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_h2smg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_h2smg_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_h2smg_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_h2smg_supp')},
		}
	},
	--
	{    
		name = 'WEAPON_MOON',
		label = ('MOON'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_moon_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_moon_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_moon_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_moon_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_moon_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_NV4',
		label = ('NV4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_nv4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_nv4_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_nv4_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_nv4_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_nv4_grip') },
		}
	},
	--
	--
	{    
		name = 'WEAPON_P226',
		label = ('P226'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_p226_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_p226_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_pi_p226_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_PP19',
		label = ('PP19'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_pp19_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_pp19_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_pp19_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_pp19_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_pp19_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_RPK',
		label = ('RPK'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_rpk_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_rpk_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_rpk_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_rpk_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_rpk_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_SAIGA',
		label = ('SAIGA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_saiga_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_saiga_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_saiga_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_saiga_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_saiga_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_SCARMK17',
		label = ('SCARMK17'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scarmk17_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scarmk17_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scarmk17_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_scarmk17_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_scarmk17_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_SCORPION',
		label = ('SCORPION'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_scorpion_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_scorpion_mag2') },
		}
	},
	--
	{    
		name = 'WEAPON_SOBMOD',
		label = ('SOBMOD'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sobmod_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sobmod_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sobmod_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_sobmod_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_sobmod_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_SUNDA',
		label = ('SUNDA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sunda_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sunda_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sunda_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_sunda_supp') },
		}
	},
	--
	{    
		name = 'WEAPON_T9ACC',
		label = ('T9ACC'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_t9acc_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_t9acc_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_t9acc_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_t9acc_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_t9acc_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_VSS',
		label = ('VSS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_vss_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_vss_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_vss_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_acr_scope') },
		}
	},
	--
	{    
		name = 'WEAPON_XR2',
		label = ('XR2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_xr2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_xr2_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_xr2_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_xr2_scope') },
		}
	},
	--
	{    
		name = 'WEAPON_KATANA',
		label = ('KATANA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MELEE')},
		components = {
		}
	},
	--
	{    
		name = 'WEAPON_THORHAMMER',
		label = ('THOR HAMMER'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MELEE')},
		components = {
		}
	},
	--




	---------------------------------------------------------------------------------------------------------------------


	{name = 'WEAPON_MINIGUN', label = _U('weapon_minigun'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MINIGUN')}},
	{name = 'WEAPON_RAILGUN', label = _U('weapon_railgun'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RAILGUN')}},
	{name = 'WEAPON_STUNGUN', label = _U('weapon_stungun'), tints = Config.DefaultWeaponTints, components = {}},
	{name = 'WEAPON_RPG', label = _U('weapon_rpg'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rockets'), hash = GetHashKey('AMMO_RPG')}},
	{name = 'WEAPON_HOMINGLAUNCHER', label = _U('weapon_hominglauncher'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_rockets'), hash = GetHashKey('AMMO_HOMINGLAUNCHER')}},
	{name = 'WEAPON_GRENADELAUNCHER', label = _U('weapon_grenadelauncher'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_COMPACTLAUNCHER', label = _U('weapon_compactlauncher'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_grenadelauncher'), hash = GetHashKey('AMMO_GRENADELAUNCHER')}},
	{name = 'WEAPON_FLAREGUN', label = _U('weapon_flaregun'), tints = Config.DefaultWeaponTints, components = {}, ammo = {label = _U('ammo_flaregun'), hash = GetHashKey('AMMO_FLAREGUN')}},
	{name = 'WEAPON_FIREEXTINGUISHER', label = _U('weapon_fireextinguisher'), components = {}, ammo = {label = _U('ammo_charge'), hash = GetHashKey('AMMO_FIREEXTINGUISHER')}},
	{name = 'WEAPON_PETROLCAN', label = _U('weapon_petrolcan'), components = {}, ammo = {label = _U('ammo_petrol'), hash = GetHashKey('AMMO_PETROLCAN')}},
	{name = 'WEAPON_FIREWORK', label = _U('weapon_firework'), components = {}, ammo = {label = _U('ammo_firework'), hash = GetHashKey('AMMO_FIREWORK')}},
	{name = 'WEAPON_FLASHLIGHT', label = _U('weapon_flashlight'), components = {}},
	{name = 'GADGET_PARACHUTE', label = _U('gadget_parachute'), components = {}},
	{name = 'WEAPON_KNUCKLE', label = _U('weapon_knuckle'), components = {}},
	{name = 'WEAPON_HATCHET', label = _U('weapon_hatchet'), components = {}},
	{name = 'WEAPON_MACHETE', label = _U('weapon_machete'), components = {}},
	{name = 'WEAPON_SWITCHBLADE', label = _U('weapon_switchblade'), components = {}},
	{name = 'WEAPON_BOTTLE', label = _U('weapon_bottle'), components = {}},
	{name = 'WEAPON_DAGGER', label = _U('weapon_dagger'), components = {}},
	{name = 'WEAPON_POOLCUE', label = _U('weapon_poolcue'), components = {}},
	{name = 'WEAPON_WRENCH', label = _U('weapon_wrench'), components = {}},
	{name = 'WEAPON_BATTLEAXE', label = _U('weapon_battleaxe'), components = {}},
	{name = 'WEAPON_KNIFE', label = _U('weapon_knife'), components = {}},
	{name = 'WEAPON_NIGHTSTICK', label = _U('weapon_nightstick'), components = {}},
	{name = 'WEAPON_HAMMER', label = _U('weapon_hammer'), components = {}},
	{name = 'WEAPON_BAT', label = _U('weapon_bat'), components = {}},
	{name = 'WEAPON_GOLFCLUB', label = _U('weapon_golfclub'), components = {}},
	{name = 'WEAPON_CROWBAR', label = _U('weapon_crowbar'), components = {}},

	{name = 'WEAPON_GRENADE', label = _U('weapon_grenade'), components = {}, ammo = {label = _U('ammo_grenade'), hash = GetHashKey('AMMO_GRENADE')}},
	{name = 'WEAPON_SMOKEGRENADE', label = _U('weapon_smokegrenade'), components = {}, ammo = {label = _U('ammo_smokebomb'), hash = GetHashKey('AMMO_SMOKEGRENADE')}},
	{name = 'WEAPON_STICKYBOMB', label = _U('weapon_stickybomb'), components = {}, ammo = {label = _U('ammo_stickybomb'), hash = GetHashKey('AMMO_STICKYBOMB')}},
	{name = 'WEAPON_PIPEBOMB', label = _U('weapon_pipebomb'), components = {}, ammo = {label = _U('ammo_pipebomb'), hash = GetHashKey('AMMO_PIPEBOMB')}},
	{name = 'WEAPON_BZGAS', label = _U('weapon_bzgas'), components = {}, ammo = {label = _U('ammo_bzgas'), hash = GetHashKey('AMMO_BZGAS')}},
	--{name = 'WEAPON_MOLOTOV', label = _U('weapon_molotov'), components = {}, ammo = {label = _U('ammo_molotov'), hash = GetHashKey('AMMO_MOLOTOV')}},
	{name = 'WEAPON_PROXMINE', label = _U('weapon_proxmine'), components = {}, ammo = {label = _U('ammo_proxmine'), hash = GetHashKey('AMMO_PROXMINE')}},
	{name = 'WEAPON_SNOWBALL', label = _U('weapon_snowball'), components = {}, ammo = {label = _U('ammo_snowball'), hash = GetHashKey('AMMO_SNOWBALL')}},
	{name = 'WEAPON_BALL', label = _U('weapon_ball'), components = {}, ammo = {label = _U('ammo_ball'), hash = GetHashKey('AMMO_BALL')}},
	{name = 'WEAPON_FLARE', label = _U('weapon_flare'), components = {}, ammo = {label = _U('ammo_flare'), hash = GetHashKey('AMMO_FLARE')}},







	--[[ New ]]


	--
	{	
		name = 'WEAPON_FOOL',
		label = ('FOOL'),
		components = {
			{ name = 'clip_default', 	label = _U('component_clip_default'), 	hash = GetHashKey('COMPONENT_FOOL_CLIP_01') },
			{ name = 'flashlight', 		label = _U('component_flashlight'), 	hash = GetHashKey('COMPONENT_AT_AR_FLSH')},
			{name = 'scope', 			label = _U('component_scope'), 			hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO')},
			{name = 'suppressor', 		label = _U('component_suppressor'), 	hash = GetHashKey('COMPONENT_AT_AR_SUPP_02')},
			{name = 'grip', 			label = _U('component_grip'), 			hash = GetHashKey('COMPONENT_AT_AR_AFGRIP')},
		}
	},

    --
    {
        name = 'WEAPON_HOWA',
        label = ('HOWA'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {},
    },
    --
    {
        name = 'WEAPON_KRISSVECT',
        label = ('KRISSVECT'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {},
    },
	--
	{
		name = 'WEAPON_MGXR',
        label = ('MGXR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MG')},
        components = {
        }
    },
	--









	--
	{    
		name = 'WEAPON_AN94',
		label = ('AN94'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_an94_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_an94_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_an94_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_an94_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_an94_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_FNFALCMG',
		label = ('FNFAL CMG'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fnfalcmg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fnfalcmg_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_fnfalcmg_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_fnfalcmg_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_fnfalcmg_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_GRAU',
		label = ('GRAU'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_grau_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_grau_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_grau_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_grau_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_grau_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_HK33',
		label = ('HK33'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hk33_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hk33_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hk33_scope') },
			{ name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_hk33_supp')},
			{ name = 'grip',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_hk33_grip')},
		}
	},
	--
	{    
		name = 'WEAPON_ICEDRAKE',
		label = ('ICEDRAKE'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_icedrake_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_icedrake_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_icedrake_scope') },
			{ name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_icedrake_supp')},
			{ name = 'grip',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_icedrake_grip')},
		}
	},
	--
	{    
		name = 'WEAPON_ISY',
		label = ('ISY'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_isy_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_isy_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_isy_scope') },
			{ name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_isy_supp')},
			{ name = 'grip',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_isy_grip')},
		}
	},
	--
	--
	{    
		name = 'WEAPON_M4RIFLE',
		label = ('M4 Rifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4rifle_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4rifle_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4rifle_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4rifle_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4rifle_grip')},
		}
	},
	--
	{    
		name = 'WEAPON_SCARMK17',
		label = ('SCARMK17'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scarmk17_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scarmk17_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scarmk17_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_scarmk17_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_scarmk17_grip')},
		}
	},
	--
	{    
		name = 'WEAPON_SOBMOD',
		label = ('SOBMOD'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sobmod_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sobmod_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sobmod_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sobmod_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sobmod_grip')},
		}
	},
	--
	{    
		name = 'WEAPON_XR2',
		label = ('XR2'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_xr2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_xr2_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_xr2_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_xr2_supp') },
		}
	},
	--
	{
		name = 'WEAPON_PP19',
		label = ('PP19'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_pp19_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_pp19_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_pp19_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_pp19_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_pp19_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_GROZA',
		label = ('GROZA'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_groza_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_groza_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_groza_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_groza_scope') },
		}
	},
	--
	{    
		name = 'WEAPON_HBR',
		label = ('HBR'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hbr_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hbr_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_hbr_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hbr_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_hbr_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_ASM1',
		label = ('ASM1'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_asm1_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_asm1_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_asm1_supp') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_asm1_scope') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_asm1_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_MK2S2',
		label = ('MK2S2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_mk2s2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_mk2s2_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_mk2s2_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_mk2s2_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_mk2s2_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_IAR',
		label = ('IAR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_iar_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_iar_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_iar_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_iar_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_iar_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_M4A1V',
		label = ('M4A1V'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4a1v_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4a1v_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4a1v_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m4a1v_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m4a1v_grip') },
		}
	},
	
	--
	
	--
	{    
		name = 'WEAPON_MP5H',
		label = ('MP5H'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp5h_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp5h_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp5h_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_mp5h_supp') },
		}
	},

		--
	--
	{
		name = 'WEAPON_G36',
		label = ('G36'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_g36_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_g36_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_g36_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_g36_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_g36_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SARB',
		label = ('SARB'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_sarb_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_sarb_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_sarb_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_sarb_supp')},
		}
	},
	--
	{
		name = 'WEAPON_SFAK',
		label = ('SFAK'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sfak_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sfak_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sfak_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sfak_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sfak_grip')},
		}
	},
	--
	{
		name = 'WEAPON_UE4',
		label = ('UE4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_ue4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_ue4_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_ue4_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_ue4_supp')},
		}
	},
	--

	--
	{
		name = 'WEAPON_SFRIFLE',
		label = ('SFRIFLE'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sfrifle_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sfrifle_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sfrifle_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sfrifle_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sfrifle_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SF2',
		label = ('SF2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sf2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sf2_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sf2_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sf2_supp')},
		}
	},
	--
	--
	--
	{
		name = 'WEAPON_M82',
		label = ('M82'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m82_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m82_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m82_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m82_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m82_grip')},
		}
	},
	--
	{
		name = 'WEAPON_M4CB',
		label = ('M4CB'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4cb_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4cb_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4cb_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4cb_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4cb_grip')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('w_ar_m4cb_varmod') },
		}
	},
	--
	{
		name = 'WEAPON_PHANTOM',
		label = ('PHANTOM'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_phantom_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_phantom_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_phantom_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_phantom_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_phantom_grip')},
			{name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('w_ar_phantom_varmod') },
		}
	},
	--
	{
		name = 'WEAPON_VANDAL',
		label = ('VANDAL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_vandal_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_vandal_mag2') },
		}
	},
	--
	{
		name = 'WEAPON_DESTRUCTION',
		label = ('DESTRUCTION'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_destruction_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_destruction_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_destruction_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_destruction_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_destruction_grip')},
		}
	},
	--
	{
		name = 'WEAPON_GYS',
		label = ('GYS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gys_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gys_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_gys_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_gys_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_gys_grip')},
		}
	},
	--
	{
		name = 'WEAPON_HEAVYSMG',
		label = ('HEAVYSMG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_heavysmg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_heavysmg_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_heavysmg_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_heavysmg_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_sb_heavysmg_grip') },
		}
	},
	--
	{
		name = 'WEAPON_HFAP',
		label = ('HFAP'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_hfap_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_hfap_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_pi_hfap_supp') },
		}
	},
	--
	{
		name = 'WEAPON_SMG9',
		label = ('SMG9'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_smg9_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_smg9_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_smg9_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_sb_smg9_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_sb_smg9_grip') },
		}
	},
	--
	{
		name = 'WEAPON_REDDRAGON',
		label = ('REDDRAGON'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_reddragon_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_reddragon_mag2') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_reddragon_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_M133_2',
		label = ('M133 v2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m133_2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m133_2_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m133_2_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m133_2_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m133_2_grip') },
		}
	},
		--
		{
			name = 'WEAPON_ARCHANGEL_AR',
			label = ('ARCHANGEL_AR'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_archangel_ar_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_archangel_ar_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_archangel_ar_scope') },
				{name = 'flashlight',         label = _U('component_flashlight'),     hash = GetHashKey('w_at_ar_archangel_ar_flsh')},
			}
		},
		--
		{
			name = 'WEAPON_ARCHANGEL_SMG',
			label = ('ARCHANGEL_SMG'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_archangel_smg_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_archangel_smg_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_archangel_smg_scope') },
			}
		},
		--
		{
			name = 'WEAPON_LTDRIFLE_KAPPA',
			label = ('LTDRIFLE_KAPPA'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ltdrifle_kappa_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ltdrifle_kappa_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ltdrifle_kappa_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ltdrifle_kappa_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ltdrifle_kappa_grip')},
				{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_ltdrifle_kappa_flsh' },
			}
		},
		--
		{
			name = 'WEAPON_PHANTOM_NASTY_BOYS',
			label = ('PHANTOM_NASTY_BOYS'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_phantom_nasty_boys_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_phantom_nasty_boys_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_phantom_nasty_boys_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_phantom_nasty_boys_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_phantom_nasty_boys_grip')},
			}
		},
		--
		{
			name = 'WEAPON_SR47_PINK',
			label = ('SR47_PINK'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sr47_pink_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sr47_pink_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sr47_pink_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sr47_pink_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sr47_pink_grip')},
			}
		},
		--
		{
			name = 'WEAPON_YANDERE_BIG_ALFA',
			label = ('YANDERE_BIG_ALFA'),
			ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
			components = {
				{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_yandere_big_alfa_mag1') },
				{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_yandere_big_alfa_mag2') },
				{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_yandere_big_alfa_scope') },
				{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_yandere_big_alfa_supp')},
				{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_yandere_big_alfa_grip')},
				{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_yandere_big_alfa_flsh' },
			}
		},
		--
	
	--
	{    
		name = 'WEAPON_MC4',
		label = ('MC-4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_mc4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_mc4_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_mc4_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_mc4_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_mc4_grip') },
		}
	},
	--
	--
	{
		name = 'WEAPON_VANDAL_4',
		label = ('VANDAL v4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_vandal_4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_vandal_4_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_vandal_4_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_vandal_4_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_vandal_4_grip') },
		}
	},
	--
	{
		name = 'WEAPON_LGWII',
		label = ('Lewis Gun WWII'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_lgwii_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_lgwii_mag2') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_lgwii_grip') },
		}
	},
	--
	{    
		name = 'WEAPON_M4_CAMO',
		label = ('M4 Camo'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4_camo_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4_camo_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4_camo_scope') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_ar_m4_camo_supp') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('w_at_ar_m4_camo_grip') },
		}
	},
	{
        name = 'WEAPON_SCIFI_KRISSVECTOR',
        label = ('SCIFI_KRISSVECTOR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_scifi_krissvector_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_scifi_krissvector_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_scifi_krissvector_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_scifi_krissvector_supp')},
        }
    },
	--
	--
	{    
		name = 'WEAPON_MUSICFEST',
		label = ('MUSICFEST'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_musicfest_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_musicfest_mag2') },
		}
	},
	--
	--
	{
        name = 'WEAPON_SMG1311',
        label = ('SMG1311'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_smg1311_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_smg1311_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_smg1311_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_smg1311_supp')},
        }
    },
	   -- 
	{
        name = 'WEAPON_ART64',
        label = ('AR-T64'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_art64_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_art64_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_gys_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_art64_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_art64_grip')},
        }
    },
	{
        name = 'WEAPON_TWINS_GUN',
        label = ('TWINS_GUN'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_twins_gun_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_twins_gun_mag2') },
        }
    },
   --
    {
        name = 'WEAPON_GRSR',
        label = ('GRSR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_grsr_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_grsr_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_grsr_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_grsr_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_grsr_grip')},
        }
    },
    --
    {
        name = 'WEAPON_ANR15',
        label = ('ANR15'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_anr15_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_anr15_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_anr15_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_anr15_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_anr15_grip')},
        }
    },
    --
	{
        name = 'WEAPON_TRUVELO',
        label = ('TRUVELO'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_truvelo_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_truvelo_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_truvelo_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_truvelo_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_truvelo_grip')},
        }
    },
	--
	{
        name = 'WEAPON_LIMPID',
        label = ('LIMPID'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_limpid_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_limpid_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_limpid_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_limpid_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_limpid_grip')},
        }
    },
	--
    {
        name = 'WEAPON_M4A4CH',
        label = ('M4A4-CH'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4a4ch_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4a4ch_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4a4ch_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4a4ch_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4a4ch_grip')},
        }
    },
    --
    {
        name = 'WEAPON_GYS_2',
        label = ('GYS mk2'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gys_2_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gys_2_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_gys_2_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_gys_2_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_gys_2_grip')},
        }
    },
    --
    {
        name = 'WEAPON_CARBINERR',
        label = ('CARBINE RR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_carbinerr_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_carbinerr_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_carbinerr_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_carbinerr_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_carbinerr_grip')},
        }
    },
    --
	{
        name = 'WEAPON_APDRAGON',
        label = ('AP-DRAGON'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_apdragon_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_apdragon_mag2') },
        }
    },
    --
    {
        name = 'WEAPON_APPOKEMON',
        label = ('AP-POKEMON'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_appokemon_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_appokemon_mag2') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_pi_appokemon_supp')},
        }
    },
    --
    {
        name = 'WEAPON_REVOLVER_JOKER',
        label = ('Joker Revolver'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_revolver_joker_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_revolver_joker_mag2') },
        }
    },
    --
    {
        name = 'WEAPON_MS4A1',
        label = ('MS4A1'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ms4a1_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ms4a1_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ms4a1_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ms4a1_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ms4a1_grip')},
        }
    },
    --
    {
        name = 'WEAPON_MS4A1SR',
        label = ('MS4A1SR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ms4a1sr_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ms4a1sr_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ms4a1sr_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ms4a1sr_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ms4a1sr_grip')},
        }
    },
    --
    {
        name = 'WEAPON_GLACIER',
        label = ('GLACIER'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_glacier_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_glacier_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_glacier_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_glacier_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_glacier_grip')},
        }
    },
    --
    {
        name = 'WEAPON_COORTEZZ',
        label = ('COORTEZZ'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_coortezz_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_coortezz_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_coortezz_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_coortezz_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_sb_coortezz_grip')},
        }
    },
    --
    {
        name = 'WEAPON_GOLD_SMG',
        label = ('GOLD SMG'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_gold_smg_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_gold_smg_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_gold_smg_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_gold_smg_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_sb_gold_smg_grip')},
        }
    },
    --
    {
        name = 'WEAPON_CROCDILE',
        label = ('CROCDILE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_crocdile_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_crocdile_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_crocdile_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_crocdile_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_sb_crocdile_grip')},
        }
    },
    --
    {
        name = 'WEAPON_PAINFUL',
        label = ('PAINFUL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_grip')},
        }
    },
    --

    --
    {
        name = 'WEAPON_FORTNITE_SCARL',
        label = ('Fortnite Scar-L'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fortnite_scarl_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fortnite_scarl_mag2') },
        }
    },
    --
    {
        name = 'WEAPON_FORTNITE_TOMMYGUN',
        label = ('Fortnite Tommy Gun'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_fortnite_tommygun_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_fortnite_tommygun_mag2') },
        }
    },
    --
    {
        name = 'WEAPON_FORTNITE_PISTOL',
        label = ('Fortnite Pistol'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_fortnite_pistol_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_fortnite_pistol_mag2') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_pi_fortnite_pistol_supp')},
        }
    },
    --
    {
        name = 'WEAPON_FORTNITE_TACTICAL_SHOTGUN',
        label = ('Fortnite Tactical Shotgun'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SHOTGUN')},
        components = {
        }
    },
    --
    {
        name = 'WEAPON_FORTNITE_PUMP_SHOTGUN',
        label = ('Fortnite Pump Shotgun'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SHOTGUN')},
        components = {
        }
    },
    --
    {
        name = 'WEAPON_FORTNITE_PICKAXE',
        label = ('Fortnite Pickaxe'),
        components = {
        }
    },
    --
    {
        name = 'WEAPON_NSR9',
        label = ('NSR9'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_nsr9_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_nsr9_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_nsr9_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_nsr9_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_nsr9_grip')},
        }
    },
    --
    {
        name = 'WEAPON_DRAGON_GUSENBERG',
        label = ('DRAGON GUSENBERG'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_dragon_gusenberg_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_dragon_gusenberg_mag1') },
        }
    },
    --
	{
        name = 'WEAPON_DRAGON_UZI',
        label = ('DRAGON UZI'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_sb_dragon_uzi_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_dragon_uzi_mag2') },
            { name = 'scope',         label = _U('component_scope'),         hash = GetHashKey('w_at_sb_dragon_uzi_scope') },
            { name = 'suppressor',    label = _U('component_suppressor'),    hash = GetHashKey('w_at_sb_dragon_uzi_supp')},
        }
    },
    --
    {
        name = 'WEAPON_DRAGON_TEC9',
        label = ('DRAGON TEC9'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_sb_dragon_tec9_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_dragon_tec9_mag2') },
        }
    },
    --
    {
        name = 'WEAPON_DRAGON_CARBINE',
        label = ('DRAGON CARBINE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_ar_dragon_carbine_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_dragon_carbine_mag2') },
            { name = 'scope',         label = _U('component_scope'),         hash = GetHashKey('w_at_ar_dragon_carbine_scope') },
            { name = 'suppressor',    label = _U('component_suppressor'),    hash = GetHashKey('w_at_ar_dragon_carbine_supp')},
            { name = 'grip',          label = _U('component_grip'),          hash = GetHashKey('w_at_ar_dragon_carbine_grip')},
        }
    },
	--
	{
        name = 'WEAPON_XM7_6_8',
        label = ('XM7_6_8'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default',    label =  _U('component_clip_default'),    	hash = `w_ar_xm7_6_8_mag1` },
			{ name = 'clip_extended',   label =  _U('component_clip_extended'),   	hash = `w_ar_xm7_6_8_mag2` },
			{ name = 'suppressor',      label =  _U('component_suppressor'),      	hash = `w_at_xm7_6_8_suppressor_1` },
			{ name = 'scope',      		label =  _U('component_scope'),      	hash = `w_at_xm7_6_8_sights_1` },
			{ name = 'grip',          	label =  _U('component_grip'),          	hash = `w_at_xm7_6_8_afgrip_2` },
			
        }
    },


	{
        name = 'WEAPON_SPECIALCARBINEMK2_SPLASH',
        label = ('Splash Special Assault Rifle'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default',  	label = _U('component_clip_default'), 	hash = `w_ar_specialcarbinemk2_splash_mag1` },
           	{ name = 'clip_extended', 	label = _U('component_clip_extended'), 	hash = `w_ar_specialcarbinemk2_splash_mag2` },
			{ name = 'suppressor',      label = _U('component_suppressor'),     hash = `w_at_specialcarbinemk2_splash_splash_supp` },
			{ name = 'scope',      		label = _U('component_scope'),     hash = `w_at_specialcarbinemk2_splash_splash_sights` },
			{ name = 'grip',          	label = _U('component_grip'),          	hash = `w_at_specialcarbinemk2_splash_splash_afgrip` },
        }
    },

	{
        name = 'WEAPON_SMGMK2_SPLASH',
        label = ('SMG MK2 Splash'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', 	label = _U('component_clip_default'), 	hash = `w_sb_smgmk2_splash_mag1` },
            { name = 'clip_extended',	label = _U('component_clip_extended'), 	hash = `w_sb_smgmk2_splash_mag2` },
            { name = 'suppressor',      label = _U('component_suppressor'),     hash = `w_at_smgmk2_splash_supp` },
			{ name = 'scope',      label = _U('component_scope'),     hash = `w_at_smgmk2_splash_sights` },
			{ name = 'grip',          	label = _U('component_grip'),          	hash = `w_at_smgmk2_splash_afgrip` },
        }
    },



	{
        name = 'WEAPON_RED_SMG',
        label = ('SMG Red Glowing'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
			{ name = 'clip_default', 	label = _U('component_clip_default'), 	hash = `w_sb_red_smg_mag1` },
            { name = 'clip_extended',	label = _U('component_clip_extended'), 	hash = `w_sb_red_smg_mag2` },
			{ name = 'suppressor',      label = _U('component_suppressor'),     hash = `w_at_red_smg_splash_supp` },
			{ name = 'scope',      		label = _U('component_scope'),     		hash = `w_at_red_smg_splash_sights` },
			{ name = 'grip',          	label = _U('component_grip'),          	hash = `w_at_red_smg_splash_afgrip` },
        }
    },

	{
        name = 'WEAPON_BLASTXP',
        label = ('Blast X'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default', 	label = _U('component_clip_default'), 		hash = `w_ar_blastxp_mag1` },
            { name = 'clip_extended',	label = _U('component_clip_extended'), 		hash = `w_ar_blastxp_mag2` },
			{ name = 'suppressor',      label = _U('component_suppressor'),     	hash = `w_at_blastxp_supp` },
        }
    },

	{
		name = 'WEAPON_SCAR-L_G',
		label = ('SACR-L Gold Edition'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_RIFLE` },
		components = {
			{ name = 'clip_default',  	label = _U('component_clip_default'), 			hash = `w_ar_scar-l_g__mag1`	},
			{ name = 'clip_extended',  	label = _U('component_clip_default'), 			hash = `w_ar_scar-l_g__mag2`	},
			{ name = 'scope',          	label = _U('component_scope'),         			hash = `w_at_scar-l_g__scope_small` },
			{ name = 'suppressor',    	label = _U('component_suppressor'),    			hash = `w_at_scar-l_g__supp`	},
			{ name = 'grip',          	label = _U('component_grip'),          			hash = `w_at_scar-l_g__afgrip` },
		}
	},
    --
    {
        name = 'WEAPON_EXP_SAR',
        label = ('Explosion Special AR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_ar_exp_sar_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_exp_sar_mag2') },
            { name = 'scope',         label = _U('component_scope'),         hash = GetHashKey('w_at_ar_exp_sar_sights') },
            { name = 'suppressor',    label = _U('component_suppressor'),    hash = GetHashKey('w_at_ar_exp_sar_supp')},
            { name = 'grip',          label = _U('component_grip'),          hash = GetHashKey('w_at_ar_exp_sar_grip')},
            { name = 'flashlight',    label = _U('component_flashlight'),    hash = GetHashKey('w_at_ar_exp_sar_flsh')},
        }
    },
    --
	{
		name = 'WEAPON_CERAMICPISTOL',
		label = 'Ceramic Pistol',
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		tints = Config.DefaultWeaponTints,
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CERAMICPISTOL_CLIP_01')},
			{name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CERAMICPISTOL_CLIP_02')},
			{name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_CERAMICPISTOL_SUPP')}
		}
	},
    --
    {
        name = 'WEAPON_EXP_AR',
        label = ('Explosion AR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_ar_exp_ar_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_exp_ar_mag2') },
            { name = 'scope',         label = _U('component_scope'),         hash = GetHashKey('w_at_ar_exp_ar_scope') },
            { name = 'suppressor',    label = _U('component_suppressor'),    hash = GetHashKey('w_at_ar_exp_ar_supp')},
            { name = 'grip',          label = _U('component_grip'),          hash = GetHashKey('w_at_ar_exp_ar_grip')},
            { name = 'flashlight',    label = _U('component_flashlight'),    hash = GetHashKey('w_at_pi_exp_ar_flsh')},
        }
    },
    --
    {
        name = 'WEAPON_EXP_AK',
        label = ('Explosion AK-47'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default',  label = _U('component_clip_default'),  hash = GetHashKey('w_ar_exp_ak_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_exp_ak_mag1') },
            { name = 'scope',         label = _U('component_scope'),         hash = GetHashKey('w_at_ar_exp_ak_sights') },
            { name = 'suppressor',    label = _U('component_suppressor'),    hash = GetHashKey('w_at_pi_exp_ak_supp')},
            { name = 'grip',          label = _U('component_grip'),          hash = GetHashKey('w_at_pi_exp_ak_grip')},
            { name = 'flashlight',    label = _U('component_flashlight'),    hash = GetHashKey('w_at_pi_exp_ak_flsh')},
        }
    },


	{
		name = 'WEAPON_PANDAPISTOL',
		label = ('Pistol Panda'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_PISTOL` },
		components = {
			{ name = 'clip_default',  label = _U('component_clip_default'),  hash = `w_pi_panda_pistoll_mag1` },
			{ name = 'flashlight',    label = _U('component_flashlight'),    hash = `w_at_panda_pistol_flsh` },
			{ name = 'suppressor',    label = _U('component_suppressor'),    hash = `w_at_panda_pistol_supp` },
		}
	},


	{
        name = 'WEAPON_REDDRAGONV2',
        label = ('Red Dragon'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default', 	label = _U('component_clip_default'), 		hash = `w_ar_reddragonv2_mag1` },
            { name = 'clip_extended',	label = _U('component_clip_extended'), 		hash = `w_ar_reddragonv2_mag2` },
			{ name = 'grip',          	label = _U('component_grip'),          		hash = `w_at_ar_reddragonv2_grip` },
        }
    },

	{
		name = 'WEAPON_BAS_P_RED',
		label = ('BAS P RED'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_SMG` },
		components = {
			{ name = 'clip_default',  		label = _U('component_clip_default'), 			hash = `w_sb_bas_p_mag1`	},
			{ name = 'clip_extended',  		label = _U('component_clip_default'), 			hash = `w_sb_bas_p_mag2`	},
			{ name = 'grip',          		label = _U('component_grip'),          			hash = `w_at_bas_p_grip` },
			{ name = 'suppressor',    		label = _U('component_suppressor'),    			hash = `w_at_bas_p_supp`	},
			{ name = 'scope',         		label = _U('component_scope'),         			hash = `w_at_bas_p_scope` },
		}
	},



	{
		name = 'WEAPON_SCAR-L',
		label = ('SACR-L White'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_RIFLE` },
		components = {
			{ name = 'clip_default',  	label = _U('component_clip_default'), 			hash = `w_ar_scar-l_mag1`	},
			{ name = 'clip_extended',  	label = _U('component_clip_default'), 			hash = `w_ar_scar-l_mag2`	},
			{ name = 'scope',          	label = _U('component_scope'),         			hash = `w_at_scar-l_scope_small` },
			{ name = 'suppressor',    	label = _U('component_suppressor'),    			hash = `w_at_scar-l_supp`	},
			{ name = 'grip',          	label = _U('component_grip'),          			hash = `w_at_scar-l_afgrip` },
		}
	},

	{
        name = 'WEAPON_M4_T_NEON',
        label = ('M4 TACTICAL NEON'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default',    label = _U('component_clip_default'),    	hash = `w_ar_m4_tactical_neon_mag1` },
			{ name = 'clip_extended',   label = _U('component_clip_extended'),   	hash = `w_ar_m4_tactical_neon_mag2` },
			{ name = 'suppressor',      label = _U('component_suppressor'),      	hash = `w_at_m4_tactical_neon_supp` },
			{ name = 'scope',      		label = _U('component_scope'),      		hash = `w_at_m4_tactical_neon_scope_small` },
			{ name = 'grip',          	label = _U('component_grip'),          		hash = `w_at_m4_tactical_neon_afgrip` },
        }
    },


	{
        name = 'WEAPON_GRAUV2',
        label = ('GRAUV2'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default',    	label = _U('component_clip_default'),    	hash = `w_ar_grauv2_mag1` 	},
			{ name = 'clip_extended',   	label = _U('component_clip_extended'),   	hash = `w_ar_grauv2_mag2` 	},
			{ name = 'suppressor',    		label = _U('component_suppressor'),    		hash = `w_at_ar_grauv2_supp`	},
			{ name = 'scope',         	label = _U('component_scope'),         hash = `w_at_ar_grauv2_scope` 	},
			{ name = 'grip',          		label = _U('component_grip'),          		hash = `w_at_ar_grauv2_grip` },
        }
    },

	{
        name = 'WEAPON_HFSMGV2',
        label = ('HFSMGV2'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default',    	label = _U('component_clip_default'),    	hash = `w_sb_hfsmgv2_mag1` 	},
			{ name = 'clip_extended',   	label = _U('component_clip_extended'),   	hash = `w_sb_hfsmgv2_mag2` 	},
			{ name = 'suppressor',    		label = _U('component_suppressor'),    		hash = `w_at_sb_hfsmgv2_supp`	},
			{ name = 'scope',         	label = _U('component_scope'),         hash = `w_at_sb_hfsmgv2_scope` 	},
        }
    },


	{
		name = 'WEAPON_FAMAS_YELLOW',
		label = ('FAMAS Yellow'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_RIFLE` },
		components = {
			{ name = 'clip_default',  		label = _U('component_clip_default'), 			hash = `w_ar_famas_yellow_mag1`	},
			{ name = 'clip_extended',  		label = _U('component_clip_default'), 			hash = `w_ar_famas_yellow_mag2`	},
			{ name = 'suppressor',    		label = _U('component_suppressor'),    			hash = `w_at_famas_yellow_supp`	},
			{ name = 'scope',         	label = _U('component_scope'),         	hash = `w_at_famas_yellow_scope` },
			--{ name = 'scope_small',         label = _U('component_scope_holo'),         	hash = `w_at_famas_yellow_sight` },
		}
	},

	{
        name = 'WEAPON_NVRIFLE_PURPLE',
        label = ('NV Rifle Purple'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
			{ name = 'clip_default',    	label = _U('component_clip_default'),    	hash = `w_ar_nvrifle_purple_mag1` },
			{ name = 'clip_extended',   	label = _U('component_clip_extended'),   	hash = `w_ar_nvrifle_purple_mag2` },
			{ name = 'suppressor',    		label = _U('component_suppressor'),    		hash = `w_at_nvrifle_purple_supp`	},
			{ name = 'scope',         	label = _U('component_scope'),         hash = `w_at_nvrifle_purple_scope_small` },
			--{ name = 'scope_small',         label = _U('component_scope_holo'),     	hash = `w_at_nvrifle_purple_scope_sight` },
			{ name = 'grip',          		label = _U('component_grip'),          		hash = `w_at_nvrifle_purple_afgrip` },
        }
    },

	{
		name = 'WEAPON_L85_CHRISTMAS',
		label = ('L85 CHRISTMAS'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_RIFLE` },
		components = {
			{ name = 'clip_default',  		label = _U('component_clip_default'), 			hash = `w_ar_l85_christmas_mag1`	},
			{ name = 'clip_extended',  		label = _U('component_clip_default'), 			hash = `w_ar_l85_christmas_mag2`	},
			{ name = 'suppressor',    		label = _U('component_suppressor'),    			hash = `w_at_l85_christmas_supp`	},
			{ name = 'scope',         		label = _U('component_scope'),         	hash = `w_at_l85_christmas_scope_small` },
			{ name = 'grip',          		label = _U('component_grip'),          			hash = `w_at_l85_christmas_afgrip` },

		}
	},

	{
		name = 'WEAPON_CRISS_CHRISTMAS',
		label = ('CRISS OPS Christmas'),
		ammo = { label = _U('ammo_rounds'), hash = `AMMO_SMG` },
		components = {
			{ name = 'clip_default',  		label = _U('component_clip_default'), 			hash = `w_sb_criss_ops_christmas_mag1`	},
			{ name = 'clip_extended',  		label = _U('component_clip_default'), 			hash = `w_sb_criss_ops_christmas_mag2`	},
			{ name = 'suppressor',    		label = _U('component_suppressor'),    			hash = `w_sb_criss_ops_christmas_supp`	},
			{ name = 'scope',         		label = _U('component_scope'),         			hash = `w_sb_criss_ops_christmas_scope` },
			--{ name = 'scope_small',       label = _U('component_scope_holo'),         	hash = `w_sb_criss_ops_christmas_sight` },
			{ name = 'grip',          		label = _U('component_grip'),          			hash = `w_sb_criss_ops_christmas_afgrip` },
		}
	},

	--
	{
        name = 'WEAPON_XM4',
        label = ('XM-4'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_xm4_mag1') },
            {name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_xm4_mag2') },
            {name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_xm4_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_xm4_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_xm4_grip')},
            {name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_xm4_flsh' },
        }
    },
    --
    {
        name = 'WEAPON_L96A3',
        label = ('L96A3'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sr_l96a3_mag1') },
            {name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sr_l96a3_scope_large') },
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('w_at_sr_l96a3_scope_max') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sr_l96a3_supp')},
        }
    },
	--
	{
		name = 'WEAPON_M4_GQUEEN',
		label = ('M4_GQUEEN'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4_gqueen_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4_gqueen_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4_gqueen_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4_gqueen_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4_gqueen_grip')},
		}
	},
	--
	{
		name = 'WEAPON_M4A5_CRIPS',
		label = ('M4A5 CRIPS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4a5_crips_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4a5_crips_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4a5_crips_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4a5_crips_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4a5_crips_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SRM2',
		label = ('SRM2'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_srm2_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_srm2_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_srm2_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_srm2_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_sb_srm2_grip')},
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_sb_srm2_flsh' },

		}
	},
    --

	--
	--
	{
        name = 'WEAPON_CAUSTIC',
        label = ('CAUSTIC'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_caustic_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_caustic_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_caustic_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_caustic_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_caustic_grip')},
        }
    },
    --
	{
        name = 'WEAPON_MP5X',
        label = ('MP5X'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp5x_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp5x_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp5x_scope') },
            { name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_mp5x_supp')},
            { name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_sb_mp5x_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_sb_mp5x_flsh' },
        }
    },
    --
	{
        name = 'WEAPON_M1918',
        label = ('M1918'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m1918_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m1918_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m1918_scope') },
        }
    },
	--
    {
        name = 'WEAPON_HEAVYSNIPER_MK2_ROZITA',
        label = ('HEAVYSNIPER MK2 ROZITA'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
        components = {
            {name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sr_heavysniper_mk2_rozita_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sr_heavysniper_mk2_rozita_mag2') },
            {name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sr_heavysniper_mk2_rozita_scope_large') },
            {name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('w_at_sr_heavysniper_mk2_rozita_scope_max') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sr_heavysniper_mk2_rozita_supp')},
        }
    },
	--
	{
		name = 'WEAPON_SNIPERRIFLE_SCOOBY_TOLIS',
		label = ('SNIPERRIFLE Scooby X Tolis'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
		components = {
			{name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sr_sniperrifle_scooby_tolis_mag1') },
			{name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sr_sniperrifle_scooby_tolis_scope_large') },
		}
	},
	-- 
	{
		name = 'WEAPON_SALTY_SNACK',
		label = ('SALTY_SNACK'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_salty_snack_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_salty_snack_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_salty_snack_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_salty_snack_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_salty_snack_grip')},
		}
	},
	--
	{
		name = 'WEAPON_AVANDK',
		label = ('AVANDK'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_avandk_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_avandk_mag2') },
		}
	},
	--
	{
		name = 'WEAPON_M250_MG',
		label = ('M250_MG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_MG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_mg_m250_mg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_mg_m250_mg_mag2') },
		}
	},
	--
	{
		name = 'WEAPON_CAUSTIC_PD',
		label = ('CAUSTIC Police Version'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_caustic_pd_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_caustic_pd_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_caustic_pd_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_caustic_pd_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_caustic_pd_grip')},
		}
	},
	--
	{
		name = 'WEAPON_COD_CARBINE_RIFLE',
		label = ('COD Carbine Rifle'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_cod_carbine_rifle_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_cod_carbine_rifle_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_cod_carbine_rifle_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_cod_carbine_rifle_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_cod_carbine_rifle_grip')},
		}
	},
	--
	{
		name = 'WEAPON_COD_SPECIAL_CARBINE',
		label = ('COD Special Carbine'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_cod_special_carbine_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_cod_special_carbine_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_cod_special_carbine_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_cod_special_carbine_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_cod_special_carbine_grip')},
		}
	},
	--
	{
		name = 'WEAPON_SCARL_FOX',
		label = ('SCAR-L FOX Version'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scarl_fox_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scarl_fox_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scarl_fox_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_scarl_fox_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_scarl_fox_grip')},
		}
	},
	--
	{
		name = 'WEAPON_HK416_PANN',
		label = ('HK416_PANN'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_hk416_pann_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_hk416_pann_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_hk416_pann_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_hk416_pann_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_hk416_pann_grip')},
			{name = 'flashlight',         label = _U('component_flashlight'),     hash = GetHashKey('w_at_ar_hk416_pann_flsh')},
		}
	},
	--
	{
        name = 'WEAPON_MP5_NEZUKO',
        label = ('MP5_NEZUKO'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp5_nezuko_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp5_nezuko_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_mp5_nezuko_scope') },
            { name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_mp5_nezuko_supp')},

        }
    },
    --
    {
        name = 'WEAPON_MP40B',
        label = ('MP40B'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_mp40b_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_mp40b_mag2') },

        }
    },
    --
    --
    {
        name = 'WEAPON_STALLION',
        label = ('STALLION'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_stallion_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_stallion_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_stallion_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_stallion_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_stallion_grip')},
        }
    },
	--
	{
        name = 'WEAPON_R20RAHE',
        label = ('R20RAHE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_r20rahe_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_r20rahe_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_r20rahe_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_r20rahe_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_r20rahe_grip')},
        }
    },
    --
    {
        name = 'WEAPON_PIKOCR',
        label = ('PIKOCR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_pikocr_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_pikocr_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_pikocr_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_pikocr_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_pikocr_grip')},
        }
    },
    --
	{
        name = 'WEAPON_INTEGRALE553',
        label = ('INTEGRALE553'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_integrale553_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_integrale553_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_integrale553_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_integrale553_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_integrale553_grip')},
        }
    },
	--
	--
	{
		name = 'WEAPON_LIMITLESS_CARBINE_MK3',
		label = ('Limitless Carbine mk3'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_limitless_carbine_mk3_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_limitless_carbine_mk3_mag2') },
		}
	},
	--
	{
		name = 'WEAPON_LIMITLESS_CARBINE_MK4',
		label = ('Limitless Carbine mk4'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_limitless_carbine_mk4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_limitless_carbine_mk4_mag2') },
		}
	},
	--
	{
        name = 'WEAPON_TM16_PANDAKI1123',
        label = ('TM16_PANDAKI1123'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_tm16_pandaki1123_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_tm16_pandaki1123_mag2') },
        }
    },
	--
	--
	{
        name = 'WEAPON_FFBFD_PANDAS',
        label = ('FFBFD_PANDAS'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ffbfd_pandas_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ffbfd_pandas_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ffbfd_pandas_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ffbfd_pandas_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ffbfd_pandas_grip')},
        }
    },
	--
	{
        name = 'WEAPON_M4_RAFAIL5020',
        label = ('M4_RAFAIL5020'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4_rafail5020_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4_rafail5020_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4_rafail5020_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4_rafail5020_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m4_rafail5020_grip')},
        }
    },
	--
	{
		name = 'WEAPON_LTDRIFLE',
		label = ('LTDRIFLE'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ltdrifle_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ltdrifle_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ltdrifle_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ltdrifle_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ltdrifle_grip')},
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_ltdrifle_flsh' },
		}
	},
	--
	{
		name = 'WEAPON_PUSSYCAT',
		label = ('PUSSYCAT'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_pussycat_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_pussycat_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_pussycat_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_pussycat_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_pussycat_grip')},
		}
	},
	--
	{
        name = 'WEAPON_R3AL_ALEXAK0S_SCARL',
        label = ('R3AL ALEXAK0S SCARL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_r3al_alexak0s_scarl_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_r3al_alexak0s_scarl_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_r3al_alexak0s_scarl_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_r3al_alexak0s_scarl_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_r3al_alexak0s_scarl_grip')},
        }
    },
	--
	{
        name = 'WEAPON_SR3SMG',
        label = ('SR3SMG'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_sr3smg_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_sr3smg_mag2') },
        }
    },
	    --
	{
		name = 'WEAPON_DUBSTEP_GUN',
		label = ('DubStep Gun'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_dubstep_gun_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_dubstep_gun_mag2') },
		}
	},
	--

	--
	{
		name = 'WEAPON_PL14_VIP',
		label = ('PL14 VIP Version'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_PISTOL')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_pl14_vip_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_pi_pl14_vip_mag2') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('w_at_pi_pl14_vip_supp') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_pi_pl14_vip_flsh' },
		}
	},
	--
	{
        name = 'WEAPON_SR47_VIP',
        label = ('SR47 VIP Version'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sr47_vip_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sr47_vip_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sr47_vip_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sr47_vip_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sr47_vip_grip')},
        }
    },
	--
	{
        name = 'WEAPON_M82_VIP',
        label = ('M82 VIP Version'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m82_vip_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m82_vip_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m82_vip_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m82_vip_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m82_vip_grip')},
        }
    },
	--
	{
        name = 'WEAPON_HFSMG_VIP',
        label = ('HFSMG VIP Version'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_hfsmg_vip_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_hfsmg_vip_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_hfsmg_vip_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_hfsmg_vip_supp')},
        }
    },
	--
	{
        name = 'WEAPON_MARINE_BRATVA',
        label = ('MARINE Bratva Version'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_marine_bratva_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_marine_bratva_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_marine_bratva_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_marine_bratva_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_marine_bratva_grip')},
        }
    },
	--
	{
        name = 'WEAPON_SXMDR',
        label = ('SpaceX MDR'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sxmdr_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sxmdr_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sxmdr_scope') },
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sxmdr_grip')},
        }
    },
	--
	{
        name = 'WEAPON_CARTOON_RIFLE',
        label = ('Cartoon Rifle'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_cartoon_rifle_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_cartoon_rifle_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_cartoon_rifle_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_cartoon_rifle_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_cartoon_rifle_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_cartoon_rifle_flsh' },
        }
    },
	{
        name = 'WEAPON_BUILDINGBLOCKGUN',
        label = ('BUILDINGBLOCKGUN'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_buildingblockgun_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_buildingblockgun_mag2') },
        }
    },
	{
        name = 'WEAPON_SFG29',
        label = ('SFG29'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sfg29_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sfg29_mag2') },
        }
    },
	{
        name = 'WEAPON_CRM_FAMILIES',
        label = ('CRM_FAMILIES'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_crm_families_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_crm_families_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_crm_families_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_crm_families_supp')},
        }
    },
	{
        name = 'WEAPON_HEAVYSNIPER_HERMANOS',
        label = ('HEAVYSNIPER_HERMANOS'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SNIPER')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sr_heavysniper_hermanos_mag1') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sr_heavysniper_hermanos_scope') },
            { name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('w_at_sr_heavysniper_hermanos_scope_2') }
        }
    },
	 --
	 {
        name = 'WEAPON_ARCADE_RIFLE',
        label = ('ARCADE RIFLE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_arcade_rifle_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_arcade_rifle_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_arcade_rifle_scope') },
        }
    },
    --
	{
        name = 'WEAPON_SCIFIRIFLE_MK2',
        label = ('Sci-Fi mk2 Rifle'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scifirifle_mk2_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scifirifle_mk2_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scifirifle_mk2_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_scifirifle_mk2_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_scifirifle_mk2_grip')},
        }
    },
    --
	{
        name = 'WEAPON_SCIFIRIFLE',
        label = ('Sci-Fi Rifle'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_scifirifle_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_scifirifle_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_scifirifle_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_scifirifle_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_scifirifle_grip')},
        }
    },
    --
	--
	{
		name = 'WEAPON_ACSCHG',
		label = ('ACSCHG'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_sb_acschg_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_sb_acschg_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_sb_acschg_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_sb_acschg_supp')},
		}
	},
	--
    --
	{
		name = 'WEAPON_M1233',
		label = ('M1233'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m1233_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m1233_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m1233_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m1233_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m1233_grip')},
		}
	},
	{
        name = 'WEAPON_CCAKM',
        label = ('CCAKM'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ccakm_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ccakm_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ccakm_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ccakm_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ccakm_grip')},
        }
    },
	   --
	{
        name = 'WEAPON_CRM_TG',
        label = ('CRM_TG'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_crm_tg_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_crm_tg_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_crm_tg_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_crm_tg_supp')},
        }
    },
	--
	{
		name = 'WEAPON_AR15_BALLAS',
		label = ('AR15_BALLAS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ar15_ballas_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ar15_ballas_mag2') },
		}
	},
	--
		    --
	{
        name = 'WEAPON_PIPER_RIFLE',
        label = ('PIPER_RIFLE'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_piper_rifle_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_piper_rifle_mag2') },
        }
    },
    --
    --







	{
        name = 'WEAPON_B93_PAINFUL',
        label = ('B93_PAINFUL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_b93_painful_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_b93_painful_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_b93_painful_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_b93_painful_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_b93_painful_grip')},
        }
    },
	{
        name = 'WEAPON_BH_PAINFUL',
        label = ('BH_PAINFUL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_bh_painful_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_bh_painful_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_bh_painful_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_bh_painful_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_bh_painful_grip')},
        }
    },
	{
        name = 'WEAPON_PAINFUL_VLOCO',
        label = ('PAINFUL_VLOCO'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_vloco_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_vloco_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_vloco_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_vloco_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_vloco_grip')},
        }
    },
	{
        name = 'WEAPON_BRATVA_PAINFUL',
        label = ('BRATVA_PAINFUL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_bratva_painful_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_bratva_painful_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_bratva_painful_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_bratva_painful_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_bratva_painful_grip')},
        }
    },
	{
        name = 'WEAPON_ITALIANS_PAINFUL',
        label = ('ITALIANS_PAINFUL'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_italians_painful_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_italians_painful_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_italians_painful_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_italians_painful_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_italians_painful_grip')},
        }
    },
	{
        name = 'WEAPON_LTDRIFLE_ALL_STARS',
        label = ('LTDRIFLE ALL STARS'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ltdrilfe_all_stars_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ltdrilfe_all_stars_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ltdrilfe_all_stars_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_ltdrilfe_all_stars_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ltdrilfe_all_stars_grip')},
            { name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_ltdrilfe_all_stars_flsh' },
        }
    },
	{
        name = 'WEAPON_M1233_ATK',
        label = ('M1233_ATK'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m1233_atk_mag1') },
            { name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m1233_atk_mag2') },
            { name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m1233_atk_scope') },
            {name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m1233_atk_supp')},
            {name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m1233_atk_grip')},
        }
    },
	--
	{
		name = 'WEAPON_M16A3_UNDERGROUND',
		label = ('M16A3_UNDERGROUND'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m16a3_underground_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m16a3_underground_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m16a3_underground_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m16a3_underground_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_m16a3_underground_grip')},
		}
	},
	--
	{
		name = 'WEAPON_PAINFUL_LOGOTEXNIA',
		label = ('PAINFUL_LOGOTEXNIA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_logotexnia_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_logotexnia_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_logotexnia_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_logotexnia_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_logotexnia_grip')},
		}
	},
	--
	{
		name = 'WEAPON_PAINFUL_MARABUNDA',
		label = ('PAINFUL_MARABUNDA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_marabunda_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_marabunda_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_marabunda_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_marabunda_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_marabunda_grip')},
		}
	},
	--
	{
		name = 'WEAPON_PAINFUL_REAL_SPYROS',
		label = ('PAINFUL_REAL_SPYROS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_real_spyros_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_real_spyros_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_real_spyros_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_real_spyros_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_real_spyros_grip')},
		}
	},
	--
	{
		name = 'WEAPON_PAINFUL_VORTEX',
		label = ('PAINFUL_VORTEX'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_vortex_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_vortex_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_vortex_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_vortex_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_vortex_grip')},
		}
	},

	{
		name = 'WEAPON_PAINFUL_OMERTA',
		label = ('PAINFUL_OMERTA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_omerta_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_omerta_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_omerta_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_omerta_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_omerta_grip')},
		}
	},
	--
	{
		name = 'WEAPON_TASER_BLXR',
		label = ('TASER_BLXR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_STUNGUN')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_pi_taser_blxr_mag1') },
		}
	},
	--
	--
	--
	--

	{
		name = 'WEAPON_SR47_ZOC',
		label = ('SR47_ZOC'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_sr47_zoc_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_sr47_zoc_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_sr47_zoc_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_sr47_zoc_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_sr47_zoc_grip')},
		}
	},
	{
		name = 'WEAPON_PAINFUL_MMAFIA',
		label = ('PAINFUL_MMAFIA'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_mmafia_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_mmafia_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_mmafia_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_mmafia_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_mmafia_grip')},
		}
	},
	{
		name = 'WEAPON_AR15_BPM',
		label = ('AR15_BPM'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ar15_bpm_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ar15_bpm_mag2') },
		}
	},
	{
		name = 'WEAPON_AR15_DROGIS_X_STRATT',
		label = ('AR15_DROGIS_X_STRATT'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ar15_drogis_x_stratt_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ar15_drogis_x_stratt_mag2') },
		}
	},
	{
		name = 'WEAPON_PAINFUL_GODFATHERS',
		label = ('PAINFUL_GODFATHERS'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_godfathers_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_godfathers_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_godfathers_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_godfathers_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_godfathers_grip')},
		}
	},


	{
		name = 'WEAPON_BLX_PAINFUL',--26/5
		label = ('BLX_PAINFUL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_blx_painful_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_blx_painful_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_blx_painful_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_blx_painful_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_blx_painful_grip')},
		}
	},
	--
	{
		name = 'WEAPON_KOSMAS_K_PAINFUL',--26/5
		label = ('KOSMAS_K_PAINFUL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_kosmas_k_painful_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_kosmas_k_painful_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_kosmas_k_painful_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_kosmas_k_painful_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_kosmas_k_painful_grip')},
		}
	},
	--
	{
		name = 'WEAPON_TZHKASS_PAINFUL',--26/5
		label = ('TZHKASS_PAINFUL'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_tzhkass_painful_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_tzhkass_painful_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_tzhkass_painful_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_tzhkass_painful_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_tzhkass_painful_grip')},
		}
	},
	--
	{
		name = 'WEAPON_CCR',--26/5
		label = ('CCR'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_ccr_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_ccr_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_ccr_scope') },
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_ccr_grip')},
		}
	},
	--
	{
		name = 'WEAPON_M4_TAVERN',--26/5
		label = ('M4_TAVERN'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_m4_tavern_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_m4_tavern_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_m4_tavern_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_m4_tavern_supp')},
		}
	},
	--
	{
		name = 'WEAPON_SAIGA9_KRAKEN',--26/5
		label = ('SAIGA9_KRAKEN'),
		ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_saiga9_kraken_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_saiga9_kraken_mag2') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_saiga9_kraken_scope') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_saiga9_kraken_supp')},
			{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_saiga9_kraken_grip')},
			{ name = 'flashlight', label = _U('component_flashlight'), hash = 'w_at_ar_saiga9_kraken_flsh' },

		}
	},
	--
	{name = 'WEAPON_M18_SM', label = "M18 Smoke", components = {}, ammo = {label = _U('AMMO_M18_SM'), hash = GetHashKey('AMMO_M18_SM')}}, --26/5
	{
        name = 'WEAPON_GM_SPECIAL_AKM',
        label = ('Greek Mafia Special AKM'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gm_special_akm_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gm_special_akm_mag2') },
        }
    },
    --
	{
        name = 'WEAPON_GM_SPECIAL_M4',
        label = ('Greek Mafia Special M4'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gm_special_m4_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gm_special_m4_mag2') },
			{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_gm_special_m4_supp')},
        }
    },
    --
	{
        name = 'WEAPON_GM_SPECIAL_VECTOR',
        label = ('Greek Mafia Special Vector'),
        ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_SMG')},
        components = {
            { name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_gm_special_vector_mag1') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_gm_special_vector_mag2') },
        }
    },


	--15/7
--
{
	name = 'WEAPON_PAINFUL_13',
	label = ('PAINFUL 13 Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_13_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_13_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_13_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_13_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_13_grip')},
	}
},
--
{
	name = 'WEAPON_PAINFUL_DOUDIS',
	label = ('PAINFUL Doudis Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_doudis_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_doudis_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_doudis_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_doudis_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_doudis_grip')},
	}
},
--
{
	name = 'WEAPON_PAINFUL_FERMAS',
	label = ('PAINFUL FERMAS Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_fermas_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_fermas_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_fermas_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_fermas_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_fermas_grip')},
	}
},
{
	name = 'WEAPON_VORTEXAK',
	label = ('VORTEXAK'),
	ammo = { label = _U('ammo_rounds'), hash = `AMMO_RIFLE` },
	components = {
	}
},
--
{
	name = 'WEAPON_PAINFUL_VXLO',
	label = ('PAINFUL VXLO Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_painful_vxlo_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_painful_vxlo_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_painful_vxlo_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_painful_vxlo_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_painful_vxlo_grip')},
	}
},
--
 {
	name = 'WEAPON_AXMC_GORILAS',
	label = ('AXMC Gorilas Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_axmc_gorilas_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_axmc_gorilas_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_axmc_gorilas_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_axmc_gorilas_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_axmc_gorilas_grip')},
	}
},
--
{
	name = 'WEAPON_G36_ELAS',
	label = ('G36 Police Version'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_g36_elas_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_g36_elas_mag2') },
		{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('w_at_ar_g36_elas_scope') },
		{name = 'suppressor',         label = _U('component_suppressor'),     hash = GetHashKey('w_at_ar_g36_elas_supp')},
		{name = 'grip',         label = _U('component_grip'),     hash = GetHashKey('w_at_ar_g36_elas_grip')},
		{name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('w_at_ar_g36_elas_flsh')},
	}
},
--
{
	name = 'WEAPON_LIMITLESS_CARBINE_BATMAN',
	label = ('LIMITLESS CARBINE BATMAN'),
	ammo = {label = _U('ammo_rounds'), hash = GetHashKey('AMMO_RIFLE')},
	components = {
		{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('w_ar_limitless_carbine_batman_mag1') },
		{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('w_ar_limitless_carbine_batman_mag2') },
	}
},
--

}

exports('GetAllWeapons', function()
	return Config.Weapons
end)