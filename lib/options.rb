require 'optparse'

module Options

  def setup_options
    hash_options = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: ruby-twarc [options]"
      opts.on('--search', "Use the Twitter search API") do |v|
        hash_options[:mode] = :search
      end
      opts.on('--stream', "Use the Twitter stream API") do |v|
        hash_options[:mode] = :stream
      end
      opts.on('--hydrate', "Rehydrate tweets from a file of ids") do |v|
        hash_options[:stream] = v
      end
      opts.on('--max_id', "Maximum tweet id to search for") do |v|
        hash_options[:stream] = v
      end
      opts.on('--since_id', "Smallest id to search for") do |v|
        hash_options[:stream] = v
      end
      opts.on('--auth_file [ARG]', "specify an auth file") do |v|
        hash_options[:auth_file] = v
      end
      opts.on('--consumer_key', "your consumer key") do |v|
        hash_options[:consumer_key] = v
      end
      opts.on('--consumer_secret', "your consumer secret") do |v|
        hash_options[:consumer_secret] = v
      end
      opts.on('--access_token', "your access token") do |v|
        hash_options[:access_token] = v
      end
      opts.on('--access_token_secret', "your secret token") do |v|
        hash_options[:access_token_secret] = v
      end
      opts.on('--query [ARG]', "query string") do |v|
        hash_options[:query] = v
      end
      opts.on('--log [ARG]', "log file location") do |v|
        hash_options[:log] = v
      end
    end.parse!
    hash_options
  end
end
