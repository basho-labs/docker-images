ARG BASHO_BENCH_BRANCH=master

RUN git clone git://github.com/basho/basho_bench.git -b $BASHO_BENCH_BRANCH /opt/basho_bench
RUN cd /opt/basho_bench && make all
