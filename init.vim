lua << EOF

require('main')

EOF

"私有配置请写入`conf/local.vimrc
for f in split(glob('~/.config/nvim/conf/*.vimrc'), '\n')
    exe 'source' f
endfor
