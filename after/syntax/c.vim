""
"" Vim Color Scheme
"" Maintainer: Joseph Yu
"" Last Update: 2020/07/18
""

syn keyword cBoolean true false TRUE FALSE

syn match 	cSymbol		"\s*\t*#"
syn keyword	cKeyword	include
syn keyword cDefine		define
syn keyword cPreproc	undef if else elif endif
syn keyword cPreproc	ifdef ifndef
syn match	cInclude	"\s*\t*#include\s*["<][0-9a-zA-Z._/+\-]*[">]" contains=cSymbol,cKeyword
syn match	cBraces		"[{}]"

hi def link cPOSIXFunction cAnsiFunction
hi def link cKeyword Keyword
hi def link cInclude Include
hi def link cDefine Define
hi def link cPreproc PreProc
hi def link cInclude Include
hi def link cBraces Delimiter
hi def link cSymbol Symbol

hi	Symbol		cterm=bold		ctermfg=255		gui=bold	guifg=#FFFFFF
