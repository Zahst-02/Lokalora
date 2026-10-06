$dir = "C:\Users\Zahdazst\.gemini\antigravity\scratch\Lokalora\app\src\main\res\layout"

function Write-File {
    param([string]$path, [string]$content)
    $content | Out-File -FilePath $path -Encoding utf8 -Force
}

Write-File "$dir\item_product.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<androidx.cardview.widget.CardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_margin="8dp"
    app:cardCornerRadius="14dp"
    app:cardElevation="2dp">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical">
        <ImageView android:id="@+id/ivImage" android:layout_width="match_parent" android:layout_height="150dp" android:scaleType="centerCrop"/>
        <TextView android:id="@+id/tvName" android:layout_width="match_parent" android:layout_height="wrap_content" android:padding="8dp" android:textColor="@color/text_primary" android:textStyle="bold" android:maxLines="2"/>
        <TextView android:id="@+id/tvPrice" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingHorizontal="8dp" android:paddingBottom="8dp" android:textColor="@color/secondary" android:textStyle="bold"/>
    </LinearLayout>
</androidx.cardview.widget.CardView>
"@

Write-File "$dir\item_cart.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<androidx.cardview.widget.CardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_margin="8dp"
    app:cardCornerRadius="14dp"
    app:cardElevation="2dp">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:padding="8dp">
        <ImageView android:id="@+id/ivImage" android:layout_width="80dp" android:layout_height="80dp" android:scaleType="centerCrop"/>
        <LinearLayout android:layout_width="0dp" android:layout_height="wrap_content" android:layout_weight="1" android:orientation="vertical" android:paddingHorizontal="8dp">
            <TextView android:id="@+id/tvName" android:layout_width="match_parent" android:layout_height="wrap_content" android:textColor="@color/text_primary" android:textStyle="bold"/>
            <TextView android:id="@+id/tvPrice" android:layout_width="match_parent" android:layout_height="wrap_content" android:textColor="@color/secondary"/>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginTop="8dp">
                <Button android:id="@+id/btnMinus" android:layout_width="40dp" android:layout_height="40dp" android:text="-" android:backgroundTint="@color/background" android:textColor="@color/text_primary"/>
                <TextView android:id="@+id/tvQty" android:layout_width="40dp" android:layout_height="match_parent" android:gravity="center" android:text="1"/>
                <Button android:id="@+id/btnPlus" android:layout_width="40dp" android:layout_height="40dp" android:text="+" android:backgroundTint="@color/background" android:textColor="@color/text_primary"/>
            </LinearLayout>
        </LinearLayout>
        <ImageButton android:id="@+id/btnDelete" android:layout_width="wrap_content" android:layout_height="wrap_content" android:src="@android:drawable/ic_menu_delete" android:background="?selectableItemBackground"/>
    </LinearLayout>
</androidx.cardview.widget.CardView>
"@

Write-File "$dir\fragment_home.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/background">
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="LOKALORA" android:textSize="24sp" android:textStyle="bold" android:textColor="@color/primary" android:padding="16dp"/>
    <EditText android:id="@+id/searchBar" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="@string/search_hint" android:layout_marginHorizontal="16dp" android:focusable="false" android:clickable="true"/>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/rvProducts" android:layout_width="match_parent" android:layout_height="match_parent" android:padding="8dp"/>
</LinearLayout>
"@

Write-File "$dir\fragment_search.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:background="@color/background">
    <EditText android:id="@+id/etSearch" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="@string/search_hint" android:layout_margin="16dp"/>
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/rvProducts" android:layout_width="match_parent" android:layout_height="match_parent" android:padding="8dp"/>
</LinearLayout>
"@

Write-File "$dir\fragment_product_detail.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/background">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical">
        <ImageView android:id="@+id/ivImage" android:layout_width="match_parent" android:layout_height="300dp" android:scaleType="centerCrop"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
            <TextView android:id="@+id/tvName" android:layout_width="match_parent" android:layout_height="wrap_content" android:textSize="20sp" android:textStyle="bold" android:textColor="@color/text_primary"/>
            <TextView android:id="@+id/tvPrice" android:layout_width="match_parent" android:layout_height="wrap_content" android:textSize="22sp" android:textStyle="bold" android:textColor="@color/secondary" android:layout_marginTop="8dp"/>
            <TextView android:id="@+id/tvDesc" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginTop="16dp" android:textColor="@color/text_secondary"/>
            
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginTop="24dp">
                <Button android:id="@+id/btnMinus" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="-" android:backgroundTint="@color/divider" android:textColor="@color/text_primary"/>
                <TextView android:id="@+id/tvQty" android:layout_width="60dp" android:layout_height="match_parent" android:gravity="center" android:text="1" android:textSize="18sp"/>
                <Button android:id="@+id/btnPlus" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="+" android:backgroundTint="@color/divider" android:textColor="@color/text_primary"/>
            </LinearLayout>
            
            <Button android:id="@+id/btnAddCart" android:layout_width="match_parent" android:layout_height="56dp" android:layout_marginTop="24dp" android:text="@string/add_to_cart" android:backgroundTint="@color/primary"/>
        </LinearLayout>
    </LinearLayout>
</ScrollView>
"@

Write-File "$dir\fragment_cart.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/background">
    <androidx.recyclerview.widget.RecyclerView android:id="@+id/rvCart" android:layout_width="match_parent" android:layout_height="match_parent" android:layout_above="@+id/bottomBar" android:padding="8dp"/>
    <LinearLayout android:id="@+id/bottomBar" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_alignParentBottom="true" android:background="@color/surface" android:orientation="horizontal" android:padding="16dp" android:elevation="8dp">
        <TextView android:id="@+id/tvSubtotal" android:layout_width="0dp" android:layout_height="wrap_content" android:layout_weight="1" android:textSize="18sp" android:textStyle="bold" android:textColor="@color/primary"/>
        <Button android:id="@+id/btnCheckout" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="@string/checkout" android:backgroundTint="@color/secondary"/>
    </LinearLayout>
</RelativeLayout>
"@

Write-File "$dir\fragment_checkout.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp"
    android:background="@color/background">
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Alamat Pengiriman" android:textStyle="bold" android:layout_marginBottom="8dp"/>
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Kota Cirebon" android:background="@color/surface" android:padding="16dp" android:layout_marginBottom="16dp"/>
    
    <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Rincian Pembayaran" android:textStyle="bold" android:layout_marginBottom="8dp"/>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:background="@color/surface" android:orientation="vertical" android:padding="16dp">
        <TextView android:id="@+id/tvSubtotal" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Subtotal: Rp 0"/>
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Pengiriman (Reguler): Rp 10000"/>
        <View android:layout_width="match_parent" android:layout_height="1dp" android:background="@color/divider" android:layout_marginVertical="8dp"/>
        <TextView android:id="@+id/tvTotal" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Total: Rp 0" android:textStyle="bold" android:textColor="@color/secondary" android:textSize="18sp"/>
    </LinearLayout>
    
    <Space android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"/>
    <Button android:id="@+id/btnOrder" android:layout_width="match_parent" android:layout_height="56dp" android:text="BUAT PESANAN" android:backgroundTint="@color/primary"/>
</LinearLayout>
"@

Write-File "$dir\fragment_payment.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp"
    android:background="@color/background">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Virtual Account BCA" android:textSize="20sp"/>
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="123 456 7890" android:textSize="32sp" android:textStyle="bold" android:textColor="@color/primary" android:layout_marginTop="16dp"/>
    <TextView android:id="@+id/tvTotal" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Total Bayar: Rp 0" android:textSize="18sp" android:layout_marginTop="16dp"/>
    
    <Button android:id="@+id/btnCekStatus" android:layout_width="match_parent" android:layout_height="56dp" android:text="CEK STATUS PEMBAYARAN" android:layout_marginTop="32dp" android:backgroundTint="@color/secondary"/>
</LinearLayout>
"@

Write-File "$dir\fragment_payment_success.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:gravity="center"
    android:padding="24dp"
    android:background="@color/background">
    <ImageView android:layout_width="100dp" android:layout_height="100dp" android:src="@android:drawable/ic_dialog_info" app:tint="@color/success"/>
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Pembayaran Berhasil!" android:textSize="24sp" android:textStyle="bold" android:textColor="@color/primary" android:layout_marginTop="16dp"/>
    <Button android:id="@+id/btnLihat" android:layout_width="match_parent" android:layout_height="56dp" android:text="LIHAT PESANAN" android:layout_marginTop="32dp" android:backgroundTint="@color/primary"/>
</LinearLayout>
"@

Write-File "$dir\fragment_order_detail.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp"
    android:background="@color/background">
    <TextView android:id="@+id/tvOrderId" android:layout_width="match_parent" android:layout_height="wrap_content" android:textSize="16sp"/>
    <TextView android:id="@+id/tvStatus" android:layout_width="match_parent" android:layout_height="wrap_content" android:textSize="18sp" android:textStyle="bold" android:textColor="@color/primary" android:layout_marginTop="8dp"/>
    <TextView android:id="@+id/tvTotal" android:layout_width="match_parent" android:layout_height="wrap_content" android:textSize="16sp" android:layout_marginTop="8dp"/>
</LinearLayout>
"@

Write-File "$dir\fragment_orders.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"
    android:background="@color/background">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Belum ada pesanan."/>
</LinearLayout>
"@

Write-File "$dir\fragment_profile.xml" @"
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:gravity="center"
    android:background="@color/background">
    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Profil Pengguna"/>
</LinearLayout>
"@
