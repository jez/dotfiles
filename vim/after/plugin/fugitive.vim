
" Override the Gdiff command to always be vertical and always split left
exe 'command! -bar -bang -nargs=* -complete=customlist,fugitive#EditComplete Gdiffsplit  exe fugitive#Diffsplit(0, <bang>0, "topleft vertical <mods>", <q-args>)'
