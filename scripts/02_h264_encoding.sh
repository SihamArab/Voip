#!/usr/bin/env bash
# Lab 1.2 - H.264 compression with ffmpeg, inspection with ffprobe, compression ratio.
# Input : video.yuv from 01_yuv_conversion.sh, 352x288, 30 fps, YUV 4:2:0.
set -euo pipefail

W=352
H=288
IN_FPS=30
OUT_FPS=15
BITRATE=128k

# Options placed before -i describe the raw input, options after it describe the output.
# The input size must match the real size of video.yuv.
ffmpeg -y -s ${W}x${H} -r ${IN_FPS} -pix_fmt yuv420p -f rawvideo -i video.yuv \
       -r ${OUT_FPS} -b:v ${BITRATE} -c:v libx264 video.264

ffmpeg -y -s ${W}x${H} -r ${IN_FPS} -pix_fmt yuv420p -f rawvideo -i video.yuv \
       -r ${OUT_FPS} -b:v ${BITRATE} -c:v libx264 video.mkv

echo "--- properties of the encoded file"
ffprobe -hide_banner video.mkv

echo "--- compression ratio"
raw=$(stat -c %s video.yuv)
enc=$(stat -c %s video.264)
awk -v r="$raw" -v e="$enc" 'BEGIN {printf "YUV %d bytes, H.264 %d bytes, ratio %.1f:1\n", r, e, r/e}'
