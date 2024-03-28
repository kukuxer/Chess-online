CREATE TABLE IF NOT EXISTS users
(
    id         SERIAL PRIMARY KEY,
    email      VARCHAR(100) UNIQUE,
    password   VARCHAR(100),
    username   VARCHAR(100) UNIQUE,
    in_game    BOOLEAN,
    created_at timestamp DEFAULT current_timestamp
);

-- Create requests table
CREATE TABLE IF NOT EXISTS requests
(
    id          SERIAL PRIMARY KEY,
    sender_id   INT         NOT NULL,
    receiver_id INT         NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at  timestamp DEFAULT current_timestamp,

    CONSTRAINT fk_requests_sender_id FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_requests_receiver_id FOREIGN KEY (receiver_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Create matches table
CREATE TABLE IF NOT EXISTS matches
(
    id          SERIAL PRIMARY KEY,
    sender_id   INT NOT NULL,
    receiver_id INT NOT NULL,
    white_user_id INT NOT NULL,
    winner_id   INT ,
    start_time  timestamp DEFAULT current_timestamp,
    end_time    timestamp,

    CONSTRAINT fk_matches_sender_id FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_matches_receiver_id FOREIGN KEY (receiver_id) REFERENCES users (id) ON DELETE CASCADE,
    CONSTRAINT fk_matches_winner_id FOREIGN KEY (winner_id) REFERENCES users (id) ON DELETE NO ACTION,
    CONSTRAINT fk_matches_white_user_id FOREIGN KEY (white_user_id) REFERENCES users (id) ON DELETE NO ACTION
);

-- Create match_history table
CREATE TABLE IF NOT EXISTS match_history
(
    id          SERIAL PRIMARY KEY,
    move_number INT NOT NULL ,
    user_id     INT,
    board       VARCHAR(200) NOT NULL,
    match_id    INT NOT NULL ,
    move_timestamp timestamp DEFAULT current_timestamp,


    CONSTRAINT fk_match_history_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ,
    CONSTRAINT fk_match_history_match_id FOREIGN KEY (match_id) REFERENCES matches (id) ON DELETE CASCADE
);
CREATE TABLE users_statistics (
                                  id SERIAL PRIMARY KEY,
                                  user_id INT NOT NULL,
                                  total_games_played INT NOT NULL DEFAULT 0,
                                  wins INT NOT NULL DEFAULT 0,
                                  losses INT NOT NULL DEFAULT 0,
                                  draws INT NOT NULL DEFAULT 0,
                                  rating INT NOT NULL DEFAULT 1000,
                                  CONSTRAINT fk_users_statistics_user_id FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);
create table if not exists users_roles
(
    user_id bigint       not null,
    role    varchar(255) not null,
    primary key (user_id, role),
    constraint fk_users_roles_users foreign key (user_id) references users (id) on delete cascade on update no action
);
CREATE TABLE IF NOT EXISTS users_matches
(
    user_id BIGINT NOT NULL,
    match_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, match_id),
    CONSTRAINT fk_users_matches_users FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_users_users_matches FOREIGN KEY (match_id) REFERENCES matches (id) ON DELETE CASCADE ON UPDATE NO ACTION
);