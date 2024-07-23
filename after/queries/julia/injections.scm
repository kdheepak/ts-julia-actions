;; extends

;; Match a prefixed string literal and capture the prefix and content.
((prefixed_string_literal
  ;; Capture the prefix identifier and assign it to @prefix.
  prefix: (identifier) @prefix)
  ;; Capture the entire string content and assign it to @injection.content.
  @injection.content
  ;; Check if the captured prefix is "md".
  (#eq? @prefix "md")
  ;; If the prefix is "md", set the injection language to "markdown".
  (#set! injection.language "markdown"))

;; Inject Bash syntax highlighting into command_literal nodes.
((command_literal) @injection.content
  (#set! injection.language "bash"))

