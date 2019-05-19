#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/arc.rkt"))

@title{svg-path-arc/arc*}

define a elliptical arc.

the arc is a part of ellipse, through start and end point.

@image{showcase/path/arc.png}

@defproc[(svg-path-arc
           [point (cons/c integer? integer?)]
           [radius (cons/c natural? natural?)]
           [direction (or/c 'left_big 'left_small 'right_big 'right_small)]
           [size (cons/c natural? natural?)]
         )
         void?]{
  arc* is the absolute version.

  point is the end point.
  
  radius specify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.
  
  as the arc's size can't be calculated, so should set the arc size manully.
}

@codeblock{
(svg-out
  #:canvas? '(1 "red" "white")
  (lambda ()
    (let (
      [arc1
        (svg-path-def
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'left_big '(170 . 85))))]
      [arc2
        (svg-path-def
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small '(170 . 85))))]
      [arc3
        (svg-path-def
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big '(280 . 110))))]
      [arc4
        (svg-path-def
          (lambda ()
            (svg-path-moveto* '(130 . 45))
            (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small '(170 . 85))))]
      [red_dot (svg-circle-def 2)]
    )

  (svg-use arc1 #:stroke? "#ccccff" #:stroke-width? 3)
  (svg-use arc2 #:stroke? "green" #:stroke-width? 3)
  (svg-use arc3 #:stroke? "blue" #:stroke-width? 3)
  (svg-use arc4 #:stroke? "yellow" #:stroke-width? 3)

  (svg-use red_dot #:at? '(130 . 45) #:fill? "red")
  (svg-use red_dot #:at? '(170 . 85) #:fill? "red")

  (svg-show-default))))
}

@image{showcase/path/arc.svg}