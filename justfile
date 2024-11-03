build:
    mkdir -p out
    cp -r static/* out/
    just render-all
    mkdir -p out/images/thumbs/
    just build-thumbs

clean:
    rm -fr out/*

dev:
    watchexec --ignore out -- "just clean; just build"

build-thumbs:
    for image in out/images/4k/*.png; do \
        magick \
            -define png:size=512x512 $image \
            -thumbnail 256x256^ -gravity center -extent 256x256 \
            $(echo $image | sed "s#4k#thumbs#"); \
    done

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