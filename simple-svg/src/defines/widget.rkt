#lang racket

(require "sstyle.rkt")

(provide (contract-out
          [struct WIDGET
                  (
                   (id string?)
                   (at (or/c #f (cons/c number? number?)))
                   (style (or/c #f SSTYLE?))
                   (filter_id (or/c #f string?))
                   (marker_start_id (or/c #f string?))
                   (marker_mid_id (or/c #f string?))
                   (marker_end_id (or/c #f string?))
                   )]
          ))

(struct WIDGET (
                [id #:mutable]
                [at #:mutable]
                [style #:mutable]
                [filter_id #:mutable]
                [marker_start_id #:mutable]
                [marker_mid_id #:mutable]
                [marker_end_id #:mutable]
                )
        #:transparent)
