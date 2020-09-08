#
# Copyright 2020 (c) Pointwise, Inc.
# All rights reserved.
# 
# This sample Pointwise script is not supported by Pointwise, Inc.
# It is provided freely for demonstration purposes only.  
# SEE THE WARRANTY DISCLAIMER AT THE BOTTOM OF THIS FILE.
#

###############################################################################
##
## CalcAngleFromPoints.glf
##
## Script to determine the angle between three points
##
###############################################################################

package require PWI_Glyph

if { ! [pw::Application isInteractive] } {
  puts "This script can only be run interactively."
  exit 1
}

set ::Rad2Deg [expr 180.0 / (atan(1) * 4.0)]

# Use a mode for temporary db curve
set mode [pw::Application begin Create]

# Use a thick database line to display the selected points
set curve [pw::Curve create]
$curve setRenderAttribute LineWidth 5
$curve setRenderAttribute ColorMode Entity
$curve setColor "#FFFF00"

set seg [pw::SegmentSpline create]
$curve addSegment $seg

catch {
  set xyz1 [pw::Display selectPoint -description "Select the first end point"]
  $seg addPoint $xyz1
  set xyz2 [pw::Display selectPoint -description "Select the apex point"]
  $seg addPoint $xyz2
  pw::Display update
  set xyz3 [pw::Display selectPoint -description "Select the last end point"]
  $seg addPoint $xyz3
  pw::Display update
  after 500

  # Calculate and print the angle between the three points
  set leg1 [pwu::Vector3 normalize [pwu::Vector3 subtract $xyz1 $xyz2]]
  set leg2 [pwu::Vector3 normalize [pwu::Vector3 subtract $xyz3 $xyz2]]
  set dot [pwu::Vector3 dot $leg1 $leg2]
  puts [format "Angle: %g degrees" [expr acos($dot) * $::Rad2Deg]]
}

pw::Display update
after 10000

$mode abort

#
# DISCLAIMER:
# TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, POINTWISE DISCLAIMS
# ALL WARRANTIES, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED
# TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE, WITH REGARD TO THIS SCRIPT.  TO THE MAXIMUM EXTENT PERMITTED 
# BY APPLICABLE LAW, IN NO EVENT SHALL POINTWISE BE LIABLE TO ANY PARTY 
# FOR ANY SPECIAL, INCIDENTAL, INDIRECT, OR CONSEQUENTIAL DAMAGES 
# WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
# BUSINESS INFORMATION, OR ANY OTHER PECUNIARY LOSS) ARISING OUT OF THE 
# USE OF OR INABILITY TO USE THIS SCRIPT EVEN IF POINTWISE HAS BEEN 
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGES AND REGARDLESS OF THE 
# FAULT OR NEGLIGENCE OF POINTWISE.
#

