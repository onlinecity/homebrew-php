require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Yaz < AbstractPhp55Extension
  init
  homepage 'http://www.indexdata.com/phpyaz'
  url 'http://pecl.php.net/get/yaz-1.1.6.tgz'
  sha1 '6add3d6dda5a676cdf74378ab968fd64e348c91f'

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file unless build.include? "without-config-file"
  end
end
