build:
    mkdir out
    cp -r static/* out/
    just render-all

render server:
    minijinja-cli templates/_server.jinja data/servers/{{ server }}.yaml > out/{{ server }}/index.html

render-all:
    for server in {pv,pv2,pv_reloaded,tvl2014,pv_remastered,vp,tvl2015,g2m}; do \
        mkdir out/$server; \
        just render $server; \
    done