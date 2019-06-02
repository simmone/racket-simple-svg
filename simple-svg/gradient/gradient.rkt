#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-def-gradient-stop (->* 
                                  (
                                   #:offset (integer-in 0 100)
                                   #:color string?
                                  )
                                  (
                                   #:opacity? (between-in 0 1)
                                  ))]
          [svg-def-lineargradient (->*
                 ((listof (cons/c (integer-in 0 100) string? (between-in 0 1))))
                 (
                  #:x1? (or/c #f natural?)
                  #:y1? (or/c #f natural?)
                  #:x2? (or/c #f natural?)
                  #:y2? (or/c #f natural?)
                 )
                 string?)]
          ))

(define (svg-def-gradient-stop #:offset offset #:color color #:opacity? [opacity? 1])
  (list offset color opacity))

(define (svg-def-lineargradient
         stop_list
         #:x1? [x1 0]
         #:y1? [y1 0]
         #:x2? [x2 100]
         #:y2? [y2 100])

  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'lineargradient)
    (hash-set! properties_map 'stop_list stop_list)

    (when x1? (hash-set! properties_map 'x1 x1?))
    (when y1? (hash-set! properties_map 'y1 y1?))

    (when x2? (hash-set! properties_map 'x2 x2?))
    (when y2? (hash-set! properties_map 'y2 y2?))

    (hash-set! properties_map 'format-def
               (lambda (index text)
                 (format "    <text id=\"~a\" ~a>~a</text>"
                         index
                         (with-output-to-string
                           (lambda ()
                             (when (hash-has-key? text 'dx)
                                   (printf "dx=\"~a\" " (hash-ref text 'dx)))

                             (when (hash-has-key? text 'dy)
                                   (printf "dy=\"~a\" " (hash-ref text 'dy)))

                             (when (hash-has-key? text 'font-size)
                                   (printf "font-size=\"~a\" " (hash-ref text 'font-size)))

                             (when (hash-has-key? text 'font-family)
                                   (printf "font-family=\"~a\" " (hash-ref text 'font-family)))

                             (when (hash-has-key? text 'rotate)
                                   (printf "rotate=\"~a\" " (foldr (lambda (a b) (format "~a ~a" a b)) "" (hash-ref text 'rotate))))

                             (when (hash-has-key? text 'textLength)
                                   (printf "textLength=\"~a\" " (hash-ref text 'textLength)))

                             (when (hash-has-key? text 'kerning)
                                   (printf "kerning=\"~a\" " (hash-ref text 'kerning)))

                             (when (hash-has-key? text 'letter-space)
                                   (printf "letter-space=\"~a\" " (hash-ref text 'letter-space)))

                             (when (hash-has-key? text 'word-space)
                                   (printf "word-space=\"~a\" " (hash-ref text 'word-space)))

                             (when (hash-has-key? text 'text-decoration)
                                   (printf "text-decoration=\"~a\" " (hash-ref text 'text-decoration)))

                             ))
                         (if (hash-has-key? text 'path)
                             (with-output-to-string
                              (lambda ()
                                (printf "\n      <textPath xlink:href=\"#~a\" " (hash-ref text 'path))
                                (when (hash-has-key? text 'path-startOffset)
                                  (printf "startOffset=\"~a%\" " (hash-ref text 'path-startOffset)))
                                (printf ">~a</textPath>\n    " (hash-ref text 'text))))
                             (hash-ref text 'text))
                         )))

    ((*add-shape*) properties_map)))
