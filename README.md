# frame-tag-plus.el

frame-tag-plus-mode is an Emacs minor mode that allows you to switch to [frames](http://www.gnu.org/software/emacs/manual/html_node/emacs/Frames.html) 
using the key bindings M-1 through M-9.

## Usage

Frames are tagged in order by crating time. The frame starts from 1. The next frame gets 2 and so on.

To switch to the first frame, press M-1

## Compatibility

Emacs 23.x and above. Not tested on older versions.

## Installation

Download frame-tag-plus.el and add this to your .emacs file

    (add-to-list 'load-path "/path/to/frame-tag-plus")
    (require 'frame-tag-plus)
    (frame-tag-plus-mode 1)

## License

Copyright (c) 2012 Wong Liang Zan. GPL v3
Modified by louxiu


## Update

Use Japanese number in frame tittle
