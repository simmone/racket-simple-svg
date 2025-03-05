#lang racket

(require "rect.rkt"
         "circle.rkt"
         "ellipse.rkt"
         "line.rkt"
         "polygon.rkt"
         "polyline.rkt"
         "gradient.rkt"
         "filter.rkt"
         "view-box.rkt"
         "text.rkt"
         "path/path.rkt"
         "arrow.rkt"
         "marker.rkt"
         "group.rkt")

(provide (contract-out
          [struct SVG
                  (
                   (shape_id_count number?)
                   (group_id_count number?)
                   (width number?)
                   (height number?)
                   (view_box (or/c #f VIEW-BOX?))
                   (shape_define_map (hash/c string?
                                             (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                                                   POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?
                                                   BLUR-DROPDOWN? ARROW? MARKER?)))
                   (group_define_map (hash/c string? GROUP?))
                   (group_show_list (listof (cons/c string? (cons/c number? number?))))
                   )
                  ]
          [new-svg (-> number? number? (or/c #f VIEW-BOX?) SVG?)]
          [*SVG* (parameter/c (or/c #f SVG?))]
          ))

(define *SVG* (make-parameter #f))

(struct SVG (
             [shape_id_count #:mutable]
             [group_id_count #:mutable]
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
  (SVG 0 1 width height view_box (make-hash) (make-hash) '()))
