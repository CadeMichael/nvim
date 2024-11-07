; parse comments as markdown
((comment) @injection.content
  (#set! injection.language "markdown")
  (#set! injection.include-children))
