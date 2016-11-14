module Backdoor
  class GitExecutor < Executor
    attr_accessor :upstream
    attr_accessor :branch

    def initialize upstream, branch
      @upstream, @branch = upstream, branch
      super()
    end

    def pop task
      case task
        when 'pull' then super "git pull #{@upstream} #{@branch}"
        when 'rebase' then super "git rebase #{upstream}/#{@branch}"
        else super task
      end
    end
  end
end
