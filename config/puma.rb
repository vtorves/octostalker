#!/usr/bin/env puma


environment 'production'

daemonize

pidfile '/var/octostalker/pids/puma.pid'

state_path '/var/octostalker/pids/puma.state'

threads 0, 4

bind 'unix:///var/octostalker/puma.sock'

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
