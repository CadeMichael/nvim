if exists("b:current_syntax")
  finish
endif

syn keyword keywords assert case def else enum if in index lat
syn keyword keywords let match namespace print rel val with

syn region LineComment  start="//" end="$"
syn region BlockComment start="/\*" end="\*/"

syntax match flixNumber "\v\d+"
highlight link flixNumber Number

syntax match flixString "\v\"([^"]|\\.)*\""
highlight link flixString String

syntax match flixChar "\v'.'"
highlight link flixChar Character

syntax match flixFunction "\<\w\+\>\ze\s*(" contains=@Function
highlight link flixFunction Function

let b:current_syntax = "flix"

hi def link keywords Statement

hi def link LineComment  Comment
hi def link BlockComment Comment
