# 将演示文稿转换为视频

将演示文稿转换为视频。

## 用法

在运行脚本之前，需要确保以下文件已准备好：

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

然后运行脚本：

```bash
bash presentation_to_video.sh -o output.mp4
```

这将在当前目录下创建一个名为`output.mp4`的视频文件，并创建一个名为`temp_videos`的目录来存储临时文件。

## 选项

用法：

```bash
bash presentation_to_video.sh [-b begin] [-n end]
    [--image_dir image_dir] [--audio_dir audio_dir] [--temp_dir temp_dir] 
    [--image_prefix image_prefix] [--image_postfix image_postfix] [--image_format image_format] 
    [--audio_prefix audio_prefix] [--audio_postfix audio_postfix] [--audio_format audio_format] 
    [--scale scale] [-o output_file] [--skip]
```

图片选项：

> 图片是演示文稿的幻灯片。
> 它们位于`${image_dir}/${image_prefix}${i}${image_postfix}.${image_format}`。

- `--image_dir string`：图片的目录，默认为`images`。
- `--image_prefix string`：图片的前缀，默认为空字符串。
- `--image_postfix string`：图片的后缀，默认为空字符串。
- `--image_format format`：图片的格式，默认为`png`。

音频选项：

> 音频是演示文稿的背景音乐或演讲。
> 它们位于`${audio_dir}/${audio_prefix}${i}${audio_postfix}.${audio_format}`。

- `--audio_dir string`：音频的目录，默认为`audios`。
- `--audio_prefix string`：音频的前缀，默认为空字符串。
- `--audio_postfix string`：音频的后缀，默认为空字符串。
- `--audio_format format`：音频的格式，默认为`mp3`。

范围选项：

> 图片和音频的索引`i`在`{$b..$n}`内。

- `-b value`：图片的起始索引，默认为1。
- `-n value`：图片的结束索引，默认为1。

输出选项：

> 临时视频文件位于`${temp_dir}/{i}.mp4`。

- `-o output_file`：最终输出的视频文件，默认为`output.mp4`。
- `--scale scale`：输出视频的尺寸，默认为`1920:1080`。
  - 1080p：`1920:1080`
  - 2K/1440p：`2560:1440`
  - 4K/2160p：`3840:2160`
- `--skip`：跳过已存在的临时视频，默认为`false`，这意味着脚本将覆盖已存在的临时视频。
    如果提供了`--skip`，脚本将跳过已存在的临时视频。
- `--temp_dir temp_dir`：临时视频的目录，默认为`temp_videos`。

## 要求

- [ffmpeg](https://ffmpeg.org/)