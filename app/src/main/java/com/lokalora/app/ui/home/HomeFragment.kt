package com.lokalora.app.ui.home
import android.os.Bundle
import android.view.*
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import com.lokalora.app.R
import com.lokalora.app.adapter.ProductAdapter
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentHomeBinding
import kotlinx.coroutines.launch

class HomeFragment : Fragment(R.layout.fragment_home) {
    private var _binding: FragmentHomeBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentHomeBinding.bind(view)
        
        val adapter = ProductAdapter { product ->
            val action = HomeFragmentDirections.actionHomeToProductDetail(product.id)
            findNavController().navigate(action)
        }
        binding.rvProducts.layoutManager = GridLayoutManager(context, 2)
        binding.rvProducts.adapter = adapter
        
        lifecycleScope.launch {
            val products = repo.getProducts()
            adapter.submitList(products)
        }
        binding.searchBar.setOnClickListener {
            findNavController().navigate(R.id.action_home_to_search)
        }
    }
    override fun onDestroyView() { super.onDestroyView(); _binding = null }
}
