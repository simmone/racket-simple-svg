#lang racket

(require "lib/sstyle.rkt")
(require "svg.rkt")
(require "shapes/rect.rkt")
(require "shapes/circle.rkt")
(require "shapes/ellipse.rkt")
(require "shapes/line.rkt")
(require "shapes/polygon.rkt")
(require "shapes/polyline.rkt")
(require "path/path.rkt")
(require "path/raw-path.rkt")
(require "path/moveto.rkt")
(require "path/lineto.rkt")
(require "path/close-path.rkt")
(require "path/qcurve.rkt")
(require "path/ccurve.rkt")
(require "path/arc.rkt")

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
                              )
                              void?)]
          [svg-show-group (->* (string? sstyle/c)
                              (
                               #:at? (cons/c natural? natural?)
                              )
                              void?)]
          [svg-show-default (-> void?)]
          [new-sstyle (-> sstyle/c)]
          [format-sstyle (-> sstyle/c string?)]
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
          ))
