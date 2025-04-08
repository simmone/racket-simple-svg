#lang scribble/manual

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

thanks to Joni's tutorial: @hyperlink["http://svgpocketguide.com/"]{"Svg Pocket Guide"}.

@table-of-contents[]

@section{Install}

raco pkg install simple-svg

@include-section["showcase.scrbl"]

@include-section["basic.scrbl"]

@include-section["sstyle/sstyle.scrbl"]

@include-section["sstyle/gradient.scrbl"]

@include-section["color.scrbl"]

@section{Shape}

Shape is basic brick of svg, basic usage: define it, use sstyle to colorize it, use svg-place-widget place it somewhere.

Shape include: Rect, Circle, Ellipse, Line, Polyline, Polygon, Path, Text, Arrow.

@include-section["shape/rect.scrbl"] 

@include-section["shape/circle.scrbl"]

@include-section["shape/ellipse.scrbl"]

@include-section["shape/line.scrbl"]

@include-section["shape/polyline.scrbl"]

@include-section["shape/polygon.scrbl"]

@include-section["shape/path.scrbl"]

@include-section["shape/arrow.scrbl"]

@include-section["shape/text.scrbl"]

@section{Effect}

Effect can give shape some decoration: DropdownBlur, Marker.

@include-section["effect/filter.scrbl"]

@include-section["effect/marker.scrbl"]

@include-section["group/group.scrbl"]

@section{Gadget}

Combine shapes and groups can make new component: Table etc.

@include-section["gadget/table.scrbl"]

@include-section["squeeze.scrbl"]
