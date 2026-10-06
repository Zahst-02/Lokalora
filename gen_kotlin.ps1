$dir = "C:\Users\Zahdazst\.gemini\antigravity\scratch\Lokalora\app\src\main"
$java = "$dir\java\com\lokalora\app"
$res = "$dir\res"

function Write-File {
    param([string]$path, [string]$content)
    $content | Out-File -FilePath $path -Encoding utf8 -Force
}

Write-File "$java\adapter\ProductAdapter.kt" @"
package com.lokalora.app.adapter
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.lokalora.app.data.model.Product
import com.lokalora.app.databinding.ItemProductBinding

class ProductAdapter(private val onClick: (Product) -> Unit) : RecyclerView.Adapter<ProductAdapter.VH>() {
    private var list = listOf<Product>()
    fun submitList(newList: List<Product>) { list = newList; notifyDataSetChanged() }
    inner class VH(val binding: ItemProductBinding) : RecyclerView.Adapter<VH>(binding.root) {
        fun bind(product: Product) {
            binding.tvName.text = product.name
            binding.tvPrice.text = "Rp " + product.price.toLong()
            Glide.with(binding.root).load(product.imageUrl).into(binding.ivImage)
            binding.root.setOnClickListener { onClick(product) }
        }
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = VH(ItemProductBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    override fun onBindViewHolder(holder: VH, position: Int) = holder.bind(list[position])
    override fun getItemCount() = list.size
}
"@

Write-File "$java\adapter\CartAdapter.kt" @"
package com.lokalora.app.adapter
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.lokalora.app.data.model.CartItem
import com.lokalora.app.databinding.ItemCartBinding

class CartAdapter(
    private val onIncrease: (CartItem) -> Unit,
    private val onDecrease: (CartItem) -> Unit,
    private val onDelete: (CartItem) -> Unit
) : RecyclerView.Adapter<CartAdapter.VH>() {
    private var list = listOf<CartItem>()
    fun submitList(newList: List<CartItem>) { list = newList; notifyDataSetChanged() }
    inner class VH(val binding: ItemCartBinding) : RecyclerView.Adapter<VH>(binding.root) {
        fun bind(item: CartItem) {
            binding.tvName.text = item.productName
            binding.tvPrice.text = "Rp " + item.price.toLong()
            binding.tvQty.text = item.quantity.toString()
            Glide.with(binding.root).load(item.productImage).into(binding.ivImage)
            binding.btnPlus.setOnClickListener { onIncrease(item) }
            binding.btnMinus.setOnClickListener { onDecrease(item) }
            binding.btnDelete.setOnClickListener { onDelete(item) }
        }
    }
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = VH(ItemCartBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    override fun onBindViewHolder(holder: VH, position: Int) = holder.bind(list[position])
    override fun getItemCount() = list.size
}
"@

Write-File "$java\ui\home\HomeFragment.kt" @"
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
"@

Write-File "$java\ui\home\HomeFragmentDirections.kt" @"
package com.lokalora.app.ui.home
import android.os.Bundle
import androidx.navigation.NavDirections
import com.lokalora.app.R
class HomeFragmentDirections {
    companion object {
        fun actionHomeToProductDetail(productId: String) = object : NavDirections {
            override val actionId = R.id.action_home_to_product_detail
            override val arguments = Bundle().apply { putString("productId", productId) }
        }
    }
}
"@

Write-File "$java\ui\search\SearchFragment.kt" @"
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
"@

Write-File "$java\ui\product\ProductDetailFragment.kt" @"
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
"@

Write-File "$java\ui\cart\CartFragment.kt" @"
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
"@

Write-File "$java\ui\checkout\CheckoutFragment.kt" @"
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
"@

Write-File "$java\ui\payment\PaymentFragment.kt" @"
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
"@

Write-File "$java\ui\payment\PaymentSuccessFragment.kt" @"
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
"@

Write-File "$java\ui\order\OrderDetailFragment.kt" @"
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
"@

Write-File "$java\ui\order\OrdersFragment.kt" @"
package com.lokalora.app.ui.order
import androidx.fragment.app.Fragment
import com.lokalora.app.R
class OrdersFragment : Fragment(R.layout.fragment_orders)
"@

Write-File "$java\ui\profile\ProfileFragment.kt" @"
package com.lokalora.app.ui.profile
import androidx.fragment.app.Fragment
import com.lokalora.app.R
class ProfileFragment : Fragment(R.layout.fragment_profile)
"@
