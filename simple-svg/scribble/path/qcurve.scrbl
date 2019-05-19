#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/qcurve.rkt"))

@title{svg-path-qcurve/qcurve*}

@image{showcase/path/qcurve.jpg}

use two control points to draw a Quadratic Bezier Curve.

@defproc[(svg-path-qcurve
          [point1 (cons/c natural? natural?) void?]
          [point2 (cons/c natural? natural?) void?]
        )
        void?]{
}

qcurve* use absolute position.

@codeblock{
(let ([path
  (svg-path-def
    200 100
    (lambda ()
    (svg-path-moveto* '(0 . 50))
    (svg-path-qcurve* '(50 . 0) '(100 . 50))
    (svg-path-qcurve* '(150 . 100) '(200 . 50))))]
    [red_dot (svg-circle-def 2)])

    (svg-use path
      #:fill? "white"
      #:stroke? "#333333"
      #:stroke-width? 3)

      (svg-use red_dot #:at? '(0 . 50) #:fill? "red")
      (svg-use red_dot #:at? '(50 . 0) #:fill? "red")
      (svg-use red_dot #:at? '(100 . 50) #:fill? "red")
      (svg-use red_dot #:at? '(150 . 100) #:fill? "red")
      (svg-use red_dot #:at? '(200 . 50) #:fill? "red")

      (svg-show-default))
}

qcurve use relative position, relative to the start position.

@codeblock{
(svg-path-moveto* '(0 . 50))
(svg-path-qcurve '(50 . -50) '(100 . 0))
(svg-path-qcurve '(50 . 50) '(100 . 0))
}

little red pots show the control points.

@image{showcase/path/qcurve1.svg}
