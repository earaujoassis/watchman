# frozen_string_literal: true

require "./config/environment"
require "./lib/backdoor"
require "./lib/backdoor/sockets/connection"

use Backdoor::Sockets::Connection

run Hanami.app
