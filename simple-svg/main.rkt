#lang racket

(require "src/lib/sstyle.rkt")
(require "src/svg.rkt")
(require "src/shapes/rect.rkt")
(require "src/shapes/circle.rkt")
(require "src/shapes/ellipse.rkt")
(require "src/shapes/line.rkt")
(require "src/shapes/polygon.rkt")
(require "src/shapes/polyline.rkt")
(require "src/path/path.rkt")
(require "src/path/raw-path.rkt")
(require "src/path/moveto.rkt")
(require "src/path/lineto.rkt")
(require "src/path/close-path.rkt")
(require "src/path/qcurve.rkt")
(require "src/path/ccurve.rkt")
(require "src/path/arc.rkt")
(require "src/text/text.rkt")
(require "src/gradient/gradient.rkt")

(provide (struct-out sstyle))

(provide (contract-out
          [svg-out (->* (natural? natural? procedure?)
                        (
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         )
                        string?)]
          [svg-use-shape (->* (string? sstyle/c) 
                              (
                               #:at? (cons/c natural? natural?)
                               #:hidden? boolean?
                              )
                              void?)]
          [svg-show-group (->* (string? sstyle/c)
                              (
                               #:at? (cons/c natural? natural?)
                              )
                              void?)]
          [svg-show-default (-> void?)]
          [sstyle-new (-> sstyle/c)]
          [sstyle-format (-> sstyle/c string?)]
          [sstyle-clone (-> sstyle/c sstyle/c)]
          [svg-rect-def (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 string?)]
          [svg-circle-def (-> natural? string?)]
          [svg-ellipse-def (-> (cons/c natural? natural?) string?)]
          [svg-line-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          [svg-polygon-def (-> (listof (cons/c natural? natural?)) string?)]
          [svg-polyline-def (-> (listof (cons/c natural? natural?)) string?)]
          [svg-path-def (-> procedure? string?)]
          [svg-path-raw (-> string? void?)]
          [svg-path-lineto (-> (cons/c integer? integer?) void?)]
          [svg-path-lineto* (-> (cons/c integer? integer?) void?)]
          [svg-path-hlineto (-> integer? void?)]
          [svg-path-vlineto (-> integer? void?)]
          [svg-path-moveto (-> (cons/c integer? integer?) void?)]
          [svg-path-moveto* (-> (cons/c integer? integer?) void?)]
          [svg-path-close (-> void?)]
          [svg-path-qcurve (-> 
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            void?)]
          [svg-path-qcurve* (->
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             void?)]
          [svg-path-ccurve (-> 
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            void?)]
          [svg-path-ccurve* (->
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             void?)]
          [svg-path-arc (->
                (cons/c integer? integer?)
                (cons/c natural? natural?)
                (or/c 'left_big 'left_small 'right_big 'right_small)
                void?)]
          [svg-path-arc* (->
                 (cons/c integer? integer?)
                 (cons/c natural? natural?)
                 (or/c 'left_big 'left_small 'right_big 'right_small)
                 void?)]
          [svg-text-def (->* 
                 (string?)
                 (
                  #:font-size? (or/c #f natural?)
                  #:font-family? (or/c #f string?)
                  #:dx? (or/c #f integer?)
                  #:dy? (or/c #f integer?)
                  #:rotate? (or/c #f (listof integer?))
                  #:textLength? (or/c #f natural?)
                  #:kerning? (or/c #f natural? 'auto 'inherit)
                  #:letter-space? (or/c #f natural? 'normal 'inherit)
                  #:word-space? (or/c #f natural? 'normal 'inherit)
                  #:text-decoration? (or/c #f 'overline 'underline 'line-through)
                  #:path? (or/c #f string?)
                  #:path-startOffset? (or/c #f (integer-in 0 100))
                 )
                 string?)]
          [svg-def-gradient-stop (->* 
                                  (
                                   #:offset (integer-in 0 100)
                                   #:color string?
                                  )
                                  (
                                   #:opacity? (between/c 0 1)
                                  )
                                  (list/c (integer-in 0 100) string? (between/c 0 1)))]
          [svg-def-lineargradient (->*
                 ((listof (list/c (integer-in 0 100) string? (between/c 0 1))))
                 (
                  #:x1? (or/c #f natural?)
                  #:y1? (or/c #f natural?)
                  #:x2? (or/c #f natural?)
                  #:y2? (or/c #f natural?)
                  #:gradientUnits? (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                  #:spreadMethod? (or/c #f 'pad 'repeat 'reflect)
                 )
                 string?)]
          ))
