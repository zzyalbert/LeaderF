" ============================================================================
" File:        colorscheme.vim
" Description:
" Author:      Yggdroot <archofortune@gmail.com>
" Website:     https://github.com/Yggdroot
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

let s:matchModeMap = {
            \   'NameOnly': 'Lf_hl_popup_nameOnlyMode',
            \   'FullPath': 'Lf_hl_popup_fullPathMode',
            \   'Fuzzy': 'Lf_hl_popup_fuzzyMode',
            \   'Regex': 'Lf_hl_popup_regexMode'
            \ }

let s:leftSep = {
            \   'sep0': {
            \       'left': 'mode',
            \       'right': 'category'
            \   },
            \   'sep1': {
            \       'left': 'category',
            \       'right': 'matchMode'
            \   },
            \   'sep2': {
            \       'left': 'matchMode',
            \       'right': 'cwd'
            \   },
            \   'sep3': {
            \       'left': 'cwd',
            \       'right': 'blank'
            \   }
            \ }

let s:rightSep = {
            \   'sep4': {
            \       'left': 'inputText',
            \       'right': 'lineInfo'
            \   },
            \   'sep5': {
            \       'left': 'lineInfo',
            \       'right': 'total'
            \   }
            \ }

function! s:HighlightGroup(category, name) abort
    if a:name == 'mode' || a:name == 'matchMode'
        return printf("Lf_hl_popup_%s_%s", a:category, a:name)
    else
        return printf("Lf_hl_popup_%s", a:name)
    endif
endfunction

function! s:HighlightSeperator(category) abort
    exec printf("highlight link Lf_hl_popup_%s_mode Lf_hl_popup_inputMode", a:category)
    exec printf("highlight link Lf_hl_popup_%s_matchMode %s", a:category, s:matchModeMap[g:Lf_DefaultMode])
    for [sep, dict] in items(s:leftSep)
        let sid_left = synIDtrans(hlID(s:HighlightGroup(a:category, dict.left)))
        let sid_right = synIDtrans(hlID(s:HighlightGroup(a:category, dict.right)))
        let hiCmd = printf("hi Lf_hl_popup_%s_%s", a:category, sep)
        let hiCmd .= printf(" guifg=%s guibg=%s", synIDattr(sid_left, "bg", "gui"), synIDattr(sid_right, "bg", "gui"))
        let hiCmd .= printf(" ctermfg=%s ctermbg=%s", synIDattr(sid_left, "bg", "cterm"), synIDattr(sid_right, "bg", "cterm"))
        if get(g:Lf_StlSeparator, "font", "") != ""
            let hiCmd .= printf(" font='%s'", g:Lf_StlSeparator["font"])
        endif
        exec hiCmd
        "let hi_group = printf("Lf_hl_popup_%s_%s", a:category, sep)
        "silent! call prop_type_add(hi_group, {'highlight': hi_group, 'priority': 20})
    endfor

    for [sep, dict] in items(s:rightSep)
        let sid_left = synIDtrans(hlID(s:HighlightGroup(a:category, dict.left)))
        let sid_right = synIDtrans(hlID(s:HighlightGroup(a:category, dict.right)))
        let hiCmd = printf("hi Lf_hl_popup_%s_%s", a:category, sep)
        let hiCmd .= printf(" guifg=%s guibg=%s", synIDattr(sid_right, "bg", "gui"), synIDattr(sid_left, "bg", "gui"))
        let hiCmd .= printf(" ctermfg=%s ctermbg=%s", synIDattr(sid_right, "bg", "cterm"), synIDattr(sid_right, "bg", "cterm"))
        if get(g:Lf_StlSeparator, "font", "") != ""
            let hiCmd .= printf(" font='%s'", g:Lf_StlSeparator["font"])
        endif
        exec hiCmd
        "let hi_group = printf("Lf_hl_%s_%s", a:category, sep)
        "silent! call prop_type_add(hi_group, {'highlight': hi_group, 'priority': 20})
    endfor
    redrawstatus
endfunction

" mode can be:
" 1. Input mode
" 2. Normal mode
function! leaderf#colorscheme#popup#hiMode(category, mode) abort
    if a:mode == 'Normal'
        exec printf("hi link Lf_hl_popup_%s_mode Lf_hl_popup_normalMode", a:category)
    else
        exec printf("hi link Lf_hl_popup_%s_mode Lf_hl_popup_inputMode", a:category)
    endif
    let sid = synIDtrans(hlID(printf("Lf_hl_popup_%s_mode")))
    exec printf("hi Lf_hl_popup_%s_sep0 guifg=%s", a:category, synIDattr(sid, "fg", "gui"))
    exec printf("hi Lf_hl_popup_%s_sep0 ctermfg=%s", a:category, synIDattr(sid, "fg", "cterm"))
endfunction

" mode can be:
" 1. NameOnly mode
" 2. FullPath mode
" 3. Fuzzy mode
" 4. Regex mode
function! leaderf#colorscheme#popup#hiMatchMode(category, mode) abort
    let sid = synIDtrans(hlID(s:matchModeMap[a:mode]))
    exec printf("hi link Lf_hl_popup_%s_matchMode %s", a:category, s:matchModeMap[a:mode])
    exec printf("hi Lf_hl_popup_%s_sep1 guibg=%s", a:category, synIDattr(sid, "bg", "gui"))
    exec printf("hi Lf_hl_popup_%s_sep1 ctermbg=%s", a:category, synIDattr(sid, "bg", "cterm"))
    exec printf("hi Lf_hl_popup_%s_sep2 guifg=%s", a:category, synIDattr(sid, "fg", "gui"))
    exec printf("hi Lf_hl_popup_%s_sep2 ctermfg=%s", a:category, synIDattr(sid, "fg", "cterm"))
    redrawstatus
endfunction

function! leaderf#colorscheme#popup#clear() abort
    highlight clear Lf_hl_popup_window
    highlight clear Lf_hl_popup_cursor
    highlight clear Lf_hl_popup_prompt
    highlight clear Lf_hl_popup_spin
    highlight clear Lf_hl_popup_inputText
    highlight clear Lf_hl_popup_normalMode
    highlight clear Lf_hl_popup_inputMode
    highlight clear Lf_hl_popup_category
    highlight clear Lf_hl_popup_nameOnlyMode
    highlight clear Lf_hl_popup_fullPathMode
    highlight clear Lf_hl_popup_fuzzyMode
    highlight clear Lf_hl_popup_regexMode
    highlight clear Lf_hl_popup_cwd
    highlight clear Lf_hl_popup_blank
    highlight clear Lf_hl_popup_lineInfo
    highlight clear Lf_hl_popup_total
endfunction

function! leaderf#colorscheme#popup#load(category, name)
    call leaderf#colorscheme#popup#clear()
    silent! call leaderf#colorscheme#popup#{a:name}#a_nonexistent_function()
    call s:HighlightSeperator(a:category)
endfunction
