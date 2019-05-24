#lang racket
 
(provide (contract-out
          [struct display
                  (
                   (x natural?)
                   (y natural?)
                   (fill string?)
                   (stroke (or/c #f string?))
                   (stroke-width (or/c natural?))
                   (stroke-linejoin (or/c #f "miter" "round" "bevel"))
                   )]
          [new-display (-> display?)]))

(struct display (x y fill stroke stroke-width stroke-linejoin))

(define (new-display)
  (display 0 0 "none" #f #f #f))
