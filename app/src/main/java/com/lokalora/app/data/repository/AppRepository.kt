package com.lokalora.app.data.repository

import com.lokalora.app.data.model.CartItem
import com.lokalora.app.data.model.Order
import com.lokalora.app.data.model.Product
import kotlinx.coroutines.delay

class AppRepository {

    private val products = mutableListOf(
        Product("1", "Kopi Arabica Gayo 250g", "Kopi asli dari dataran tinggi Gayo, Aceh. Notes: Fruity, Chocolate.", 75000.0, 4.8, 125, "Minuman", "Aceh", "https://images.unsplash.com/photo-1559525839-b184a4d698c7?w=500&q=80", 50, "Biji,Bubuk Kasar,Bubuk Halus"),
        Product("2", "Batik Tulis Lasem Klasik", "Kain batik tulis asli Lasem dengan motif klasik warna sogan dan merah.", 350000.0, 4.9, 42, "Fashion Lokal", "Rembang", "https://images.unsplash.com/photo-1605337222474-5c9c10bd9b2c?w=500&q=80", 15, "Satu Ukuran"),
        Product("3", "Keripik Tempe Sagu", "Cemilan khas Bandung, renyah dan gurih. Kemasan 200gr.", 20000.0, 4.5, 300, "Makanan", "Bandung", "https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=500&q=80", 100, "Original,Pedas,Keju"),
        Product("4", "Tas Anyaman Rotan Bali", "Tas selempang wanita bahan rotan asli buatan pengrajin Bali. Diameter 20cm.", 125000.0, 4.7, 89, "Kerajinan", "Bali", "https://images.unsplash.com/photo-1591561954557-26941169b49e?w=500&q=80", 25, "Natural,Coklat Tua"),
        Product("5", "Sambal Roa Manado 150g", "Sambal khas Manado dengan campuran ikan roa asap. Pedas mantap.", 45000.0, 4.6, 210, "Makanan", "Manado", "https://images.unsplash.com/photo-1582035384157-1901a1460c23?w=500&q=80", 60, "Sedang,Ekstra Pedas")
    )

    private val cartItems = mutableListOf<CartItem>()
    private val orders = mutableListOf<Order>()

    suspend fun getProducts(query: String? = null): List<Product> {
        delay(500) // simulate network
        return if (query.isNullOrEmpty()) {
            products
        } else {
            products.filter { it.name.contains(query, ignoreCase = true) }
        }
    }

    suspend fun getProduct(id: String): Product? {
        delay(300)
        return products.find { it.id == id }
    }

    suspend fun getCart(): List<CartItem> {
        delay(300)
        return cartItems.toList()
    }

    suspend fun addToCart(cartItem: CartItem) {
        delay(300)
        val existing = cartItems.find { it.productId == cartItem.productId }
        if (existing != null) {
            existing.quantity += cartItem.quantity
        } else {
            cartItems.add(cartItem)
        }
    }

    suspend fun updateCartQuantity(cartId: String, quantity: Int) {
        delay(300)
        cartItems.find { it.id == cartId }?.quantity = quantity
    }

    suspend fun removeFromCart(cartId: String) {
        delay(300)
        cartItems.removeIf { it.id == cartId }
    }

    suspend fun clearCart() {
        delay(300)
        cartItems.clear()
    }

    suspend fun checkout(order: Order): String {
        delay(800)
        val newOrder = order.copy(id = java.util.UUID.randomUUID().toString())
        orders.add(newOrder)
        cartItems.clear()
        return newOrder.id
    }

    suspend fun getOrder(orderId: String): Order? {
        delay(300)
        return orders.find { it.id == orderId }
    }

    suspend fun updateOrderStatus(orderId: String, status: String, paymentStatus: String) {
        delay(300)
        val orderIndex = orders.indexOfFirst { it.id == orderId }
        if (orderIndex != -1) {
            val order = orders[orderIndex]
            orders[orderIndex] = order.copy(orderStatus = status, paymentStatus = paymentStatus)
        }
    }
}
