


Locales['br'] = {
  -- Inventory
  ['inventory'] = 'inventário %s / %s',
  ['use'] = 'usar',
  ['give'] = 'dar',
  ['remove'] = 'remover',
  ['return'] = 'voltar',
  ['give_to'] = 'dar para',
  ['amount'] = 'quantidade',
  ['giveammo'] = 'dar munição',
  ['amountammo'] = 'quantidade de munição',
  ['noammo'] = 'voce não tem todas essas munições!',
  ['gave_item'] = 'voce deu ~y~%sx~s~ ~b~%s~s~ para ~y~%s~s~',
  ['received_item'] = 'voce recebeu ~y~%sx~s~ ~b~%s~s~ de ~b~%s~s~',
  ['gave_weapon'] = 'você deu ~b~%s~s~ para ~y~%s~s~',
  ['gave_weapon_ammo'] = 'você deu ~o~%sx %s~s~ para ~b~%s~s~ de ~y~%s~s~',
  ['gave_weapon_withammo'] = 'você deu ~b~%s~s~ com ~o~%sx %s~s~ para ~y~%s~s~',
  ['gave_weapon_hasalready'] = '~y~%s~s~ já tem um(a) ~y~%s~s~',
  ['gave_weapon_noweapon'] = 'não tem essa arma ~y~%s~s~',
  ['received_weapon'] = 'você recebeu ~b~%s~s~ de ~b~%s~s~',
  ['received_weapon_ammo'] = 'você recebeu ~o~%sx %s~s~ para a sua(o seu) ~b~%s~s~ de ~b~%s~s~',
  ['received_weapon_withammo'] = 'você recebeu ~b~%s~s~ com ~o~%sx %s~s~ de ~b~%s~s~',
  ['received_weapon_hasalready'] = '~b~%s~s~ tentou lhe dar uma ~y~%s~s~, mas você já tem um(a)',
  ['received_weapon_noweapon'] = '~b~%s~s~ tentou lhe dar munição para ~y~%s~s~, mas você não tem um(a)',
  ['gave_account_money'] = 'voce deu ~g~$%s~s~ (%s) para ~y~%s~s~',
  ['received_account_money'] = 'voce recebeu ~g~$%s~s~ (%s) de ~b~%s~s~',
  ['amount_invalid'] = 'quantidade inválida',
  ['players_nearby'] = 'nenhum cidadão por perto',
  ['ex_inv_lim'] = 'ação não e possivel, excedendo o limite de estoque para ~y~%s~s~',
  ['imp_invalid_quantity'] = 'ação impossível, quantidade inválida',
  ['imp_invalid_amount'] = 'ação impossível, valor invalido',
  ['threw_standard'] = 'você jogou ~y~%sx~s~ ~b~%s~s~',
  ['threw_account'] = 'você jogou ~g~$%s~s~ ~b~%s~s~',
  ['threw_weapon'] = 'você jogou ~b~%s~s~',
  ['threw_weapon_ammo'] = 'você jogou ~b~%s~s~ com ~o~%sx %s~s~',
  ['threw_weapon_already'] = 'você já esta com essa arma',
  ['threw_cannot_pickup'] = 'você não pode pegar porque seu inventário está cheio!',
  ['threw_pickup_prompt'] = 'pressione ~y~E~s~ para pegar',

  -- Key mapping
  ['keymap_showinventory'] = 'exibir inventario',

  -- Salary related
  ['received_salary'] = 'voce recebeu seu salário: ~g~$%s~s~ ',
  ['received_help'] = 'voce recebeu seu cheque de bem-estar: ~g~$%s~s~ ',
  ['company_nomoney'] = 'a empresa em que voce esta empregado esta muito pobre para pagar seu salário',
  ['received_paycheck'] = 'recebeu dinheiro',
  ['bank'] = 'banco',
  ['account_bank'] = 'banco',
  ['account_black_money'] = 'dinheiro sujo',
  ['account_money'] = 'dinheiro',

  ['act_imp'] = 'ação impossível',
  ['in_vehicle'] = 'voce não pode dar nada para alguem no veículo',

  -- Commands
  ['command_car'] = 'spawn um carro',
  ['command_car_car'] = 'nome do carro',
  ['command_cardel'] = 'excluir veículo',
  ['command_cardel_radius'] = 'optional, delete every vehicle within the specified radius',
  ['command_clear'] = 'limpar o chat',
  ['command_clearall'] = 'limpar o chat para todos',
  ['command_clearinventory'] = 'remover todos os itens do inventário',
  ['command_clearloadout'] = 'remova todas as armas do carregamento',
  ['command_giveaccountmoney'] = 'dar dinheiro da conta',
  ['command_giveaccountmoney_account'] = 'conta',
  ['command_giveaccountmoney_amount'] = 'amount',
  ['command_giveaccountmoney_invalid'] = 'conta inválida',
  ['command_giveitem'] = 'dar item',
  ['command_giveitem_item'] = 'item',
  ['command_giveitem_count'] = 'count',
  ['command_giveweapon'] = 'dar arma',
  ['command_giveweapon_weapon'] = 'arma',
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
  ['command_setjob'] = 'atribuir um trabalho a um usuario',
  ['command_setjob_job'] = 'o trabalho que voce deseja atribuir',
  ['command_setjob_grade'] = 'o nivel de emprego',
  ['command_setjob_invalid'] = 'the job, grade or both are invalid',
  ['command_setgroup'] = 'set player group',
  ['command_setgroup_group'] = 'group name',
  ['commanderror_argumentmismatch'] = 'argument count mismatch (passed %s, wanted %s)',
  ['commanderror_argumentmismatch_number'] = 'argument #%s type mismatch (passed string, wanted number)',
  ['commanderror_invaliditem'] = 'item invalido',
  ['commanderror_invalidweapon'] = 'invalid weapon',
  ['commanderror_console'] = 'that command can not be run from console',
  ['commanderror_invalidcommand'] = '^3%s^0 is not an valid command!',
  ['commanderror_invalidplayerid'] = 'there is no player online matching that server id',
  ['commandgeneric_playerid'] = 'o ID do jogador',

  -- Locale settings
  ['locale_digit_grouping_symbol'] = ' ',
  ['locale_currency'] = 'R$%s',

  -- Weapons
  ['weapon_knife'] = 'faca',
  ['weapon_nightstick'] = 'cacetete',
  ['weapon_hammer'] = 'martelo',
  ['weapon_bat'] = 'bastao',
  ['weapon_golfclub'] = 'golf club',
  ['weapon_crowbar'] = 'pe de cabra',
  ['weapon_pistol'] = 'pistola',
  ['weapon_combatpistol'] = 'pistola de combate',
  ['weapon_appistol'] = 'ap pistola',
  ['weapon_pistol50'] = 'pistola .50',
  ['weapon_microsmg'] = 'micro smg',
  ['weapon_smg'] = 'smg',
  ['weapon_assaultsmg'] = 'smg de assalto',
  ['weapon_assaultrifle'] = 'rifle de assalto',
  ['weapon_carbinerifle'] = 'carabina rifle',
  ['weapon_advancedrifle'] = 'rifle avançado',
  ['weapon_mg'] = 'mg',
  ['weapon_combatmg'] = 'combate mg',
  ['weapon_pumpshotgun'] = 'espingarda',
  ['weapon_sawnoffshotgun'] = 'espingarda serrada',
  ['weapon_assaultshotgun'] = 'espingarda de assalto',
  ['weapon_bullpupshotgun'] = 'espingarda de bullpup',
  ['weapon_stungun'] = 'arma de choque',
  ['weapon_sniperrifle'] = 'sniper rifle',
  ['weapon_heavysniper'] = 'heavy sniper',
  ['weapon_grenadelauncher'] = 'lançador de granada',
  ['weapon_rpg'] = 'lançador de foguetes',
  ['weapon_minigun'] = 'minigun',
  ['weapon_grenade'] = 'granada',
  ['weapon_stickybomb'] = 'bomba pegajosa',
  ['weapon_smokegrenade'] = 'granada de fumaça',
  ['weapon_bzgas'] = 'bz gas',
  ['weapon_molotov'] = 'molotov',
  ['weapon_fireextinguisher'] = 'extintor',
  ['weapon_petrolcan'] = 'galao de combustivel',
  ['weapon_ball'] = 'bola',
  ['weapon_snspistol'] = 'sns pistol',
  ['weapon_bottle'] = 'garrafa',
  ['weapon_gusenberg'] = 'gusenberg sweeper',
  ['weapon_specialcarbine'] = 'carabina especial',
  ['weapon_heavypistol'] = 'heavy pistol',
  ['weapon_bullpuprifle'] = 'bullpup rifle',
  ['weapon_dagger'] = 'punhal',
  ['weapon_vintagepistol'] = 'vintage pistol',
  ['weapon_firework'] = 'fogos de artificio',
  ['weapon_musket'] = 'mosquete',
  ['weapon_heavyshotgun'] = 'heavy shotgun',
  ['weapon_marksmanrifle'] = 'marksman rifle',
  ['weapon_hominglauncher'] = 'homing launcher',
  ['weapon_proxmine'] = 'mina de proximidade',
  ['weapon_snowball'] = 'bola de neve',
  ['weapon_flaregun'] = 'sinalizador',
  ['weapon_combatpdw'] = 'combat pdw',
  ['weapon_marksmanpistol'] = 'marksman pistol',
  ['weapon_knuckle'] = 'soco ingles',
  ['weapon_hatchet'] = 'machado',
  ['weapon_railgun'] = 'railgun',
  ['weapon_machete'] = 'facão',
  ['weapon_machinepistol'] = 'machine pistol',
  ['weapon_switchblade'] = 'canivete',
  ['weapon_revolver'] = 'heavy revolver',
  ['weapon_dbshotgun'] = 'espingarda de cano duplo',
  ['weapon_compactrifle'] = 'compact rifle',
  ['weapon_autoshotgun'] = 'auto shotgun',
  ['weapon_battleaxe'] = 'battle axe',
  ['weapon_compactlauncher'] = 'compact launcher',
  ['weapon_minismg'] = 'mini smg',
  ['weapon_pipebomb'] = 'bomba caseira',
  ['weapon_poolcue'] = 'taco de sinuca',
  ['weapon_wrench'] = 'chave de cano',
  ['weapon_flashlight'] = 'laterna',
  ['gadget_parachute'] = 'paraquedas',
  ['weapon_flare'] = 'flare',
  ['weapon_doubleaction'] = 'double-Action Revolver',

  -- Weapon Components
  ['component_clip_default'] = 'aderência padrão',
  ['component_clip_extended'] = 'aderência prolongada',
  ['component_clip_drum'] = 'drum Magazine',
  ['component_clip_box'] = 'box Magazine',
  ['component_flashlight'] = 'lanterna',
  ['component_scope'] = 'mira',
  ['component_scope_advanced'] = 'mira avançada',
  ['component_suppressor'] = 'supressor',
  ['component_grip'] = 'grip',
  ['component_luxary_finish'] = 'acabamento de arma de luxo',

  -- Weapon Ammo
  ['ammo_rounds'] = 'round(s)',
  ['ammo_shells'] = 'shell(s)',
  ['ammo_charge'] = 'charge',
  ['ammo_petrol'] = 'gallons of fuel',
  ['ammo_firework'] = 'firework(s)',
  ['ammo_rockets'] = 'rocket(s)',
  ['ammo_grenadelauncher'] = 'grenade(s)',
  ['ammo_grenade'] = 'grenade(s)',
  ['ammo_stickybomb'] = 'bomb(s)',
  ['ammo_pipebomb'] = 'bomb(s)',
  ['ammo_smokebomb'] = 'bomb(s)',
  ['ammo_molotov'] = 'cocktail(s)',
  ['ammo_proxmine'] = 'mine(s)',
  ['ammo_bzgas'] = 'can(s)',
  ['ammo_ball'] = 'ball(s)',
  ['ammo_snowball'] = 'snowball(s)',
  ['ammo_flare'] = 'flare(s)',
  ['ammo_flaregun'] = 'flare(s)',

  -- Weapon Tints
  ['tint_default'] = 'default skin',
  ['tint_green'] = 'green skin',
  ['tint_gold'] = 'gold skin',
  ['tint_pink'] = 'pink skin',
  ['tint_army'] = 'army skin',
  ['tint_lspd'] = 'blue skin',
  ['tint_orange'] = 'orange skin',
  ['tint_platinum'] = 'platinum skin',
}
