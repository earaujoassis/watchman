require "./config/environment"
require "./lib/backdoor"
require "./lib/backdoor/ws/connection"

use Backdoor::Ws::Connection

run Hanami.app
