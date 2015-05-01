" tabby.vim - Un/Expand tabs
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_tabby') || &cp || (v:version < 700))
	finish
endif
let g:loaded_tabby = 1

function! s:tab_expand (...)
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!expand --tabs ' . v:count1
endfunction

function! s:tab_unexpand (...)
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!unexpand --tabs ' . v:count1 . ' --first-only'
endfunction

function s:set_up_mappings()
	nnoremap <silent> <Plug>TabbyExpandA :<C-U>call <SID>tab_expand (1, line ('$'))<CR>
	nnoremap <silent> <Plug>TabbyExpandL :<C-U>call <SID>tab_expand (line ('.'), line ('.'))<CR>
	nnoremap <silent> <Plug>TabbyExpandM :<C-U>set opfunc=<SID>tab_expand<CR>g@
	xnoremap <silent> <Plug>TabbyExpandV :<C-U>call <SID>tab_expand (line ('''<'), line ('''>'))<CR>

	nnoremap <silent> <Plug>TabbyUnexpandA :<C-U>call <SID>tab_unexpand (1, line ('$'))<CR>
	nnoremap <silent> <Plug>TabbyUnexpandL :<C-U>call <SID>tab_unexpand (line ('.'), line ('.'))<CR>
	nnoremap <silent> <Plug>TabbyUnexpandM :<C-U>set opfunc=<SID>tab_unexpand<CR>g@
	xnoremap <silent> <Plug>TabbyUnexpandV :<C-U>call <SID>tab_unexpand (line ('''<'), line ('''>'))<CR>

	if (get (g:, 'tabby_create_mappings', 1))
		nmap <Leader><S-Tab> <Plug>TabbyExpandL
		nmap <Leader><S-Tab> <Plug>TabbyExpandM
		nmap <Leader><S-Tab> <Plug>TabbyExpandA
		xmap <Leader><S-Tab> <Plug>TabbyExpandV

		nmap <Leader><Tab> <Plug>TabbyUnexpandL
		nmap <Leader><Tab> <Plug>TabbyUnexpandM
		nmap <Leader><Tab> <Plug>TabbyUnexpandA
		xmap <Leader><Tab> <Plug>TabbyUnexpandV
	endif

endfunction


call s:set_up_mappings()

" vim:set noet ts=8 sw=8:
