" tabby.vim - Un/Expand tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if exists("g:loaded_tabby") || &cp || v:version < 700
	finish
endif
let g:loaded_tabby = 1

function! s:tab_e(...)
	if (a:0 == 2)
		let [start, stop] = [a:1, a:2]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!expand --tabs '.v:count1.' --initial'
endfunction

function! s:tab_u(...)
	if (a:0 == 2)
		let [start, stop] = [a:1, a:2]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!unexpand --tabs '.v:count1.' --first-only'
endfunction

xnoremap <silent> <Plug>TabbyExpandV :<C-U>call <SID>tab_e(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>TabbyExpandM :<C-U>set opfunc=<SID>tab_e<CR>g@
nnoremap <silent> <Plug>TabbyExpandA :<C-U>call <SID>tab_e(1,line('$'))<CR>
nnoremap <silent> <Plug>TabbyExpandL :<C-U>call <SID>tab_e(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>TabbyUnexpandV :<C-U>call <SID>tab_u(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>TabbyUnexpandM :<C-U>set opfunc=<SID>tab_u<CR>g@
nnoremap <silent> <Plug>TabbyUnexpandA :<C-U>call <SID>tab_u(1,line('$'))<CR>
nnoremap <silent> <Plug>TabbyUnexpandL :<C-U>call <SID>tab_u(line('.'),line('.'))<CR>

if get(g:, 'tabby_create_mappings', 1)
	xmap <Leader><S-Tab> <plug>TabbyExpandV
	nmap <Leader><S-Tab> <plug>TabbyExpandM
	nmap <Leader><S-Tab> <plug>TabbyExpandL
	nmap <Leader><S-Tab> <plug>TabbyExpandA

	xmap <Leader><Tab> <plug>TabbyUnexpandV
	nmap <Leader><Tab> <plug>TabbyUnexpandM
	nmap <Leader><Tab> <plug>TabbyUnexpandL
	nmap <Leader><Tab> <plug>TabbyUnexpandA
endif

" vim:set noet ts=8 sw=8:
