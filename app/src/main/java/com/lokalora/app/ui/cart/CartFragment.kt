package com.lokalora.app.ui.cart
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.LinearLayoutManager
import com.lokalora.app.R
import com.lokalora.app.adapter.CartAdapter
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentCartBinding
import kotlinx.coroutines.launch

class CartFragment : Fragment(R.layout.fragment_cart) {
    private var _binding: FragmentCartBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()
    private lateinit var adapter: CartAdapter

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentCartBinding.bind(view)
        
        adapter = CartAdapter(
            onIncrease = { lifecycleScope.launch { repo.updateCartQuantity(it.id, it.quantity+1); load() } },
            onDecrease = { lifecycleScope.launch { if(it.quantity>1) repo.updateCartQuantity(it.id, it.quantity-1); load() } },
            onDelete = { lifecycleScope.launch { repo.removeFromCart(it.id); load() } }
        )
        binding.rvCart.layoutManager = LinearLayoutManager(context)
        binding.rvCart.adapter = adapter
        
        binding.btnCheckout.setOnClickListener { findNavController().navigate(R.id.action_cart_to_checkout) }
        load()
    }
    private fun load() {
        lifecycleScope.launch {
            val cart = repo.getCart()
            adapter.submitList(cart)
            val subtotal = cart.sumOf { it.price * it.quantity }
            binding.tvSubtotal.text = "Rp " + subtotal.toLong()
            binding.btnCheckout.isEnabled = cart.isNotEmpty()
        }
    }
}
