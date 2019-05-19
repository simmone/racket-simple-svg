#lang racket

(require "path.rkt")

(provide (contract-out
          [svg-path-raw (-> natural? natural? string? void?)]
          ))

(define (svg-path-raw width height raw_data)
  ((*size-func*) (cons width height))

  ((*add-path*) raw_data))
