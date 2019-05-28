#lang racket

(provide (struct-out sstyle))
 
(provide (contract-out
          [sstyle/c contract?]
          [sstyle-new (-> sstyle/c)]
          [sstyle-format (-> sstyle/c string?)]
          [sstyle-clone (-> sstyle/c sstyle/c)]
          ))

(struct sstyle (fill stroke stroke-width stroke-linejoin) #:transparent #:mutable)

(define sstyle/c
  (struct/dc
   sstyle
     [fill string?]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
    ))

(define (sstyle-clone sv)
  (sstyle
   (sstyle-fill sv)
   (sstyle-stroke sv)
   (sstyle-stroke-width sv)
   (sstyle-stroke-linejoin sv)))

(define (sstyle-new)
  (sstyle
;; fill color
   "none"
;; stroke color
   #f
;; stroke width
   #f
;; stroke-linejoin
   #f))

(define (sstyle-format _sstyle)
  (with-output-to-string
    (lambda ()
      (printf "fill=\"~a\" " (sstyle-fill _sstyle))

      (when (sstyle-stroke-width _sstyle)
            (printf "stroke-width=\"~a\" " (sstyle-stroke-width _sstyle))

            (when (sstyle-stroke _sstyle)
                  (printf "stroke=\"~a\" " (sstyle-stroke _sstyle)))

            (when (sstyle-stroke-linejoin _sstyle)
                  (printf "stroke-linejoin=\"~a\" " (sstyle-stroke-linejoin _sstyle))))
      )))

