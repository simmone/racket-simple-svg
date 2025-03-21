#lang racket

(require "../function.rkt")

(provide (contract-out
          [svg-gadget-table (->* ( (listof (listof string?)) )
                                 (
                                  #:col_width (listof (pair? natral? number?))
                                  #:row_ehgith (listof (pair? natral? number?))
                                  #:cell_margin_top number?
                                  #:cell_margin_left number?
                                  )
                                 string?)]
          ))

(define (svg-gadget-table matrix #:col_width [col_width 5] #:row_height [row_height 5] #:cell_margin_top [cell_margin_top 1] #:cell_margin_left [cell_margin_left 1])
  (svg-def-group
   (lambda ()
     (let loop ([loop_x 200]
                [loop_y 200]
                [loop_radius origin_radius])
       (when (> loop_radius 6)
         (let ([circle_id (hash-ref radius_to_circle_id_map loop_radius)])
           (svg-place-widget circle_id #:at (cons loop_x loop_y)))

         (loop (+ loop_x loop_radius) loop_y (/ loop_radius 2))
         (loop (- loop_x loop_radius) loop_y (/ loop_radius 2))
         (loop loop_x (+ loop_y loop_radius) (/ loop_radius 2))
         (loop loop_x (- loop_y loop_radius) (/ loop_radius 2)))))))
