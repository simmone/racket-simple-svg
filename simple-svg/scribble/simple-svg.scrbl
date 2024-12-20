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

@include-section["sstyle.scrbl"]

@include-section["color.scrbl"]

@include-section["shapes/rect.scrbl"] 

@include-section["shapes/circle.scrbl"]

@include-section["shapes/ellipse.scrbl"]

@include-section["shapes/line.scrbl"]

@include-section["shapes/polyline.scrbl"]

@include-section["shapes/polygon.scrbl"]

@include-section["shapes/arrow.scrbl"]

@include-section["path/path.scrbl"]

@include-section["text/text.scrbl"]

@include-section["gradient/gradient.scrbl"]

@include-section["filter/filter.scrbl"]

@include-section["group/group.scrbl"]

@include-section["marker/marker.scrbl"]
