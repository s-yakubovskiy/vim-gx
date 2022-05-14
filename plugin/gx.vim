if exists('g:loaded_sanegx') | finish | endif
let g:loaded_sanegx = 1

function! GXBrowse(url)
  let l:url = substitute(a:url, ".*\\(https.*\\))", "\\1", "")
  let redir = '>&/dev/null'
  if exists('g:netrw_browsex_viewer')
   let viewer = g:netrw_browsex_viewer
  elseif has('unix') && executable('xdg-open')
   let viewer = 'xdg-open'
  elseif has('macunix') && executable('open')
   let viewer = 'open'
  elseif has('win64') || has('win32')
   let viewer = 'start'
   redir = '>null'
  else
   return
  endif

  execute 'silent! !' . viewer . ' ' . shellescape(l:url, 1) . redir
  redraw!
endfunction

nnoremap <silent> gx :call GXBrowse(expand('<cWORD>'))<cr>
