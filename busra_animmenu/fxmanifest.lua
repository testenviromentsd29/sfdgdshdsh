fx_version 'cerulean'
game 'gta5'


client_scripts {
    "animations/*.lua",
    "animations/merge/*.lua",
    "client/*.lua"
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    "animations/*.lua",
    "server/main.lua"
}

ui_page "html/index.html"

files {
    "html/index.html",
    "html/css/*.css",
    "html/img/*.png",
    "html/js/*.js",
    "html/fonts/*.otf",
    "html/fonts/*.ttf",
}


escrow_ignore {
    "animations/*.lua",
    "animations/merge/*.lua",
}


data_file "DLC_ITYP_REQUEST" "badge1.ytyp"
data_file "DLC_ITYP_REQUEST" "copbadge.ytyp"
data_file "DLC_ITYP_REQUEST" "prideprops_ytyp"
data_file "DLC_ITYP_REQUEST" "lilflags_ytyp"
data_file 'DLC_ITYP_REQUEST' 'bzzz_foodpack'
data_file 'DLC_ITYP_REQUEST' 'natty_props_lollipops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'bebekbus.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/drugs_props.ytyp'

server_script "@Protector/Server/injection.lua"
client_script "@Greek_ac/client/injections.lua"
server_script "@Greek_ac/server/injections.lua"