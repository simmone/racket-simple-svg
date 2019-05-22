#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/qcurve.rkt"))

@title{svg-path-qcurve/qcurve*}

@image{showcase/path/qcurve.jpg}

use two control points to draw a Quadratic Bezier Curve.

@defproc[(svg-path-qcurve
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
        )
        void?]{
}

qcurve* use absolute position.

@codeblock{
(let ([path
        (svg-path-def
          (lambda ()
          (svg-path-moveto* '(10 . 60))
          (svg-path-qcurve* '(60 . 10) '(110 . 60))
          (svg-path-qcurve* '(160 . 110) '(210 . 60))))
        ]
      [red_dot (svg-circle-def 5)])

    (svg-use path
      #:stroke? "#333333"
      #:stroke-width? 3)

    (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
    (svg-use red_dot #:at? '(60 . 10) #:fill? "red")
    (svg-use red_dot #:at? '(110 . 60) #:fill? "red")
    (svg-use red_dot #:at? '(160 . 110) #:fill? "red")
    (svg-use red_dot #:at? '(210 . 60) #:fill? "red")

    (svg-show-default))
}

qcurve use relative position, relative to the start position.

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-qcurve '(50 . -50) '(100 . 0))
(svg-path-qcurve '(50 . 50) '(100 . 0))
}

little red pots show the control points.

@image{showcase/path/qcurve1.svg}
