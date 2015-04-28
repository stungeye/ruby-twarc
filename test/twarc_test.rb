require "minitest/autorun"
require_relative "test_helper"

class TwarcTest < Minitest::Test

  def setup
    @log_location = "../data/twarc.log"
    @auth_hash = eval(File.open("../../ruby-twarc-auth.rb").read)
    File.delete(@log_location) if File.exists? @log_location
    @twarc = Twarc.new({consumer_key: @auth_hash[:consumer_key], consumer_secret: @auth_hash[:consumer_secret], access_token: @auth_hash[:access_token], access_token_secret: @auth_hash[:access_token_secret], log: @log_location})
  end

  def test_instantiation_of_twarc_object
    assert @twarc
    assert_instance_of Twarc, @twarc
  end

  def test_basic_search
    results = @twarc.fetch(query: "vodka", mode: :search)
    assert_instance_of Array, results
    assert_equal 100, results.size
    assert_equal @twarc.max_id, results.last["id_str"]
  end

  # def test_continued_search
  #   id = "592338718205353986"
  #   results = @twarc.search(query: "vodka", max_id: id, since_id: (id.to_i - 1).to_s)
  #   assert_equal 100, results.size
  #   assert_equal id.to_i, results.first["id_str"].to_i
  # end

  def test_empty_search
    results = @twarc.fetch(query: (0...50).map { ('a'..'z').to_a[rand(26)] }.join, mode: :search)
    assert_equal 0, results.size
    log = File.open(@log_location).readlines
    assert_equal "INFO -- : archived 0 tweets.", log.last.split("]").last.strip
  end

  def test_basic_search_logging
    @twarc.fetch(query: "mandolin", mode: :search)
    log = File.open(@log_location).readlines
    assert_equal 3, log.size
    assert_equal "INFO -- : starting search for mandolin", log[1].split("]").last.strip
    assert_equal "INFO -- : archived 100 tweets.", log.last.split("]").last.strip
  end

  def test_basic_stream
    results = @twarc.fetch(query: "vodka", mode: :stream)
    assert_instance_of Array, results
    assert_equal 10, results.size
  end
end


