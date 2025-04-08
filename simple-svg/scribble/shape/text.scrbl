#lang scribble/manual

@title{Text}

@codeblock|{
(new-text (->*
           (string?)
           (
             #:font-size (or/c #f number?)
             #:font-family (or/c #f string?)
             #:dx (or/c #f number?)
             #:dy (or/c #f number?)
             #:rotate (or/c #f (listof number?))
             #:textLength (or/c #f number?)
             #:kerning (or/c #f number? 'auto 'inherit)
             #:letter-space (or/c #f number? 'normal 'inherit)
             #:word-space (or/c #f number? 'normal 'inherit)
             #:text-decoration (or/c #f 'overline 'underline 'line-through)
             #:path (or/c #f string?)
             #:path-startOffset (or/c #f (between/c 0 100))
  )
 TEXT?))
}|
  dx, dy: relative position.
  kerning, letter-space, word-space: all about letter and word spaces.

@codeblock|{
(svg-out
 310 70
 (lambda ()
   (let ([text_id (svg-def-shape (new-text "城春草木深" #:font-size 50))]
         [_sstyle (sstyle-new)])

         (set-SSTYLE-fill! _sstyle "#ED6E46")
         (svg-place-widget text_id #:style _sstyle #:at '(30 . 50)))))
}|
@image{showcase/text/text1.svg}

rotate: a list of rotate angles, it represent each letter's rotate, only one means each letter have same angle.

@codeblock|{
(svg-out
 350 120
 (lambda ()
   (let ([text_id (svg-def-shape (new-text "城春草木深" #:font-size 50 #:rotate '(10 20 30 40 50) #:textLength 300))]
         [_sstyle (sstyle-new)])

    (set-SSTYLE-fill! _sstyle "#ED6E46")
    (svg-place-widget text_id #:style _sstyle #:at '(30 . 60)))))
}|
@image{showcase/text/text2.svg}

@codeblock|{
(svg-out
 310 280
 (lambda ()
   (let (
         [text1_id (svg-def-shape (new-text "国破山河在" #:font-size 50 #:text-decoration 'overline))]
         [text2_id (svg-def-shape (new-text "国破山河在" #:font-size 50 #:text-decoration 'underline))]
         [text3_id (svg-def-shape (new-text "国破山河在" #:font-size 50 #:text-decoration 'line-through))]
         [_sstyle (sstyle-new)])
     (set-SSTYLE-fill! _sstyle "#ED6E46")

     (svg-place-widget text1_id #:style _sstyle #:at '(30 . 60))
     (svg-place-widget text2_id #:style _sstyle #:at '(30 . 160))
     (svg-place-widget text3_id #:style _sstyle #:at '(30 . 260)))))
}|
@image{showcase/text/text3.svg}

let text follow a path:
@codeblock|{
(svg-out
 500 100
 (lambda ()
   (let* ([path
             (svg-def-shape 
               (new-path
                 (lambda ()
                   (svg-path-moveto* '(10 . 60))
                   (svg-path-qcurve* '(110 . 10) '(210 . 60))
                   (svg-path-qcurve* '(310 . 110) '(410 . 60)))))]
          [path_sstyle (sstyle-new)]
          [text
            (svg-def-shape (new-text "国破山河在 城春草木深 感时花溅泪 恨别鸟惊心"
            #:path path
            #:path-startOffset 5))]
          [text_sstyle (sstyle-new)])

     (set-SSTYLE-fill! text_sstyle "#ED6E46")
     (svg-place-widget text #:style text_sstyle))))
}|
@image{showcase/text/text4.svg}