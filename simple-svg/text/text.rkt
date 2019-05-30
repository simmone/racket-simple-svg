#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-text-def (->*
                 (string?)
                 (
                  #:font-size? (or/c #f natural?)
                  #:font-family? (or/c #f string?)
                  #:dx? (or/c #f integer?)
                  #:dy? (or/c #f integer?)
                  #:rotate? (or/c #f (listof integer?))
                  #:textLength? (or/c #f natural?)
                  #:kerning? (or/c #f natural? 'auto 'inherit)
                  #:letter-space? (or/c #f natural? 'normal 'inherit)
                  #:word-space? (or/c #f natural? 'normal 'inherit)
                  #:text-decoration? (or/c #f 'overline 'underline 'line-through)
                 )
                 string?)]
          ))

(define (svg-text-def text
              #:font-size? [font-size? #f]
              #:font-family? [font-family? #f]
              #:dx? [dx? #f]
              #:dy? [dy? #f]
              #:rotate? [rotate? #f]
              #:textLength? [textLength? #f]
              #:kerning? [kerning? #f]
              #:letter-space? [letter-space? #f]
              #:word-space? [word-space? #f]
              #:text-decoration? [text-decoration? #f]
              )
  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'text)
    (hash-set! properties_map 'text text)

    (when font-size?
          (hash-set! properties_map 'font-size font-size?))

    (when font-family?
          (hash-set! properties_map 'font-family font-family?))

    (when dx?
          (hash-set! properties_map 'dx dx?))

    (when dy?
          (hash-set! properties_map 'dy dy?))

    (when rotate?
          (hash-set! properties_map 'rotate rotate?))

    (when textLength?
          (hash-set! properties_map 'textLength textLength?))

    (when kerning?
          (hash-set! properties_map 'kerning kerning?))

    (when letter-space?
          (hash-set! properties_map 'letter-space letter-space?))

    (when word-space?
          (hash-set! properties_map 'word-space word-space?))

    (when text-decoration?
          (hash-set! properties_map 'text-decoration text-decoration?))

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
                         (hash-ref text 'text))))

    ((*add-shape*) properties_map)))
