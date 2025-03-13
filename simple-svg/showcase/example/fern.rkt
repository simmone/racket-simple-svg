#lang racket

(require "../../main.rkt")
 
;;; calculate the end point
(define (get-end-point start_point #:length length #:deg deg #:precision precision)
  (let* ([end (make-polar length (* 2 pi (/ deg 360)))]
         [end_x (string->number (~r #:precision precision (+ (car start_point) (real-part end))))]
         [end_y (string->number (~r #:precision precision (+ (cdr start_point) (imag-part end))))])
    (cons end_x end_y)))

(let ([canvas_width 600]
      [canvas_height 600]
      [start_point '(300 . 50)]
      [start_length 120]
      [start_deg 100] ;100°
      [start_width 3]
      [step_width 0.86]
      [color "#5a5"]
      [min_length 0.5]
      [central_reduction 0.75]
      [lateral_reduction 0.35]
      [lateral_deg 80] ;80°
      [bend 5] ;5°
      [precision 0])
   
  (let ([svg_data
         (svg-out
          canvas_width canvas_height
          (lambda ()
            ;; same style in a group, reduce svg file size.
            ;; group same width lines to a list
            (let ([style_map (make-hash)])
              (let loop ([loop_start_point start_point]
                         [loop_length start_length]
                         [loop_deg start_deg]
                         [loop_width start_width])
                
                (when (>= (* central_reduction loop_length) min_length)
                  (let ([loop_end_point (get-end-point loop_start_point #:length loop_length #:deg loop_deg #:precision precision)])
                    ;; width -> listof (start_point, end_point)
                    (hash-set! style_map
                               loop_width
                               `(,@(hash-ref style_map loop_width '())
                                 ,(list
                                   (cons (car loop_start_point) (- canvas_height (cdr loop_start_point)))
                                   (cons (car loop_end_point) (- canvas_height (cdr loop_end_point))))))

                    ;; central branch
                    (loop
                     loop_end_point
                     (* loop_length central_reduction)
                     (- loop_deg bend)
                     (* loop_width step_width))
                    
                    ;; left branch
                    (loop
                     loop_end_point
                     (* loop_length lateral_reduction)
                     (- (+ loop_deg lateral_deg) bend)
                     (* loop_width step_width))

                    ;; right branch
                    (loop
                     loop_end_point
                     (* loop_length lateral_reduction)
                     (- (- loop_deg lateral_deg) bend)
                     (* loop_width step_width)))))

              ;; place all the lines to different groups
              (let loop-width ([widths (sort (hash->list style_map) > #:key car)])
                (when (not (null? widths))
                  (let ([_sstyle (sstyle-new)])
                    (set-SSTYLE-stroke! _sstyle color)
                    (set-SSTYLE-stroke-width! _sstyle (caar widths))

                    (let ([group_id
                           (svg-def-group
                            (lambda ()
                              (let loop-group ([point_pair_list (hash-ref style_map (caar widths) '())])
                                (when (not (null? point_pair_list))
                                  (let* ([line_start_point (first (car point_pair_list))]
                                         [line_end_point (second (car point_pair_list))]
                                         [line_id (svg-def-shape (new-line line_start_point line_end_point))])

                                    (svg-place-widget line_id)
                                    (loop-group (cdr point_pair_list)))))))])

                      (svg-place-widget group_id #:style _sstyle)))
                  
                  (loop-width (cdr widths)))))))])

    (with-output-to-file
        "fern.svg" #:exists 'replace
        (lambda () (display svg_data)))))
