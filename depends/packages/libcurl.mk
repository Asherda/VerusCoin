package=libcurl
$(package)_version=8.4.0
$(package)_dependencies=openssl
$(package)_download_path=https://curl.se/download
$(package)_file_name=curl-$($(package)_version).tar.gz
$(package)_sha256_hash=816e41809c043ff285e8c0f06a75a1fa250211bbfb2dc0a037eeef39f1a9e427
$(package)_config_opts=--with-openssl --disable-shared --enable-static --prefix=$(host_prefix)
$(package)_config_opts+=--without-ca-bundle
$(package)_config_opts+=--without-ca-path
$(package)_config_opts+=--with-ca-fallback
$(package)_config_opts+=--disable-dict
$(package)_config_opts+=--disable-file
$(package)_config_opts+=--disable-ftp
$(package)_config_opts+=--disable-gopher
$(package)_config_opts+=--disable-imap
$(package)_config_opts+=--disable-ldap
$(package)_config_opts+=--disable-ldaps
$(package)_config_opts+=--disable-mqtt
$(package)_config_opts+=--disable-pop3
$(package)_config_opts+=--disable-rtsp
$(package)_config_opts+=--disable-smb
$(package)_config_opts+=--disable-smtp
$(package)_config_opts+=--disable-telnet
$(package)_config_opts+=--disable-tftp
$(package)_config_opts+=--disable-websockets
$(package)_config_opts+=--disable-alt-svc
$(package)_config_opts+=--disable-aws
$(package)_config_opts+=--disable-bearer-auth
$(package)_config_opts+=--disable-cookies
$(package)_config_opts+=--disable-digest-auth
$(package)_config_opts+=--disable-doh
$(package)_config_opts+=--disable-form-api
$(package)_config_opts+=--disable-get-easy-options
$(package)_config_opts+=--disable-headers-api
$(package)_config_opts+=--disable-hsts
$(package)_config_opts+=--disable-kerberos-auth
$(package)_config_opts+=--disable-libcurl-option
$(package)_config_opts+=--disable-mime
$(package)_config_opts+=--disable-negotiate-auth
$(package)_config_opts+=--disable-netrc
$(package)_config_opts+=--disable-ntlm
$(package)_config_opts+=--disable-sspi
$(package)_config_opts+=--disable-tls-srp
$(package)_config_opts+=--disable-unix-sockets
$(package)_config_opts+=--disable-manual
$(package)_config_opts+=--without-brotli
$(package)_config_opts+=--without-libgsasl
$(package)_config_opts+=--without-libidn2
$(package)_config_opts+=--without-libpsl
$(package)_config_opts+=--without-librtmp
$(package)_config_opts+=--without-libssh
$(package)_config_opts+=--without-libssh2
$(package)_config_opts+=--without-nghttp2
$(package)_config_opts+=--without-nghttp3
$(package)_config_opts+=--without-ngtcp2
$(package)_config_opts+=--without-quiche
$(package)_config_opts+=--without-winidn
$(package)_config_opts+=--without-zlib
$(package)_config_opts+=--without-zstd
$(package)_config_opts_linux=--host=$(HOST)
$(package)_config_opts_mingw32=--host=x86_64-w64-mingw32
$(package)_cflags_darwin=-mmacos-version-min=$(OSX_MIN_VERSION)
$(package)_conf_tool=./configure

ifeq ($(build_os),darwin)
define $(package)_set_vars
  $(package)_build_env=MACOSX_DEPLOYMENT_TARGET="$(OSX_MIN_VERSION)"
endef
endif

ifeq ($(build_os),linux)
define $(package)_set_vars
  $(package)_config_env=LD_LIBRARY_PATH="$(host_prefix)/lib" PKG_CONFIG_LIBDIR="$(host_prefix)/lib/pkgconfig" CPPFLAGS="-I$(host_prefix)/include" LDFLAGS="-L$(host_prefix)/lib"
endef
endif


define $(package)_config_cmds
  echo '=== config for $(package):' && \
  echo '$($(package)_config_env) $($(package)_conf_tool) $($(package)_config_opts)' && \
  echo '=== ' && \
  $($(package)_config_env) $($(package)_conf_tool) $($(package)_config_opts) 
endef

ifeq ($(build_os),darwin)
define $(package)_build_cmds
  $(MAKE) CPPFLAGS="-I$(host_prefix)/include -fPIC" CFLAGS="-mmacos-version-min=$(OSX_MIN_VERSION)"
endef
else
define $(package)_build_cmds
  $(MAKE)
endef
endif

define $(package)_stage_cmds
  echo 'Staging dir: $($(package)_staging_dir)$(host_prefix)/' && \
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef
