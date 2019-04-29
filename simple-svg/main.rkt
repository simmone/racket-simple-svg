#lang racket

(require "svg.rkt")
(require "shapes/rect.rkt")

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
                  #:start_point pair?
                  #:radius pair?
                  )
                 void?)]
          ))
