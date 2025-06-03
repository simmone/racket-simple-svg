#lang racket

(require racket/serialize
         "../../lib.rkt")

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
                                      #:dropdown_color (or/c #f string?)
                                      )
                              BLUR-DROPDOWN?)]
          [format-blur-dropdown (-> string? BLUR-DROPDOWN? string?)]
          ))

(serializable-struct BLUR-DROPDOWN (
                               [blur #:mutable]
                               [dropdown_offset #:mutable]
                               [dropdown_color #:mutable]
                               )
                #:transparent
                )

(define (new-blur-dropdown 
         #:blur [blur 2]
         #:dropdown_offset [dropdown_offset 3]
         #:dropdown_color [dropdown_color "black"])
  (BLUR-DROPDOWN blur dropdown_offset dropdown_color))

(define (format-blur-dropdown shape_id blur_dropdown)
  (with-output-to-string
    (lambda ()
      (printf "    <filter id=\"~a\">\n" shape_id)
      (printf "      <feGaussianBlur in=\"SourceAlpha\" stdDeviation=\"~a\"></feGaussianBlur>\n" (svg-precision (BLUR-DROPDOWN-blur blur_dropdown)))
      (printf "      <feOffset dx=\"~a\" dy=\"~a\" result=\"offsetblur\"></feOffset>\n"
              (svg-precision (BLUR-DROPDOWN-dropdown_offset blur_dropdown))
              (svg-precision (BLUR-DROPDOWN-dropdown_offset blur_dropdown)))
      (printf "      <feFlood flood-color=\"~a\"></feFlood>\n" (BLUR-DROPDOWN-dropdown_color blur_dropdown))
      (printf "      <feComposite in2=\"offsetblur\" operator=\"in\"></feComposite>\n")
      (printf "      <feMerge>\n")
      (printf "        <feMergeNode></feMergeNode>\n")
      (printf "        <feMergeNode in=\"SourceGraphic\"></feMergeNode>\n")
      (printf "      </feMerge>\n")
      (printf "    </filter>\n"))))
