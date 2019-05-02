#lang racket

(require "svg.rkt")
(require "shapes/rect.rkt")
(require "shapes/circle.rkt")
(require "shapes/ellipse.rkt")
(require "shapes/line.rkt")
(require "shapes/polyline.rkt")
(require "shapes/polygon.rkt")
(require "path/raw-path.rkt")
(require "path/path.rkt")
(require "path/moveto.rkt")

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:padding? natural?
                                    #:width? (or/c #f natural?)
                                    #:height? (or/c #f natural?)
                                    #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                                    #:canvas? (or/c #f (list/c natural? string? string?))
                                    )
                                   void?)]
          [rect (->* 
                 (natural? natural? string?)
                 (
                  #:start_point? (or/c #f (cons/c natural? natural?))
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 void?)]
          [circle (-> (cons/c natural? natural?) natural? string? void?)]
          [ellipse (-> (cons/c natural? natural?) (cons/c natural? natural?) string? void?)]
          [line (-> (cons/c natural? natural?) (cons/c natural? natural?) string? natural? void?)]
          [polyline (-> (listof (cons/c natural? natural?)) string? natural? string? void?)]
          [polygon (-> (listof (cons/c natural? natural?)) string? void?)]
          [raw-path (->* 
                 (natural? natural? string?)
                 (
                  #:fill? string?
                  #:stroke-fill? string?
                  #:stroke-width? natural?
                  #:stroke-linejoin? string?
                  )
                 void?)]
          [path (->*
                 (procedure?)
                 (
                  #:fill? string?
                  #:stroke-fill? string?
                  #:stroke-width? natural?
                  #:stroke-linejoin? string?
                  )
                 void?)]
          [moveto (-> (cons/c natural? natural?) void?)]
          [moveto* (-> (cons/c natural? natural?) void?)]
          ))
