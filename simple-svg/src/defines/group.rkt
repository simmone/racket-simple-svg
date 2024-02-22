#lang racket

(require "sstyle.rkt")

(provide (contract-out
          [struct WIDGET
                  (
                   (id string?)
                   (at (or/c #f (cons/c number? number?)))
                   (style (or/c #f SSTYLE?))
                   )]
          [struct GROUP
                  (
                   (widget_list (listof WIDGET?))
                   )]
          [new-group (-> GROUP?)]
          [*GROUP* (parameter/c (or/c #f GROUP?))]          
          ))

(define *GROUP* (make-parameter #f))

(struct WIDGET (
                [id #:mutable]
                [at #:mutable]
                [style #:mutable]
                )
        #:transparent)

(struct GROUP (
              [widget_list #:mutable]
              )
        #:transparent)

(define (new-group)
  (GROUP '()))
