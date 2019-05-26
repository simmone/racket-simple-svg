#lang racket

(provide (struct-out svgview))
 
(provide (contract-out
          [svgview/c contract?]
          [new-svgview (-> svgview/c)]
          [format-svgview (-> svgview/c string?)]
          [svgview-clone (-> svgview/c svgview/c)]
          ))

(struct svgview (pos fill stroke stroke-width stroke-linejoin) #:transparent #:mutable)

(define svgview/c
  (struct/dc
   svgview
     [pos (or/c #f (cons/c natural? natural?))]
     [fill string?]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
    ))

(define (svgview-clone sv)
  (svgview
   (svgview-pos sv)
   (svgview-fill sv)
   (svgview-stroke sv)
   (svgview-stroke-width sv)
   (svgview-stroke-linejoin sv)))

(define (new-svgview)
  (svgview
;; pos   
   #f
;; fill color
   "none"
;; stroke color
   #f
;; stroke width
   #f
;; stroke-linejoin
   #f))

(define (format-svgview _svgview)
  (with-output-to-string
    (lambda ()
      (when (svgview-pos _svgview)
        (printf "x=\"~a\" y=\"~a\" "
                (car (svgview-pos _svgview))
                (cdr (svgview-pos _svgview))))

      (printf "fill=\"~a\" " (svgview-fill _svgview))

      (when (svgview-stroke-width _svgview)
            (printf "stroke-width=\"~a\" " (svgview-stroke-width _svgview))

            (when (svgview-stroke _svgview)
                  (printf "stroke=\"~a\" " (svgview-stroke _svgview)))

            (when (svgview-stroke-linejoin _svgview)
                  (printf "stroke-linejoin=\"~a\" " (svgview-stroke-linejoin _svgview))))
      )))

