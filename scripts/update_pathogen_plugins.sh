#/bin/bash
for i in ~/.vim/bundle/*; do git -C $i pull; done
