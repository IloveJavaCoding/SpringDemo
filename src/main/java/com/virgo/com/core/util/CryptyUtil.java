package com.virgo.com.core.util;

import org.apache.commons.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.math.BigInteger;
import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.util.Date;
import java.util.UUID;

/**
 * 加密工具类
 */
public class CryptyUtil {
    private static final String TAG = "CryptyUtil";

    private static final String AES = "AES";
    private static final byte[] key128Base64 = Base64.decodeBase64("1xLYfn7al4eAUqK/TjgHlA==");

    //1. ASE 加密 解密
    private static byte[] encryptAES(byte[] input, byte[] key) {
        return aes(input, key, Cipher.ENCRYPT_MODE);
    }

    private static byte[] decryptAES(byte[] input, byte[] key) {
        return aes(input, key, Cipher.DECRYPT_MODE);
    }

    private static byte[] aes(byte[] input, byte[] key, int mode) {
        try {
            SecretKey secretKey = new SecretKeySpec(key, AES);
            Cipher cipher = Cipher.getInstance(AES);
            cipher.init(mode, secretKey);
            return cipher.doFinal(input);
        } catch (GeneralSecurityException e) {
            throw new RuntimeException(e);
        }
    }

    //2. Md5 加密
    private static byte[] md5(String s) {
        MessageDigest algorithm;
        try {
            algorithm = MessageDigest.getInstance("MD5");
            algorithm.reset();
            algorithm.update(s.getBytes("UTF-8"));
            return algorithm.digest();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static byte[] md5(byte[] s) {
        MessageDigest algorithm;
        try {
            algorithm = MessageDigest.getInstance("MD5");
            algorithm.reset();
            algorithm.update(s);
            return algorithm.digest();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String toHex(byte[] bytes) {
        if (bytes == null) {
            return null;
        }
        StringBuilder buf = new StringBuilder(bytes.length * 2);
        int i;

        for (i = 0; i < bytes.length; i++) {
            if ((bytes[i] & 0xff) < 0x10) {
                buf.append("0");
            }
            buf.append(Long.toString(bytes[i] & 0xff, 16));
        }
        return buf.toString();
    }


    //////////////////////////////////////////////////////////////////
    /**
     * 根据用户生成token
     * @param uId
     * @param username
     * @return
     */
    public static String encodeAccount(String uId, String username) {
        //Joiner.on("|").join(userId, username, timestamp);
        long timestamp = new Date().getTime();
        return encode(uId, username, String.valueOf(timestamp));
    }

    /**
     * 根据终端生成token
     * @param packageName
     * @param type
     * @return
     */
    public static String encodeAppkey(String packageName, String type) {
        long timestamp = new Date().getTime();
        return encode(packageName, type, String.valueOf(timestamp));
    }

    public static String encode(String ... param){
        String temp = TextUtil.joinStrs("|", param);
        byte[] bytes = encryptAES(temp.getBytes(), key128Base64);
        return Base64.encodeBase64String(bytes);
    }

    /**
     * 解密token
     * @param encStr
     * @return
     */
    public static String decode(String encStr) {
        byte[] temp = Base64.decodeBase64(encStr);
        byte[] bytes = decryptAES(temp, key128Base64);
        return new String(bytes);
    }

    /**
     * 校验token
     * @param appkey
     * @param appPackageName
     * @param type
     * @return
     */
    public static boolean validAppKey(String appkey,String appPackageName,String type){
        try {
            String decodeToken = decode(appkey);
            String[] arrs = decodeToken.split("\\|");
            return appPackageName.equals(arrs[0]) && type.equalsIgnoreCase(arrs[1]);
        }catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 加密保存文件名 md5
     * @param fileName
     * @return
     */
    public static String cryptyFileName(String fileName){
        if(TextUtil.isEmpty(fileName)){
            return fileName;
        }

        byte[] bytes = md5(fileName);
        if(bytes!=null){
            return new BigInteger(1, bytes).toString(16);
        }else{
            return UUID.randomUUID().toString();
        }
//        return Base64.encodeBase64String(bytes);
    }
}
