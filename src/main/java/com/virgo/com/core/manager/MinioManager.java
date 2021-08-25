package com.virgo.com.core.manager;

import com.virgo.com.core.util.LogUtil;
import com.virgo.com.core.util.PropertiesUtil;
import com.virgo.com.core.util.TextUtil;
import io.minio.MinioClient;
import io.minio.errors.*;
import org.xmlpull.v1.XmlPullParserException;

import java.io.*;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

/**
 * minio 文件服务器
 */
public class MinioManager {
    private static final String TAG = "MinioManager";
    private static final String minioUrl;//ip port
    private static final String minioUser;//user
    private static final String minioPsd;//password
    private static final String minioBucket;//bucket
    static {
        PropertiesUtil p = new PropertiesUtil("properties/minio.properties");
        minioUrl = p.getString("minio_server");
        minioUser = p.getString("minio_user");
        minioPsd = p.getString("minio_psd");
        minioBucket = p.getString("minio_bucket");
        LogUtil.debug(TAG, "init attr: " + minioUrl + ", "+ minioUser + ", " +minioPsd);
    }

    /**
     * 上传文件 通用
     * @param stream 文件流
     * @param fileName 文件名 无后缀
     * @param type 文件类型
     * @return 下载链接
     */
    private static String upload(InputStream stream, String fileName, String type){
        String url = null;
        try {
            MinioClient client = new MinioClient(minioUrl,minioUser,minioPsd);
            client.putObject(minioBucket, fileName, stream, type);
            url = client.getObjectUrl(minioBucket, fileName);
        } catch (InvalidEndpointException | InvalidPortException | InvalidKeyException | NoSuchAlgorithmException | NoResponseException | InvalidBucketNameException | XmlPullParserException | InsufficientDataException | ErrorResponseException | IOException | InternalException | InvalidArgumentException e) {
            e.printStackTrace();
        }

        return url;
    }

    /**
     * 从文件服务器移除某个文件
     * @param fileName
     * @return
     */
    private static boolean delete(String fileName){
        boolean isOk = false;
        try {
            MinioClient client = new MinioClient(minioUrl, minioUser, minioPsd);
            client.removeObject(minioBucket, fileName);
            isOk = true;
        } catch (InvalidKeyException | NoSuchAlgorithmException | NoResponseException | XmlPullParserException | InvalidEndpointException | InvalidBucketNameException | ErrorResponseException | InsufficientDataException | InternalException | InvalidPortException | IOException e) {
            e.printStackTrace();
        }

        return isOk;
    }

    /**
     * 直接从minio文件服务器下载文件
     * @param fileName
     * @return
     */
    private static InputStream download(String fileName){
        InputStream inputStream = null;
        try {
            MinioClient client = new MinioClient(minioUrl, minioUser, minioPsd);
            inputStream = client.getObject(minioBucket, fileName);
        } catch (InvalidKeyException | NoSuchAlgorithmException | NoResponseException | XmlPullParserException | InvalidEndpointException | InvalidBucketNameException | ErrorResponseException | InsufficientDataException | InternalException | InvalidPortException | IOException | InvalidArgumentException e) {
            e.printStackTrace();
        }
        return inputStream;
    }

    /**
     * 上传图片
     * @param stream
     * @param fileNmae
     * @return
     */
    public static String uploadImg(InputStream stream, String fileNmae){
        return upload(stream, fileNmae, "image/jpeg");
    }

    /**
     * 上传视频
     * @param stream
     * @param fileName
     * @return
     */
    public static String uploadVideo(InputStream stream, String fileName){
        return upload(stream, fileName,"video/mp4");
    }

    /**
     * 上传文件 任意类型
     * @param stream
     * @param fileName
     * @param type
     * @return
     */
    public static String uploadFile(InputStream stream, String fileName, String type){
        return upload(stream, fileName, type);
    }

    /**
     * 删除某个文件
     * @param saveName
     * @return
     */
    public static boolean deleteFile(String saveName){
        //从链接提取有效文件名
        //http://192.168.2.151:9000/media/2021/08/25/bd540ce64b4dfbcb93d5c5535a152781.png
        if(saveName.contains(minioBucket)){//若包含容器名则截断
            String name = saveName.substring(saveName.indexOf(minioBucket)+minioBucket.length()+1);
            LogUtil.debug(TAG, name);
            return delete(name);
        }
        return delete(saveName);
    }

    /**
     * 下载文件到本地
     * @param saveName 文件在服务器上的位置
     * @param savePath 存储到本地的位置
     * @return
     */
    public static boolean downloadFile(String saveName, String savePath){
        InputStream inputstream = download(saveName);
        OutputStream outputStream = null;

        if(inputstream!=null){
            String name = TextUtil.getFileNameWithSuffix(saveName);
            try {
                byte[] buffer = new byte[1024];
                int length;

                outputStream = new FileOutputStream(new File(savePath+File.separator+name));
                while ((length = inputstream.read(buffer)) > 0) {
                    outputStream.write(buffer, 0, length);
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                try {
                    inputstream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }

                if(outputStream!=null) {
                    try {
                        outputStream.flush();
                        outputStream.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return false;
    }
}
