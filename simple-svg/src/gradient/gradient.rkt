#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-def-gradient-stop (->* 
                                  (#:offset (integer-in 0 100)  #:color string?)
                                  (
                                   #:opacity? (between/c 0 1)
                                  )
                                  (list/c (integer-in 0 100) string? (between/c 0 1)))]
          [svg-def-lineargradient (->*
                 ((listof (list/c (integer-in 0 100) string? (between/c 0 1))))
                 (
                  #:x1? (or/c #f natural?)
                  #:y1? (or/c #f natural?)
                  #:x2? (or/c #f natural?)
                  #:y2? (or/c #f natural?)
                  #:gradientUnits? (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                  #:spreadMethod? (or/c #f 'pad 'repeat 'reflect)
                 )
                 string?)]
          ))

(define (svg-def-gradient-stop #:offset offset #:color color #:opacity? [opacity? 1])
  (list offset color opacity?))

(define (svg-def-lineargradient
         stop_list
         #:x1? [x1? #f]
         #:y1? [y1? #f]
         #:x2? [x2? #f]
         #:y2? [y2? #f]
         #:gradientUnits? [gradientUnits? #f]
         #:spreadMethod? [spreadMethod? #f]
         )

  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'lineargradient)
    (hash-set! properties_map 'stop_list stop_list)

    (when x1? (hash-set! properties_map 'x1 x1?))
    (when y1? (hash-set! properties_map 'y1 y1?))

    (when x2? (hash-set! properties_map 'x2 x2?))
    (when y2? (hash-set! properties_map 'y2 y2?))

    (when gradientUnits? (hash-set! properties_map 'gradientUnits gradientUnits?))

    (when spreadMethod? (hash-set! properties_map 'spreadMethod spreadMethod?))

    (hash-set! properties_map 'format-def
               (lambda (index linearGradient)
                 (with-output-to-string
                   (lambda()
                     (printf "    <linearGradient id=\"~a\" " index)
                     
                     (when (hash-has-key? linearGradient 'x1)
                       (printf "x1=\"~a\" " (hash-ref linearGradient 'x1)))

                     (when (hash-has-key? linearGradient 'y1)
                       (printf "y1=\"~a\" " (hash-ref linearGradient 'y1)))

                     (when (hash-has-key? linearGradient 'x2)
                       (printf "x2=\"~a\" " (hash-ref linearGradient 'x2)))

                     (when (hash-has-key? linearGradient 'y2)
                       (printf "y2=\"~a\" " (hash-ref linearGradient 'y2)))

                     (when (hash-has-key? linearGradient 'gradientUnits)
                       (printf "gradientUnits=\"~a\" " (hash-ref linearGradient 'gradientUnits)))

                     (when (hash-has-key? linearGradient 'spreadMethod)
                       (printf "spreadMethod=\"~a\" " (hash-ref linearGradient 'spreadMethod)))
                     
                     (printf ">\n")
                     
                     (let loop ([stops (hash-ref linearGradient 'stop_list)])
                       (when (not (null? stops))
                         (printf "      <stop offset=\"~a%\" stop-color=\"~a\" " (list-ref (car stops) 0) (list-ref (car stops) 1))
                         (when (not (= (list-ref (car stops) 2) 1))
                           (printf "stop-opacity=\"~a\" " (list-ref (car stops) 2)))
                         (printf "/>\n")
                         (loop (cdr stops))))
                     
                     (printf "    </linearGradient>")
                     ))))
    
    (let ([shape_index ((*add-shape*) properties_map)])
      ((*add-to-shape-def-list*) shape_index)
      
      shape_index)))
