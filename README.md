Color Anomaly Detector
======================

Written as part of a class project on color anomaly detection for search and rescue purposes, this repository contains a number of Matlab implementations of common anomaly detection algorithm from literature on hyperspectral techniques, as well as our own algorithm (PCAG) selected to balance performance and computation time.

The full technical report on the project, including citations and evaluations of the different anomaly detection algorithms is available online at:

[Color Outlier Detection for Search and Rescue](http://www.nathanntg.com/writing/color-anomaly-detection.pdf)


Implemented hyperspectral algorithms
------------------------------------

The following hyperspectral algorithms are implemented in this repository:

* Global RX (`rxg`)
* Local RX (`rxl`)
* Dual Window-based Eigen Separation Transform (`dwest`)
* Nested Spatial Window-based Target Detection (`nswtd`)
* Multiple Window Nested Spatial Window-based Target Detection (`mwnswtd`)

Each function above takes a single argument representing the image as a Matlab double matrix with spectral intensities between 0 and 1.

Novel anomaly detection algorithms
----------------------------------

The following new algorithms are implemented in this repository:

* Principal Component Analysis Gaps (`pcag`)
* Multiple Window Principal Component Analysis Gaps (`mwpcag`)

Utility functions
-----------------

A few useful utility functions are implemented in this repository:

* `im_norm = normalize_image(im)` normalizes an image to be stored in a Matlab double matrix and discarding any transparency channel data.
* `[scene, target] = build_scene(file, num_anomalies, blended)` superimposes random anomalies (from an "anomalies" directory) onto a scene (from a "scenes" directory) in a random position and rotation, and with luminance matching to the surrounding pixels. Returns both the new scene (scene) and a target image (target), representing anomaly positions.
* `[tpr, fpr, th, auc] = roc_anomaly(target, out)` calculates the ROC curve for a particular anomaly detector output (out) based on the target image (target). Shows a plot and returns the true-positive rate (tpr), false-positive rate (fpr), thresholds (th) and area under the curve (auc).

Analysis scripts
----------------

* `run` evaluates the above algorithms over a number of scenes and color spaces in parallel (using `run_script`)
* `analyze` evaluates the output of the run function above across algorithms and colorspaces
* `analyze_environ` evaluates the output of the run function above across scene types (assuming consistently prefixed scene names)
* `performance` evaluates the execution time of the various algorithms

### Authors

**L. Nathan Perkins**

- <https://github.com/nathanntg>
- <http://www.nathanntg.com>

**Travis Marshall**
