require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Mcrypt < AbstractPhp54Extension
  init
  homepage 'http://php.net/manual/en/book.mcrypt.php'
  url 'http://www.php.net/get/php-5.4.23.tar.bz2/from/this/mirror'
  sha1 '1ad25b03486742dba18134ce07111146805d930f'
  version '5.4.23'

  depends_on 'mcrypt'

  def install
    Dir.chdir "ext/mcrypt"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-mcrypt=#{Formula.factory('mcrypt').opt_prefix}"
    system "make"
    prefix.install "modules/mcrypt.so"
    write_config_file unless build.include? "without-config-file"
  end
end
