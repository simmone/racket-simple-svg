#lang racket

(require "../svg.rkt")

(provide (contract-out
          [rect (->* 
                 (natural? natural? string?)
                 (
                  #:x natural?
                      #:y natural?
                      #:rx natural?
                      #:ry natural?
                      )
                 void?)]
          ))

(define (rect width height fill
              #:x [x 0]
              #:y [y 0]
              #:rx [rx 0]
              #:ry [ry 0])

  (fprintf (*svg*) "  <rect ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "width=\"~a\" height=\"~a\" fill=\"~a\" "
                       width height fill)

               (when (not (= x 0)) (printf "x=\"~a\" " x))
               (when (not (= y 0)) (printf "y=\"~a\" " y))
               (when (not (= rx 0)) (printf "rx=\"~a\" " rx))
               (when (not (= ry 0)) (printf "ry=\"~a\" " ry))))))
                     
