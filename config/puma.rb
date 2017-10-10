# frozen_string_literal: true

HTML_BODY = <<~HTML
  <!DOCTYPE html>
  <html>
  <head>
    <title>Under Maintenance</title>
  </head>
  <body>
    <h1>Under Maintenance</h1>
    <p>This site is currently undergoing maintenance. We'll have it back online as soon as possible.</p>
  </body>
  </html>
HTML

JSON_BODY = <<~JSON
  {
    "status": "Under Maintenance"
    "message": "This site is currently underoing maintenance. We'll have it back online as soon as possible."
  }
JSON

tag "Maintenance"

app do |env|
  if env.fetch("HTTP_ACCEPT", "")[/json/]
    [
      503,
      {
        "Content-Type"   => "application/json",
        "Content-Length" => JSON_BODY.length.to_s
      },
      [JSON_BODY]
    ]
  else
    [
      503,
      {
        "Content-Type"   => "text/html",
        "Content-Length" => HTML_BODY.length.to_s
      },
      [HTML_BODY]
    ]
  end
end
