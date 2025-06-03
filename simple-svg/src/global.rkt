#lang racket

(provide (contract-out
          [*PRECISION* (parameter/c (or/c #f natural?))]
          ))

(define *PRECISION* (make-parameter #f))
