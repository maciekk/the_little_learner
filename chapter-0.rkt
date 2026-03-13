#lang racket

;; 3:6
(define pie 3.14)

;; 4:7
(define a-radius 8.4)

(define an-area
  (* pie
     (* a-radius a-radius)))

;; 5:10
(define area-of-circle
  (lambda (r)
    (* pie
       (* r r))))

;; 5:12
(define area-of-rectangle
  (lambda (width)
    (lambda (height)
      (* width height))))

;; 6:14
(define double-result-of-f
  (lambda (f)
    (lambda (z)
      (* 2 (f z)))))

;; 6:15
(define add3
  (lambda (x)
    (+ 3 x)))

;; 6:16
((double-result-of-f add3) 4)

;; 9:24
(define abs
  (lambda (x)
    (cond
      ((< x 0) (- 0 x))
      (else x))))

;; 9:26
(define silly-abs
  (lambda (x)
    (let ((x-is-negative (< x 0)))
      (cond
        (x-is-negative (- 0 x))
        (else x)))))

;; 11:34 & 11:37
(define remainder
  (lambda (x y)
    (cond
      ((< x y) x)
      (else (remainder (- x y) y)))))

;; 12:40
(define add
  (lambda (n m)
    (cond
      ((zero? m) n)
      ; this seems more natural...
      (else (add (add1 n) (sub1 m))))))

;; 14:49
; ... but this is form in book; I think this form was chosen (and that whole
; nonsense with (k + 1) + n -> (k + n) + 1, so as to introduce the "wrapper".
(define add
  (lambda (n m)
    (cond
      ((zero? m) n)
      ; this seems more natural...
      (else (add1 (add n) (sub1 m))))))


;; -- various tests
an-area
(area-of-circle 2)
((area-of-rectangle 3) 7)
((double-result-of-f sqrt) 9)
(abs -13)
(abs 7)
(silly-abs -13)
(silly-abs 7)
(remainder 13 4)
(add 3 7)
