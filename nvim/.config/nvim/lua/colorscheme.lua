vim.cmd([[
  " VIM color file
  "
  " Note: Based on the 1337 theme for Sublime Text
  " by Mark Herpich

  hi clear

  set background=dark
  if version > 580
    if exists("syntax_on")
      syntax reset
    endif
  endif

  set t_Co=256
  let g:colors_name="1337"

  hi Character       guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Comment         guifg=#6d6d6d guibg=None guisp=None gui=None ctermfg=242 ctermbg=None cterm=None
  hi Constant        guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Cursor          guifg=None guibg=#F8F8F0 guisp=None gui=None ctermfg=None ctermbg=255 cterm=None
  hi CursorLine      guifg=None guibg=#3D3D3D55 guisp=None gui=None ctermfg=None ctermbg=None cterm=None
  hi Function        guifg=#8cdaff guibg=None guisp=None gui=None ctermfg=117 ctermbg=None cterm=None
  hi Identifier      guifg=#e9fdac guibg=None guisp=None gui=None ctermfg=193 ctermbg=None cterm=None
  hi Keyword         guifg=#ff5e5e guibg=None guisp=None gui=None ctermfg=203 ctermbg=None cterm=None
  hi LineNr          guifg=None guibg=None guisp=None gui=None ctermfg=None ctermbg=None cterm=None
  hi Normal          guifg=#F8F8F2 guibg=#191919 guisp=None gui=None ctermfg=255 ctermbg=234 cterm=None
  hi Number          guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Statement       guifg=#d0d0d0 guibg=None guisp=None gui=None ctermfg=252 ctermbg=None cterm=None
  hi StorageClass    guifg=#ff5e5e guibg=None guisp=None gui=None ctermfg=203 ctermbg=None cterm=None
  hi String          guifg=#fbe3bf guibg=None guisp=None gui=None ctermfg=223 ctermbg=None cterm=None
  hi Type            guifg=#8cdaff guibg=None guisp=None gui=None ctermfg=117 ctermbg=None cterm=None
  hi Visual          guifg=None guibg=#515151 guisp=None gui=None ctermfg=None ctermbg=239 cterm=None
  
  hi TabLineFill ctermfg=234 ctermbg=234
  hi TabLineSel ctermfg=255 ctermbg=234 cterm=underline
  hi TabLine ctermfg=255 ctermbg=234 cterm=none gui=none


  hi link Conditional Keyword
  hi link Repeat Keyword

  hi link cType Keyword
]])
