require 'open3'
require 'io/wait'

module Backdoor
  class Executor
    attr_reader :exitstatus

    def initialize
      @_stack = []
      self
    end

    def commit
      unless @_stack.empty?
        @_stdin, @_stdout, @_stderr, @_wait_thr = Open3.popen3 @_stack.join ' && '
        @exitstatus = @_wait_thr.value
        @_stack = []
        [@_stdin, @_stdout, @_stderr]
      end
    end

    def committed?
      @_stdin and @_stdout and @_stderr
    end

    def error?
      return nil unless committed?
      not @_wait_thr.value.success? and @_stderr and not @_stderr.empty? or @exitstatus and @exitstatus != 0
    end

    def success?
      return nil unless committed?
      @_stderr and @_stderr.empty?
    end

    def pop task
      @_stack << task
      self
    end
  end
end
