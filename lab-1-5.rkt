#lang racket

(require (for-syntax syntax/parse))

; Exercise 5. You might have gotten tired of writing

; (define-syntax (f stx)
;   (syntax-parse stx ...))

; If so, you have what it takes to recognize when a
; language extension is called for. If not, you should
; solve some more of the exercises.
; Develop define-rewrite-rule, which accepts a syntax
; pattern and a syntax template and then synthesizes an
; appropriate combination of define-syntax and syntax-parse.


(define-syntax (define-rewrite-rule stx)
  (syntax-parse stx
    [(_ (the-name pattern) template)
     #'(define-syntax (the-name stx)
         (syntax-parse stx
           [(_ pattern) #'template]))]))

(define-rewrite-rule
  (loop-for-ever exp)
  ; ->
  (local ((define (for-ever) (begin exp (for-ever)))) (for-ever)))
 
(loop-for-ever (println "infinity"))