#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-close (-> void?)]
          ))

(define (svg-path-close)
  ((*add-path*) (format "z")))
