#lang scribble/manual

@title{Gradient}

@codeblock|{
(new-linear-gradient (->*
  ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
  (
   #:x1 (or/c #f number?)
   #:y1 (or/c #f number?)
   #:x2 (or/c #f number?)
   #:y2 (or/c #f number?)
   #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
   #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
   )
  LINEAR-GRADIENT?))
}|

  gradient combined by stop_list, each stop has 3 factor: offset, color, opacity.
  
  offset from 0 to 100, means the distance of the color gradient.

  use x1, y1, x2, y2 justify gradient's direction and position.

  default is from left to right, x1=0, y1=0, x2=100, y2=0.

@codeblock|{
(svg-out
 100 100
 (lambda ()
   (let ([rec_id (svg-def-shape (new-rect 100 100))]
         [gradient_id
          (svg-def-shape
            (new-linear-gradient
            '(
               (0 "#BBC42A" 1)
               (100 "#ED6E46" 1))))]
         [_sstyle (sstyle-new)])

      (set-SSTYLE-fill-gradient! _sstyle gradient_id)
      (svg-place-widget rec_id #:style _sstyle))))
}|
@image{showcase/gradient/linear_gradient.svg}

@codeblock|{
(new-radial-gradient (->*
  ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
  (
   #:cx (or/c #f (between/c 0 100))
   #:cy (or/c #f (between/c 0 100))
   #:fx (or/c #f (between/c 0 100))
   #:fy (or/c #f (between/c 0 100))
   #:r (or/c #f number?)
   #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
   #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
   )
  RADIAL-GRADIENT?))
}|

  cx, cy, fx, fy has value 0 - 100, means 0% - 100%, use them to justify gradient's position and direction.

@codeblock|{
(svg-out
 100 100
 (lambda ()
   (let ([rec_id (svg-def-shape (new-rect 100 100))]
         [gradient_id
          (svg-def-shape
           (new-radial-gradient
            '(
              (0 "#BBC42A" 1)
              (100 "#ED6E46" 1))))]
         [_sstyle (sstyle-new)])

     (set-SSTYLE-fill-gradient! _sstyle gradient_id)
     (svg-place-widget rec_id #:style _sstyle))))
}|
@image{showcase/gradient/radial_gradient.svg}
