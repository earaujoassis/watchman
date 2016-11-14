module Backdoor
  module Routes
    class Webhook < Base
      get '/webhook/backdoor/?' do
        json message: 'all fine'
      end

      post '/webhook/backdoor/?' do
        executor = GitExecutor.new config('BD_UPSTREAM'), config('BD_BRANCH')
        payload = JSON.parse(request.body.read).symbolize_keys

        if payload and payload[:ref] and payload[:ref].end_with? config('BD_BRANCH')
          executor.pop("cd #{config('BD_REPO_DIR')}").pop('pull')
          stdin, stdout, stderr = executor.commit
          stdout.wait_readable
          stderr.wait_readable

          if executor.committed? and executor.error?
            raise 'something unexpected happened when executor-pulling branch'
          end

          json message: 'successfully updated local repository',
            stdout: stdout.readlines.join(' ').to_s,
            stderr: stderr.readlines.join(' ').to_s
        else
          status 204
        end
      end
    end
  end
end
