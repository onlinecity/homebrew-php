require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Intl < AbstractPhp55Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.5.7.tar.bz2/from/this/mirror'
  sha1 'f32ccf1a2aa0592e2dcc151c89a7a811e53e0925'
  version '5.5.7'

  depends_on 'icu4c'

  def install
    Dir.chdir "ext/intl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-icu-dir=#{Formula.factory('icu4c').opt_prefix}",
                          "--enable-intl"
    system "make"
    prefix.install "modules/intl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
