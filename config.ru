require './backdoor'

use Backdoor::Middleware::Logger
run Backdoor::App
