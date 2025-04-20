#lang scribble/manual

@title{Showcase}

@section{Empty Svg}

@codeblock|{
(svg-out
  20 20
  (lambda ()
    (void)))
}|

generated a empty svg only have a head part:

@verbatim{
<svg
    version="1.1"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    width="20" height="20"
    >
</svg>
}

@section{Five Circles}

@codeblock|{
(with-output-to-file
    "five_circles.svg" #:exists 'replace
    (lambda ()
      (printf
       "~a\n"
       (svg-out
        500 300
        (lambda ()
          (let ([circle1_sstyle (sstyle-new)]
                [circle2_sstyle (sstyle-new)]
                [circle3_sstyle (sstyle-new)]
                [circle4_sstyle (sstyle-new)]
                [circle5_sstyle (sstyle-new)]
                [circle_id (svg-def-shape (new-circle 60))]
                [filter_id (svg-def-shape (new-blur-dropdown))]
                )

            (set-SSTYLE-stroke! circle1_sstyle "rgb(11, 112, 191)")
            (set-SSTYLE-stroke-width! circle1_sstyle 12)

            (set-SSTYLE-stroke! circle2_sstyle "rgb(240, 183, 0)")
            (set-SSTYLE-stroke-width! circle2_sstyle 12)

            (set-SSTYLE-stroke! circle3_sstyle "rgb(0, 0, 0)")
            (set-SSTYLE-stroke-width! circle3_sstyle 12)

            (set-SSTYLE-stroke! circle4_sstyle "rgb(13, 146, 38)")
            (set-SSTYLE-stroke-width! circle4_sstyle 12)

            (set-SSTYLE-stroke! circle5_sstyle "rgb(214, 0, 23)")
            (set-SSTYLE-stroke-width! circle5_sstyle 12)

            (svg-place-widget circle_id #:style circle1_sstyle #:at '(120 . 120) #:filter_id filter_id)
            (svg-place-widget circle_id #:style circle2_sstyle #:at '(180 . 180) #:filter_id filter_id)
            (svg-place-widget circle_id #:style circle3_sstyle #:at '(260 . 120) #:filter_id filter_id)
            (svg-place-widget circle_id #:style circle4_sstyle #:at '(320 . 180) #:filter_id filter_id)
            (svg-place-widget circle_id #:style circle5_sstyle #:at '(400 . 120) #:filter_id filter_id)
            ))))))
}|
@image{showcase/example/five_circles.svg}

@section{Recursive Circle}

@codeblock|{
(let ([canvas_size 400])
  (with-output-to-file
      "recursive.svg" #:exists 'replace
      (lambda ()
        (printf "~a\n"
                (svg-out
                 canvas_size canvas_size
                 (lambda ()
                   (let ([_sstyle (sstyle-new)])
                     (set-SSTYLE-stroke! _sstyle "red")
                     (set-SSTYLE-stroke-width! _sstyle 1)

                     (letrec ([recur-circle 
                               (lambda (x y radius)
                                 (let ([circle_id (svg-def-shape (new-circle radius))])
                                   (svg-place-widget circle_id #:style _sstyle #:at (cons x y)))

                                 (when (> radius 8)
                                   (recur-circle (+ x radius) y (/ radius 2))
                                   (recur-circle (- x radius) y (/ radius 2))
                                   (recur-circle x (+ y radius) (/ radius 2))
                                   (recur-circle x (- y radius) (/ radius 2))))])
                       (recur-circle 200 200 100)))))))))
}|
@image{showcase/example/recursive.svg}

@section{Recursive Fern}

@verbatim|{Thanks to the author: Matteo d'Addio matteo.daddio@live.it}|

@codeblock|{
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
                  (let ([loop_end_point (get-end-point loop_start_point #:length loop_length #:deg loop_deg #:precision precision)]
                        [truncted_width (string->number (~r #:precision 2 loop_width))])

                    ;; width -> listof (start_point, end_point)
                    (hash-set! style_map
                               truncted_width
                               `(,@(hash-ref style_map truncted_width '())
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
}|
@image{showcase/example/fern.svg}

@section{Racket Logo}

@verbatim|{Use Home Page Logo's raw path, another add a little blur down effect.}|

@codeblock|{
(svg-out
 519.875 519.824
 (lambda ()
   (let ([background_circle_sstyle (sstyle-new)]
         [background_circle_id (svg-def-shape (new-circle 253.093))]
         [blue_piece_sstyle (sstyle-new)]
         [blue_piece_id
          (svg-def-shape
           (new-path
            (lambda ()
              (svg-path-raw
               (string-append
                "M455.398,412.197c33.792-43.021,53.946-97.262,53.946-156.211"
            	   "c0-139.779-113.313-253.093-253.093-253.093c-30.406,0-59.558,5.367-86.566,15.197"
                "C272.435,71.989,408.349,247.839,455.398,412.197z")
               ))))]
         [left_red_piece_sstyle (sstyle-new)]
         [left_red_piece_id
          (svg-def-shape
           (new-path
            (lambda ()
              (svg-path-raw
               (string-append
                "M220.003,164.337c-39.481-42.533-83.695-76.312-130.523-98.715"
	                     "C36.573,112.011,3.159,180.092,3.159,255.986c0,63.814,23.626,122.104,62.597,166.623"
	                     "C100.111,319.392,164.697,219.907,220.003,164.337z")
               ))))]
         [bottom_red_piece_sstyle (sstyle-new)]
         [bottom_red_piece_id
          (svg-def-shape
           (new-path
            (lambda ()
              (svg-path-raw
               (string-append
                "M266.638,221.727c-54.792,59.051-109.392,162.422-129.152,257.794"
	                     "c35.419,18.857,75.84,29.559,118.766,29.559c44.132,0,85.618-11.306,121.74-31.163"
                "C357.171,381.712,317.868,293.604,266.638,221.727z")
               ))))]
         )

     (set-SSTYLE-fill! background_circle_sstyle "white")
     (svg-place-widget background_circle_id #:style background_circle_sstyle #:at '(256.252 . 255.986))

     (set-SSTYLE-fill! blue_piece_sstyle "#3E5BA9")
     (svg-place-widget blue_piece_id #:style blue_piece_sstyle)

     (set-SSTYLE-fill! left_red_piece_sstyle "#9F1D20")
     (svg-place-widget left_red_piece_id #:style left_red_piece_sstyle)

     (set-SSTYLE-fill! bottom_red_piece_sstyle "#9F1D20")
     (svg-place-widget bottom_red_piece_id #:style bottom_red_piece_sstyle)
     )))
}|

@image{showcase/example/logo.svg}

