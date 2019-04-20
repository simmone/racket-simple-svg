#lang racket

(require "svg.rkt")

(provide (contract-out
          [with-output-to-svg (-> output-port? procedure? void?)]
          ))

(define (with-output-to-svg output_port write_proc)
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () (start-svg))
       (lambda () (write_proc))
       (lambda () (end-svg)))))
