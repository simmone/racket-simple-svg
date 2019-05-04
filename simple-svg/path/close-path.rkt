#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [close-path (-> void?)]
          ))

(define (close-path)
  ((*sequence-set*))

  (fprintf (*svg*) "           z\n"))
