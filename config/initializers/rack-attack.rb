class Rack::Attack

  # Throttle all requests by IP (60rpm)
  throttle('req/ip', :limit => 300, :period => 5.minutes) do |req|
    req.ip
  end

  # Throttle POST requests to /login by IP address
  throttle('logins/ip', :limit => 5, :period => 20.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end

  # Throttle POST requests to /login by email param
  throttle("logins/email", :limit => 5, :period => 20.seconds) do |req|
    if req.path == '/login' && req.post?
      # return the email if present, nil otherwise
      req.params['email'].presence
    end
  end
end
