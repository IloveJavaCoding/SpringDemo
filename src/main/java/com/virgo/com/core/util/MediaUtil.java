package com.virgo.com.core.util;

import com.virgo.com.core.bean.MediaInfo;
import com.virgo.com.core.data.Constants;
import it.sauronsoftware.jave.Encoder;
import it.sauronsoftware.jave.MultimediaInfo;
import it.sauronsoftware.jave.VideoSize;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.io.FileUtils;
import org.bytedeco.javacv.FFmpegFrameGrabber;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber;
import org.bytedeco.javacv.Java2DFrameConverter;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Arrays;

/**
 * 媒体处理工具类
 */
public class MediaUtil {
    /**
     * 获取在线图片的分辨率
     * @param url
     * @param suffix
     * @return
     */
    public static MediaInfo getOnlineImageInfo(String url, String suffix){
        if (TextUtil.isEmpty(url) || TextUtil.isEmpty(suffix)) return null;
        if (!Arrays.asList(TextUtil.IMAGE_EXTENSION).contains(suffix)) return null;

        try {
            InputStream is = new URL(url).openStream();
            return getImageInfo(is);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取在线图片的分辨率
     * @param url
     * @return
     */
    public static MediaInfo getOnlineImageInfo(String url){
        if (TextUtil.isEmpty(url)) return null;

        try {
            InputStream is = new URL(url).openStream();
            return getImageInfo(is);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取图片的分辨率
     * @return
     */
    public static MediaInfo getImageInfo(InputStream inputStream){
        try {
            MediaInfo info = new MediaInfo();
            BufferedImage reader = ImageIO.read(inputStream);
            int width = reader.getWidth();
            int height = reader.getHeight();
            info.setWidth(width);
            info.setHeight(height);
            return info;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取文件时长，分辨率
     * @param path 文件路径或url
     * @param suffix  文件格式
     * @return
     */
    public static MediaInfo getVideoInfo(String path, String suffix) {
        if (TextUtil.isEmpty(path) || TextUtil.isEmpty(suffix)) return null;
        if (!Arrays.asList(TextUtil.MEDIA_EXTENSION).contains(suffix)) return null;

        try {
            File f2 = new File(path);
            if (!f2.exists()) return null;

           return getVideoInfo(f2);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取音频，视频文件时长，分辨率
     * @param file
     * @return
     */
    public static MediaInfo getVideoInfo(File file) {
        try {
            Encoder encoder = new Encoder();
            MultimediaInfo m = encoder.getInfo(file);

            MediaInfo info = new MediaInfo();
            info.setDurition(m.getDuration() / 1000);
            info.setSize(file.length());

            if (m.getVideo() != null && m.getVideo().getSize() != null) {
                VideoSize size = m.getVideo().getSize();
                info.setHeight(size.getHeight());
                info.setWidth(size.getWidth());
            }
            return info;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 获取视频音频时长，分辨率，大小信息
     * @param file
     * @return
     */
    public static MediaInfo getAVInfo(MultipartFile file){
        String filename = file.getOriginalFilename();
        if(filename!=null){
            //防止一些非法字符
            String suffix = TextUtil.getFileSuffixDot(filename);
            File tempFile = new File("mediafile"+suffix);
            try {
                FileUtils.copyInputStreamToFile(file.getInputStream(), tempFile);
                if(tempFile.exists()){
                    MediaInfo mediaInfo = MediaUtil.getVideoInfo(tempFile);
                    tempFile.delete();
                    return mediaInfo;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /**
     * 获取图片缩略图
     * @param inputStream
     */
    public static void getImageThumb(InputStream inputStream, File thumbFile){
        try {
            //size： 会保留原宽高比
            Thumbnails.of(inputStream).size(Constants.THUMB_SIZE,Constants.THUMB_SIZE).toFile(thumbFile);
            //forcesize：不保留宽高比
//            Thumbnails.of(inputStream).forceSize(Constants.THUMB_SIZE,Constants.THUMB_SIZE).toFile(thumbFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取视频文件的缩略图
     * @param filePath 视频路径
     * @param savePath 缩略图保存路径
     */
    public static void fetchFrame(String filePath, String savePath) {
        long start = System.currentTimeMillis();
        FFmpegFrameGrabber ff = new FFmpegFrameGrabber(filePath);
        File file = new File(savePath);
        getVideoFrame(ff, file);
        System.out.println(System.currentTimeMillis() - start);
    }

    /**
     * 获取视频文件的缩略图
     * @param stream 视频路径
     * @param thumbFile 缩略图保存路径
     */
    public static void fetchFrame(InputStream stream, File thumbFile) {
        long start = System.currentTimeMillis();
        FFmpegFrameGrabber ff = new FFmpegFrameGrabber(stream);
        getVideoFrame(ff, thumbFile);
        System.out.println(System.currentTimeMillis() - start);
    }

    private static void getVideoFrame(FFmpegFrameGrabber ff, File thumbFile) {
        try {
            ff.start();
            int length = ff.getLengthInFrames();
            int i = 0;
            Frame f = null;
            while (i < length) {
                // 去掉前5帧，避免出现全黑的图片，依自己情况而定
                f = ff.grabImage();
                if ((i > 5) && (f.image != null)) {
                    break;
                }
                i++;
            }
            ImageIO.write(FrameToBufferedImage(f), "jpg", thumbFile);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            try {
                ff.flush();
                ff.stop();
            } catch (FrameGrabber.Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static BufferedImage FrameToBufferedImage(Frame frame) {
        //创建BufferedImage对象
        Java2DFrameConverter converter = new Java2DFrameConverter();
        return converter.getBufferedImage(frame);
    }

}
