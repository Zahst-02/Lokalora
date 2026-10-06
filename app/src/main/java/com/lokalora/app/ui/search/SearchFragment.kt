package com.lokalora.app.ui.search
import android.os.Bundle
import android.view.*
import androidx.core.widget.addTextChangedListener
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import com.lokalora.app.R
import com.lokalora.app.adapter.ProductAdapter
import com.lokalora.app.data.repository.AppRepository
import com.lokalora.app.databinding.FragmentSearchBinding
import kotlinx.coroutines.launch

class SearchFragment : Fragment(R.layout.fragment_search) {
    private var _binding: FragmentSearchBinding? = null
    private val binding get() = _binding!!
    private val repo = AppRepository()

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        _binding = FragmentSearchBinding.bind(view)
        
        val adapter = ProductAdapter {
            val bundle = Bundle().apply { putString("productId", it.id) }
            findNavController().navigate(R.id.action_search_to_product_detail, bundle)
        }
        binding.rvProducts.layoutManager = GridLayoutManager(context, 2)
        binding.rvProducts.adapter = adapter
        
        binding.etSearch.addTextChangedListener {
            val q = it.toString()
            lifecycleScope.launch { adapter.submitList(repo.getProducts(q)) }
        }
    }
}
