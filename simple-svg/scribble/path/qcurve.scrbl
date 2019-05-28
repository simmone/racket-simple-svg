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
        [path_style (sstyle-new)]
        [red_dot (svg-circle-def 5)]
        [dot_style (sstyle-new)])

        (set-sstyle-stroke! path_style "#333333")
        (set-sstyle-stroke-width! path_style 3)
        (svg-use-shape path path_style)

  (set-sstyle-fill! dot_style "red")
  (svg-use-shape red_dot dot_style #:at? '(10 . 60))
  (svg-use-shape red_dot dot_style #:at? '(60 . 10))
  (svg-use-shape red_dot dot_style #:at? '(110 . 60))
  (svg-use-shape red_dot dot_style #:at? '(160 . 110))
  (svg-use-shape red_dot dot_style #:at? '(210 . 60))

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
