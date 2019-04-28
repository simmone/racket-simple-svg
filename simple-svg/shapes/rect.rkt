#lang racket

(require "../svg.rkt")

(provide (contract-out
          [rect (->* 
                 (natural? natural? string?)
                 (
                  #:start_point pair?
                  #:radius pair?
                  )
                 void?)]
          ))

(define (rect width height fill
              #:start_point [start_point '(0 . 0)]
              #:radius [radius '(0 . 0)])
  
  ((*size-func*) (+ (car start_point) width) (+ (cdr start_point) height))

  (fprintf (*svg*) "  <rect ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "width=\"~a\" height=\"~a\" fill=\"~a\" "
                       width height fill)

               (if (> (*padding*) 0)
                   (printf "x=\"~a\" y=\"~a\" " (+ (car start_point) (*padding*)) (+ (cdr start_point) (*padding*)))
                   (begin
                     (when (not (= (car start_point) 0)) (printf "x=\"~a\" " (car start_point)))
                     (when (not (= (cdr start_point) 0)) (printf "y=\"~a\" " (cdr start_point)))))

               (when (not (= (car radius) 0)) (printf "rx=\"~a\" " (car radius)))
               (when (not (= (cdr radius) 0)) (printf "ry=\"~a\" " (cdr radius)))))))

