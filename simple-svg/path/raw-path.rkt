#lang racket

(require "../svg.rkt")

(provide (contract-out
          [raw-path (->* 
                 (natural? natural? string?)
                 (
                  #:fill? string?
                  #:stroke-fill? string?
                  #:stroke-width? natural?
                  #:stroke-linejoin? string?
                  )
                 void?)]
          ))

(define (raw-path width height raw_data
              #:fill? [fill? "red"]
              #:stroke-fill? [stroke-fill? "red"]
              #:stroke-width? [stroke-width? 1]
              #:stroke-linejoin? [stroke-linejoin? "round"])

  ((*size-func*) width height)

  (fprintf (*svg*) "  <path fill=\"~a\" stroke=\"~a\" stroke-width=\"~a\" stroke-linejoin=\"~a\"\n"
           fill? stroke-fill? stroke-width? stroke-linejoin?)
  
  (fprintf (*svg*) "        d=\"~a\" />\n" raw_data))

