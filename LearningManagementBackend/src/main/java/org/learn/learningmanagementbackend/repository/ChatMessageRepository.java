package org.learn.learningmanagementbackend.repository;

import org.learn.learningmanagementbackend.model.ChatMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {

    @Query("SELECT m FROM ChatMessage m WHERE " +
           "(m.senderEmail = :user1 AND m.receiverEmail = :user2) OR " +
           "(m.senderEmail = :user2 AND m.receiverEmail = :user1) " +
           "ORDER BY m.timestamp ASC")
    List<ChatMessage> findChatHistory(@Param("user1") String user1, @Param("user2") String user2);

    @Query("SELECT m FROM ChatMessage m WHERE m.senderEmail = :email OR m.receiverEmail = :email ORDER BY m.timestamp DESC")
    List<ChatMessage> findRecentChatsForUser(@Param("email") String email);
}
