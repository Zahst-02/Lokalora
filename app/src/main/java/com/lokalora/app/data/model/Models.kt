package com.lokalora.app.data.model

data class Product(
    val id: String,
    val name: String,
    val description: String,
    val price: Double,
    val rating: Double,
    val sold: Int,
    val category: String,
    val origin: String,
    val imageUrl: String,
    val stock: Int,
    val variant: String
)

data class CartItem(
    val id: String,
    val productId: String,
    val productName: String,
    val productImage: String,
    val price: Double,
    var quantity: Int,
    val variant: String
)

data class Order(
    val id: String,
    val userId: String,
    val address: String,
    val city: String,
    val shippingMethod: String,
    val subtotal: Double,
    val shippingCost: Double,
    val total: Double,
    val paymentStatus: String,
    val orderStatus: String
)
