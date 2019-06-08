#lang scribble/manual

@(require (for-label racket))
@(require (for-label simple-svg))

@title{Gradient}

@defproc[(svg-def-gradient-stop
           [#:offset offset (integer-in 0 100)]
           [#:color color string?]
           [#:opacity? opacity? (between/c 0 1) 1]
         )
         (list/c (integer-in 0 100) string? (between/c 0 1))]{
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
(let ([rec (svg-def-rect 100 100)]
      [gradient
        (svg-def-linear-gradient
          (list
            (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
            (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")
           ))]
     [_sstyle (sstyle-new)])
   (set-sstyle-fill-gradient! _sstyle gradient)
   (svg-use-shape rec _sstyle)
   (svg-show-default))
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
(let ([rec (svg-def-rect 100 100)]
      [gradient
       (svg-def-radial-gradient
        (list
         (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
         (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")
         ))]
      [_sstyle (sstyle-new)])
  (set-sstyle-fill-gradient! _sstyle gradient)
  (svg-use-shape rec _sstyle)
  (svg-show-default))
}
@image{showcase/gradient/gradient2.svg}
