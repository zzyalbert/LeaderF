" ============================================================================
" File:        default.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

" due to https://github.com/vim/vim/issues/5227,
" if aim to link to another highlight group,
" it is better to use leaderf#colorscheme#popup#link_no_reverse()
" instead of `hi link`. Because some BAD colorscheme such as solarized8_flat
" like use `reverse` attribute.

" Lf_hl_popup_inputText is the wincolor of input window
call leaderf#colorscheme#popup#link_no_reverse("Lf_hl_popup_inputText", "Statusline")
" Lf_hl_popup_blank is the wincolor of statusline window
call leaderf#colorscheme#popup#link_no_reverse("Lf_hl_popup_blank", "Statusline")

" Lf_hl_popup_window is the wincolor of content window
highlight def link Lf_hl_popup_window       Pmenu
highlight def link Lf_hl_popup_cursor             Cursor
highlight def link Lf_hl_popup_prompt             Constant
highlight Lf_hl_popup_spin cterm=bold ctermfg=Red gui=bold guifg=Red guibg=Blue
call leaderf#colorscheme#popup#link_no_reverse("Lf_hl_popup_normalMode", "Error")
highlight def link Lf_hl_popup_normalMode   Error
highlight def link Lf_hl_popup_inputMode    Lf_hl_File_stlName
highlight def link Lf_hl_popup_category    Lf_hl_File_stlCategory
highlight def link Lf_hl_popup_nameOnlyMode    Lf_hl_File_stlNameOnlyMode
highlight def link Lf_hl_popup_fullPathMode    Lf_hl_File_stlFullPathMode
highlight def link Lf_hl_popup_fuzzyMode    Lf_hl_File_stlFuzzyMode
highlight def link Lf_hl_popup_regexMode    Lf_hl_File_stlRegexMode
highlight def link Lf_hl_popup_cwd    Lf_hl_File_stlCwd
highlight def link Lf_hl_popup_lineInfo    Lf_hl_File_stlLineInfo
highlight def link Lf_hl_popup_total    Lf_hl_File_stlTotal
