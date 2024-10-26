CREATE DATABASE SocialHubDB;
USE SocialHubDB;
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Status VARCHAR(20) DEFAULT 'active'
);
CREATE TABLE UserProfiles (
    ProfileID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    FullName VARCHAR(100),
    Bio TEXT,
    Location VARCHAR(100),
    ProfilePicURL VARCHAR(255),
    FollowersCount INT DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE UserPosts (
    PostID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Content TEXT NOT NULL,
    PostDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LikesCount INT DEFAULT 0,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE PostComments (
    CommentID INT PRIMARY KEY AUTO_INCREMENT,
    PostID INT,
    UserID INT,
    CommentText TEXT,
    CommentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES UserPosts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE PostLikes (
    LikeID INT PRIMARY KEY AUTO_INCREMENT,
    PostID INT,
    UserID INT,
    LikeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES UserPosts(PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE Tags (
    TagID INT PRIMARY KEY AUTO_INCREMENT,
    TagName VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE PostTags (
    PostTagID INT PRIMARY KEY AUTO_INCREMENT,
    PostID INT,
    TagID INT,
    FOREIGN KEY (PostID) REFERENCES UserPosts(PostID),
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
);
CREATE TABLE Followings (
    FollowID INT PRIMARY KEY AUTO_INCREMENT,
    FollowerID INT,
    FollowedID INT,
    FollowDate DATE,
    FOREIGN KEY (FollowerID) REFERENCES Users(UserID),
    FOREIGN KEY (FollowedID) REFERENCES Users(UserID)
);
CREATE TABLE UserNotifications (
    NotificationID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    NotificationType VARCHAR(50),
    NotificationContent TEXT,
    NotificationDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
INSERT INTO Users (Username, Email, PasswordHash) VALUES 
('alice', 'alice@example.com', 'hashA123'),
('bob', 'bob@example.com', 'hashB456'),
('charlie', 'charlie@example.com', 'hashC789');
INSERT INTO UserProfiles (UserID, FullName, Bio, Location, ProfilePicURL) VALUES 
(1, 'Alice Johnson', 'Nature lover and photographer', 'Seattle', 'url_to_pic1'),
(2, 'Bob Smith', 'Foodie and traveler', 'Boston', 'url_to_pic2'),
(3, 'Charlie Brown', 'Music enthusiast', 'New York', 'url_to_pic3');
INSERT INTO UserPosts (UserID, Content) VALUES 
(1, 'Exploring the mountains today! #Adventure'),
(2, 'Just tried the best burger in town! #Foodie'),
(3, 'Listening to some classics. #Music');
SELECT * FROM UserProfiles;
SELECT UserPosts.Content 
FROM UserPosts 
JOIN PostTags ON UserPosts.PostID = PostTags.PostID
JOIN Tags ON PostTags.TagID = Tags.TagID
WHERE Tags.TagName = 'Adventure';
SELECT COUNT(*) AS FollowerCount 
FROM Followings 
WHERE FollowedID = 1;
















