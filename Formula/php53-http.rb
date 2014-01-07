require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Http < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/pecl_http'
  url 'http://pecl.php.net/get/pecl_http-2.0.4.tgz'
  sha1 'a54d97dcd731e9b1442eca9c2dffe4cae346f6f8'
  head 'https://git.php.net/repository/pecl/http/pecl_http.git'

  depends_on 'curl' => :build
  depends_on 'libevent' => :build
  depends_on 'php53-raphf'
  depends_on 'php53-propro'

  # overwrite the config file name to ensure extension is loaded after dependencies
  def config_filename; "zzz_ext-" + extension + ".ini"; end

  def install
    Dir.chdir "pecl_http-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize

    # link in the raphf extension header
    system "mkdir -p ext/raphf"
    cp "#{Formula.factory('php53-raphf').opt_prefix}/include/php_raphf.h", "ext/raphf/php_raphf.h"

    # link in the propro extension header
    system "mkdir -p ext/propro"
    cp "#{Formula.factory('php53-propro').opt_prefix}/include/php_propro.h", "ext/propro/php_propro.h"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent-dir=#{Formula.factory('libevent').opt_prefix}",
                          "--with-curl-dir=#{Formula.factory('curl').opt_prefix}"
    system "make"
    prefix.install "modules/http.so"
    write_config_file unless build.include? "without-config-file"

    # remove old configuration file
    old_config_filepath = config_scandir_path / "ext-http.ini"
    if File.exist?(old_config_filepath)
      system "unlink " + old_config_filepath
    end
  end
end
