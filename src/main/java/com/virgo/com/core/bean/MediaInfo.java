package com.virgo.com.core.bean;

/**
 * 媒体的一些信息
 */
public class MediaInfo extends BaseBean{
    private int width;//宽
    private int height;//高
    private long size;//文件大小
    private long durition;//时长 s

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public long getDurition() {
        return durition;
    }

    public void setDurition(long durision) {
        this.durition = durision;
    }

    /**
     * 分辨率 w*h
     * @return
     */
    public String getResolve() {
        if(width>0 && height>0){
            return width + " * " + height;
        }
        return "未知";
    }

    @Override
    public String toString() {
        return "MediaInfo{" +
                "width=" + width +
                ", height=" + height +
                ", size=" + size +
                ", durition=" + durition +
                '}';
    }
}
