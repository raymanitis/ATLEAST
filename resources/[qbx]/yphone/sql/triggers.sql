-- Like / unlike tweet triggers
DELIMITER //

CREATE TRIGGER IF NOT EXISTS twitter_update_like_count
AFTER INSERT ON yphone_twitter_likes
FOR EACH ROW
BEGIN
    -- Update like_count for the tweet
    UPDATE yphone_twitter_tweets
    SET like_count = like_count + 1
    WHERE id = NEW.tweet_id;
END//

CREATE TRIGGER IF NOT EXISTS twitter_decrease_like_count
AFTER DELETE ON yphone_twitter_likes
FOR EACH ROW
BEGIN
    -- Decrease like_count for the tweet
    UPDATE yphone_twitter_tweets
    SET like_count = like_count - 1
    WHERE id = OLD.tweet_id;
END//

-- Retweet / Unretweet tweet triggers
CREATE TRIGGER IF NOT EXISTS twitter_update_retweet_count
AFTER INSERT ON yphone_twitter_retweets
FOR EACH ROW
BEGIN
    -- Update retweet_count for the tweet
    UPDATE yphone_twitter_tweets
    SET retweet_count = retweet_count + 1
    WHERE id = NEW.tweet_id;
END//

CREATE TRIGGER IF NOT EXISTS twitter_decrease_retweet_count
AFTER DELETE ON yphone_twitter_retweets
FOR EACH ROW
BEGIN
    -- Decrease retweet_count for the tweet
    UPDATE yphone_twitter_tweets
    SET retweet_count = retweet_count - 1
    WHERE id = OLD.tweet_id;
END//

-- Follow / unfollow triggers
CREATE TRIGGER IF NOT EXISTS twitter_update_follow_counts
AFTER INSERT ON yphone_twitter_follows
FOR EACH ROW
BEGIN
    -- Update follower_count for the followed user
    UPDATE yphone_twitter_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Update following_count for the follower user
    UPDATE yphone_twitter_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END//

CREATE TRIGGER IF NOT EXISTS twitter_update_unfollow_counts
AFTER DELETE ON yphone_twitter_follows
FOR EACH ROW
BEGIN
    -- Update follower_count for the followed user
    UPDATE yphone_twitter_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Update following_count for the follower user
    UPDATE yphone_twitter_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END//

-- Instashots triggers

-- Like / unlike triggers

-- Increase
CREATE TRIGGER IF NOT EXISTS insta_update_like_count
AFTER INSERT ON yphone_instashots_likes
FOR EACH ROW
BEGIN
    -- Update like_count for the post
    UPDATE yphone_instashots_posts
    SET like_count = like_count + 1
    WHERE id = NEW.post_id;
END//

-- Decrease
CREATE TRIGGER IF NOT EXISTS insta_decrease_like_count
AFTER DELETE ON yphone_instashots_likes
FOR EACH ROW
BEGIN
    -- Decrease like_count for the post
    UPDATE yphone_instashots_posts
    SET like_count = like_count - 1
    WHERE id = OLD.post_id;
END//

-- Like / unlike triggers

-- Update comments count triggers
-- Increase
CREATE TRIGGER IF NOT EXISTS insta_update_comment_count
AFTER INSERT ON yphone_instashots_comments
FOR EACH ROW
BEGIN
    -- Update comment_count for the post
    UPDATE yphone_instashots_posts
    SET comment_count = comment_count + 1
    WHERE id = NEW.post_id;
END//

-- Decrease
CREATE TRIGGER IF NOT EXISTS insta_decrease_comment_count
AFTER DELETE ON yphone_instashots_comments
FOR EACH ROW
BEGIN
    -- Decrease comment_count for the post
    UPDATE yphone_instashots_posts
    SET comment_count = comment_count - 1
    WHERE id = OLD.post_id;
END//
-- Update comments count triggers

-- Update comment like count triggers
-- Increase
CREATE TRIGGER IF NOT EXISTS update_comment_like_count
AFTER INSERT ON yphone_instashots_likes
FOR EACH ROW
BEGIN
    IF NEW.is_comment = 1 THEN
        -- Update like_count for the corresponding comment
        UPDATE yphone_instashots_comments
        SET like_count = like_count + 1
        WHERE id = NEW.post_id;
    END IF;
END//

CREATE TRIGGER IF NOT EXISTS decrease_comment_like_count
AFTER DELETE ON yphone_instashots_likes
FOR EACH ROW
BEGIN
    IF OLD.is_comment = 1 THEN
        -- Decrease like_count for the corresponding comment
        UPDATE yphone_instashots_comments
        SET like_count = like_count - 1
        WHERE id = OLD.post_id;
    END IF;
END//

-- Follow / unfollow triggers
CREATE TRIGGER IF NOT EXISTS insta_update_follow_counts
AFTER INSERT ON yphone_instashots_follows
FOR EACH ROW
BEGIN
    -- Update follower_count for the followed user
    UPDATE yphone_instashots_accounts
    SET follower_count = follower_count + 1
    WHERE username = NEW.followed;

    -- Update following_count for the follower user
    UPDATE yphone_instashots_accounts
    SET following_count = following_count + 1
    WHERE username = NEW.follower;
END//

CREATE TRIGGER IF NOT EXISTS insta_update_unfollow_counts
AFTER DELETE ON yphone_instashots_follows
FOR EACH ROW
BEGIN
    -- Update follower_count for the followed user
    UPDATE yphone_instashots_accounts
    SET follower_count = follower_count - 1
    WHERE username = OLD.followed;

    -- Update following_count for the follower user
    UPDATE yphone_instashots_accounts
    SET following_count = following_count - 1
    WHERE username = OLD.follower;
END//

CREATE TRIGGER IF NOT EXISTS insta_increment_story_count
AFTER INSERT ON yphone_instashots_stories
FOR EACH ROW
BEGIN
    UPDATE yphone_instashots_accounts
    SET story_count = story_count + 1
    WHERE username = NEW.username;
END//

CREATE TRIGGER IF NOT EXISTS insta_decrement_story_count
AFTER DELETE ON yphone_instashots_stories
FOR EACH ROW
BEGIN
    UPDATE yphone_instashots_accounts
    SET story_count = story_count - 1
    WHERE username = OLD.username;
END//

-- End of Instashots triggers
DELIMITER ;
