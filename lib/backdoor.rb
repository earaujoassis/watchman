module Backdoor
  VERSION = "0.2.4".freeze
  COMMIT_HASH = "#{`git describe --always`}".strip.freeze

  module Services
  end

  module Ws
  end
end
