# video-streaming-voip-labs

Video streaming and voice over IP labs: H.264 encoding with FFmpeg, RTSP unicast and RTP multicast streaming
with live555 and VLC, a smartphone used as a surveillance camera, and SIP calls through a Kamailio server.

Coursework of the Video and Voice over IP module, Master in Networks and Telecommunications, University of Boumerdes.

## What is built

A small video surveillance chain, from the raw image to the network:

```
RGB file -> YUV 4:2:0 -> H.264 -> HTTP download | RTSP/RTP unicast | RTP multicast
smartphone camera -> RTSP proxy -> several viewers, unicast or multicast
SIP softphones <-> Kamailio registrar and proxy
```

## Labs

| Script | Lab | What it shows |
|---|---|---|
| `scripts/01_yuv_conversion.sh` | Video formats | RGB24 to YUV 4:2:0 halves the file size. Frame count and duration from the file size. |
| `scripts/02_h264_encoding.sh` | H.264 compression | Encoding at 15 fps and 128 kb/s, inspection with ffprobe, compression ratio. |
| `scripts/03_http_progressive.sh` | Progressive download | Apache serving an MP4 file to an HTML5 video tag. |
| `scripts/04_rtsp_unicast.sh` | RTSP/RTP unicast | live555MediaServer and ffplay, RTSP and RTP ports seen in Wireshark. |
| `scripts/05_camera_view.sh` | Surveillance camera | An Android phone running RTSP Camera Server on its own Wi-Fi hotspot. |
| `scripts/06_multicast.sh` | Multicast | One stream to several viewers on 239.255.42.42. |
| `scripts/07_proxy_unicast.sh` | RTSP proxy | One connection to the camera shared by several clients. |
| `scripts/08_proxy_multicast.sh` | Unicast to multicast proxy | VLC relays the camera as RTP multicast, with an SDP file. |
| `scripts/09_sip_kamailio.sh` | SIP server | Kamailio as registrar and proxy, call between Twinkle and Linphone. |

## Tools

| Tool | Use |
|---|---|
| FFmpeg, ffprobe, ffplay | Conversion, encoding, inspection and playback |
| live555MediaServer, live555ProxyServer, testMPEG2TransportStreamer | RTSP server, RTSP proxy, multicast test streamer |
| VLC, cvlc | Unicast to multicast relay |
| Apache | HTTP progressive download |
| RTSP Camera Server, Android | Smartphone as an IP camera |
| Kamailio | SIP registrar and proxy |
| Twinkle on Linux, Linphone on Android | SIP softphones |
| Wireshark | Protocol analysis |
| gnome-system-monitor | Bandwidth comparison between unicast and multicast |

## Concepts

- **YUV 4:2:0** keeps full resolution for luminance and halves chrominance in both directions, so a frame takes 1.5 bytes per pixel instead of 3.
- **H.264** splits frames into 16x16 macroblocks, then applies prediction, DCT, quantisation and entropy coding. It uses I, P and B frames in groups of pictures.
- **RTSP** controls the session with OPTIONS, DESCRIBE, SETUP, PLAY, PAUSE and TEARDOWN. **RTP** carries the media and **RTCP** carries quality statistics. The transport, UDP or TCP, is chosen at SETUP.
- **Multicast** sends one copy of the stream whatever the number of viewers. Unicast bandwidth grows with the number of clients. Multicast needs a network that forwards it, and works over UDP.
- **SIP** runs on port 5060. A call is INVITE, 180 Ringing, 200 OK, ACK. Kamailio plays the registrar and proxy roles, and the softphones are the user agents.

## Usage

Run the scripts in order from a working directory that holds the input files. The inputs are given by the course and are not in this repository: `video.rgb`, 352x288 RGB24 frames, and `test.ts`, an MPEG-2 transport stream.

```bash
cd scripts
./01_yuv_conversion.sh
./02_h264_encoding.sh
./04_rtsp_unicast.sh server        # then on a client: ./04_rtsp_unicast.sh client SERVER_IP
```

Useful Wireshark filters: `rtsp`, `rtp`, `rtcp`, `sip`.

Requirements: a Linux machine with `ffmpeg`, `livemedia-utils`, `vlc`, `apache2`, `kamailio`, `twinkle` and `wireshark`.
Scripts 01 and 02 were run on a generated test video. The scripts that need a camera, several machines or SIP terminals were not run in an automated environment.

## Differences from the course sheets

- The course command uses `-v:c h264` and a 176x144 input size for a 352x288 file. The scripts use `-c:v libx264` and the real input size, because FFmpeg reads a raw file with the size given before `-i`.
- The course copies `video.mkv` to the web server but links `video.mp4` in the page. The script converts the MKV to MP4 without re-encoding.

## License

MIT
