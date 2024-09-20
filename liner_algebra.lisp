(defun swap-rows (matrix row1 row2)
  "Swap two rows in a matrix."
  (let ((temp (copy-seq (aref matrix row1))))
    (setf (aref matrix row1) (aref matrix row2))
    (setf (aref matrix row2) temp)))

(defun scale-row (matrix row scalar)
  "Multiply a row by a scalar."
  (let ((cols (array-dimensions matrix)))
    (dotimes (i (second cols))
      (setf (aref matrix row i) (* (aref matrix row i) scalar)))))

(defun add-multiple-row (matrix target-row source-row scalar)
  "Add a multiple of one row to another row."
  (let ((cols (array-dimensions matrix)))
    (dotimes (i (second cols))
      (setf (aref matrix target-row i)
            (+ (aref matrix target-row i)
               (* (aref matrix source-row i) scalar))))))

(defun row-reduce (matrix)
  "Perform row reduction (Gaussian elimination) on a matrix."
  (let ((rows (first (array-dimensions matrix)))
        (cols (second (array-dimensions matrix))))
    (loop for i from 0 to (1- rows) do
      (when (= (aref matrix i i) 0)
        (loop for j from (1+ i) to (1- rows) do
          (when (/= (aref matrix j i) 0)
            (swap-rows matrix i j)
            (return))))
      (let ((pivot (aref matrix i i)))
        (when (/= pivot 0)
          (scale-row matrix i (/ 1 pivot)))
        (loop for j from 0 to (1- rows) do
          (when (and (/= i j) (/= (aref matrix j i) 0))
            (add-multiple-row matrix j i (- (aref matrix j i))))))))
    matrix)

;; Test the row-reduction function with a sample matrix.
(let ((matrix (make-array '(3 3) :initial-contents '((2 1 1)
                                                     (4 -6 0)
                                                     (-2 7 2)))))
  (row-reduce matrix)
  matrix)
