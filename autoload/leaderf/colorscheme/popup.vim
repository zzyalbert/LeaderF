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
            \       'left': 'Lf_hl_popup_name',
            \       'right': 'Lf_hl_popup_category'
            \   },
            \   'sep1': {
            \       'left': 'Lf_hl_popup_category',
            \       'right': 'Lf_hl_popup_mode'
            \   },
            \   'sep2': {
            \       'left': 'Lf_hl_popup_mode',
            \       'right': 'Lf_hl_popup_cwd'
            \   },
            \   'sep3': {
            \       'left': 'Lf_hl_popup_cwd',
            \       'right': 'Lf_hl_popup_blank'
            \   }
            \ }

let s:rightSep = {
            \   'sep4': {
            \       'left': 'Lf_hl_popup_blank',
            \       'right': 'Lf_hl_popup_lineInfo'
            \   },
            \   'sep5': {
            \       'left': 'Lf_hl_popup_lineInfo',
            \       'right': 'Lf_hl_popup_total'
            \   }
            \ }

function! leaderf#colorscheme#highlight(category)
    try
        let s:palette = g:leaderf#colorscheme#{g:Lf_StlColorscheme}#palette
    catch /^Vim\%((\a\+)\)\=:E121/
        try
            let s:palette = g:leaderf#colorscheme#{g:colors_name}#palette
        catch /^Vim\%((\a\+)\)\=:E121/
            "echohl WarningMsg
            "try
            "    echo "Could not load colorscheme '".g:colors_name."', use 'default'."
            "catch /^Vim\%((\a\+)\)\=:E121/
            "    echo "Could not load colorscheme, use 'default'."
            "    let g:colors_name = "default"
            "endtry
            "echohl None

            let s:palette = g:leaderf#colorscheme#default#palette
        endtry
    endtry

    let palette = copy(s:palette)
    for [name, dict] in items(palette)
        let hi_group = printf("Lf_hl_%s_%s", a:category, name)
        let highlightCmd = printf("hi def %s", hi_group)
        for [k, v] in items(dict)
            let highlightCmd .= printf(" %s=%s", k, v)
        endfor
        exec highlightCmd
        silent! call prop_type_add(hi_group, {'highlight': hi_group, 'priority': 20})
    endfor

    let palette.stlMode = palette[s:modeMap[g:Lf_DefaultMode]]

    for [sep, dict] in items(s:leftSep)
        let hi_group = printf("Lf_hl_%s_%s", a:category, sep)
        let highlightCmd = printf("hi def Lf_hl_%s_%s", a:category, sep)
        let highlightCmd .= printf(" guifg=%s guibg=%s", palette[dict.left].guibg, palette[dict.right].guibg)
        let highlightCmd .= printf(" ctermfg=%s ctermbg=%s", palette[dict.left].ctermbg, palette[dict.right].ctermbg)
        if get(g:Lf_StlSeparator, "font", "") != ""
            let highlightCmd .= printf(" font='%s'", g:Lf_StlSeparator["font"])
        endif
        exec highlightCmd
        silent! call prop_type_add(hi_group, {'highlight': hi_group, 'priority': 20})
    endfor

    for [sep, dict] in items(s:rightSep)
        let hi_group = printf("Lf_hl_%s_%s", a:category, sep)
        let highlightCmd = printf("hi def Lf_hl_%s_%s", a:category, sep)
        let highlightCmd .= printf(" guifg=%s guibg=%s", palette[dict.right].guibg, palette[dict.left].guibg)
        let highlightCmd .= printf(" ctermfg=%s ctermbg=%s", palette[dict.right].ctermbg, palette[dict.left].ctermbg)
        if get(g:Lf_StlSeparator, "font", "") != ""
            let highlightCmd .= printf(" font='%s'", g:Lf_StlSeparator["font"])
        endif
        exec highlightCmd
        silent! call prop_type_add(hi_group, {'highlight': hi_group, 'priority': 20})
    endfor
    redrawstatus
endfunction

function! leaderf#colorscheme#popup#hiMatchMode(category, mode)
    exec printf("hi link Lf_hl_popup_%s_matchMode %s", a:category, s:matchModeMap[a:mode])
    exec printf("hi Lf_hl_popup_%s_sep1 guibg=%s", a:category, s:palette[s:matchModeMap[a:mode]].guibg)
    exec printf("hi Lf_hl_popup_%s_sep1 ctermbg=%s", a:category, s:palette[s:matchModeMap[a:mode]].ctermbg)
    exec printf("hi Lf_hl_popup_%s_sep2 guifg=%s", a:category, s:palette[s:matchModeMap[a:mode]].guibg)
    exec printf("hi Lf_hl_popup_%s_sep2 ctermfg=%s", a:category, s:palette[s:matchModeMap[a:mode]].ctermbg)
    redrawstatus
endfunction

function! leaderf#colorscheme#popup#clear() abort
    highlight clear Lf_hl_popup_window
    highlight clear Lf_hl_popup_cursor
    highlight clear Lf_hl_popup_prompt
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

function! leaderf#colorscheme#popup#load(name) abort
    call leaderf#colorscheme#popup#clear()
    silent! call leaderf#colorscheme#popup#{a:name}#a_not_existing_function()
endfunction
