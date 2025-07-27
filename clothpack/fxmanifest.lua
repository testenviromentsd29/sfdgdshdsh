fx_version 'cerulean'
game { 'gta5' }
version '2.0'
description 'DoItDigital Clothing Pack'
author 'KilluaZoldyck#0099'

files {
  'meta/mp_m_freemode_01_mp_m_add1.meta',
  'meta/mp_m_freemode_01_mp_m_add2.meta',
  'meta/mp_m_freemode_01_mp_m_add3.meta',
  'meta/mp_m_freemode_01_mp_m_add4.meta',
  'meta/mp_m_freemode_01_mp_m_add6.meta', --donates
  'meta/mp_m_freemode_01_mp_m_add7.meta', --donates
  'meta/mp_m_freemode_01_chris_addon.meta', --donates
  'meta/mp_f_freemode_01_chris_addon.meta', --donates
  
  'meta/mp_f_freemode_01_mp_f_add1.meta',
  'meta/mp_f_freemode_01_mp_f_add2.meta',
  'meta/mp_f_freemode_01_mp_f_add3.meta',
  'meta/mp_f_freemode_01_mp_f_add4.meta',
  'meta/mp_f_freemode_01_mp_f_add5.meta',
  'meta/mp_f_freemode_01_mp_f_add6.meta', --donates
  'meta/mp_f_freemode_01_mp_f_add7.meta', --donates

  'meta/pedalternatevariations_add1.meta',
  'meta/pedalternatevariations_add2.meta',
  'meta/pedalternatevariations_add3.meta',
  'meta/pedalternatevariations_add4.meta',
  'meta/pedalternatevariations_add5.meta',
  'meta/pedalternatevariations_add6.meta', --donates
  'meta/pedalternatevariations_add7.meta', --donates
}

data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add1.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add2.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add3.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add4.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add6.meta' 
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_mp_m_add7.meta' 
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_m_freemode_01_chris_addon.meta' --donates
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_chris_addon.meta' --donates

data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add1.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add2.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add3.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add4.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add5.meta'
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add6.meta' --donates
data_file 'SHOP_PED_APPAREL_META_FILE' 'meta/mp_f_freemode_01_mp_f_add7.meta' --donates

data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add1.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add2.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add3.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add4.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add5.meta'
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add6.meta' --donates
data_file 'ALTERNATE_VARIATIONS_FILE' 'meta/pedalternatevariations_add7.meta' --donates
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"