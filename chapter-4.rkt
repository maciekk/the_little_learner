#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-3.rkt"))
(require "chapter-3.rkt")

;; 80:23
(define revise
  (λ (f revs θ)
    (cond
      ((zero? revs) θ)
      (else
        (revise f (sub1 revs) (f θ))))))

;; 81:25
(revise
  (lambda (θ)
    (map (λ (p)
           (- p 3))
         θ))
  5 (list 1 2 3))

;; 83:31
(let ((α 0.01)
      (obj ((l2-loss line) line-xs line-ys)))
  (let ((f (λ (θ)
             (let ((gs (gradient-of obj θ)))
               (list
                (- (ref θ 0) (* α (ref gs 0)))
                (- (ref θ 1) (* α (ref gs 1))))))))
    (revise f 1000 (list 0.0 0.0))))

;; 88:44
(define revs 1000)
(define α 0.01)

;; 89:46
(define gradient-descent
  (λ (obj θ)
    (let ((f (λ (Θ)
               (map (λ (p g)
                      (- p (* α g)))
                    Θ
                    (gradient-of obj Θ)))))
      (revise f revs θ))))

;; 90:50
(gradient-descent
 ((l2-loss line) line-xs line-ys)
 (list 0.0 0.0))
