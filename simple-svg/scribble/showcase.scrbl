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

