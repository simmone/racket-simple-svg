#lang racket

(require "svg.rkt")
(require "shapes/rect.rkt")

(provide (contract-out
          [svg-out (->* (procedure?)
                        (
                         #:padding? natural?
                         #:width? (or/c #f natural?)
                         #:height? (or/c #f natural?)
                         #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                         #:canvas? (or/c #f (list/c natural? string? string?))
                         )
                        string?)]
          [svg-set-property (-> string? symbol? any/c void?)]
          [svg-use (->* (string?) (#:at? (cons/c natural? natural?)) void?)]
          [svg-show-default (-> void?)]
          [svg-rect-def (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 string?)]
          ))
