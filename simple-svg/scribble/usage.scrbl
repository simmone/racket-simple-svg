#lang scribble/manual

@title{Usage}

@section{Basic steps to use simple-svg}

1. use svg-out to define a canvas and a lambda to define all the things, at the end, output complete svg string.

2. all svg defines shoud be included in the lambda.

3. use svg-def-shape and new-* create a shape with basic properties.

4. use sstyle-new and set-SSTYLE-* define a new style.

5. if needed, use svg-def-group to combine a more complicated pattern.

6. use svg-place-widget to show a shape or a group at specific postion and style.

Define a basic widget(shape or group), Place it at some place with some style one or many times.

@section{Basic: Empty Svg}

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

@section{Example: Recursive Circle}

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

@section{Example: Recursive Fern}

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
(define start-grad 100)
(define width 2)
(define start-color "#5a5")

(define min-length 0.5)
(define central-reduction 0.75)
(define lateral-reduction 0.35)
(define lateral-grad 80) ;80°
(define bend 5) ;5°

;;;; ----- create the svg -----
(define (svg-data)
  (svg-out
   canvas-width canvas-height
   (lambda ()
     ;; draw the stem
     (define end (end-point start-point #:length start-length #:grad start-grad))
     (make-line start-point end #:color start-color)
     ;; start the fern
     (fern end
           #:length start-length
           #:grad start-grad
           #:color start-color))))

;;; draw the fern
(define (fern start
              #:length prev-length
              #:grad prev-grad
              #:color prev-color)
  
  (define central-length (* central-reduction prev-length))
  (when (>= central-length min-length)
    ;; central branch
    (define central-grad (- prev-grad bend))
    (define central-end (end-point start
                                   #:length central-length
                                   #:grad central-grad))
    
    (make-line start central-end #:color prev-color)
    
    (fern central-end
          #:length central-length
          #:grad central-grad
          #:color prev-color)

    ;; left branch
    (define left-length (* lateral-reduction prev-length))
    (define left-grad (- (+ prev-grad lateral-grad) bend))
    (define left-end (end-point start
                           #:length left-length
                           #:grad left-grad))
    
    (make-line start left-end #:color prev-color)
    
    (fern left-end
          #:length left-length
          #:grad left-grad
          #:color prev-color)
    
    ;; right branch
    (define right-length (* lateral-reduction prev-length))
    (define right-grad (- (- prev-grad lateral-grad) bend))
    (define right-end (end-point start
                           #:length right-length
                           #:grad right-grad))
    
    (make-line start right-end #:color prev-color)
    
    (fern right-end
          #:length right-length
          #:grad right-grad
          #:color prev-color)))

;;; calculate the end point
(define (end-point start #:length length #:grad grad)
  (define end (make-polar length (* 2 pi (/ grad 360))))
  (define end-x (+ (pair-first  start) (real-part end)))
  (define end-y (+ (pair-second start) (imag-part end)))
  (pair end-x end-y))

;;; create a line
(define (make-line start end #:color [color "#000"])
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

'done
}|
@image{showcase/example/fern.svg}

@section{Basic Function}

@codeblock|{
(svg-out (->* (positive? positive? procedure?)
           (
             #:viewBox (or/c #f VIEW-BOX?)
           )
           string?
           ))
}|

  specify width and height manully.
  
  viewBox: use (new-view-box x y width height) to create a view-box, if needed.

@codeblock|{
  (svg-def-shape (-> (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                           POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?)
                           string?))
}|

  deinfe a shape, each shape has its create function.

@codeblock|{
 (svg-def-group (-> procedure? void?))
}|
  create a group if needed.

  all svg actions in procedure will be added to the group.

@codeblock|{
  [svg-place-widget (->* (string?)
                         (
                          #:style SSTYLE?
                          #:at (cons/c (not/c negative?) (not/c negative?))
                         )
                         void?)]
}|
  place a widget(shape or group) in current group.

  specify a style and a postion, if no position, default to '(0 . 0)

@section{basic usage}

define shape first, then reuse shape and style in group(s).

@codeblock|{
(svg-out
  100 100
  (lambda ()
    (let ([rec_id (svg-def-shape (new-rect 100 100))]
          [_sstyle (sstyle-new)])
      (set-SSTYLE-fill! _sstyle "#BBC42A")
      (svg-place-widget rec_id #:style _sstyle))))
}|

@image{showcase/shapes/rect/rect.svg}

@section{multiple shapes}

@codeblock|{
(svg-out
  150 150
  (lambda ()
    (let (
      [blue_rec_id (svg-def-shape (new-rect 150 150))]
      [_blue_sstyle (sstyle-new)]
      [green_rec_id (svg-def-shape (new-rect 100 100))]
      [_green_sstyle (sstyle-new)]
      [red_rec_id (svg-def-shape (new-rect 50 50))]
      [_red_sstyle (sstyle-new)])

      (set-SSTYLE-fill! _blue_sstyle "blue")
      (svg-place-widget blue_rec_id #:style _blue_sstyle)

      (set-SSTYLE-fill! _green_sstyle "green")
      (svg-place-widget green_rec_id #:style _green_sstyle #:at '(25 . 25))

      (set-SSTYLE-fill! _red_sstyle "red")
      (svg-place-widget red_rec_id #:style _red_sstyle #:at '(50 . 50)))))
}|
@image{showcase/shapes/rect/m_rect.svg}

@section{use group}

@codeblock|{
(svg-out
  220 280
  (lambda ()
    (let (
      [line1_id (svg-def-shape (new-line '(0 . 0) '(30 . 30)))]
      [line2_id (svg-def-shape (new-line '(0 . 15) '(30 . 15)))]
      [line3_id (svg-def-shape (new-line '(15 . 0) '(15 . 30)))]
      [line4_id (svg-def-shape (new-line '(30 . 0) '(0 . 30)))]
      [_sstyle (sstyle-new)]
      [group_sstyle (sstyle-new)])

      (set-SSTYLE-stroke-width! _sstyle 5)
      (set-SSTYLE-stroke! _sstyle "#765373")
      (let ([pattern_id 
        (svg-def-group
          (lambda ()
            (svg-place-widget line1_id #:style _sstyle #:at '(5 . 5))
            (svg-place-widget line2_id #:style _sstyle #:at '(5 . 5))
            (svg-place-widget line3_id #:style _sstyle #:at '(5 . 5))
            (svg-place-widget line4_id #:style _sstyle #:at '(5 . 5))))])

      (svg-place-widget pattern_id #:at '(50 . 50))
      (svg-place-widget pattern_id #:at '(100 . 100))
      (svg-place-widget pattern_id #:at '(80 . 200))
      (svg-place-widget pattern_id #:at '(150 . 100))))))
}|
@image{showcase/group/group1.svg}