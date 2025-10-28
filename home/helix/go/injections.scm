((
  (raw_string_literal) @constant
  (#match? @constant "(SELECT|select|INSERT|insert|DELETE|delete|ALTER|alter|CREATE|create).*")
) @injection.content (#set! injection.language "sql"))

((
  (interpreted_string_literal) @constant
  (#match? @constant "(SELECT|select|INSERT|insert|DELETE|delete|ALTER|alter|CREATE|create).*")
) @injection.content (#set! injection.language "sql"))
