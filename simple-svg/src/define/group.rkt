#lang racket

(require "widget.rkt")

(provide (contract-out
          [struct GROUP
                  (
                   (widget_list (listof WIDGET?))
                   )]
          [new-group (-> GROUP?)]
          [*GROUP* (parameter/c (or/c #f GROUP?))]          
          ))

(define *GROUP* (make-parameter #f))

(struct GROUP (
              [widget_list #:mutable]
              )
        #:transparent)

(define (new-group)
  (GROUP '()))
