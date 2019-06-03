#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../src/path/arc.rkt"))

@title{svg-path-arc/arc*}

define a elliptical arc.

the arc is a part of ellipse, through start and end point.

@image{showcase/path/arc.png}

@defproc[(svg-path-arc
           [point (cons/c integer? integer?)]
           [radius (cons/c natural? natural?)]
           [direction (or/c 'left_big 'left_small 'right_big 'right_small)]
         )
         void?]{
  arc* is the absolute version.

  point is the end point.
  
  radius specify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.
}

@codeblock{
(let (
      [arc1
        (svg-def-path
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'left_big)))]
      [arc2
        (svg-def-path
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small)))]
      [arc3
        (svg-def-path
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big)))]
      [arc4
        (svg-def-path
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small)))]
      [arc_style (sstyle-new)]
      [red_dot (svg-def-circle 5)]
      [dot_style (sstyle-new)]
     )

  (set-sstyle-stroke-width! arc_style 3)
               
  (let ([_arc_style (sstyle-clone arc_style)])
    (set-sstyle-stroke! _arc_style "#ccccff")
    (svg-use-shape arc1 _arc_style))

  (let ([_arc_style (sstyle-clone arc_style)])
    (set-sstyle-stroke! _arc_style "green")
    (svg-use-shape arc2 _arc_style))

  (let ([_arc_style (sstyle-clone arc_style)])
    (set-sstyle-stroke! _arc_style "blue")
    (svg-use-shape arc3 _arc_style))

  (let ([_arc_style (sstyle-clone arc_style)])
    (set-sstyle-stroke! _arc_style "yellow")
    (svg-use-shape arc4 _arc_style))

  (set-sstyle-fill! dot_style "red")
  (svg-use-shape red_dot dot_style #:at? '(130 . 45))
  (svg-use-shape red_dot dot_style #:at? '(170 . 85))

  (svg-show-default))
}
@image{showcase/path/arc.svg}
