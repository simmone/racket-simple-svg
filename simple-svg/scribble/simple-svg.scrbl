#lang scribble/manual

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@defmodule[simple-svg]
@include-section["usage.scrbl"]

@defmodule[simple-svg]
@include-section["sstyle.scrbl"]

@defmodule[simple-svg]
@include-section["shapes/rect.scrbl"] 

@defmodule[simple-svg]
@include-section["shapes/circle.scrbl"]

@defmodule[simple-svg]
@include-section["shapes/ellipse.scrbl"]

@defmodule[simple-svg]
@include-section["shapes/line.scrbl"]

@defmodule[simple-svg]
@include-section["shapes/polyline.scrbl"]

@defmodule[simple-svg]
@include-section["shapes/polygon.scrbl"]

@defmodule[simple-svg]
@include-section["path/path.scrbl"]

@defmodule[simple-svg]
@include-section["text/text.scrbl"]

@defmodule[simple-svg]
@include-section["gradient/gradient.scrbl"]
