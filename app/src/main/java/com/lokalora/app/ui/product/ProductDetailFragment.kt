package com.lokalora.app.ui.product
import android.os.Bundle
import android.view.*
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.bumptech.glide.Glide
import com.lokalora.app.R
import com.lokalora.app.data.model.CartItem
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentProductDetailBinding
import kotlinx.coroutines.launch

class ProductDetailFragment : Fragment(R.layout.fragment_product_detail) {
    private var _binding: FragmentProductDetailBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()
    private var qty = 1

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentProductDetailBinding.bind(view)
        
        val productId = arguments?.getString("productId") ?: return
        
        lifecycleScope.launch {
            val product = repo.getProduct(productId) ?: return@launch
            binding.tvName.text = product.name
            binding.tvPrice.text = "Rp " + product.price.toLong()
            binding.tvDesc.text = product.description
            Glide.with(this@ProductDetailFragment).load(product.imageUrl).into(binding.ivImage)
            
            binding.btnPlus.setOnClickListener { qty++; binding.tvQty.text = qty.toString() }
            binding.btnMinus.setOnClickListener { if(qty>1) qty--; binding.tvQty.text = qty.toString() }
            
            binding.btnAddCart.setOnClickListener {
                lifecycleScope.launch {
                    val item = CartItem(java.util.UUID.randomUUID().toString(), product.id, product.name, product.imageUrl, product.price, qty, "Default")
                    repo.addToCart(item)
                    Toast.makeText(context, "Berhasil masuk keranjang", Toast.LENGTH_SHORT).show()
                    findNavController().navigate(R.id.action_detail_to_cart)
                }
            }
        }
    }
}
