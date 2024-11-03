render server:
    minijinja-cli templates/_server.jinja data/servers/{{ server }}.yaml > {{ server }}/index.html