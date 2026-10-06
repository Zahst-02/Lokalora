package com.lokalora.app.ui.checkout
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.lokalora.app.R
import com.lokalora.app.data.model.Order
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentCheckoutBinding
import kotlinx.coroutines.launch

class CheckoutFragment : Fragment(R.layout.fragment_checkout) {
    private var _binding: FragmentCheckoutBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentCheckoutBinding.bind(view)
        
        var subtotal = 0.0
        val shipping = 10000.0
        
        lifecycleScope.launch {
            val cart = repo.getCart()
            subtotal = cart.sumOf { it.price * it.quantity }
            binding.tvSubtotal.text = "Rp " + subtotal.toLong()
            binding.tvTotal.text = "Rp " + (subtotal + shipping).toLong()
        }
        
        binding.btnOrder.setOnClickListener {
            lifecycleScope.launch {
                val order = Order("", "user1", "Alamat: Kota Cirebon", "Cirebon", "Reguler", subtotal, shipping, subtotal+shipping, "Menunggu Pembayaran", "Pending")
                val orderId = repo.checkout(order)
                val bundle = Bundle().apply { putString("orderId", orderId) }
                findNavController().navigate(R.id.action_checkout_to_payment, bundle)
            }
        }
    }
}
