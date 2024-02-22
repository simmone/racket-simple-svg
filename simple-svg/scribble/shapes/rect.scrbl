#lang scribble/manual

@title{Rectangle}

@codeblock|{
(new-rect (->* (number? number?)
               (  
                 #:radius_x (or/c #f number?)
                 #:radius_y (or/c #f number?)
               )))
}|

  use width and height to define a rectangle.

  optional radius_x, radius_y to specify a round corner.

@section{rect}

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([rec_id (svg-def-shape (new-rect 100 100))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget rec_id #:style _sstyle))))
}|
@image{showcase/shapes/rect/rect.svg}

@section{rect with start point(no padding)}

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([rec_id (svg-def-shape (new-rect 100 100))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget rec_id #:style _sstyle #:at '(50 . 50)))))
}|
@image{showcase/shapes/rect/rect_y.svg}

@section{rect with radius}

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([rec_id (svg-def-shape (new-rect 100 100 #:radius_x 5 #:radius_y 10))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget rec_id #:style _sstyle))))
}|
@image{showcase/shapes/rect/rect_radius.svg}

@section{multiple rect}

@codeblock|{
(svg-out
  150 150
  (lambda ()
    (let (
      [blue_rec_id (svg-def-shape (new-rect 150 150))]
      [_blue_sstyle (sstyle-new)]
      [green_rec_id (svg-def-shape (new-rect 100 100))]
      [_green_sstyle (sstyle-new)]
      [red_rec_id (svg-def-shape (new-rect 50 50))]
      [_red_sstyle (sstyle-new)])

      (set-SSTYLE-fill! _blue_sstyle "blue")
      (svg-place-widget blue_rec_id #:style _blue_sstyle)

      (set-SSTYLE-fill! _green_sstyle "green")
      (svg-place-widget green_rec_id #:style _green_sstyle #:at '(25 . 25))

      (set-SSTYLE-fill! _red_sstyle "red")
      (svg-place-widget red_rec_id #:style _red_sstyle #:at '(50 . 50)))))
}|

@image{showcase/shapes/rect/m_rect.svg}
