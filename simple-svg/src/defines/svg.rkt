#lang racket

(require "rect.rkt")
(require "circle.rkt")
(require "ellipse.rkt")
(require "line.rkt")
(require "polygon.rkt")
(require "polyline.rkt")
(require "gradient.rkt")
(require "view-box.rkt")
(require "text.rkt")
(require "path/path.rkt")
(require "group.rkt")

(provide (contract-out
          [struct SVG
                  (
                   (widget_id_count number?)
                   (width number?)
                   (height number?)
                   (view_box (or/c #f VIEW-BOX?))
                   (shape_define_map (hash/c string?
                                             (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                                                   POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?)))
                   (group_define_map (hash/c string? GROUP?))
                   (group_show_list (listof (cons/c string? (cons/c number? number?))))
                   )
                  ]
          [new-svg (-> number? number? (or/c #f VIEW-BOX?) SVG?)]
          [*SVG* (parameter/c (or/c #f SVG?))]
          ))

(define *SVG* (make-parameter #f))

(struct SVG (
             [widget_id_count #:mutable]
             [width #:mutable]
             [height #:mutable]
             [view_box #:mutable]
             [shape_define_map #:mutable]
             [group_define_map #:mutable]
             [group_show_list #:mutable]
             )
        #:transparent
        )

(define (new-svg width height view_box)
  (SVG 0 width height view_box (make-hash) (make-hash) '()))
