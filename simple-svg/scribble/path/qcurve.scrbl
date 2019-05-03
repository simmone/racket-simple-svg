#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/qcurve.rkt"))

@title{qcurve/qcurve*}

@image{showcase/path/qcurve.jpg}

use two control points to draw a Quadratic Bezier Curve.

@defproc[(qcurve
          [point1 (cons/c natural? natural?) void?]
          [point2 (cons/c natural? natural?) void?]
        )
        void?]{
}

qcurve* use absolute position.

@codeblock{
  (path
    #:stroke-fill? "#333333"
    #:stroke-width? 3
    (lambda ()
      (moveto* '(0 . 50))
      (qcurve* '(50 . 0) '(100 . 50))
      (qcurve* '(150 . 100) '(200 . 50))))
}

qcurve use relative position, relative to the start position.

@codeblock{
  (path
    #:stroke-fill? "#333333"
    #:stroke-width? 3
    (lambda ()
      (moveto* '(0 . 50))
      (qcurve '(50 . -50) '(100 . 0))
      (qcurve '(50 . 50) '(100 . 0))))
}

little red pots show the control points.

@image{showcase/path/qcurve1.svg}
