#lang racket

(provide (contract-out
          [struct MARKER
                  (
                   (type (or/c 'triangle 'circle 'indent 'diamond))
                   )
                  ]
          [new-marker (-> (or/c 'triangle 'circle 'indent 'diamond) MARKER?)]
          [format-marker (-> string? MARKER? string?)]
          ))

(struct MARKER (
              [type #:mutable]
              )
        #:transparent
        )

(define (new-marker type)
  (MARKER type))

(define (format-marker shape_id marker)
  (let* ([marker_shape
          (cond
           [(eq? (MARKER-type marker) 'triangle)
            "<path d=\"M 0 0 L 10 5 L 0 10 z\""]
           [(eq? (MARKER-type marker) 'circle)
            "<circle r=\"5\" cx=\"5\" cy=\"5\""]
           [(eq? (MARKER-type marker) 'indent)
            "<path d=\"M 0 0 L 10 5 L 0 10 L 5 5 z\""]
           [(eq? (MARKER-type marker) 'diamond)
            "<path d=\"M 3 0 L 10 5 L 3 10 L 0 5 z\""]
           )])
    
    (with-output-to-string
      (lambda ()
        (printf "    <marker id=\"~a\" markerWidth=\"4\" markerHeight=\"3\" orient=\"auto-start-reverse\" viewBox=\"0 0 10 10\" refX=\"5\" refY=\"5\" markerUnits=\"strokeWidth\">\n"
                shape_id)
        (printf "      ~a fill=\"context-stroke\" />\n" marker_shape)
        (printf "    </marker>\n")))))
