(import (rnrs)
        (ice-9 format))

(define style-sheet
  (call-with-input-file "style.css" get-string-all))

(define group-margin 5)

(define (group-box y height name content)
  `((g transform: ,(format #f "translate(~s,~s)" 0 y) class: "group-box")
    (rect x: 0 width: 500 y: 0 height: ,(- height group-margin) rx: 5 /)
    (text x: 12 y: 8 writing-mode: "tb" text-anchor: "start") ,name (/text)
    ,@content
    (/g)
   ))

`((?xml version: "1.0" standalone: "no" ?)
  (svg viewBox: "0 0 500 800" xmlns: "http://www.w3.org/2000/svg")
  (style) ,style-sheet (/style)
  ,@(group-box 0 100 "kernel"
    `((text font-size: 50 x: 250 y: 60 text-anchor: "middle") "Linux" (/text)
      (image href: "./tux.svg" x: 420 y: 5 height: 80 /)
    ))
  ,@(group-box 100 200 "libraries" '())
  ,@(group-box 300 200 "applications" '())
  ,@(group-box 500 200 "packages" '())
  ,@(group-box 700 100 "script"
     '((text font-family: "monospace" y: 30)
       (tspan x: 100) "import numpy as np" (/tspan)
       (tspan x: 100 dy: "1.2em") "from scipy import linalg" (/tspan)
       (tspan x: 100 dy: "1.2em") "M = np.array([[1, 2], [3, 4]])" (/tspan)
       (tspan x: 100 dy: "1.2em") "linalg.eig(M)" (/tspan)
       (/text)
    ))
  (/svg))