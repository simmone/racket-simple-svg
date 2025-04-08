#lang racket

(require "shape/rect.rkt"
         "shape/circle.rkt"
         "shape/ellipse.rkt"
         "shape/line.rkt"
         "shape/polygon.rkt"
         "shape/polyline.rkt"
         "shape/gradient.rkt"
         "shape/filter.rkt"
         "shape/text.rkt"
         "shape/path/path.rkt"
         "shape/arrow.rkt"
         "shape/marker.rkt"
         "view-box.rkt"
         "group.rkt")

(provide (contract-out
          [struct SVG
                  (
                   (shape_id_count number?)
                   (group_id_count number?)
                   (width number?)
                   (height number?)
                   (view_box (or/c #f VIEW-BOX?))
                   (serialized_to_shape_id_map (hash/c bytes? string?))
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
             [serialized_to_shape_id_map #:mutable]
             [group_define_map #:mutable]
             [group_show_list #:mutable]
             )
        #:transparent
        )

(define (new-svg width height view_box)
  (SVG 0 1 width height view_box (make-hash) (make-hash) '()))
