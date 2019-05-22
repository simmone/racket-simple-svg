#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-polygon-def (-> (listof (cons/c natural? natural?)) string?)]
          ))

(define (svg-polygon-def points)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'polygon)
    (hash-set! properties_map 'points points)
    
    (hash-set! properties_map 'format-def
               (lambda (index line)
                 (format "    <polygon id=\"~a\" points=\"~a\" />"
                         index
                         (with-output-to-string
                           (lambda ()
                             (let loop ([loop_points points])
                               (when (not (null? loop_points))
                                     (printf "~a,~a" (caar loop_points) (cdar loop_points))
                                     (when (> (length loop_points) 1) (printf " "))
                                     (loop (cdr loop_points)))))))))

    ((*add-shape*) shape_id properties_map)))
