#lang scribble/manual

@(require "../../main.rkt")

@(require (for-label racket))
@(require (for-label "../../path/raw-path.rkt"))

@title{Raw Path}

draw path by raw data.

@defproc[(raw-path
          [width natural?]
          [height natural?]
          [data string?]
          [#:fill? fill? string?]
          [#:stroke-fill? stroke-fill? string?]
          [#:stroke-width? stroke-width? natural?]
          [#:stroke-linejoin? stroke-linejoin? string?]
        )
        void?]{
  draw a path by raw data.

  raw data normally come from other svg tools.

  raw path's size can't be calculated, so width and height is mandatory.
}

@codeblock{
  (raw-path
    240 166
    "M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021
    c-10.035,37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334
    c-0.765,0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731
    c0-9.78,7.93-17.71,17.71-17.71c0.787,0,1.552,0.042,2.317,0.149
    C39.238,37.084,80.419,9.083,129.702,9.083c49.24,0,90.379,27.937,100.414,65.228h0.021
    c0.298-0.021,0.617-0.021,0.914-0.021C240.831,74.29,248.761,82.22,248.761,92z"
    #:fill? "#7AA20D"
    #:stroke-fill? "#7AA20D"
    #:stroke-width? 9
    #:stroke-linejoin? "round")
}

@image{showcase/path/raw_path.svg}