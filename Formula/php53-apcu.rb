require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Apcu < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/apcu'
  url 'http://pecl.php.net/get/apcu-4.0.2.tgz'
  sha1 'dd8a2ed00304501318f678a7f5b7364af4fc7dcf'
  head 'https://github.com/krakjoe/apcu.git'

  option 'with-apc-bc', "Wether APCu should provide APC full compatibility support"
  depends_on 'pcre'

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.include? 'with-apc-bc'

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file unless build.include? "without-config-file"
  end

  def config_file
    super + <<-EOS.undent
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
