-- ============================================================
--  Recipe Planner - Nutrition API Seed Data
--  PostgreSQL schema + sample insert data
-- ============================================================

DROP TABLE IF EXISTS ingredient CASCADE;

CREATE TABLE ingredient (
    id               VARCHAR(50) PRIMARY KEY,
    slug             VARCHAR(100) UNIQUE NOT NULL,
    name             VARCHAR(100) NOT NULL,
    category_key     VARCHAR(50) NOT NULL,
    description      TEXT,
    calories         INTEGER,
    protein          NUMERIC(6,2),
    fat              NUMERIC(6,2),
    carbs            NUMERIC(6,2),
    updated_at       TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================
-- Insert example ingredients (these 3 match the assignment JSON)
-- ============================================================

INSERT INTO ingredient (id, slug, name, category_key, description, calories, protein, fat, carbs, updated_at) VALUES
('1a', 'tomato', 'Tomato', 'vegetable',
 'Fresh red tomato used in salads, soups, and sauces.',
 18, 0.9, 0.2, 3.9, '2025-10-01T10:15:00Z'),

('2a', 'cheese', 'Cheese', 'dairy',
 'High-fat dairy product, commonly used as topping or filling.',
 402, 25, 33, 1.3, '2025-10-01T10:15:00Z'),

('3a', 'flour', 'Flour', 'grain',
 'Powder made by grinding grains, used for baking and cooking.',
 364, 10, 1, 76, '2025-10-01T10:15:00Z');

-- ============================================================
-- Additional realistic ingredients (optional but useful)
-- ============================================================

INSERT INTO ingredient (id, slug, name, category_key, description, calories, protein, fat, carbs, updated_at) VALUES
('4a', 'onion', 'Onion', 'vegetable',
 'Common aromatic vegetable used for flavoring.', 
 40, 1.1, 0.1, 9.3, '2025-10-01T10:15:00Z'),

('5a', 'carrot', 'Carrot', 'vegetable',
 'Orange root vegetable rich in beta-carotene.',
 41, 0.9, 0.2, 10, '2025-10-01T10:15:00Z'),

('6a', 'chicken', 'Chicken', 'meat',
 'Lean white meat commonly used as protein source.',
 165, 31, 3.6, 0, '2025-10-01T10:15:00Z'),

('7a', 'beef', 'Beef', 'meat',
 'Red meat with high protein and fat.',
 250, 26, 15, 0, '2025-10-01T10:15:00Z'),

('8a', 'milk', 'Milk', 'dairy',
 'Dairy drink used in cooking and baking.',
 60, 3.2, 3.3, 5.0, '2025-10-01T10:15:00Z'),

('9a', 'butter', 'Butter', 'dairy',
 'High-fat dairy product used for frying and baking.',
 717, 0.9, 81, 0.1, '2025-10-01T10:15:00Z'),

('10a', 'rice', 'Rice', 'grain',
 'Staple grain used worldwide as a carbohydrate source.',
 130, 2.7, 0.3, 28.2, '2025-10-01T10:15:00Z'),

('11a', 'pasta', 'Pasta', 'grain',
 'Wheat-based noodle used in many cuisines.',
 131, 5.0, 1.1, 25, '2025-10-01T10:15:00Z'),

('12a', 'salt', 'Salt', 'spice',
 'Mineral used as seasoning.',
 0, 0, 0, 0, '2025-10-01T10:15:00Z'),

('13a', 'pepper', 'Pepper', 'spice',
 'Spicy seasoning used for flavor.',
 251, 10, 3.3, 64, '2025-10-01T10:15:00Z'),

('14a', 'apple', 'Apple', 'fruit',
 'Sweet fruit enjoyed raw or cooked.',
 52, 0.3, 0.2, 14, '2025-10-01T10:15:00Z'),

('15a', 'banana', 'Banana', 'fruit',
 'Sweet yellow fruit rich in potassium.',
 89, 1.1, 0.3, 23, '2025-10-01T10:15:00Z');

-- ============================================================
-- Verification 
-- ============================================================

SELECT category_key, COUNT(*) AS total_ingredients
FROM ingredient
GROUP BY category_key
ORDER BY category_key;

