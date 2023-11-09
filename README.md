# Presentation to Video

convert presentation to video.

## Usage

before running the script, you need to make sure that 
the images and audios (these files are needed to be prepared in advance) are in the following format:

```bash
images/
    1.png
    2.png
    ...
audios/
    1.mp3
    2.mp3
    ...
```

then run the script:

```bash
bash presentation_to_video.sh -o output.mp4
```

this will create a video named `output.mp4` in the current directory,
and a directory named `temp_videos` will be created to store the temporary files.

## Options

Usage:

```bash
bash presentation_to_video.sh [-b begin] [-n end]
    [--image_dir image_dir] [--audio_dir audio_dir] [--temp_dir temp_dir] 
    [--image_prefix image_prefix] [--image_postfix image_postfix] [--image_format image_format] 
    [--audio_prefix audio_prefix] [--audio_postfix audio_postfix] [--audio_format audio_format] 
    [--scale scale] [-o output_file] [--skip]
```

image options:

> Images are the slides of the presentation.
> They are placed at `${image_dir}/${image_prefix}${i}${image_postfix}.${image_format}`.

- `--image_dir string`: the directory of the images, defaults to `images`.
- `--image_prefix string`: the prefix of the images, defaults to empty string.
- `--image_postfix string`: the postfix of the images, defaults to empty string.
- `--image_format format`: the format of the images, defaults to `png`.

audios options:

> Audios are the background music or speech of the presentation.
> They are placed at `${audio_dir}/${audio_prefix}${i}${audio_postfix}.${audio_format}`.

- `--audio_dir string`: the directory of the audios, defaults to `audios`.
- `--audio_prefix string`: the prefix of the audios, defaults to empty string.
- `--audio_postfix string`: the postfix of the audios, defaults to empty string.
- `--audio_format format`: the format of the audios, defaults to `mp3`.

range options:

> The index `i` of images and audios are in `{$b..$n}`.

- `-b value`: the begin index of the images, defaults to 1.
- `-n value`: the end index of the images, defaults to 1.

output options:

> The output temporary videos are placed at `${temp_dir}/{i}.mp4`.

- `-o output_file`: the final output video, defaults to `output.mp4`.
- `--scale scale`: the scale of the output video, defaults to `1920:1080`.
  - 1080p: `1920:1080`
  - 2K/1440p: `2560:1440`
  - 4K/2160p: `3840:2160`
- `--skip`: skip the existing temporary videos, defaults to `false`, which means the script will overwrite the existing temporary videos.
    If `--skip` is provided, the script will skip the existing temporary videos.
- `--temp_dir temp_dir`: the directory of the temporary videos, defaults to `temp_videos`.

## Requirements

- [ffmpeg](https://ffmpeg.org/)
