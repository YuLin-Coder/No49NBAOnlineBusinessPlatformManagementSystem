package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.Comment;
import org.healthbeauty.pojo.CommentExample;

public interface CommentService {
    public void insertSelective(Comment comment);

    public List<Comment> selectByExample(CommentExample commentExample);
}
