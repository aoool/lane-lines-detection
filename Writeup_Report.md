#**Finding Lane Lines on the Road** 

###Author: Sergey Morozov

The goal of the project is to identify lane lines on images and on video streams. 
The implementation is provided in 
[`Lane_Lines_Detection.ipynb`](./Lane_Lines_Detection.ipynb) Jupyter notebook. 
Input images and videos are provided in [`img_src`](./img_src) and 
[`vid_src`](./vid_src) correspondingly. Resulting images and videos 
with detected lane lines are in [`img_dst`](./img_dst) and 
[`vid_dst`](./vid_dst) correspondingly. There is also [`README.md`](./README.md) 
with the description of how to run the code from Jupyter notebook.

---
### Program Description
Lane lines detecting pipeline consists of the following steps:
  - convert RGB image to grayscale;
  - apply Gaussian blur filter to the grayscaled image in order to suppress 
    noise and spurious gradients by averaging;
  - apply Canny edge detection to determine edges on the picture;
  - define a region of interest and make anything else black;
  - detect lines in the region of interest using Hough transformation;
  - prepare a black image on which lane lines will be drawn;
  - draw lines following the approach described below;
  - combine initial image with lane lines image to get the final result.

##### `draw_lines()` function
To get lines begining from the bottom of the image, the least squares 
algorithm was applied to the input set of points that define beginings and ends
of the lines (output of Hough transformation).
That was enough to correctly process all images and first videos. There was a
problem with the last video called `challenge.mp4`. There were a lot of edges 
detected by Canny algorithm so that it was needed to adjust threshould parameters.
That was not enough however, there was a need **not** to react 
immediately on substantial changes of the lines' positions. Function was modified 
to be aware of previous positions of lines and in case of substantial line's 
position change, change coordinates by a small fraction of the actually 
"requested" change. The last modification helped to "stabilize" lane lines 
in the `challenge.mp4` video.

### Reflection
##### Shortcommings
  - image processing could be faster;
  - lane lines detecting might be over-stabilized, i.e. will react only on a huge
    changes in the line's slope; there is no confidence that it will succeed
    in cases with a lot of sharp turns; but it should be checked first.

##### Improvements
  - Author was not fammiliar with `numpy` python library.
    Some calculations were done using pure python where vectorized operations 
    provided by aforementioned library could be applied instead. 
    Author believes that the usage of vectorized operations will slighlty 
    descrease a processing time.
  - For the roads with turns there is a need to detect curves, not just 
    lane lines. May be it will be enough just to split each line (left and right) to 
    two lines and then sharp turns may be handled better.
    
### Resulting Images
Few examples of images with detected lane lines:
[image1]: ./img_dst/solidWhiteCurve.jpg "solidWhiteCurve"
[image2]: ./img_dst/solidYellowCurve.jpg "solidYellowCurve"