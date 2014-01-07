require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Sundown < AbstractPhp55Extension
  init
  homepage 'http://pecl.php.net/package/sundown'
  url 'http://pecl.php.net/get/sundown-0.3.11.tgz'
  sha1 'e905cf2cd3540480af598e971a3c37c769775351'

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file unless build.include? "without-config-file"
  end
end
