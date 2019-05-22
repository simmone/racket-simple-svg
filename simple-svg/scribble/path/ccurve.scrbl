#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/ccurve.rkt"))

@title{svg-path-ccurve/ccurve*}

@image{showcase/path/ccurve.jpg}

use three control points to draw a Cubic Bezier Curve.

@defproc[(ccurve
          [point1 (cons/c natural? natural?)]
          [point2 (cons/c natural? natural?)]
          [point3 (cons/c natural? natural?)]
        )
        void?]{
}

ccurve* use absolute position.

@codeblock{
(let ([path
        (svg-path-def
          (lambda ()
            (svg-path-moveto* '(10 . 60))
            (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
            (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
          ))]
      [red_dot (svg-circle-def 5)])

      (svg-use path
        #:stroke? "#333333"
        #:stroke-width? 3)

      (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
      (svg-use red_dot #:at? '(30 . 15) #:fill? "red")
      (svg-use red_dot #:at? '(80 . 15) #:fill? "red")
      (svg-use red_dot #:at? '(100 . 60) #:fill? "red")
      (svg-use red_dot #:at? '(120 . 105) #:fill? "red")
      (svg-use red_dot #:at? '(170 . 105) #:fill? "red")
      (svg-use red_dot #:at? '(190 . 60) #:fill? "red")

      (svg-show-default))
}

ccurve use relative position, relative to the start position.

@codeblock{
(svg-path-moveto* '(10 . 60))
(svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
(svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
}

little red pots show the control points.

@image{showcase/path/ccurve1.svg}
