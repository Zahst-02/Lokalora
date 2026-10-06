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
    inner class VH(val binding: ItemCartBinding) : RecyclerView.ViewHolder(binding.root) {
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
