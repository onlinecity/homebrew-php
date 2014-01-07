require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Thrift < AbstractPhp55Extension
  init
  homepage 'thrift.apache.org'
  url 'https://git-wip-us.apache.org/repos/asf/thrift.git', :branch => "0.9.1"
  version "0.9.1"

  def module_path
      prefix / "thrift_protocol.so"
  end

  def install
    Dir.chdir "lib/php/src/ext/thrift_protocol"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/thrift_protocol.so"
    write_config_file unless build.include? "without-config-file"
  end
end
