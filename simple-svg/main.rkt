#lang racket

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

(provide (contract-out
          [svg-out (->* (natural? natural? procedure?)
                        (
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         )
                        string?)]
          [svg-use (->* (string?)
                        (
                         #:at? (or/c #f (cons/c natural? natural?))
                         #:fill? (or/c #f string?)
                         #:stroke? (or/c #f string?)
                         #:stroke-width? (or/c #f natural?)
                         #:stroke-linejoin? (or/c #f 'miter 'round 'bevel)
                        )
                        void?)]
          [svg-show-default (-> void?)]
          [svg-show (-> string? (cons/c natural? natural?) void?)]
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

