build:
    mkdir -p out
    cp -r static/* out/
    just render-all

clean:
    rm -fr out/*

dev:
    watchexec --ignore out -- "just clean; just build"

render-server server:
    minijinja-cli templates/server.jinja data/servers/{{ server }}.yaml > out/{{ server }}/index.html

render-index:
    minijinja-cli templates/index.jinja data/index.yaml > out/index.html

render-all:
    just render-index

    for server in {pv,pv2,pv_reloaded,tvl2014,pv_remastered,vp,tvl2015,g2m}; do \
        mkdir -p out/$server; \
        just render-server $server; \
    done