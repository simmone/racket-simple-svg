#lang racket

(require "../svg.rkt")

(provide (contract-out
          [line (-> (cons/c natural? natural?) (cons/c natural? natural?) string? natural? void?)]
          ))

(define (line start_point end_point stroke_fill stroke_width)

  ((*size-func*) (car start_point) (cdr start_point))
  ((*size-func*) (car end_point) (cdr end_point))

  (fprintf (*svg*) "  <line ~a />\n"
           (with-output-to-string
             (lambda ()
               (printf "x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" stroke=\"~a\" stroke-width=\"~a\""
                       (+ (car start_point) (*padding*))
                       (+ (cdr start_point) (*padding*))
                       (+ (car end_point) (*padding*))
                       (+ (cdr end_point) (*padding*))
                       stroke_fill
                       stroke_width)))))

