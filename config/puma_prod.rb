#!/usr/bin/env puma

app_home = '/var/octostalker'
environment 'production'

daemonize

pidfile "#{app_home}/pids/puma.pid"
state_path "#{app_home}/pids/puma.state"

stdout_redirect "#{app_home}/logs/stdout", "#{app_home}/logs/stderr", true

threads 0, 4

bind "unix://#{app_home}/puma.sock"

# Preload the application before starting the workers; this conflicts with
# phased restart feature. (off by default)
preload_app!

tag 'octostalker'

worker_timeout 10


# === Puma control rack application ===

# Start the puma control rack application on "url". This application can
# be communicated with to control the main server. Additionally, you can
# provide an authentication token, so all requests to the control server
# will need to include that token as a query parameter. This allows for
# simple authentication.
#
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb
# to see what the app has available.
#
# activate_control_app 'unix:///var/run/pumactl.sock'
# activate_control_app 'unix:///var/run/pumactl.sock', { auth_token: '12345' }
# activate_control_app 'unix:///var/run/pumactl.sock', { no_token: true }
