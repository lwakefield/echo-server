require "http/server"
require "json"

server = HTTP::Server.new do |context|
    puts({
        "method" => context.request.method,
        "resource" => context.request.resource,
        "headers" => context.request.headers,
        "body" => if context.request.body
                      context.request.body.not_nil!.gets_to_end
                  else
                      nil
                  end
    }.to_json)

    context.response.respond_with_status(200)
end

host = ENV["host"]? || "127.0.0.1"
port = ENV["PORT"]? || 8080
server.bind_tcp port.to_i
puts "Listening on http://#{host}:#{port}"
server.listen
