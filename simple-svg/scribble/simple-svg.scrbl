#lang scribble/manual

@(require simple-svg)

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Simple-Svg: Scalable Vector Graphics}

@author+email["Chen Xiao" "chenxiao770117@gmail.com"]

simple-svg package is a simple tool to write svg.

@table-of-contents[]

@section[#:tag "install"]{Install}

raco pkg install simple-svg

@section{Usage}

@defmodule[simple-svg]

@defproc[(svg-out
          [width natural?]
          [height natural?]
          [procedure procedure?]
          [#:viewBox? viewBox? (or/c #f (list/c natural? natural? natural? natural?)) #f]
        )
        string?]{
  specify width and height manully.
  
  viewBox?: '(x y width height), if needed.
}

@defproc[(svg-use-shape
           [shape_index string?]
           [shape_style sstyle/c]
           [#:at? at? (cons/c natural? natural?) '(0 . 0)]
           [#:hidden? hidden? boolean? #f]
        )
        string?]{
  use a shape in group.
  
  hidden? set to true means just use it, but not show it. 
}

@defproc[(svg-def-group
           [group_name string?]
           [use-proc procedure?]
         )
         void?]{
  default, all svg-use-* will be added to "default" group.

  use svg-def-group to define a named group to use later.

  all svg-use-* in use-proc will be added to the group.
}

@defproc[(svg-show-group
           [group_name string?]
           [group_style sstyle/c]
           [#:at? at? (cons/c natural? natural?) '(0 . 0)]
          )
          void?]{
  show a group by name with style and position.
}

@defproc[(svg-show-default)
         void?]{
  (svg-show-group "default" (sstyle-new))
}

@subsection{basic usage}

@itemlist[
  #:style 'ordered
  @item{use svg-out to generate svg content}
  @item{all svg drawings should occur in the svg-out's procedure.}
  @item{you should specify the svg whole size manully.}
  @item{use svg-def-... define shape first, it includes shape's baisc properties: width, height, radius etc.}
  @item{use sstyle-new and sstyle-set! etc to give shape style properties: stroke, fill etc.}
  @item{svg-use-shape to claim how to show a shape in a group by style(sstyle) and position(#:at?). if not specify which group, all svg-use included in the default group.}
  @item{svg-show-default shows default group at '(0 . 0)}
  @item{svg-show-group reuse group}
]

define shape first, then define group, reuse shape and style in group(s), show group(s) with style in canvas.

@codeblock{
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (sstyle-set! _sstyle 'fill "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
}

generated svg file:

@verbatim[
(svg-out
  100 100
  (lambda ()
    (let ([rec (svg-def-rect 100 100)]
          [_sstyle (sstyle-new)])

      (sstyle-set! _sstyle 'fill "#BBC42A")
      (svg-use-shape rec _sstyle)
      (svg-show-default))))
]
@image{showcase/shapes/rect/rect.svg}

@section{Svg Style}

each shape and group can have multiple styles: stroke, fill etc.

sstyle is a struct, use sstyle-new, sstyle-clone, sstyle-get and sstyle-set! to manage it.

sstyle used in svg-use-shape and svg-show-group.

@defstruct*[sstyle (
     [fill string?]
     [fill-rule (or/c #f 'nonzero 'evenodd 'inerit)]
     [fill-opacity (or/c #f (between/c 0 1))]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linecap (or/c #f 'butt 'round 'square 'inherit)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
     [stroke-miterlimit (or/c #f (>=/c 1))]
     [stroke-dasharray (or/c #f string?)]
     [stroke-dashoffset (or/c #f natural?)]
     [translate (or/c #f (cons/c natural? natural?))]
     [rotate (or/c #f integer?)]
     [scale (or/c #f natural? (cons/c natural? natural?))]
     [skewX (or/c #f natural?)]
     [skewY (or/c #f natural?)]
     [fill-gradient (or/c #f string?)]
     )]{
}

@defproc[(sstyle-new) sstyle/c]{
  init a empty svg style.                    
}

@defproc[(sstyle-clone
           [sstyle sstyle/c]
         ) sstyle/c]{
  init a empty svg style.                    
}

@defproc[(sstyle-get
           [sstyle sstyle/c]
           [key symbol?]
         ) sstyle/c]{
  get a sstyle property.
}

@defproc[(sstyle-set!
           [sstyle sstyle/c]
           [key symbol?]
           [val any/c]
         ) void?]{
  set a sstyle property.
}

@section{Rectangle}

@defproc[(svg-def-rect
          [width natural?]
          [height natural?]
          [#:radius? radius? (or/c #f (cons/c natural? natural?)) #f]
        )
        string?]{
  define a rectangle.

  radius?: '(radiusX . radiusY)
}

@subsection{rect}

@codeblock{
(svg-def-rect 100 100)
}
@image{showcase/shapes/rect/rect.svg}

@subsection{rect with start point(no padding)}

@codeblock{
(svg-def-rect 100 100)
...
(svg-use-shape rec _sstyle #:at? '(50 . 50))
}
@image{showcase/shapes/rect/rect_y.svg}

@subsection{rect with radius}

@subsection{multiple rect}

@codeblock{
(svg-def-rect 150 150)
(svg-def-rect 100 100)
(svg-def-rect 50 50)
}
@image{showcase/shapes/rect/m_rect.svg}

@section{Circle}

@defproc[(svg-def-circle
          [radius natural?]
        )
        string?]{
  define a circle by radius length.
}

@subsection{circle}

@codeblock{
(svg-def-circle 50)
}
@image{showcase/shapes/circle/circle.svg}

@subsection{multiple circle}

@codeblock{
(svg-def-circle 50)
...
(svg-use-shape circle red_sstyle #:at? '(50 . 50))
(svg-use-shape circle yellow_sstyle #:at? '(150 . 50))
(svg-use-shape circle blue_sstyle #:at? '(50 . 150))
(svg-use-shape circle green_sstyle #:at? '(150 . 150))
}
@image{showcase/shapes/circle/circle3.svg}

@section{Ellipse}

@defproc[(svg-def-ellipse
          [radius (cons/c natural? natural?)]
        )
        string?]{

  define a ellipse by radius length: '(x . y).
}

@codeblock{
(svg-def-ellipse '(100 . 50))
...
(svg-use-shape ellipse _sstyle #:at? '(100 . 50))
}
@image{showcase/shapes/ellipse/ellipse.svg}

@section{Line}

@defproc[(svgf-line-def
          [start_point (cons/c natural? natural?)]
          [end_point (cons/c natural? natural?)]
        )
        string?]{
  define a line by start point and end point.
}

@subsection{line}

@codeblock{
(svg-def-line '(0 . 0) '(100 . 100))
...
(svg-use-shape line _sstyle #:at? '(5 . 5))
}
@image{showcase/shapes/line/line.svg}

@section{Polyline}

@defproc[(svg-def-polyline
          [points (listof (cons/c natural? natural?))]
        )
        string?]{
  define a polyline by points list.
}

@subsection{polyline}

@codeblock{
(svg-def-polyline
           '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))
...
(svg-use-shape polyline _sstyle #:at? '(5 . 5))
}
@image{showcase/shapes/polyline/polyline.svg}

@section{Polygon}

@defproc[(svg-def-polygon
          [points (listof pair?)]
        )
        string?]{
  define a polygon by points list.
}

@subsection{polygon}

@codeblock{
(svg-def-polygon
  '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75)))
...
(svg-use-shape polygon _sstyle #:at? '(5 . 5))
}
@image{showcase/shapes/polygon/polygon.svg}

@section{Path}

@defproc[(svg-def-path
          [procedure procedure?]
        )
        void?]{
}

@subsection{Basic Usage}

all path actions should be include in this procedure: moveto, curve etc.

@codeblock{
(svg-def-path
  (lambda ()
    (svg-path-moveto* '(5 . 5))
    (svg-path-hlineto 100)
    (svg-path-vlineto 100)
    (svg-path-lineto '(-50 . 50))
    (svg-path-lineto '(-50 . -50))
    (svg-path-close)))
...
(svg-use-shape path sstyle_path)
}

@subsection{Raw Path}

@defproc[(svg-path-raw
          [data string?]
        )
        void?]{
}

@codeblock{
(svg-def-path
  (lambda ()
    (svg-path-raw
     "M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021
     c-10.035,37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334
     c-0.765,0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731
     c0-9.78,7.93-17.71,17.71-17.71c0.787,0,1.552,0.042,2.317,0.149
     C39.238,37.084,80.419,9.083,129.702,9.083c49.24,0,90.379,27.937,100.414,65.228h0.021
     c0.298-0.021,0.617-0.021,0.914-0.021C240.831,74.29,248.761,82.22,248.761,92z")))
}
@image{showcase/path/raw_path.svg}

@subsection{svg-path-moveto/moveto*}

@defproc[(svg-path-moveto [point (cons/c natural? natural?)])
        void?]{
  moveto use relative position.
}

@defproc[(svg-path-moveto* [point (cons/c natural? natural?)])
        void?]{
  moveto* use absolute position.
}

@subsection{svg-path-close}

@defproc[(svg-path-close) void?]{
  close a path.                          
}

@subsection{svg-path-lineto/lineto*/hlineto/vlineto}

@defproc[(svg-path-lineto [point (cons/c integer? integer?)]) void?]{
}

@defproc[(svg-path-lineto* [point (cons/c integer? integer?)]) void?]{
}

@defproc[(svg-path-hlineto [point integer?]) void?]{
}

@defproc[(svg-path-vlineto [point integer?]) void?]{
}

@codeblock{
(svg-def-path
  (lambda ()
    (svg-path-moveto* '(5 . 5))
    (svg-path-hlineto 100)
    (svg-path-vlineto 100)
    (svg-path-lineto '(-50 . 50))
    (svg-path-lineto '(-50 . -50))
    (svg-path-close)))
}
@image{showcase/path/lineto.svg}

@subsection{svg-path-qcurve/qcurve*}

@image{showcase/path/qcurve.jpg}

@defproc[(svg-path-qcurve
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
        )
        void?]{
  use two control points to draw a Quadratic Bezier Curve.

  qcurve use relative position, relative to the start position.
}

@defproc[(svg-path-qcurve*
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
        )
        void?]{
}

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-qcurve* '(60 . 10) '(110 . 60))
(svg-path-qcurve* '(160 . 110) '(210 . 60))
}

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-qcurve '(50 . -50) '(100 . 0))
(svg-path-qcurve '(50 . 50) '(100 . 0))
}
@image{showcase/path/qcurve1.svg}

@subsection{svg-path-ccurve/ccurve*}

@image{showcase/path/ccurve.jpg}

@defproc[(ccurve
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
          [point3 (cons/c natural? natural?)]
        )
        void?]{
  use three control points to draw a Cubic Bezier Curve.
}

@defproc[(ccurve*
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
          [point3 (cons/c natural? natural?)]
        )
        void?]{
}

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
(svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
}

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
(svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
}
@image{showcase/path/ccurve1.svg}

@subsection{svg-path-arc/arc*}

@image{showcase/path/arc.png}

@defproc[(svg-path-arc
           [point (cons/c integer? integer?)]
           [radius (cons/c natural? natural?)]
           [direction (or/c 'left_big 'left_small 'right_big 'right_small)]
         )
         void?]{
  point is the end point.
  
  radius specify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.
}

@defproc[(svg-path-arc*
           [point (cons/c integer? integer?)]
           [radius (cons/c natural? natural?)]
           [direction (or/c 'left_big 'left_small 'right_big 'right_small)]
         )
         void?]{
}

@codeblock{
(svg-path-moveto* '(130 . 45))
(svg-path-arc* '(170 . 85) '(80 . 40) 'left_big)
...
(svg-path-moveto* '(130 . 45))
(svg-path-arc* '(170 . 85) '(80 . 40) 'left_small)
...
(svg-path-moveto* '(130 . 45))
(svg-path-arc* '(170 . 85) '(80 . 40) 'right_big)
...
(svg-path-moveto* '(130 . 45))
(svg-path-arc* '(170 . 85) '(80 . 40) 'right_small)
}
@image{showcase/path/arc.svg}

@section{Text}

@defproc[(svg-def-text
          [text string?]
          [#:font-size? font-size? (or/c #f natural?) #f]
          [#:font-family? font-family? (or/c #f string?) #f]
          [#:dx? dx? (or/c #f integer?) #f]
          [#:dy? dy? (or/c #f integer?) #f]
          [#:rotate? rotate? (or/c #f (listof integer?)) #f]
          [#:textLength? textLength? (or/c #f natural?) #f]
          [#:kerning? kerning? (or/c #f natural? 'auto 'inherit) #f]
          [#:letter-space? letter-space? (or/c #f natural? 'normal 'inherit) #f]
          [#:word-space? word-space? (or/c #f natural? 'normal 'inherit) #f]
          [#:text-decoration? text-decoration? (or/c #f 'overline 'underline 'line-through) #f]
          [#:path? path? (or/c #f string?) #f]
          [#:path-startOffset? path-startOffset? (or/c #f (integer-in 0 100)) #f]
         )
        string?]{
  define a text programmtially.
  dx, dy: relative position.
  kerning, letter-space, word-space: all about letter and word spaces.
}

@codeblock{
(svg-def-text "城春草木深" #:font-size? 50)
}
@image{showcase/text/text1.svg}

rotate: a list of rotate angles, it represent each letter's rotate, only one means each letter have same angle.

@codeblock{
(svg-def-text "城春草木深" #:font-size? 50 #:rotate? '(10 20 30 40 50) #:textLength? 300)
}
@image{showcase/text/text2.svg}

@codeblock{
(svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'overline)
(svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'underline)
(svg-def-text "国破山河在" #:font-size? 50 #:text-decoration? 'line-through)
}
@image{showcase/text/text3.svg}

let text follow a path:
@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-qcurve* '(110 . 10) '(210 . 60))
(svg-path-qcurve* '(310 . 110) '(410 . 60))
...
(svg-def-text "国破山河在 城春草木深 感时花溅泪 恨别鸟惊心"
              #:path? path
              #:path-startOffset? 5)
}
@image{showcase/text/text4.svg}

@section{Gradient}

@defproc[(svg-def-gradient-stop
           [#:offset offset (integer-in 0 100)]
           [#:color color string?]
           [#:opacity? opacity? (between/c 0 1) 1]
         )
         (list/c (integer-in 0 100) string? (between/c 0 1))]{
  define a gradient programmtially.

  offset from 0 to 100, means the distance of the color gradient.
 
  lineargradient and radialgradient both have a stop list.
}

@defproc[(svg-def-linear-gradient
           [stop_list (listof (list/c (integer-in 0 100) string? (between/c 0 1)))]
           [#:x1? x1? (or/c #f natural?) #f]
           [#:y1? y1? (or/c #f natural?) #f]
           [#:x2? x2? (or/c #f natural?) #f]
           [#:y2? y2? (or/c #f natural?) #f]
           [#:gradientUnits? gradientUnits? (or/c #f 'userSpaceOnUse 'objectBoundingBox) #f]
           [#:spreadMethod? spreadMethod? (or/c #f 'pad 'repeat 'reflect) #f]
         )
         string?]{
  use x1, y1, x2, y2 justify gradient's direction and position.

  default is from left to right, x1=0, y1=0, x2=100, y2=0.
}

@codeblock{
(svg-def-linear-gradient
  (list
    (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
    (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")))
}
@image{showcase/gradient/gradient1.svg}

@defproc[(svg-def-radial-gradient
           [stop_list (listof (list/c (integer-in 0 100) string? (between/c 0 1)))]
           [#:cx? cx? (or/c #f natural?) #f]
           [#:cy? cy? (or/c #f natural?) #f]
           [#:fx? fx? (or/f #f natural?) #f]
           [#:fy? fy? (or/f #f natural?) #f]
           [#:r? r? (or/c #f natural?) #f]
           [#:gradientUnits? gradientUnits? (or/c #f 'userSpaceOnUse 'objectBoundingBox) #f]
           [#:spreadMethod? spreadMethod? (or/c #f 'pad 'repeat 'reflect) #f]
         )
         string?]{
  cx, cy, fx, fy has value 0 - 100, means 0% - 100%, use them to justify gradient's position and direction.
}

@codeblock{
(svg-def-radial-gradient
  (list
    (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
    (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")))
}
@image{showcase/gradient/gradient2.svg}


