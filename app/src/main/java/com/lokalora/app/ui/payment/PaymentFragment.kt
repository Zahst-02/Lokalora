package com.lokalora.app.ui.payment
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.lokalora.app.R
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentPaymentBinding
import kotlinx.coroutines.launch

class PaymentFragment : Fragment(R.layout.fragment_payment) {
    private var _binding: FragmentPaymentBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentPaymentBinding.bind(view)
        
        val orderId = arguments?.getString("orderId") ?: return
        
        lifecycleScope.launch {
            val order = repo.getOrder(orderId) ?: return@launch
            binding.tvTotal.text = "Total Bayar: Rp " + order.total.toLong()
        }
        
        binding.btnCekStatus.setOnClickListener {
            lifecycleScope.launch {
                repo.updateOrderStatus(orderId, "Diproses", "Berhasil")
                val bundle = Bundle().apply { putString("orderId", orderId) }
                findNavController().navigate(R.id.action_payment_to_success, bundle)
            }
        }
    }
}
