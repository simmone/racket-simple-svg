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
(define pair cons)
(define pair-first car)
(define pair-second cdr)
 
;;;; ----- parameters -----
(define canvas-width 600)
(define canvas-height 600)
 
(define start-point '(300 . 50))
(define start-length 120)
(define start-deg 100) ;100°
(define start-width 3)
(define step-width 0.86)
(define color "#5a5")
 
(define min-length 0.5)
(define central-reduction 0.75)
(define lateral-reduction 0.35)
(define lateral-deg 80) ;80°
(define bend 5) ;5°
 
;;;; ----- create the svg -----
(define (svg-data)
  (svg-out
   canvas-width canvas-height
   (lambda ()
     ;; draw the stem
     (define end (end-point start-point #:length start-length #:deg start-deg))
     (make-line start-point end #:width start-width)
     ;; start the fern
     (fern end
           #:length start-length
           #:deg start-deg
           #:width start-width))))
 
;;; draw the fern
(define (fern start
              #:length prev-length
              #:deg prev-deg
              #:width prev-width)
 
  (define central-length (* central-reduction prev-length))
  (when (>= central-length min-length)
    (define new-width (* step-width prev-width))
    ;; central branch
    (define central-deg (- prev-deg bend))
    (define central-end (end-point start
                                   #:length central-length
                                   #:deg central-deg))
 
    (make-line start central-end #:width new-width)
 
    (fern central-end
          #:length central-length
          #:deg central-deg
          #:width new-width)
 
    ;; left branch
    (define left-length (* lateral-reduction prev-length))
    (define left-deg (- (+ prev-deg lateral-deg) bend))
    (define left-end (end-point start
                           #:length left-length
                           #:deg left-deg))
 
    (make-line start left-end #:width new-width)
 
    (fern left-end
          #:length left-length
          #:deg left-deg
          #:width new-width)
 
    ;; right branch
    (define right-length (* lateral-reduction prev-length))
    (define right-deg (- (- prev-deg lateral-deg) bend))
    (define right-end (end-point start
                           #:length right-length
                           #:deg right-deg))
 
    (make-line start right-end #:width new-width)
 
    (fern right-end
          #:length right-length
          #:deg right-deg
          #:width new-width)))
 
;;; calculate the end point
(define (end-point start #:length length #:deg deg)
  (define end (make-polar length (* 2 pi (/ deg 360))))
  (define end-x (+ (pair-first  start) (real-part end)))
  (define end-y (+ (pair-second start) (imag-part end)))
  (pair end-x end-y))
 
;;; create a line
(define (make-line start end  #:width [width 1])
  (define start-x (pair-first start))
  (define start-y (pair-second start))
  (define end-x (pair-first end))
  (define end-y (pair-second end))
  (define line_id (svg-def-shape (new-line (pair start-x (- canvas-height start-y))
                                           (pair end-x   (- canvas-height end-y)))))
  (define line-style (sstyle-new))
  (set-SSTYLE-stroke-width! line-style width)
  (set-SSTYLE-stroke! line-style color)
  (svg-place-widget line_id #:style line-style))
 
;;;; ----- write the svg data ------
(with-output-to-file
    "fern.svg" #:exists 'replace
  (lambda () (display (svg-data))))
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
;;                [filter_id (svg-def-shape (new-blur-dropdown))]
         )

     (set-SSTYLE-fill! background_circle_sstyle "white")
     (svg-place-widget background_circle_id #:style background_circle_sstyle #:at '(256.252 . 255.986))

     (set-SSTYLE-fill! blue_piece_sstyle "#3E5BA9")
     (svg-place-widget blue_piece_id #:style blue_piece_sstyle)
;;            (svg-place-widget blue_piece_id #:style blue_piece_sstyle #:filter_id filter_id)

     (set-SSTYLE-fill! left_red_piece_sstyle "#9F1D20")
     (svg-place-widget left_red_piece_id #:style left_red_piece_sstyle)
;;            (svg-place-widget left_red_piece_id #:style left_red_piece_sstyle #:filter_id filter_id)

     (set-SSTYLE-fill! bottom_red_piece_sstyle "#9F1D20")
     (svg-place-widget bottom_red_piece_id #:style bottom_red_piece_sstyle)
;;            (svg-place-widget bottom_red_piece_id #:style bottom_red_piece_sstyle #:filter_id filter_id)
     )))
}|

@image{showcase/example/logo.svg}

@image{showcase/example/logo_blur.svg}

