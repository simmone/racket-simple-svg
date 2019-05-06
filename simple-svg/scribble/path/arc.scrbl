#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/arc.rkt"))

@title{arc/arc*}

draw a elliptical arc.

the arc is a part of ellipse, through start and end point.

@image{showcase/path/arc.png}

@defproc[(arc
           [point (cons/c integer? integer?) void?]
           [radius (cons/c natural? natural?) void?]
           [direction (or/c 'left_big 'left_small 'right_big 'right_small)]
           [size (cons/c natural? natural?) void?]
         )
         void?]{
  arc* is the absolute version.

  point is the end point.
  
  radius spcify the ellipse's size.
  
  direction is a simplified large-arc-flag and sweep-flag's comibination.
  
  as the arc's size can't be calculated, so should set the arc size manully.
}

@codeblock{
(path
  #:stroke-fill? "#ccccff"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'left_big '(160 . 75))))

(path
  #:stroke-fill? "green"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'left_small '(160 . 75))))

(path
  #:stroke-fill? "blue"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'right_big '(280 . 110))))

(path
  #:stroke-fill? "yellow"
  #:stroke-width? 3
  (lambda ()
    (moveto* '(120 . 35))
    (arc* '(160 . 75) '(80 . 40) 'right_small '(160 . 75))))
}

@image{showcase/path/arc.svg}
