require "ec2/tracer/version"
require 'aws-sdk-ec2'

module Ec2
  module Tracer
    class Writer
      WRITE_MODE = 'a'.freeze

      attr_reader :file_name, :host_prefix, :range, :user, :identity_file

      def initialize(file_name = 'ec2.d', host_prefix = 'welligence_ml', range = (2..10), user = 'ubuntu', identity_file = '~/.ssh/welligence.pem' )
        @file_name = file_name
        @host_prefix = host_prefix
        @range = range
        @user = user
        @identity_file = identity_file
      end

      def write_config
        ec2 = Aws::EC2::Resource.new(region: 'us-west-2')
        filepath = "#{Dir.pwd}/#{file_name}"

        FileUtils.rm_rf filepath
        FileUtils.touch filepath

        ec2.instances({filters: [{name: 'tag:Name', values: range.map{|i| "#{host_prefix}_#{i}"} }]}).each do |i|
          instance_tag_name = i.tags.map(&:value).join()
          public_ip_address = i.public_ip_address

          puts "#{instance_tag_name} - #{public_ip_address}"
          File.open(filepath, WRITE_MODE) { |f| f << ssh_host(host: instance_tag_name, host_name: public_ip_address) }
        end
      end

      private

      def ssh_host(host:, host_name:)
        %{
  # #{host}
  Host #{host}
  HostName #{host_name}
  User #{user}
  IdentityFile #{identity_file}
        }
      end
    end
  end
end
