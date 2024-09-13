DELIMITER //

CREATE PROCEDURE twitter_insert_or_update_notification(
    IN p_username VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_from VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_type VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_postId INT,
    IN p_attachments TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE existing_notification_id INT;

    IF p_type = 'follow' THEN
        -- Check if a "follow" notification entry already exists for the given username and from account
        SELECT id INTO existing_notification_id
        FROM yphone_twitter_notifications
        WHERE username = p_username AND `from` = p_from AND type = p_type;
    ELSE
        IF p_postId IS NOT NULL THEN
            -- Check if a notification entry already exists for the given postId and type
            SELECT id INTO existing_notification_id
            FROM yphone_twitter_notifications
            WHERE post_id = p_postId AND type = p_type;
        ELSE
            -- Check if a notification entry already exists for the given username and type
            SELECT id INTO existing_notification_id
            FROM yphone_twitter_notifications
            WHERE username = p_username AND type = p_type;
        END IF;
    END IF;

    IF existing_notification_id IS NOT NULL THEN
        -- Update the timestamp and attachments for the existing entry
        UPDATE yphone_twitter_notifications
        SET TIMESTAMP = CURRENT_TIMESTAMP, attachments = p_attachments
        WHERE id = existing_notification_id;
    ELSE
        -- Insert a new notification entry
        IF p_postId IS NOT NULL THEN
            -- Insert with postId
            INSERT INTO yphone_twitter_notifications (
                username,
                `from`,
                `type`,
                post_id,
                attachments
            )
            VALUES (
                p_username,
                p_from,
                p_type,
                p_postId,
                p_attachments
            );
        ELSE
            -- Insert without postId
            INSERT INTO yphone_twitter_notifications (
                username,
                `from`,
                `type`,
                attachments
            )
            VALUES (
                p_username,
                p_from,
                p_type,
                p_attachments
            );
        END IF;
    END IF;
END //

DELIMITER ;

DELIMITER //

-- Create a stored procedure to handle the insertion or update of notifications
CREATE PROCEDURE insta_insert_or_update_notification(
    IN p_username VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_from VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_type VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    IN p_postId INT,
    IN p_attachments TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
)
BEGIN
    DECLARE existing_notification_id INT;

    IF p_type = 'follow' THEN
        -- Check if a "follow" notification entry already exists for the given username and from account
        SELECT id INTO existing_notification_id
        FROM yphone_instashots_notifications
        WHERE username = p_username AND `from` = p_from AND type = p_type;
    ELSE
        IF p_postId IS NOT NULL THEN
            -- Check if a notification entry already exists for the given postId and type
            SELECT id INTO existing_notification_id
            FROM yphone_instashots_notifications
            WHERE post_id = p_postId AND type = p_type;
        ELSE
            -- Check if a notification entry already exists for the given username and type
            SELECT id INTO existing_notification_id
            FROM yphone_instashots_notifications
            WHERE username = p_username AND type = p_type;
        END IF;
    END IF;

    IF existing_notification_id IS NOT NULL THEN
        -- Update the timestamp and attachments for the existing entry
        UPDATE yphone_instashots_notifications
        SET TIMESTAMP = CURRENT_TIMESTAMP, attachments = p_attachments
        WHERE id = existing_notification_id;
    ELSE
        -- Insert a new notification entry
        IF p_postId IS NOT NULL THEN
            -- Insert with postId
            INSERT INTO yphone_instashots_notifications (
                username,
                `from`,
                `type`,
                post_id,
                attachments
            )
            VALUES (
                p_username,
                p_from,
                p_type,
                p_postId,
                p_attachments
            );
        ELSE
            -- Insert without postId
            INSERT INTO yphone_instashots_notifications (
                username,
                `from`,
                `type`,
                attachments
            )
            VALUES (
                p_username,
                p_from,
                p_type,
                p_attachments
            );
        END IF;
    END IF;
END //

DELIMITER ;
