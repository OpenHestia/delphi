docker run \
    --gpus all \
    --volume /$HOME/models:/models \
    --network host \
    -it \
    delphi-$1\
    /bin/bash