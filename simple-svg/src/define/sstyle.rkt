#lang racket

(provide (contract-out
          [struct SSTYLE
                  (
                   (fill (or/c #f string?))
                   (fill-rule (or/c #f 'nonzero 'evenodd 'inerit))
                   (fill-opacity (or/c #f (between/c 0 1)))
                   (stroke (or/c #f string?))
                   (stroke-width (or/c #f number?))
                   (stroke-linecap (or/c #f 'butt 'round 'square 'inherit))
                   (stroke-linejoin (or/c #f 'miter 'round 'bevel))
                   (stroke-miterlimit (or/c #f (>=/c 1)))
                   (stroke-dasharray (or/c #f string?))
                   (stroke-dashoffset (or/c #f number?))
                   (translate (or/c #f (cons/c number? number?)))
                   (rotate (or/c #f number?))
                   (scale (or/c #f number? (cons/c number? number?)))
                   (skewX (or/c #f number?))
                   (skewY (or/c #f number?))
                   (fill-gradient (or/c #f string?))
                   )]
          [sstyle-new (-> SSTYLE?)]
          [sstyle-format (-> SSTYLE? string?)]
          ))

(struct SSTYLE (
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
                )
        #:transparent
        #:mutable)

(define (sstyle-new)
  (SSTYLE
   #f #f #f #f #f #f #f #f #f #f
   #f #f #f #f #f #f))

(define (sstyle-format _sstyle)
  (with-output-to-string
    (lambda ()
      (if (SSTYLE-fill-gradient _sstyle)
          (printf " fill=\"url(#~a)\"" (SSTYLE-fill-gradient _sstyle))
          (if (SSTYLE-fill _sstyle)
              (printf " fill=\"~a\"" (SSTYLE-fill _sstyle))
              (printf " fill=\"none\"")))

      (when (SSTYLE-fill-rule _sstyle)
        (printf " fill-rule=\"~a\"" (SSTYLE-fill-rule _sstyle)))

      (when (SSTYLE-fill-opacity _sstyle)
        (printf " fill-opacity=\"~a\"" (~r (SSTYLE-fill-opacity _sstyle))))

      (when (SSTYLE-stroke-width _sstyle)
        (printf " stroke-width=\"~a\"" (~r (SSTYLE-stroke-width _sstyle))))

      (when (SSTYLE-stroke _sstyle)
        (printf " stroke=\"~a\"" (SSTYLE-stroke _sstyle)))

      (when (SSTYLE-stroke-linejoin _sstyle)
        (printf " stroke-linejoin=\"~a\"" (SSTYLE-stroke-linejoin _sstyle)))

      (when (SSTYLE-stroke-linecap _sstyle)
        (printf " stroke-linecap=\"~a\"" (SSTYLE-stroke-linecap _sstyle)))

      (when (SSTYLE-stroke-miterlimit _sstyle)
        (printf " stroke-miterlimit=\"~a\"" (SSTYLE-stroke-miterlimit _sstyle)))

      (when (SSTYLE-stroke-dasharray _sstyle)
        (printf " stroke-dasharray=\"~a\"" (SSTYLE-stroke-dasharray _sstyle)))

      (when (SSTYLE-stroke-dashoffset _sstyle)
        (printf " stroke-dashoffset=\"~a\"" (~r (SSTYLE-stroke-dashoffset _sstyle))))
      
      (when (or
             (SSTYLE-translate _sstyle)
             (SSTYLE-rotate _sstyle)
             (SSTYLE-scale _sstyle)
             (SSTYLE-skewX _sstyle)
             (SSTYLE-skewY _sstyle)
             )
        (printf " transform=\"~a\""
                (string-join
                 (filter
                  (lambda (a) (not (string=? a "")))
                  (list
                   (if (SSTYLE-translate _sstyle)
                       (format "translate(~a ~a)"
                               (~r (car (SSTYLE-translate _sstyle)))
                               (~r (cdr (SSTYLE-translate _sstyle))))
                       "")
                   (if (SSTYLE-rotate _sstyle)
                       (format "rotate(~a)" (~r (SSTYLE-rotate _sstyle)))
                       "")
                   (if (SSTYLE-scale _sstyle)
                       (if (pair? (SSTYLE-scale _sstyle))
                           (format "scale(~a ~a)"
                                   (~r (car (SSTYLE-scale _sstyle)))
                                   (~r (cdr (SSTYLE-scale _sstyle))))
                           (format "scale(~a)" (~r (SSTYLE-scale _sstyle))))
                       "")
                   (if (SSTYLE-skewX _sstyle)
                       (format "skewX(~a)" (~r (SSTYLE-skewX _sstyle)))
                       "")
                   (if (SSTYLE-skewY _sstyle)
                       (format "skewY(~a)" (~r (SSTYLE-skewY _sstyle)))
                       ""))))))
      )))
