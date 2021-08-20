package com.virgo.com.core.util;

import com.virgo.com.core.manager.MinioManager;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;

public class FileUploadUtil {
    private static final String TAG = "FileUploadUtil";

    public static final String[] IMAGE_EXTENSION = {"bmp", "gif", "jpg", "jpeg", "png"};
    public static final String[] FLASH_EXTENSION = {"swf", "flv"};
    public static final String[] OTHER_EXTENSION = {"apk"};
    public static final String[] MEDIA_EXTENSION = {"swf", "flv", "mp4", "mp3", "wav", "wma", "3gp", "wmv", "mpeg", "mid", "avi", "mpg", "asf", "rmvb"};
    public static final String[] DEFAULT_ALLOWED_EXTENSION = {
            // 图片
            "bmp", "gif", "jpg", "jpeg", "png",
            // word excel powerpoint
            "doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt",
            // 压缩文件
            "rar", "zip", "gz", "bz2",
            // pdf
            "pdf"};

    private static HashMap<String, String> ContentType;

    static {
        ContentType = new HashMap<String, String>() {
            {
                put("AAC", "audio/aac");
                put("aaf", "application/octet-stream");
                put("aax", "audio/vnd.audible.aax");
                put("ac3", "audio/ac3");
                put("aca", "application/octet-stream");
                put("amc", "application/x-mpeg");
                put("application", "application/x-ms-application");
                put("art", "image/x-jg");
                put("avi", "video/x-msvideo");
                put("axs", "application/olescript");
                put("bin", "application/octet-stream");
                put("bmp", "image/bmp");
                put("c", "text/plain");
                put("cc", "text/plain");
                put("cdf", "application/x-cdf");
                put("cer", "application/x-x509-ca-cert");
                put("chm", "application/octet-stream");
                put("class", "application/x-java-applet");
                put("config", "application/xml");
                put("cpp", "text/plain");
                put("crd", "application/x-mscardfile");
                put("crl", "application/pkix-crl");
                put("crt", "application/x-x509-ca-cert");
                put("cs", "text/plain");
                put("csproj", "text/plain");
                put("css", "text/css");
                put("csv", "text/csv");
                put("cur", "application/octet-stream");
                put("cxx", "text/plain");
                put("dat", "application/octet-stream");
                put("dif", "video/x-dv");
                put("dir", "application/x-director");
                put("dll", "application/x-msdownload");
                put("doc", "application/msword");
                put("docm", "application/vnd.ms-word.document.macroEnabled.12");
                put("docx", "application/vnd.openxmlformats-officedocument.wordprocessingml.document");
                put("dot", "application/msword");
                put("dotx", "application/vnd.openxmlformats-officedocument.wordprocessingml.template");
                put("exe", "application/octet-stream");
                put("exe.config", "text/xml");
                put("flv", "video/x-flv");
                put("fsscript", "application/fsharp-script");
                put("fsx", "application/fsharp-script");
                put("generictest", "application/xml");
                put("gif", "image/gif");
                put("group", "text/x-ms-group");
                put("gsm", "audio/x-gsm");
                put("gtar", "application/x-gtar");
                put("gz", "application/x-gzip");
                put("htm", "text/html");
                put("html", "text/html");
                put("jar", "application/java-archive");
                put("java", "application/octet-stream");
                put("jck", "application/liquidmotion");
                put("jcz", "application/liquidmotion");
                put("jfif", "image/pjpeg");
                put("jnlp", "application/x-java-jnlp-file");
                put("jpb", "application/octet-stream");
                put("jpe", "image/jpeg");
                put("jpeg", "image/jpeg");
                put("jpg", "image/jpeg");
                put("js", "application/x-javascript");
                put("jsx", "text/jscript");
                put("jsxbin", "text/plain");
                put("latex", "application/x-latex");
                put("library-ms", "application/windows-library+xml");
                put("lit", "application/x-ms-reader");
                put("loadtest", "application/xml");
                put("lpk", "application/octet-stream");
                put("lsf", "video/x-la-asf");
                put("lst", "text/plain");
                put("lsx", "video/x-la-asf");
                put("lzh", "application/octet-stream");
                put("m13", "application/x-msmediaview");
                put("m14", "application/x-msmediaview");
                put("m1v", "video/mpeg");
                put("m2t", "video/vnd.dlna.mpeg-tts");
                put("m2ts", "video/vnd.dlna.mpeg-tts");
                put("m2v", "video/mpeg");
                put("m3u", "audio/x-mpegurl");
                put("m3u8", "audio/x-mpegurl");
                put("m4a", "audio/m4a");
                put("m4b", "audio/m4b");
                put("m4p", "audio/m4p");
                put("m4r", "audio/x-m4r");
                put("m4v", "video/x-m4v");
                put("mac", "image/x-macpaint");
                put("mak", "text/plain");
                put("man", "application/x-troff-man");
                put("manifest", "application/x-ms-manifest");
                put("map", "text/plain");
                put("master", "application/xml");
                put("mda", "application/msaccess");
                put("mdb", "application/x-msaccess");
                put("mde", "application/msaccess");
                put("mdp", "application/octet-stream");
                put("me", "application/x-troff-me");
                put("mfp", "application/x-shockwave-flash");
                put("mht", "message/rfc822");
                put("mhtml", "message/rfc822");
                put("mid", "audio/mid");
                put("midi", "audio/mid");
                put("mix", "application/octet-stream");
                put("mk", "text/plain");
                put("mmf", "application/x-smaf");
                put("mno", "text/xml");
                put("mny", "application/x-msmoney");
                put("mod", "video/mpeg");
                put("mov", "video/quicktime");
                put("movie", "video/x-sgi-movie");
                put("mp2", "video/mpeg");
                put("mp2v", "video/mpeg");
                put("mp3", "audio/mpeg");
                put("mp4", "video/mp4");
                put("mp4v", "video/mp4");
                put("mpa", "video/mpeg");
                put("mpe", "video/mpeg");
                put("mpeg", "video/mpeg");
                put("mpf", "application/vnd.ms-mediapackage");
                put("mpg", "video/mpeg");
                put("mpp", "application/vnd.ms-project");
                put("mpv2", "video/mpeg");
                put("mqv", "video/quicktime");
                put("ms", "application/x-troff-ms");
                put("msi", "application/octet-stream");
                put("mso", "application/octet-stream");
                put("mts", "video/vnd.dlna.mpeg-tts");
                put("mtx", "application/xml");
                put("mvb", "application/x-msmediaview");
                put("mvc", "application/x-miva-compiled");
                put("mxp", "application/x-mmxp");
                put("nc", "application/x-netcdf");
                put("nsc", "video/x-ms-asf");
                put("nws", "message/rfc822");
                put("ocx", "application/octet-stream");
                put("oda", "application/oda");
                put("odc", "text/x-ms-odc");
                put("odh", "text/plain");
                put("odl", "text/plain");
                put("odp", "application/vnd.oasis.opendocument.presentation");
                put("ods", "application/oleobject");
                put("odt", "application/vnd.oasis.opendocument.text");
                put("one", "application/onenote");
                put("pct", "image/pict");
                put("pcx", "application/octet-stream");
                put("pcz", "application/octet-stream");
                put("pdf", "application/pdf");
                put("pfb", "application/octet-stream");
                put("pfm", "application/octet-stream");
                put("pfx", "application/x-pkcs12");
                put("pgm", "image/x-portable-graymap");
                put("pic", "image/pict");
                put("pict", "image/pict");
                put("png", "image/png");
                put("pnm", "image/x-portable-anymap");
                put("pnt", "image/x-macpaint");
                put("pntg", "image/x-macpaint");
                put("pnz", "image/png");
                put("ppt", "application/vnd.ms-powerpoint");
                put("pptm", "application/vnd.ms-powerpoint.presentation.macroEnabled.12");
                put("pptx", "application/vnd.openxmlformats-officedocument.presentationml.presentation");
                put("ram", "audio/x-pn-realaudio");
                put("rar", "application/octet-stream");
                put("rm", "application/vnd.rn-realmedia");
                put("rmp", "application/vnd.rn-rn_music_package");
                put("safariextz", "application/x-safari-safariextz");
                put("sh", "application/x-sh");
                put("shtml", "text/html");
                put("tgz", "application/x-compressed");
                put("ts", "video/vnd.dlna.mpeg-tts");
                put("tsv", "text/tab-separated-values");
                put("ttf", "application/octet-stream");
                put("tts", "video/vnd.dlna.mpeg-tts");
                put("txt", "text/plain");
                put("u32", "application/octet-stream");
                put("vcproj", "Application/xml");
                put("vcs", "text/plain");
                put("vcxproj", "Application/xml");
                put("vddproj", "text/plain");
                put("vdp", "text/plain");
                put("vdproj", "text/plain");
                put("vdx", "application/vnd.ms-visio.viewer");
                put("vml", "text/xml");
                put("vscontent", "application/xml");
                put("vsct", "text/xml");
                put("vsd", "application/vnd.visio");
                put("vsi", "application/ms-vsi");
                put("vsix", "application/vsix");
                put("vsixlangpack", "text/xml");
                put("vsixmanifest", "text/xml");
                put("vsmdi", "application/xml");
                put("vspscc", "text/plain");
                put("vss", "application/vnd.visio");
                put("vsscc", "text/plain");
                put("vssettings", "text/xml");
                put("vssscc", "text/plain");
                put("vst", "application/vnd.visio");
                put("vstemplate", "text/xml");
                put("vsto", "application/x-ms-vsto");
                put("vsw", "application/vnd.visio");
                put("vsx", "application/vnd.visio");
                put("vtx", "application/vnd.visio");
                put("wav", "audio/wav");
                put("wave", "audio/wav");
                put("wax", "audio/x-ms-wax");
                put("wbk", "application/msword");
                put("wbmp", "image/vnd.wap.wbmp");
                put("wcm", "application/vnd.ms-works");
                put("wdb", "application/vnd.ms-works");
                put("wdp", "image/vnd.ms-photo");
                put("webarchive", "application/x-safari-webarchive");
                put("webtest", "application/xml");
                put("wiq", "application/xml");
                put("wiz", "application/msword");
                put("wks", "application/vnd.ms-works");
                put("WLMP", "application/wlmoviemaker");
                put("wlpginstall", "application/x-wlpg-detect");
                put("wlpginstall3", "application/x-wlpg3-detect");
                put("wm", "video/x-ms-wm");
                put("wma", "audio/x-ms-wma");
                put("wmd", "application/x-ms-wmd");
                put("wmf", "application/x-msmetafile");
                put("wml", "text/vnd.wap.wml");
                put("wmlc", "application/vnd.wap.wmlc");
                put("wmls", "text/vnd.wap.wmlscript");
                put("wmlsc", "application/vnd.wap.wmlscriptc");
                put("wmp", "video/x-ms-wmp");
                put("wmv", "video/x-ms-wmv");
                put("wmx", "video/x-ms-wmx");
                put("wmz", "application/x-ms-wmz");
                put("wpl", "application/vnd.ms-wpl");
                put("wps", "application/vnd.ms-works");
                put("wri", "application/x-mswrite");
                put("wrl", "x-world/x-vrml");
                put("wrz", "x-world/x-vrml");
                put("wsc", "text/scriptlet");
                put("wsdl", "text/xml");
                put("xhtml", "application/xhtml+xml");
                put("xls", "application/vnd.ms-excel");
                put("xlsx", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
                put("xml", "text/xml");
                put("XOML", "text/plain");
                put("zip", "application/x-zip-compressed");
            }
        };
    }

    /**
     * 日期路径 即年/月/日 如2013/01/03
     * @return
     */
    private static String datePath() {
        Date now = new Date();
        return DateFormatUtils.format(now, "yyyy/MM/dd");
    }

    public static String extractFilename(MultipartFile file) {
        String filename = file.getOriginalFilename();
//        LogUtil.debug(TAG, "org name: " + filename);
        int slashIndex = filename.indexOf("/");
        if (slashIndex >= 0) {
            filename = filename.substring(slashIndex + 1);
        }

        return datePath() + "/" + filename;
    }

    public static synchronized String uploadFiles(MultipartFile file){
        String filename = extractFilename(file);
        String contentType = ContentType.get(TextUtil.getExtensionName(filename));

        String url = null;
        // TODO: 2021/8/10 加密文件名
        try {
            url = MinioManager.uploadFile(file.getInputStream(), filename, contentType);
        } catch (IOException e) {
            e.printStackTrace();
        }
//        LogUtil.debug(TAG, "url: " + url);
        return url;
    }

}
