#lang racket

(provide (contract-out
          [sstyle/c contract?]
          [sstyle-new (-> sstyle/c)]
          [sstyle-format (-> sstyle/c string?)]
          [sstyle-clone (-> sstyle/c sstyle/c)]
          [sstyle-set! (-> sstyle/c symbol? any/c void?)]
          [sstyle-get (-> sstyle/c symbol? any/c)]
          ))

(struct sstyle (
                fill
                fill-rule
                fill-opacity
                stroke
                stroke-width
                stroke-linecap
                stroke-linejoin
                stroke-miterlimit
                stroke-dasharray
                stroke-dashoffset
                translate
                rotate
                scale
                skewX
                skewY
                fill-gradient
                ) #:transparent #:mutable)

(define sstyle/c
  (struct/dc
   sstyle
     [fill string?]
     [fill-rule (or/c #f 'nonzero 'evenodd 'inerit)]
     [fill-opacity (or/c #f (between/c 0 1))]
     [stroke (or/c #f string?)]
     [stroke-width (or/c #f natural?)]
     [stroke-linecap (or/c #f 'butt 'round 'square 'inherit)]
     [stroke-linejoin (or/c #f 'miter 'round 'bevel)]
     [stroke-miterlimit (or/c #f (>=/c 1))]
     [stroke-dasharray (or/c #f string?)]
     [stroke-dashoffset (or/c #f natural?)]
     [translate (or/c #f (cons/c natural? natural?))]
     [rotate (or/c #f integer?)]
     [scale (or/c #f natural? (cons/c natural? natural?))]
     [skewX (or/c #f natural?)]
     [skewY (or/c #f natural?)]
     [fill-gradient (or/c #f string?)]
    ))

(define (sstyle-set! _sstyle key value)
  (cond
   [(eq? key 'fill) (set-sstyle-fill! _sstyle value)]
   [(eq? key 'fill-rule) (set-sstyle-fill-rule! _sstyle value)]
   [(eq? key 'fill-opacity) (set-sstyle-fill-opacity! _sstyle value)]
   [(eq? key 'stroke) (set-sstyle-stroke! _sstyle value)]
   [(eq? key 'stroke-width) (set-sstyle-stroke-width! _sstyle value)]
   [(eq? key 'stroke-linecap) (set-sstyle-stroke-linecap! _sstyle value)]
   [(eq? key 'stroke-linejoin) (set-sstyle-stroke-linejoin! _sstyle value)]
   [(eq? key 'stroke-miterlimit) (set-sstyle-stroke-miterlimit! _sstyle value)]
   [(eq? key 'stroke-dasharray) (set-sstyle-stroke-dasharray! _sstyle value)]
   [(eq? key 'stroke-dashoffset) (set-sstyle-stroke-dashoffset! _sstyle value)]
   [(eq? key 'translate) (set-sstyle-translate! _sstyle value)]
   [(eq? key 'rotate) (set-sstyle-rotate! _sstyle value)]
   [(eq? key 'scale) (set-sstyle-scale! _sstyle value)]
   [(eq? key 'skewX) (set-sstyle-skewX! _sstyle value)]
   [(eq? key 'skewY) (set-sstyle-skewY! _sstyle value)]
   [(eq? key 'fill-gradient) (set-sstyle-fill-gradient! _sstyle value)]
   ))

(define (sstyle-get _sstyle key)
  (cond
   [(eq? key 'fill) (sstyle-fill _sstyle)]
   [(eq? key 'fill-rule) (sstyle-fill-rule _sstyle)]
   [(eq? key 'fill-opacity) (sstyle-fill-opacity _sstyle)]
   [(eq? key 'stroke) (sstyle-stroke _sstyle)]
   [(eq? key 'stroke-width) (sstyle-stroke-width _sstyle)]
   [(eq? key 'stroke-linecap) (sstyle-stroke-linecap _sstyle)]
   [(eq? key 'stroke-linejoin) (sstyle-stroke-linejoin _sstyle)]
   [(eq? key 'stroke-miterlimit) (sstyle-stroke-miterlimit _sstyle)]
   [(eq? key 'stroke-dasharray) (sstyle-stroke-dasharray _sstyle)]
   [(eq? key 'stroke-dashoffset) (sstyle-stroke-dashoffset _sstyle)]
   [(eq? key 'translate) (sstyle-translate _sstyle)]
   [(eq? key 'rotate) (sstyle-rotate _sstyle)]
   [(eq? key 'scale) (sstyle-scale _sstyle)]
   [(eq? key 'skewX) (sstyle-skewX _sstyle)]
   [(eq? key 'skewY) (sstyle-skewY _sstyle)]
   [(eq? key 'fill-gradient) (sstyle-fill-gradient _sstyle)]
   ))

(define (sstyle-clone sv)
  (sstyle
   (sstyle-fill sv)
   (sstyle-fill-rule sv)
   (sstyle-fill-opacity sv)
   (sstyle-stroke sv)
   (sstyle-stroke-width sv)
   (sstyle-stroke-linecap sv)
   (sstyle-stroke-linejoin sv)
   (sstyle-stroke-miterlimit sv)
   (sstyle-stroke-dasharray sv)
   (sstyle-stroke-dashoffset sv)
   (sstyle-translate sv)
   (sstyle-rotate sv)
   (sstyle-scale sv)
   (sstyle-skewX sv)
   (sstyle-skewY sv)
   (sstyle-fill-gradient sv)
   ))

(define (sstyle-new)
  (sstyle
;; fill color
   "none"
;; fill-rule
   #f
;; fill-opacity
   #f
;; stroke color
   #f
;; stroke width
   #f
;; stroke-linecap
   #f
;; stroke-linejoin
   #f
;; stroke-miterlimit
   #f
;; stroke-dasharray
   #f
;; stroke-dashoffset
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
;; fill-gradient
   #f
   ))

(define (sstyle-format _sstyle)
  (with-output-to-string
    (lambda ()
      (cond
       [(sstyle-fill-gradient _sstyle)
        (printf "fill=\"url(#~a)\" " (sstyle-fill-gradient _sstyle))]
       [else
        (printf "fill=\"~a\" " (sstyle-fill _sstyle))])

      (when (sstyle-fill-rule _sstyle)
            (printf "fill-rule=\"~a\" " (sstyle-fill-rule _sstyle)))

      (when (sstyle-fill-opacity _sstyle)
            (printf "fill-opacity=\"~a\" " (sstyle-fill-opacity _sstyle)))


      (when (sstyle-stroke-width _sstyle)
            (printf "stroke-width=\"~a\" " (sstyle-stroke-width _sstyle))

            (when (sstyle-stroke _sstyle)
                  (printf "stroke=\"~a\" " (sstyle-stroke _sstyle)))

            (when (sstyle-stroke-linejoin _sstyle)
                  (printf "stroke-linejoin=\"~a\" " (sstyle-stroke-linejoin _sstyle)))

            (when (sstyle-stroke-linecap _sstyle)
                  (printf "stroke-linecap=\"~a\" " (sstyle-stroke-linecap _sstyle)))

            (when (sstyle-stroke-miterlimit _sstyle)
                  (printf "stroke-miterlimit=\"~a\" " (sstyle-stroke-miterlimit _sstyle)))

            (when (sstyle-stroke-dasharray _sstyle)
                  (printf "stroke-dasharray=\"~a\" " (sstyle-stroke-dasharray _sstyle)))

            (when (sstyle-stroke-dashoffset _sstyle)
                  (printf "stroke-dashoffset=\"~a\" " (sstyle-stroke-dashoffset _sstyle)))
            )
      
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

