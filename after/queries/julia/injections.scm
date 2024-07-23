;; extends

;; Inject Bash syntax highlighting into command_literal nodes.
((command_literal) @injection.content
  (#set! injection.language "bash"))

