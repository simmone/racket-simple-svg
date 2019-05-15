#lang racket

(require "path.rkt")

(provide (contract-out
          [svg-path-raw (-> string? void?)]
          )

(define (svg-path-raw raw_data)
    ((*add-path*) raw_data))

