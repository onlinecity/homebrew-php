require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Intl < AbstractPhp53Extension
  init
  homepage 'http://php.net/manual/en/book.intl.php'
  url 'http://www.php.net/get/php-5.3.28.tar.bz2/from/this/mirror'
  sha1 'f985ca1f6a5f49ebfb25a08f1837a44c563b31f8'
  version '5.3.28'

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
