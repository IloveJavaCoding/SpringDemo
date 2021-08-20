package com.virgo.com.core.manager;

import com.virgo.com.core.util.LogUtil;
import com.virgo.com.core.util.PropertiesUtil;
import io.minio.MinioClient;
import io.minio.errors.*;
import org.xmlpull.v1.XmlPullParserException;

import java.io.IOException;
import java.io.InputStream;
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

//        Properties properties = new Properties();
//        String path = MinioManager.class.getClassLoader().getResource("properties/minio.properties").getPath();
//        InputStream is = null;
//        try {
//            is = new FileInputStream(path);
//            properties.load(is);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }finally {
//            if(is!=null){
//                try {
//                    is.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//
//        minioUrl = properties.getProperty("minio_server", "http://192.168.2.151:9000");
//        minioUser = properties.getProperty("minio_user", "virgo");
//        minioPsd = properties.getProperty("minio_psd", "z12345678");
//        minioBucket = properties.getProperty("minio_bucket", "media");
//        LogUtil.debug(TAG, "init attr: " + minioUrl + ", "+ minioUser + ", " +minioPsd);
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
}
