#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-line-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          ))

(define (svg-line-def start_point end_point)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'line)
    (hash-set! properties_map 'start_point start_point)
    (hash-set! properties_map 'end_point end_point)
    
    (hash-set! properties_map 'format-def
               (lambda (index line)
                 (format "    <line id=\"~a\" x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" />"
                         index
                         (car (hash-ref line 'start_point))
                         (cdr (hash-ref line 'start_point))
                         (car (hash-ref line 'end_point))
                         (cdr (hash-ref line 'end_point)))))

    (let ([max_width 0]
          [max_height 0])

      (let loop ([loop_points (list start_point end_point)])
        (when (not (null? loop_points))
              (when (> (caar loop_points) max_width) (set! max_width (caar loop_points)))
              (when (> (cdar loop_points) max_height) (set! max_height (cdar loop_points)))
              (loop (cdr loop_points))))

      (hash-set! properties_map 'max_width max_width)
      (hash-set! properties_map 'max_height max_height))

    ((*add-shape*) shape_id properties_map)))
