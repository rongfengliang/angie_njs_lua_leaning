FROM docker.angie.software/angie:1.3.1-rocky
RUN mkdir -p /run/angie/
# copy from openresty add cjson 
COPY openresy-lua/luajit/ /usr/share/angie/lualib/
COPY luarocks-3.9.2.tar.gz /tmp/luarocks-3.9.2.tar.gz
RUN yum install -y wget gcc unzip  \
   && cd  /tmp/ && tar -zxvf  luarocks-3.9.2.tar.gz \
   && cd luarocks-3.9.2 \
   && ./configure --prefix=/usr/share/angie/lualib/ \
      --with-lua=/usr/share/angie/lualib/ \
      --lua-suffix=jit \
      --with-lua-include=/usr/share/angie/lualib/include/luajit-2.1 \
    && make build \
    && make install \
    && cd /tmp \
    && rm -rf  luarocks-3.9.2.tar.gz luarocks-3.9.2 \
    && ln -s /usr/share/angie/lualib/share/lua/5.1 /usr/share/lua/5.1
ENV LUA_CPATH="/usr/share/angie/lualib/?.so;/usr/share/angie/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/share/angie/lualib/lib/?.so;/usr/local/lib/lua/5.1/loadall.so;/usr/share/angie/lualib/lib/lua/5.1/?.so"