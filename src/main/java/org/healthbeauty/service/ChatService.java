package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.Chat;
import org.healthbeauty.pojo.ChatExample;

public interface ChatService {
    public void insertChatSelective(Chat chat);

    public List<Chat> selectChatByExample(ChatExample chatExample);
}
