## mkdir
#### make yaml dir
if [ ! -d yaml ]; then
    mkdir yaml
    mkdir yaml/_template
    mkdir yaml/_install
fi

#### make image dir for download capi, aws images
if [ ! -d img ]; then
   mkdir img
fi