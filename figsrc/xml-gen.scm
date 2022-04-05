#| ---
 | title: Programmable XML from Scheme
 | author: Johan Hidding
 | ---
 | 
 | This Scheme script translates S-expressions to XML. This lets you use the
 | full (R6RS) Scheme language to generate any XML document. This script is
 | fully R6RS compatible, but it does use some libraries that are specific to
 | Guile, namely `(ice-9 format)` and `(ice-9 match)`.
 | 
 | ```bash
 | guile xml-gen.scm <<EOF | xmlindent -i 2
 | '((html)
 |   (h1) "Hello, World!" (/h1)
 |   (p) "This is translated into HTML." (/p)
 |   (/html))
 | EOF
 | ```
 | 
 | Gives output:
 | 
 | ```html
 | <html>
 |   <h1>
 |     Hello, World!
 |   </h1>
 |   <p>
 |     This is translated into HTML.
 |   </p>
 | </html>
 | ```
 | 
 | The input can be any number of Scheme expressions; they will be evaluated as
 | if contained in a `(begin ...)` block.
 | 
 | I use this to create programmable SVG documents. If you want to do anything
 | similar for a serious project, consider using something less hacky. The
 | upshot of this implementation is that it is extremely trivial in Scheme.
 | 
 |#
(import (rnrs)
        (rnrs eval)
        (ice-9 match)
        (ice-9 format))

(define (read-all)
  (do ((x (read) (read))
       (r '() (cons x r)))
      ((eof-object? x) (reverse r))))

(define (string-ends-with? c s)
  (eq? c (string-ref s (- (string-length s) 1))))

(define (keyword? obj)
  (and (symbol? obj) (string-ends-with? #\: (symbol->string obj))))

(define (keyword->string obj)
  (let ((str (symbol->string obj)))
    (substring str 0 (- (string-length str) 1))))

(define (kwargs->attrs lst)
  (let loop ((lst lst)
             (r   '()))
    (match lst
      (((? keyword? kw) arg . rest)
       (loop rest
             (cons (format #f "~a=\"~a\"" (keyword->string kw) arg) r)))
      (('/) (reverse (cons "/" r)))
      ((a . rest)
       (loop rest
             (cons (format #f "~a" a) r)))
      (()  (reverse r)))))

(define (xmlize expr)
  (match expr
    ((tag)           (string-append "<" (symbol->string tag) ">"))
    ((tag . kwargs)  (string-append "<" (symbol->string tag) " " (string-join (kwargs->attrs kwargs) " ") ">"))
    (a               a)))

(define (run code)
  (match code
    ((('import . <imports> ) . <program>)
     (eval (cons 'begin <program>)
           (apply environment '(rnrs) <imports>)))
    (<program>
     (eval (cons 'begin <program>)
           (environment '(rnrs))))))

(let* ((src  (read-all))
       (expr (run src)))
  (display (string-join (map xmlize expr) "\n")) (newline))
