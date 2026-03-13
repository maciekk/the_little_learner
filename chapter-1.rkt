#lang racket

(require malt)

; Turns out we can use λ directly in Racket, instead of `lambda` keyword; nice!

;; 21:9
(define line-initial
  (λ (x)
    (λ (w b)
      (let ((y (+ (* w x) b)))
        y))))

;; 22:11
(define line-shorter
  (λ (x)
    (λ (w b)
      (+ (* w x) b))))

;; 24:17
(define line-xs
  (tensor 2.0 1.0 4.0 3.0))

(define line-ys
  (tensor 1.8 1.2 4.2 3.3))

;; 26:25
(define line
  (λ (x)
    (λ (θ)
      (+ (* (ref θ 0) x)
         (ref θ 1)))))

;; -- testing
((line-initial 2) 2 0)
((line-shorter 2) 2 0)
; NOTE: it's NOT (2 0)... in that, '2' would be interpreted as a fn
((line 2) (list 2 0))

