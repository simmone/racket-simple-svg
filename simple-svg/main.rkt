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

(provide (contract-out
          [svg-out (->* (procedure?)
                        (
                         #:width? natural?
                         #:height? natural?
                         #:padding? natural?
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         #:canvas? (or/c #f (list/c natural? string? string?))
                         )
                        string?)]
          [svg-use (->* (string?) 
                        (
                         #:at? (cons/c natural? natural?)
                         #:fill? string?
                         #:stroke? (cons/c natural? string?)
                        )
                        void?)]
          [svg-show-default (-> void?)]
          [svg-rect-def (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 string?)]
          [svg-circle-def (-> (cons/c natural? natural?) natural? string?)]
          [svg-ellipse-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          [svg-line-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          [svg-polygon-def (-> (listof (cons/c natural? natural?)) string?)]
          [svg-polyline-def (-> (listof (cons/c natural? natural?)) string?)]
          [svg-path-def (-> natural? natural? procedure? string?)]
          [svg-path-raw (-> string? void?)]
          ))
