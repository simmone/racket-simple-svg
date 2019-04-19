#lang racket

(require "svg.rkt")

(provide (contract-out
          [with-output-to-svg (-> path-string? procedure? void?)]
          ))

(define (with-output-to-svg file_name write_proc)
  (call-with-output-file
      file_name #:exists 'replace
      (lambda (file)
        (parameterize 
         ([*svg* file])
         (dynamic-wind
             (labmda () (start-svg))
             (lambda () (write_proc))
             (lambda () (end-svg)))))))
