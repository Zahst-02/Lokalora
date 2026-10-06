package com.lokalora.app.ui.payment
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.lokalora.app.R
import com.lokalora.app.databinding.FragmentPaymentSuccessBinding

class PaymentSuccessFragment : Fragment(R.layout.fragment_payment_success) {
    private var _binding: FragmentPaymentSuccessBinding? = null
    private val binding get() = _binding!!

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentPaymentSuccessBinding.bind(view)
        
        val orderId = arguments?.getString("orderId") ?: return
        binding.btnLihat.setOnClickListener {
            val bundle = Bundle().apply { putString("orderId", orderId) }
            findNavController().navigate(R.id.action_success_to_order_detail, bundle)
        }
    }
}
