#!/usr/local/bin/sbcl --script
(print "Hello, World!")

(print "Addition")

(print "(+ 3 ( * 2 4))")
(print (+ 3 ( * 2 4)))

(print "(ash 11 1)")
(print (ash 11 1))
(print "(ash 11 -1)")
(print (ash 11 -1))

(print "The Guess-My-Number Game")
(defparameter *small* 1)
(defparameter *big* 100)

(defun guess-my-number () 
  (ash (+ *small* *big*) -1 ))

(defun smaller ()
  (setf *big* (1- (guess-my-number)))
	(guess-my-number))

(defun bigger ()
  (setf *small* (1+ (guess-my-number)))
	(guess-my-number))

(print (guess-my-number))
(print (bigger))
(print (smaller))
(print (bigger))
