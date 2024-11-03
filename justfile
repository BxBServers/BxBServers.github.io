build:
    mkdir -p out
    cp -r static/* out/
    just render-all

clean:
    rm -fr out/*

dev:
    watchexec --ignore out -- "just clean; just build"

build-images:
    #!/usr/bin/env sh

    for image in images/servers/*.png; do
        image_file_name=$(basename -- "$image");
        image_name="${image_file_name%.*}";
        echo "building image $image_name...";
    
        for format in {jpg,webp}; do
            for size in {1280x720,1920x1080,3840x2160}; do
                mkdir -p "static/images/$size/";
                magick "$image" -resize $size "static/images/$size/$image_name.$format";
            done;

            for size in {256x256,512x512}; do
                mkdir -p "static/images/thumbs/$size/";
                    
                magick \
                    -define png:size=512x512 "$image" \
                    -thumbnail "$size^" -gravity center -extent "$size"  \
                    "static/images/thumbs/$size/$image_name.$format";
            done;

        done;
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