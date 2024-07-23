#lang racket

(provide (contract-out
          [struct BLUR-DROPDOWN
                  (
                   (blur (or/c #f number?))
                   (dropdown_offset (or/c #f number?))
                   (dropdown_color (or/c #f string?))
                   )
                  ]
          [new-blur-dropdown (->*
                              ()
                              (
                               #:blur (or/c #f number?)
                               #:dropdown_offset (or/c #f number?)
                               #:dropdown_color (or/c #f number?)
                               )
                              BLUR-DROPDOWN?)]
          [format-blur-dropdown (-> string? BLUR-DROPDOWN? string?)]
          ))

(struct BLUR-DROPDOWN (
              [blur #:mutable]
              [dropdown_offset #:mutable]
              [dropdown_color #:mutable]
              )
        #:transparent
        )

(define (new-blur-dropdown 
         #:blur [blur 2]
         #:dropdown_offset [3 #f]
         #:dropdown_color ["black" #f])
  (BLUR-DROPDOWN blur dropdown_offset dropdown_color))

(define (format-blur-dropdown shape_id blur_dropdown)
  (with-output-to-string
    (lambda ()
      (printf "    <filter id=\"~a\">\n" shape_id)
      (printf "      <feGaussianBlur in=\"SourceAlpha\" stdDeviation=\"~a\"></feGaussianBlur>\n" (BLUR-DROPDOWN-blur blur_dropdown))
      (printf "      <feOffset dx=\"~a\" dy=\"~a\" result=\"offsetblur\"></feOffset>\n"
              (BLUR-DROPDOWN-dropdown_offset blur_dropdown)
              (BLUR-DROPDOWN-dropdown_offset blur_dropdown))
      (printf "      <feFlood flood-color=\"~a\"></feFlood>\n" (BLUR-DROPDOWN-dropdown_color blur_dropdown))
      (printf "      <feComposite in2=\"offsetblur\" operator=\"in\"></feComposite>\n")
      (printf "      <feMerge>\n")
      (printf "        <feMergeNode></feMergeNode>\n")
      (printf "        <feMergeNode in=\"SourceGraphic\"></feMergeNode>\n")
      (printf "      </feMerge>\n")
      (printf "    </filter>\n"))))



                     
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

