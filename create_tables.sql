CREATE DATABASE event_management;
USE event_management;

""" Creating tables """
  
"""User"""
  
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,    """ or here we can use AUTO_INCREMENT in MYSQL WORKBENCH"""
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    city TEXT NOT NULL,
    registration_date DATE NOT NULL
);

"""Events """
CREATE TABLE Events (
    event_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    city TEXT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    status TEXT CHECK(status IN ('upcoming','completed','cancelled')),
    organizer_id INTEGER,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id)
);

"""Sessions """
CREATE TABLE Sessions (
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER,
    title TEXT NOT NULL,
    speaker_name TEXT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

"""Registrations """
CREATE TABLE Registrations (
    registration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    event_id INTEGER,
    registration_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

"""Feedback """
CREATE TABLE Feedback (
    feedback_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    event_id INTEGER,
    rating INTEGER CHECK(rating BETWEEN 1 AND 5),
    comments TEXT,
    feedback_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

"""Resources"""
CREATE TABLE Resources (
    resource_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER,
    resource_type TEXT CHECK(resource_type IN ('pdf','image','link')),
    resource_url TEXT NOT NULL,
    uploaded_at DATETIME NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);
