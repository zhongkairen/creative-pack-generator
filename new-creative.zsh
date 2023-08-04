# Me generate new creative files

# input files (read-only, don't delete these files)
input_image=endcard.png
input_video=video.mp4

# output seed, use time stamp
usec=`perl -MTime::HiRes=time -e 'printf "%.6f\n", time - int(time);' | awk -F'.' '{print $2}'`
# datetime + microseconds
file_seed=`date +'%Y.%m.%d.%H%M%S'`$usec

# output file names
output_image=endcard.$file_seed.png
output_video=video.$file_seed.mp4

# text that is used in the retouch
text="`hostname` $file_seed"

# retouch the image
convert $input_image -pointsize 12 -fill "#ccc" -gravity northeast -annotate 0 "$text" $output_image
echo $output_image

# retouch the video
ffmpeg -y -hide_banner -loglevel error -i $input_video -vf "drawtext=fontfile=/path/to/font.ttf:text=$text:fontcolor=white@0.1:fontsize=24:x=(w-text_w)-h/20:y=h/20" -codec:a copy $output_video 
echo $output_video
