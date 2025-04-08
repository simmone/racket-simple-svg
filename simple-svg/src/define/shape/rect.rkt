#lang racket

(require racket/serialize)

(provide (contract-out
          [struct RECT
           (
            (width number?)
            (height number?)
            (radius_x (or/c #f number?))
            (radius_y (or/c #f number?))
            )
           ]
          [new-rect (->* (number? number?)
                         (
                          #:radius_x (or/c #f number?)
                          #:radius_y (or/c #f number?)
                         )
                         RECT?
                         )]
          [format-rect (-> string? RECT? string?)]
          ))

(serializable-struct RECT (
                        [width #:mutable]
                        [height #:mutable]
                        [radius_x #:mutable]
                        [radius_y #:mutable]
                        )
                  #:transparent
                  )

(define (new-rect width height #:radius_x [radius_x #f] #:radius_y [radius_y #f])
  (RECT width height radius_x radius_y))

(define (format-rect shape_id rect)
  (format "    <rect id=\"~a\" ~a />\n"
          shape_id
          (with-output-to-string
            (lambda ()
              (printf "width=\"~a\" height=\"~a\""
                      (RECT-width rect)
                      (RECT-height rect))
                             
              (when (and (RECT-radius_x rect) (RECT-radius_y rect))
                (printf " rx=\"~a\" ry=\"~a\""
                        (RECT-radius_x rect)
                        (RECT-radius_y rect)))
              ))))
