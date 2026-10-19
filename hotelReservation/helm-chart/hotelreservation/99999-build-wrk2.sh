sudo apt-get install -y make luarocks luajit libssl-dev && \
sudo luarocks install luasocket && \
cd ../../../wrk2 && \
cd deps && git clone https://github.com/luajit/luajit ; cd - && \
make all && \
wrk
