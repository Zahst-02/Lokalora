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
    inner class VH(val binding: ItemProductBinding) : RecyclerView.ViewHolder(binding.root) {
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
