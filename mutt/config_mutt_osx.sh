./configure \
    --enable-debug \
    --enable-pop \
    --enable-imap \
    --enable-smtp \
    --enable-locales-fix \
    --enable-exact-address \
    --enable-hcache \
    --disable-nls \
    --with-regex \
    --with-curses \
    --with-sasl \
    --with-ssl \
    --with-gnutls \
    --with-gss \
    CPPFLAGS=-I/opt/local/include/ \
    LDFLAGS=-L/opt/local/lib/
