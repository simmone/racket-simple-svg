#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct MARKER
                  (
                   (type (or/c 'triangle1 'triangle2 'circle 'indent1 'indent2 'diamond1 'diamond2 'curve1 'curve2))
                   (size number?)
                   (x number?)
                   (shape string?)
                   )
                  ]
          [new-marker (->*
                       ((or/c 'triangle1 'triangle2 'circle 'indent1 'indent2 'diamond1 'diamond2 'curve1 'curve2))
                       (
                        #:size (or/c #f number?)
                               #:x (or/c #f number?)
                               )
                       MARKER?)]
          [format-marker (-> string? MARKER? string?)]
          ))

(serializable-struct MARKER (
                        [type #:mutable]
                        [size #:mutable]
                        [x #:mutable]
                        [shape #:mutable]
                        )
                #:transparent
                )

(define (new-marker type #:size [size #f] #:x [x #f])
  (cond
   [(eq? type 'triangle1)
    (MARKER type (if size size 6) (if x x 1) "<path d=\"M0,0 L10,5 L0,10 z\"")]
   [(eq? type 'triangle2)
    (MARKER type (if size size 6) (if x x 1) "<path d=\"M0,0 L15,5 L0,10 z\"")]
   [(eq? type 'circle)
    (MARKER type (if size size 6) (if x x 5) "<circle r=\"5\" cx=\"5\" cy=\"5\"")]
   [(eq? type 'indent1)
    (MARKER type (if size size 6) (if x x 4) "<path d=\"M0,0 L10,5 L0,10 L5,5 z\"")]
   [(eq? type 'indent2)
    (MARKER type (if size size 6) (if x x 4) "<path d=\"M0,0 L15,5 L0,10 L5,5 z\"")]
   [(eq? type 'diamond1)
    (MARKER type (if size size 6) (if x x 1) "<path d=\"M3,0 L10,5 L3,10 L0,5 z\"")]
   [(eq? type 'diamond2)
    (MARKER type (if size size 6) (if x x 1) "<path d=\"M3,0 L15,5 L3,10 L0,5 z\"")]
   [(eq? type 'curve1)
    (MARKER type (if size size 6) (if x x 2) "<path d=\"M0,0 L10,5 L0,10 C0,10 5,5 0,0 z\"")]
   [(eq? type 'curve2)
    (MARKER type (if size size 6) (if x x 2) "<path d=\"M0,0 L15,5 L0,10 C0,10 5,5 0,0 z\"")]
   ))

(define (format-marker shape_id marker)
  (with-output-to-string
    (lambda ()
      (printf "    <marker id=\"~a\" markerWidth=\"~a\" markerHeight=\"~a\" orient=\"auto-start-reverse\" viewBox=\"0 0 15 15\" refX=\"~a\" refY=\"5\" markerUnits=\"strokeWidth\">\n"
              shape_id
              (svg-precision (MARKER-size marker))
              (svg-precision (MARKER-size marker))
              (svg-precision (MARKER-x marker)))
      (printf "      ~a fill=\"context-stroke\" />\n" (MARKER-shape marker))
      (printf "    </marker>\n"))))
