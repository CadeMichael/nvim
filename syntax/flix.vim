if exists("b:current_syntax")
  finish
endif

" Define Flix keywords (keywords should be highlighted distinctly)
syn keyword flixKeyword assert pub class instance case def else enum if in index lat let match namespace rel val with

" Highlight operators
syn match flixOp "=>\|+\|-\|\*\|/\|,\|%"

" Highlight types
syn match flixType /\<[A-Z]\w*/

" Highlight function calls
syn match flixFunctionCall /\<[a-zA-Z_]\w*\ze(/

" Highlight numbers
syn match flixNumber /\<[0-9]\+\>/

" Highlight both // and /// comments
syn match flixLineComment /\/\/.*/ contains=@Spell

" Highlight block comments
syn region flixBlockComment start="/\*" end="\*/" contains=@Spell

" Set the current syntax type
let b:current_syntax = "flix"

" Link syntax groups to appropriate highlight groups
hi def link flixKeyword Keyword
hi def link flixOp Operator
hi def link flixFunctionCall Function
hi def link flixType Type
hi def link flixNumber Number
hi def link flixLineComment Comment
hi def link flixBlockComment Comment

