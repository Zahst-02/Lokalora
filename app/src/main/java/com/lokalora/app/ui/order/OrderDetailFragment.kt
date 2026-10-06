package com.lokalora.app.ui.order
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import com.lokalora.app.R
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentOrderDetailBinding
import kotlinx.coroutines.launch

class OrderDetailFragment : Fragment(R.layout.fragment_order_detail) {
    private var _binding: FragmentOrderDetailBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentOrderDetailBinding.bind(view)
        val orderId = arguments?.getString("orderId") ?: return
        
        lifecycleScope.launch {
            val order = repo.getOrder(orderId) ?: return@launch
            binding.tvOrderId.text = "Order ID: " + order.id
            binding.tvStatus.text = "Status: " + order.orderStatus
            binding.tvTotal.text = "Total: Rp " + order.total.toLong()
        }
    }
}
