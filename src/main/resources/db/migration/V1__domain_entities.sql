CREATE TABLE categories(
  id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE businesses(
  id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  business_name TEXT NOT NULL,
  rating INT DEFAULT 0,
  price_level INT,
  opening_hours INT,
  location INT,
  user_id BIGINT,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  CONSTRAINT fk_business_user FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE business_category(
  category_id BIGINT NOT NULL,
  business_id BIGINT NOT NULL,
  CONSTRAINT fk_bc_category_id FOREIGN KEY(category_id) REFERENCES categories(id),
  CONSTRAINT fk_bc_business_id FOREIGN KEY(business_id) REFERENCES businesses(id),
  PRIMARY KEY(category_id,business_id)
);


CREATE TABLE reviews(
  id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  comment TEXT,
  rating INT DEFAULT 0,
  user_id BIGINT,
  business_id BIGINT,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  CONSTRAINT fk_review_user FOREIGN KEY(user_id) REFERENCES users(id),
  CONSTRAINT fk_review_business FOREIGN KEY(business_id) REFERENCES businesses(id)
);

CREATE TABLE favorites(
  id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  CONSTRAINT fk_favorite_user FOREIGN KEY(user_id) REFERENCES users(id)
);



