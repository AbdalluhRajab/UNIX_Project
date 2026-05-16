CREATE TABLE IF NOT EXISTS items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  keyword VARCHAR(50) NOT NULL UNIQUE,
  recommendation VARCHAR(100) NOT NULL
);

INSERT INTO items (keyword, recommendation) VALUES
  ('hot',   'Summer'),
  ('cold',  'Winter'),
  ('rainy', 'Autumn'),
  ('mild',  'Spring'),
  ('snow',  'Winter'),
  ('warm',  'Spring'),
  ('windy', 'Autumn'),
  ('sunny', 'Summer');
