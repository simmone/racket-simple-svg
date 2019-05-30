#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-text-def (->* 
                 (string?)
                 (
                  #:font-size? (or/c #f natural?)
                  #:font-family? (or/c #f string?)
                  #:dx? (or/c integer?)
                  #:dy? (or/c integer?)
                 )
                 string?)]
          ))

(define (svg-text-def text
              #:font-size? [font-size? #f]
              #:font-family? [font-family? #f]
              #:dx? [dx? #f]
              #:dy? [dy? #f]
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
                                   (printf "font-family=\"~a\" " (hash-ref text 'font-family)))))
                         (hash-ref text 'text))))

    ((*add-shape*) properties_map)))
