#lang racket

(require racket/serialize)

(provide (contract-out
          [struct LINEAR-GRADIENT
                          (
                           (stops (listof (list/c (between/c 0 100) string? (between/c 0 1))))
                           (x1 (or/c #f number?))
                           (y1 (or/c #f number?))
                           (x2 (or/c #f number?))
                           (y2 (or/c #f number?))
                           (gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox))
                           (spreadMethod (or/c #f 'pad 'repeat 'reflect))
                           )
                          ]
          [new-linear-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:x1 (or/c #f number?)
                                      #:y1 (or/c #f number?)
                                      #:x2 (or/c #f number?)
                                      #:y2 (or/c #f number?)
                                      #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                      #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                      )
                                LINEAR-GRADIENT?)]
          [format-linear-gradient (-> string? LINEAR-GRADIENT? string?)]
          [struct RADIAL-GRADIENT
                          (
                           (stops (listof (list/c (between/c 0 100) string? (between/c 0 1))))
                           (cx (or/c #f (between/c 0 100)))
                           (cy (or/c #f (between/c 0 100)))
                           (fx (or/c #f (between/c 0 100)))
                           (fy (or/c #f (between/c 0 100)))
                           (r (or/c #f number?))
                           (gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox))
                           (spreadMethod (or/c #f 'pad 'repeat 'reflect))
                           )
                          ]
          [new-radial-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:cx (or/c #f (between/c 0 100))
                                      #:cy (or/c #f (between/c 0 100))
                                      #:fx (or/c #f (between/c 0 100))
                                      #:fy (or/c #f (between/c 0 100))
                                      #:r (or/c #f number?)
                                      #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                      #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                      )
                                RADIAL-GRADIENT?)]
          [format-radial-gradient (-> string? RADIAL-GRADIENT? string?)]
          ))

(serializable-struct LINEAR-GRADIENT (
                                 [stops #:mutable]
                                 [x1 #:mutable]
                                 [y1 #:mutable]
                                 [x2 #:mutable]
                                 [y2 #:mutable]
                                 [gradientUnits #:mutable]
                                 [spreadMethod #:mutable]
                                 )
                #:transparent
                )

(serializable-struct RADIAL-GRADIENT (
                                 [stops #:mutable]
                                 [cx #:mutable]
                                 [cy #:mutable]
                                 [fx #:mutable]
                                 [fy #:mutable]
                                 [r #:mutable]
                                 [gradientUnits #:mutable]
                                 [spreadMethod #:mutable]
                                 )
                #:transparent
                )

(define (new-linear-gradient stops
                             #:x1 [x1 #f]
                             #:y1 [y1 #f]
                             #:x2 [x2 #f]
                             #:y2 [y2 #f]
                             #:gradientUnits [gradientUnits #f]
                             #:spreadMethod [spreadMethod #f])
  (LINEAR-GRADIENT stops x1 y1 x2 y2 gradientUnits spreadMethod))

(define (format-linear-gradient shape_id gradient)
  (with-output-to-string
    (lambda ()
      (printf "    <linearGradient id=\"~a\" ~a>\n"
              shape_id
              (string-join
               (filter
                (lambda (a) (not (string=? a "")))
                (list
                 (if (LINEAR-GRADIENT-x1 gradient) (format "x1=\"~a\"" (~r (LINEAR-GRADIENT-x1 gradient))) "")
                 (if (LINEAR-GRADIENT-y1 gradient) (format "y1=\"~a\"" (~r (LINEAR-GRADIENT-y1 gradient))) "")
                 (if (LINEAR-GRADIENT-x2 gradient) (format "x2=\"~a\"" (~r (LINEAR-GRADIENT-x2 gradient))) "")
                 (if (LINEAR-GRADIENT-y2 gradient) (format "y2=\"~a\"" (~r (LINEAR-GRADIENT-y2 gradient))) "")
                 (if (LINEAR-GRADIENT-gradientUnits gradient) (format "gradientUnits=\"~a\"" (LINEAR-GRADIENT-gradientUnits gradient)) "")
                 (if (LINEAR-GRADIENT-spreadMethod gradient) (format "spreadMethod=\"~a\"" (LINEAR-GRADIENT-spreadMethod gradient)) "")))))
      
      (let loop ([stops (LINEAR-GRADIENT-stops gradient)])
        (when (not (null? stops))
          (printf "      <stop offset=\"~a%\" stop-color=\"~a\" "
                  (~r (list-ref (car stops) 0)) (list-ref (car stops) 1))

          (when (not (= (list-ref (car stops) 2) 1))
            (printf "stop-opacity=\"~a\" " (~r (list-ref (car stops) 2))))
          (printf "/>\n")
          (loop (cdr stops))))
      
      (printf "    </linearGradient>\n")
      )))

(define (new-radial-gradient stops
                             #:cx [cx #f]
                             #:cy [cy #f]
                             #:fx [fx #f]
                             #:fy [fy #f]
                             #:r  [r #f]
                             #:gradientUnits [gradientUnits #f]
                             #:spreadMethod [spreadMethod #f])
  (RADIAL-GRADIENT stops cx cy fx fy r gradientUnits spreadMethod))

(define (format-radial-gradient shape_id gradient)
  (with-output-to-string
    (lambda ()
      (printf "    <radialGradient id=\"~a\" ~a>\n"
              shape_id
              (string-join
               (filter
                (lambda (a) (not (string=? a "")))
                (list
                 (if (RADIAL-GRADIENT-cx gradient) (format "cx=\"~a\"" (~r (RADIAL-GRADIENT-cx gradient))) "")
                 (if (RADIAL-GRADIENT-cy gradient) (format "cy=\"~a\"" (~r (RADIAL-GRADIENT-cy gradient))) "")
                 (if (RADIAL-GRADIENT-fx gradient) (format "fx=\"~a\"" (~r (RADIAL-GRADIENT-fx gradient))) "")
                 (if (RADIAL-GRADIENT-fy gradient) (format "fy=\"~a\"" (~r (RADIAL-GRADIENT-fy gradient))) "")
                 (if (RADIAL-GRADIENT-r gradient) (format "r=\"~a\"" (RADIAL-GRADIENT-r gradient)) "")
                 (if (RADIAL-GRADIENT-gradientUnits gradient) (format "gradientUnits=\"~a\"" (RADIAL-GRADIENT-gradientUnits gradient)) "")
                 (if (RADIAL-GRADIENT-spreadMethod gradient) (format "spreadMethod=\"~a\"" (RADIAL-GRADIENT-spreadMethod gradient)) "")
                 ))))
      
      (let loop ([stops (RADIAL-GRADIENT-stops gradient)])
        (when (not (null? stops))
          (printf "      <stop offset=\"~a%\" stop-color=\"~a\" "
                  (~r (list-ref (car stops) 0)) (list-ref (car stops) 1))

          (when (not (= (list-ref (car stops) 2) 1))
            (printf "stop-opacity=\"~a\" " (~r (list-ref (car stops) 2))))
          (printf "/>\n")
          (loop (cdr stops))))
      
      (printf "    </radialGradient>\n")
      )))

