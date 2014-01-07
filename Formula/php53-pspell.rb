require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Pspell < AbstractPhp53Extension
  init
  homepage 'http://php.net/manual/en/book.pspell.php'
  url 'http://www.php.net/get/php-5.3.28.tar.bz2/from/this/mirror'
  sha1 'f985ca1f6a5f49ebfb25a08f1837a44c563b31f8'
  version '5.3.28'

  depends_on 'aspell'

  def install
    Dir.chdir "ext/pspell"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--with-pspell=#{Formula.factory('aspell').opt_prefix}"
    system "make"
    prefix.install "modules/pspell.so"
    write_config_file unless build.include? "without-config-file"
  end
end
