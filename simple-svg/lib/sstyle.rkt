#lang racket

(provide (struct-out sstyle))
 
(provide (contract-out
          [sstyle/c contract?]
          [sstyle-new (-> sstyle/c)]
          [sstyle-format (-> sstyle/c string?)]
          [sstyle-clone (-> sstyle/c sstyle/c)]
          ))

(struct sstyle (fill stroke stroke-width stroke-linejoin translate rotate scale skewX skewY) #:transparent #:mutable)

(define sstyle/c
  (struct/dc
   sstyle
     [fill string?]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
     [translate (or/c #f (cons/c natural? natural?))]
     [rotate (or/c #f integer?)]
     [scale (or/c #f natural? (cons/c natural? natural?))]
     [skewX (or/c #f natural?)]
     [skewY (or/c #f natural?)]
    ))

(define (sstyle-clone sv)
  (sstyle
   (sstyle-fill sv)
   (sstyle-stroke sv)
   (sstyle-stroke-width sv)
   (sstyle-stroke-linejoin sv)
   (sstyle-translate sv)
   (sstyle-rotate sv)
   (sstyle-scale sv)
   (sstyle-skewX sv)
   (sstyle-skewY sv)
   ))

(define (sstyle-new)
  (sstyle
;; fill color
   "none"
;; stroke color
   #f
;; stroke width
   #f
;; stroke-linejoin
   #f
;; translate
   #f
;; rotate
   #f
;; scale
   #f
;; skewX
   #f
;; skewY
   #f
   ))

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
      
      (when (or
             (sstyle-translate _sstyle)
             (sstyle-rotate _sstyle)
             (sstyle-scale _sstyle)
             (sstyle-skewX _sstyle)
             (sstyle-skewY _sstyle)
             )
            (printf "transform=\"")

            (when (sstyle-translate _sstyle)
                  (printf "translate(~a ~a) "
                          (car (sstyle-translate _sstyle))
                          (cdr (sstyle-translate _sstyle))))
            
            (when (sstyle-rotate _sstyle)
                  (printf "rotate(~a) " (sstyle-rotate _sstyle)))

            (when (sstyle-scale _sstyle)
                  (if (pair? (sstyle-scale _sstyle))
                      (printf "scale(~a ~a) "
                              (car (sstyle-scale _sstyle))
                              (cdr (sstyle-scale _sstyle)))
                      (printf "scale(~a) " (sstyle-scale _sstyle))))
            
            (when (sstyle-skewX _sstyle)
                  (printf "skewX(~a) " (sstyle-skewX _sstyle)))

            (when (sstyle-skewY _sstyle)
                  (printf "skewY(~a) " (sstyle-skewY _sstyle)))
            
            (printf "\""))
      )))

