# frozen_string_literal: true

require "rack-protection"

require "./config/environment"
require "./lib/backdoor"
require "./lib/backdoor/sockets/connection"

use Backdoor::Sockets::Connection
run Hanami.app
