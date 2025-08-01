


Locales['de'] = {
  -- Inventory
  ['inventory'] = 'inventar %s / %s',
  ['use'] = 'benutzen',
  ['give'] = 'geben',
  ['remove'] = 'entfernen',
  ['return'] = 'zurück',
  ['give_to'] = 'geben an',
  ['amount'] = 'betrag',
  ['giveammo'] = 'munition geben',
  ['amountammo'] = 'anzahl der munition',
  ['noammo'] = 'du hast keine munition!',
  ['gave_item'] = 'du gibst ~y~%sx~s~ ~b~%s~s~ an ~y~%s~s~',
  ['received_item'] = 'du empfängst ~y~%sx~s~ ~b~%s~s~ von ~b~%s~s~',
  ['gave_weapon'] = 'du gibst ~b~%s~s~ an ~y~%s~s~',
  ['gave_weapon_ammo'] = 'du gibst ~o~%sx %s~s~ von ~b~%s~s~ an ~y~%s~s~',
  ['gave_weapon_withammo'] = 'du gibst ~b~%s~s~ mit ~o~%sx %s~s~ an ~y~%s~s~',
  ['gave_weapon_hasalready'] = '~y~%s~s~ hat bereits eine(n) ~y~%s~s~',
  ['gave_weapon_noweapon'] = '~y~%s~s~ hat diese Waffe nicht',
  ['received_weapon'] = 'du erhälst ~b~%s~s~ von ~b~%s~s~',
  ['received_weapon_ammo'] = 'du erhälst ~o~%sx %s~s~ für dein ~b~%s~s~ von ~b~%s~s~',
  ['received_weapon_withammo'] = 'du erhälst ~b~%s~s~ mit ~o~%sx %s~s~ von ~b~%s~s~',
  ['received_weapon_hasalready'] = '~b~%s~s~ hat versucht dir eine(n) ~y~%s~s~ zu geben, aber du hast bereits eine(n)',
  ['received_weapon_noweapon'] = '~b~%s~s~ ahat versucht dir Munition für eine(n) ~y~%s~s~, aber du besitzt diese Waffe nicht',
  ['gave_account_money'] = 'du gibst ~g~$%s~s~ (%s) an ~y~%s~s~',
  ['received_account_money'] = 'du empfängst ~g~$%s~s~ (%s) von ~b~%s~s~',
  ['amount_invalid'] = 'ungültiger Betrag',
  ['players_nearby'] = 'keine Spieler in der Nähe',
  ['ex_inv_lim'] = 'aktion nicht möglich, Inventarlimit überschritten für ~y~%s~s~',
  ['imp_invalid_quantity'] = 'aktion nicht möglich, ungültige Anzahl',
  ['imp_invalid_amount'] = 'aktion nicht möglich, ungültiger Betrag',
  ['threw_standard'] = 'you threw ~y~%sx~s~ ~b~%s~s~',
  ['threw_account'] = 'du wirfst ~g~$%s~s~ ~b~%s~s~ weg',
  ['threw_weapon'] = 'du wirfst ~b~%s~s~ weg',
  ['threw_weapon_ammo'] = 'du wirfst ~b~%s~s~ mit ~o~%sx %s~s~ weg',
  ['threw_weapon_already'] = 'Du hast bereits diese Waffe',
  ['threw_cannot_pickup'] = 'Du kannst das nicht aufheben, da dein Inventar voll ist',
  ['threw_pickup_prompt'] = 'drücke ~y~E~s~ um aufzuheben',

  -- Key mapping
  ['keymap_showinventory'] = 'inventar anzeigen',

  -- Salary related
  ['received_salary'] = 'du hast dein Gehalt erhalten: ~g~$%s~s~',
  ['received_help'] = 'du hast deine Sozialhilfe erhalten: ~g~$%s~s~',
  ['company_nomoney'] = 'die Firma in der du angestellt bist, ist zu arm um dein Gehalt zu zahlen',
  ['received_paycheck'] = 'erhaltener Gehaltsscheck',
  ['bank'] = 'bank',
  ['account_bank'] = 'bank',
  ['account_black_money'] = 'dirty Money',
  ['account_money'] = 'cash',

  ['act_imp'] = 'Aktion nicht möglich',
  ['in_vehicle'] = 'du kannst keine Items in einem Fahrzeug weitergeben',

  -- Commands
  ['command_car'] = 'spawn an vehicle',
  ['command_car_car'] = 'vehicle spawn name or hash',
  ['command_cardel'] = 'delete vehicle in proximity',
  ['command_cardel_radius'] = 'optional, delete every vehicle within the specified radius',
  ['command_clear'] = 'clear chat',
  ['command_clearall'] = 'clear chat for all players',
  ['command_clearinventory'] = 'clear player inventory',
  ['command_clearloadout'] = 'clear a player loadout',
  ['command_giveaccountmoney'] = 'give account money',
  ['command_giveaccountmoney_account'] = 'valid account name',
  ['command_giveaccountmoney_amount'] = 'amount to add',
  ['command_giveaccountmoney_invalid'] = 'invalid account name',
  ['command_giveitem'] = 'give an item to a player',
  ['command_giveitem_item'] = 'item name',
  ['command_giveitem_count'] = 'item count',
  ['command_giveweapon'] = 'give a weapon to a player',
  ['command_giveweapon_weapon'] = 'weapon name',
  ['command_giveweapon_ammo'] = 'ammo count',
  ['command_giveweapon_hasalready'] = 'player already has that weapon',
  ['command_giveweaponcomponent'] = 'give weapon component',
  ['command_giveweaponcomponent_component'] = 'component name',
  ['command_giveweaponcomponent_invalid'] = 'invalid weapon component',
  ['command_giveweaponcomponent_hasalready'] = 'player already has that weapon component',
  ['command_giveweaponcomponent_missingweapon'] = 'player does not have that weapon',
  ['command_save'] = 'save a player to database',
  ['command_saveall'] = 'save all players to database',
  ['command_setaccountmoney'] = 'set account money for a player',
  ['command_setaccountmoney_amount'] = 'amount of money to set',
  ['command_setcoords'] = 'teleport to coordinates',
  ['command_setcoords_x'] = 'x axis',
  ['command_setcoords_y'] = 'y axis',
  ['command_setcoords_z'] = 'z axis',
  ['command_setjob'] = 'set job for a player',
  ['command_setjob_job'] = 'job name',
  ['command_setjob_grade'] = 'job grade',
  ['command_setjob_invalid'] = 'the job, grade or both are invalid',
  ['command_setgroup'] = 'set player group',
  ['command_setgroup_group'] = 'group name',
  ['commanderror_argumentmismatch'] = 'argument count mismatch (passed %s, wanted %s)',
  ['commanderror_argumentmismatch_number'] = 'argument #%s type mismatch (passed string, wanted number)',
  ['commanderror_invaliditem'] = 'invalid item name',
  ['commanderror_invalidweapon'] = 'invalid weapon',
  ['commanderror_console'] = 'that command can not be run from console',
  ['commanderror_invalidcommand'] = '^3%s^0 is not an valid command!',
  ['commanderror_invalidplayerid'] = 'there is no player online matching that server id',
  ['commandgeneric_playerid'] = 'player id',

  -- Locale settings
  ['locale_digit_grouping_symbol'] = ' ',
  ['locale_currency'] = '$%s',

  -- Weapons
  ['weapon_knife'] = 'Messer',
  ['weapon_nightstick'] = 'Schlagstock',
  ['weapon_hammer'] = 'Hammer',
  ['weapon_bat'] = 'Schläger',
  ['weapon_golfclub'] = 'Golfschläger',
  ['weapon_crowbar'] = 'Brecheisen',
  ['weapon_pistol'] = 'Pistole',
  ['weapon_combatpistol'] = 'Kampfpistole',
  ['weapon_appistol'] = 'AP Pistole',
  ['weapon_pistol50'] = 'Pistole .50',
  ['weapon_microsmg'] = 'Mikro SMG',
  ['weapon_smg'] = 'SMG',
  ['weapon_assaultsmg'] = 'Kampf SMG',
  ['weapon_assaultrifle'] = 'Kampfgewehr',
  ['weapon_carbinerifle'] = 'Karabinergewehr',
  ['weapon_advancedrifle'] = 'Advancedgewehr',
  ['weapon_mg'] = 'MG',
  ['weapon_combatmg'] = 'Kampf MG',
  ['weapon_pumpshotgun'] = 'Pumpgun',
  ['weapon_sawnoffshotgun'] = 'Abgesägte Schrotflinte',
  ['weapon_assaultshotgun'] = 'Kampf Schrotflinte',
  ['weapon_bullpupshotgun'] = 'Bullpup Schrotflinte',
  ['weapon_stungun'] = 'Tazer',
  ['weapon_sniperrifle'] = 'Scharfschützengewehr',
  ['weapon_heavysniper'] = 'Schweres Sniper',
  ['weapon_grenadelauncher'] = 'Granatwerfer',
  ['weapon_rpg'] = 'RPG',
  ['weapon_minigun'] = 'Minigun',
  ['weapon_grenade'] = 'Granate',
  ['weapon_stickybomb'] = 'Haftbombe',
  ['weapon_smokegrenade'] = 'Rauchgranate',
  ['weapon_bzgas'] = 'BZ Gas',
  ['weapon_molotov'] = 'Molotov Cocktail',
  ['weapon_fireextinguisher'] = 'Feuerlöscher',
  ['weapon_petrolcan'] = 'Benzinkanister',
  ['weapon_ball'] = 'Ball',
  ['weapon_snspistol'] = 'SNS Pistole',
  ['weapon_bottle'] = 'Flasche',
  ['weapon_gusenberg'] = 'Gusenberg',
  ['weapon_specialcarbine'] = 'Spezialkarabiner',
  ['weapon_heavypistol'] = 'Schwere Pistole',
  ['weapon_bullpuprifle'] = 'Bullpupgewehr',
  ['weapon_dagger'] = 'Dolch',
  ['weapon_vintagepistol'] = 'Vintage Pistole',
  ['weapon_firework'] = 'Feuerwerk',
  ['weapon_musket'] = 'Muskete',
  ['weapon_heavyshotgun'] = 'Schwere Schrotflinte',
  ['weapon_marksmanrifle'] = 'Marksmangewehr',
  ['weapon_hominglauncher'] = 'Homing Launcher',
  ['weapon_proxmine'] = 'Annäherungsmine',
  ['weapon_snowball'] = 'Schneeball',
  ['weapon_flaregun'] = 'Leuchtpistole',
  ['weapon_combatpdw'] = 'Kampf PDW',
  ['weapon_marksmanpistol'] = 'Marksman Pistole',
  ['weapon_knuckle'] = 'Schlagring',
  ['weapon_hatchet'] = 'Axt',
  ['weapon_railgun'] = 'Railgun',
  ['weapon_machete'] = 'Machete',
  ['weapon_machinepistol'] = 'Maschinenpistole',
  ['weapon_switchblade'] = 'Klappmesser',
  ['weapon_revolver'] = 'Schwerer Revolver',
  ['weapon_dbshotgun'] = 'Doppelläufige Schrotflinte',
  ['weapon_compactrifle'] = 'Kampfgewehr',
  ['weapon_autoshotgun'] = 'Auto Schrotflinte',
  ['weapon_battleaxe'] = 'Kampfaxt',
  ['weapon_compactlauncher'] = 'Kompakt Granatwerfer',
  ['weapon_minismg'] = 'Mini SMG',
  ['weapon_pipebomb'] = 'Rohrbombe',
  ['weapon_poolcue'] = 'Billiard-Kö',
  ['weapon_wrench'] = 'Rohrzange',
  ['weapon_flashlight'] = 'Taschenlampe',
  ['gadget_parachute'] = 'Fallschirm',
  ['weapon_flare'] = 'Leuchtpistole',
  ['weapon_doubleaction'] = 'double-Action Revolver',

  -- Weapon Components
  ['component_clip_default'] = 'standart Griff',
  ['component_clip_extended'] = 'erweiterter Griff',
  ['component_clip_drum'] = 'trommelmagazin',
  ['component_clip_box'] = 'kastenmagazin',
  ['component_flashlight'] = 'taschenlampe',
  ['component_scope'] = 'zielfernrohr',
  ['component_scope_advanced'] = 'erweitertes Zielfernrohr',
  ['component_suppressor'] = 'schalldämpfer',
  ['component_grip'] = 'griff',
  ['component_luxary_finish'] = 'luxus Waffen Design',

  -- Weapon Ammo
  ['ammo_rounds'] = 'kugel(n)',
  ['ammo_shells'] = 'schrotpatrone(n)',
  ['ammo_charge'] = 'ladung',
  ['ammo_petrol'] = 'liter Benzin',
  ['ammo_firework'] = 'feuerwerksrakete(n)',
  ['ammo_rockets'] = 'rakete(n)',
  ['ammo_grenadelauncher'] = 'granate(n)',
  ['ammo_grenade'] = 'granate(n)',
  ['ammo_stickybomb'] = 'bombe(n)',
  ['ammo_pipebomb'] = 'bombe(n)',
  ['ammo_smokebomb'] = 'bombe(n)',
  ['ammo_molotov'] = 'cocktail(s)',
  ['ammo_proxmine'] = 'mine(n)',
  ['ammo_bzgas'] = 'can(n)',
  ['ammo_ball'] = 'ball',
  ['ammo_snowball'] = 'schneebälle',
  ['ammo_flare'] = 'signalfackel(n)',
  ['ammo_flaregun'] = 'signalfackeln(munition)',

  -- Weapon Tints
  ['tint_default'] = 'standard',
  ['tint_green'] = 'grün',
  ['tint_gold'] = 'gold',
  ['tint_pink'] = 'pink',
  ['tint_army'] = 'camouflage',
  ['tint_lspd'] = 'blau',
  ['tint_orange'] = 'orange',
  ['tint_platinum'] = 'platin',
}
