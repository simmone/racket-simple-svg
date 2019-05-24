#lang racket
 
(provide (contract-out
          [struct display
                  (
                   (x (or/c #f natural?))
                   (y (or/c #f natural?))
                   (fill string?)
                   (stroke (or/c #f string?))
                   (stroke-width (or/c natural?))
                   (stroke-linejoin (or/c #f "miter" "round" "bevel"))
                   )]
          [default-display (-> display?)]
          [format-display (-> display? string?)]))

(struct display (x y fill stroke stroke-width stroke-linejoin #:transparent))

(define (default-display)
  (display
;; x   
   #f
;; y
   #f
;; fill color
   "none"
;; stroke color
   #f
;; stroke width
   #f
;; stroke-linejoin
   #f))

(define (format-display _display)
  (with-output-to-string
    (lambda ()
      (when (display-x _display) (printf "x=\"~a\" " (display-x _display)))

      (when (display-y _display) (printf "y=\"~a\" " (display-y _display)))

      (printf "fill=\"~a\" " (display-fill _display))

      (when (display-stroke-width _display)
            (printf "stroke-width=\"~a\" " (display-stroke-width _display))

            (when (display-stroke _display)
                  (printf "stroke=\"~a\" " (display-stroke _display)))

            (when (display-stroke-linejoin _display)
                  (printf "stroke-linejoin=\"~a\" " (display-stroke-linejoin _display))))
      )))

