package org.healthbeauty.pojo;

import java.util.Date;

public class Favorite extends FavoriteKey {
    private Date collecttime;

    public Date getCollecttime() {
        return collecttime;
    }

    public void setCollecttime(Date collecttime) {
        this.collecttime = collecttime;
    }
}