#!/bin/bash

function file_exists() {
    if [ ! -f "$1" ]; then
        echo "Error: $1 not found"
        exit 1
    fi
}

# Initialize variables
image_dir="images"
audio_dir="audios"
temp_dir="temp_videos"
image_prefix=""
image_postfix=""
image_format="png"
audio_prefix=""
audio_postfix=""
audio_format="mp3"
scale="1920:1080"
output_file="output.mp4"
skip=false
b=1
n=1

# Parse command line arguments
while (( "$#" )); do
    case "$1" in
    -b)
        b="$2"
        shift 2
        ;;
    -n)
        n="$2"
        shift 2
        ;;
    --image_dir)
        image_dir="$2"
        shift 2
        ;;
    --audio_dir)
        audio_dir="$2"
        shift 2
        ;;
    --temp_dir)
        temp_dir="$2"
        shift 2
        ;;
    --image_prefix)
        image_prefix="$2"
        shift 2
        ;;
    --image_postfix)
        image_postfix="$2"
        shift 2
        ;;
    --image_format)
        image_format="$2"
        shift 2
        ;;
    --audio_prefix)
        audio_prefix="$2"
        shift 2
        ;;
    --audio_postfix)
        audio_postfix="$2"
        shift 2
        ;;
    --audio_format)
        audio_format="$2"
        shift 2
        ;;
    --scale)
        scale="$2"
        shift 2
        ;;
    -o)
        output_file="$2"
        shift 2
        ;;
    --skip)
        skip=true
        shift 1
        ;;
    *)
        echo "Error: Invalid argument"
        echo "Usage: $0 [-b value] [-n value] [--image_dir dir] [--audio_dir dir] [--temp_dir dir] [--image_prefix prefix] [--image_postfix postfix] [--image_format format] [--audio_prefix prefix] [--audio_postfix postfix] [--audio_format format] [--scale scale] [--skip] [-o output_file]"
        exit 1
    esac
done

if [ ! -d "$temp_dir" ]; then
    mkdir $temp_dir
fi

# check files exits
for ((i=$b; i<=$n; i++))
do
    _image_file=$image_dir/${image_prefix}${i}${image_postfix}.${image_format}
    _audio_file=${audio_dir}/${audio_prefix}${i}${audio_postfix}.${audio_format}
    # check _image_file and _audio_file exist
    file_exists $_image_file
    file_exists $_audio_file
done

for ((i=$b; i<=$n; i++))
do
    _image_file=$image_dir/${image_prefix}${i}${image_postfix}.${image_format}
    _audio_file=${audio_dir}/${audio_prefix}${i}${audio_postfix}.${audio_format}
    _output_file=${temp_dir}/$i.mp4
    # if `skip` is set to true, skip the existing files
    if [ "$skip" = true ] && [ -f "$_output_file" ]; then
        echo "Skip $_output_file"
        continue
    fi
    ffmpeg -hide_banner \
        -loop 1 -i ${_image_file} \
        -i ${_audio_file} \
        -vcodec libx264 -acodec copy -tune stillimage \
        -vf scale=${scale} -shortest \
        -y \
        ${temp_dir}/$i.mp4 || exit 1
done

echo > $temp_dir/input.txt
for ((i=$b; i<=$n; i++))
do 
    file_exists $temp_dir/$i.mp4
    echo "file $i.mp4" >> $temp_dir/input.txt
done

ffmpeg -y -f concat -safe 0 -i $temp_dir/input.txt -c copy $output_file
