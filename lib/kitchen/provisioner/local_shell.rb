# -*- encoding: utf-8 -*-
#
# Author:: Masashi Terui (<marcy9114@gmail.com>)
#
# Copyright (C) 2015, HiganWorks LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "kitchen/provisioner/base"

module Kitchen

  module Provisioner

    # LocalShell Provisoner for Kitchen. This provisoner just execute shell command from local.
    # This provisioner is made in reference to Shell-Verifier
    #
    # @author Masashi Terui (<marcy9114@gmail.com>)
    class LocalShell < Base
      require "mixlib/shellout"

      kitchen_provisioner_api_version 2

      plugin_version Kitchen::VERSION

      default_config :sleep, 0
      default_config :command, "true"
      default_config :shellout_opts, {}
      default_config :live_stream, $stdout

      # (see Base#call)
      def call(state)
        debug("[#{name}] Provison on instance=#{instance} with state=#{state}")
        sleep_if_set
        merge_state_to_env(state)
        shellout
        debug("[#{name}] Provison completed.")
      end

      private

      # Sleep for a period of time, if a value is set in the config.
      #
      # @api private
      def sleep_if_set
        sleep_sec = config[:sleep].to_i
        if sleep_sec > 0
          info("Sleep #{config[:sleep]} seconds...")
          sleep sleep_sec
        end
      end

      def shellout
        cmd = Mixlib::ShellOut.new(config[:command], config[:shellout_opts])
        cmd.live_stream = config[:live_stream]
        cmd.run_command
        begin
          cmd.error!
        rescue Mixlib::ShellOut::ShellCommandFailed
          raise ActionFailed, "Action #provision failed for #{instance.to_str}."
        end
      end

      def merge_state_to_env(state)
        env_state = { :environment => {} }
        env_state[:environment]["KITCHEN_INSTANCE"] = instance.name
        env_state[:environment]["KITCHEN_PLATFORM"] = instance.platform.name
        env_state[:environment]["KITCHEN_SUITE"] = instance.suite.name
        state.each_pair do |key, value|
          env_state[:environment]["KITCHEN_" + key.to_s.upcase] = value
        end
        config[:shellout_opts].merge!(env_state)
      end
    end
  end
end
