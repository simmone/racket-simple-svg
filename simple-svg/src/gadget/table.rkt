#lang racket

(provide (contract-out
          [svg-def-table (->* ( (listof (listof string?)) )
                              (
                               #:col_width (listof (pair? natral? number?))
                               #:row_ehgith (listof (pair? natral? number?))
                               #:cell_margin_top number?
                               #:cell_margin_left number?
                               )
                              string?)]
          ))

(define (svg-def-table matrix #:col_width [col_width 5] #:row_height [row_height 5] #:cell_margin_top [cell_margin_top 1] #:cell_margin_left [cell_margin_left 1])
  (svg-def-
