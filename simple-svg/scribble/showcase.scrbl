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

