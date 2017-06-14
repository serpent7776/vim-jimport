function! JimportReadImportsFromDir(dir)
	let pattern = shellescape('^import\s[\w\.]+;\r$')
	let dir = shellescape(a:dir)
	let cmd = 'ag --java --nofilename ' . pattern . ' ' . dir
	let imports = system(cmd)
	let list = split(imports, '\r\{,1}\n')
	call filter(uniq(sort(list)), 'len(v:val) > 1')
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	call append(line('$'), list)
	" remove first, empty line
	normal 1dd
	setl noma
endf

function! JimportReadImportsFromGit()
	let gitdir = fugitive#extract_git_dir('.')
	let rootDir = fnamemodify(expand(gitdir), ":h") 
	call JimportReadImportsFromDir(rootDir)
endf
