#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct POLYGON
                  (
                   (points (listof (cons/c number? number?)))
                   )
                  ]
          [new-polygon (-> (listof (cons/c number? number?)) POLYGON?)]
          [format-polygon (-> string? POLYGON? string?)]
          ))

(serializable-struct POLYGON (
                         [points #:mutable]
                         )
                #:transparent
                )

(define (new-polygon points)
  (POLYGON points)) 

(define (format-polygon shape_id polygon)
  (format "    <polygon id=\"~a\" points=\"~a\" />\n"
          shape_id
          (string-join
           (map
            (lambda (point)
              (format "~a,~a" (svg-precision (car point)) (svg-precision (cdr point))))
            (POLYGON-points polygon)))))
