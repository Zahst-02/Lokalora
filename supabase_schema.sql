-- Supabase Schema for Lokalora

-- 1. Table: products
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price NUMERIC NOT NULL,
    rating NUMERIC DEFAULT 0,
    sold INTEGER DEFAULT 0,
    category VARCHAR(100),
    origin VARCHAR(100),
    image_url TEXT,
    stock INTEGER DEFAULT 0,
    variant TEXT, -- JSON string or comma separated
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Table: cart
CREATE TABLE cart (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    product_name VARCHAR(255) NOT NULL,
    product_image TEXT,
    price NUMERIC NOT NULL,
    quantity INTEGER DEFAULT 1,
    variant TEXT,
    user_id VARCHAR(255) NOT NULL, -- using string for simple user tracking or UUID if using Auth
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Table: orders
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    shipping_method VARCHAR(50) NOT NULL,
    subtotal NUMERIC NOT NULL,
    shipping_cost NUMERIC NOT NULL,
    total NUMERIC NOT NULL,
    payment_status VARCHAR(50) DEFAULT 'Menunggu Pembayaran',
    order_status VARCHAR(50) DEFAULT 'Diproses',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Table: order_items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    product_name VARCHAR(255) NOT NULL,
    price NUMERIC NOT NULL,
    quantity INTEGER NOT NULL,
    variant TEXT,
    subtotal NUMERIC NOT NULL
);

-- 5. Table: payment
CREATE TABLE payment (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    virtual_account VARCHAR(50) NOT NULL,
    amount NUMERIC NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    expired_at TIMESTAMP WITH TIME ZONE,
    paid_at TIMESTAMP WITH TIME ZONE
);

-- Insert Dummy Data for products
INSERT INTO products (name, description, price, rating, sold, category, origin, image_url, stock, variant) VALUES
('Kopi Arabica Gayo 250g', 'Kopi asli dari dataran tinggi Gayo, Aceh. Notes: Fruity, Chocolate.', 75000, 4.8, 125, 'Minuman', 'Aceh', 'https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=500&q=80', 50, 'Biji,Bubuk Kasar,Bubuk Halus'),
('Batik Tulis Lasem Klasik', 'Kain batik tulis asli Lasem dengan motif klasik warna sogan dan merah.', 350000, 4.9, 42, 'Fashion Lokal', 'Rembang', 'https://images.unsplash.com/photo-1605337222474-5c9c10bd9b2c?w=500&q=80', 15, 'Satu Ukuran'),
('Keripik Tempe Sagu', 'Cemilan khas Bandung, renyah dan gurih. Kemasan 200gr.', 20000, 4.5, 300, 'Makanan', 'Bandung', 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=500&q=80', 100, 'Original,Pedas,Keju'),
('Tas Anyaman Rotan Bali', 'Tas selempang wanita bahan rotan asli buatan pengrajin Bali. Diameter 20cm.', 125000, 4.7, 89, 'Kerajinan', 'Bali', 'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=500&q=80', 25, 'Natural,Coklat Tua'),
('Sambal Roa Manado 150g', 'Sambal khas Manado dengan campuran ikan roa asap. Pedas mantap.', 45000, 4.6, 210, 'Makanan', 'Manado', 'https://images.unsplash.com/photo-1582035384157-1901a1460c23?w=500&q=80', 60, 'Sedang,Ekstra Pedas'),
('Gelang Kayu Gaharu', 'Gelang kesehatan dari kayu gaharu asli kalimantan. Wangi natural.', 85000, 4.8, 56, 'Aksesoris', 'Kalimantan', 'https://images.unsplash.com/photo-1611082531818-f230f82b7ba4?w=500&q=80', 40, '8mm,10mm,12mm'),
('Kaos Polos Katun Bambu', 'Kaos lokal bahan katun bambu, sangat lembut, anti bakteri dan menyerap keringat.', 65000, 4.9, 450, 'Fashion Lokal', 'Bandung', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&q=80', 200, 'S,M,L,XL'),
('Madu Hutan Sumbawa 500g', 'Madu murni dari hutan liar Sumbawa. Kualitas terjamin.', 110000, 4.7, 134, 'Minuman', 'Sumbawa', 'https://images.unsplash.com/photo-1587049352847-4d4b1242c4b0?w=500&q=80', 30, '500g,1kg'),
('Tenun Ikat Sumba', 'Kain tenun ikat tradisional Sumba, pewarna alam. Ukuran 240x120cm.', 850000, 5.0, 12, 'Fashion Lokal', 'NTT', 'https://images.unsplash.com/photo-1581452243764-16a8d6268817?w=500&q=80', 5, 'Satu Ukuran'),
('Kerupuk Udang Sidoarjo', 'Kerupuk udang mentah super, rasanya sangat udang.', 35000, 4.6, 180, 'Oleh-oleh', 'Sidoarjo', 'https://images.unsplash.com/photo-1621815124045-812e1281dbd9?w=500&q=80', 80, 'Kecil,Besar'),
('Sepatu Sneakers Kanvas Lokal', 'Sneakers brand lokal bahan kanvas tebal, insole empuk.', 250000, 4.8, 220, 'Fashion Lokal', 'Jakarta', 'https://images.unsplash.com/photo-1560769629-975ec94e6a86?w=500&q=80', 45, '39,40,41,42,43'),
('Kopi Susu Gula Aren Literan', 'Kopi susu dengan gula aren asli 1 liter. Tahan 3 hari di kulkas.', 70000, 4.9, 310, 'Minuman', 'Jakarta', 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500&q=80', 20, 'Normal,Less Sugar'),
('Pajangan Kayu Jati', 'Pajangan unik dari akar kayu jati, cocok untuk dekorasi rumah/cafe.', 175000, 4.7, 28, 'Kerajinan', 'Jepara', 'https://images.unsplash.com/photo-1520697926130-1017e4f9b884?w=500&q=80', 10, 'Satu Ukuran'),
('Dompet Kulit Garut', 'Dompet pria bahan kulit sapi asli dari Garut. Awet bertahun-tahun.', 140000, 4.8, 155, 'Aksesoris', 'Garut', 'https://images.unsplash.com/photo-1605367332219-482200dc896d?w=500&q=80', 35, 'Coklat,Hitam'),
('Teh Hitam Kayu Aro 200g', 'Teh ortodoks kualitas ekspor dari perkebunan teh tertinggi kedua di dunia.', 55000, 4.7, 88, 'Minuman', 'Jambi', 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?w=500&q=80', 50, 'Bubuk,Celup');
