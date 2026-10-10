import 'package:flutter/material.dart';

void main() {
  runApp(const BleePlusAdvancedApp());
}

class BleePlusAdvancedApp extends StatelessWidget {
  const BleePlusAdvancedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق توصيلك - Blee Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// =============================================================
// 1. شاشة تسجيل الدخول الذكية
// =============================================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'زبون';
  final TextEditingController phoneController = TextEditingController(text: '07880254887');
  final TextEditingController passController = TextEditingController();

  final List<Map<String, dynamic>> roles = [
    {'title': 'زبون', 'icon': Icons.person, 'color': Colors.blue},
    {'title': 'صاحب عمل', 'icon': Icons.store, 'color': Colors.purple},
    {'title': 'مندوب / دلفري', 'icon': Icons.two_wheeler, 'color': Colors.orange},
  ];

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(userRole: selectedRole),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.rocket_launch, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'توصيلك | Tawseelak',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              const Text(
                'الجيل المتطور من تطبيقات التوصيل والخدمات',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 35),

              const Text('اختر نوع الحساب:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: roles.map((role) {
                  bool isSelected = selectedRole == role['title'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedRole = role['title']),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? role['color'] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? role['color'] : Colors.grey.shade300),
                        ),
                        child: Column(
                          children: [
                            Icon(role['icon'], color: isSelected ? Colors.white : Colors.grey),
                            const SizedBox(height: 6),
                            Text(
                              role['title'],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('دخول كـ ($selectedRole)', style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// 2. الهيكل الرئيسي بالتنقل (Bottom Navigation)
// =============================================================
class MainNavigationScreen extends StatefulWidget {
  final String userRole;
  const MainNavigationScreen({super.key, required.userRole});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomeScreen(userRole: widget.userRole),
      const LiveMapScreen(),
      const ChatScreen(),
      const AboutScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'الخريطة'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'المحادثة'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline_rounded), label: 'بلمحة'),
        ],
      ),
    );
  }
}

// =============================================================
// 3. الشاشة الرئيسية التفاعلية حسب نوع الحساب
// =============================================================
class HomeScreen extends StatelessWidget {
  final String userRole;
  const HomeScreen({super.key, required.userRole});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تطبيق توصيلك - $userRole'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ترحيب الحساب
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.deepOrange, Colors.orangeAccent]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25,
                    child: Icon(Icons.person, color: Colors.deepOrange, size: 30),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('مرحباً بك يا بطل!', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('الحساب الحالي: $userRole', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // محتوى متغير حسب نوع الحساب
            if (userRole == 'زبون') _buildCustomerDashboard(context),
            if (userRole == 'صاحب عمل') _buildMerchantDashboard(),
            if (userRole == 'مندوب / دلفري') _buildDriverDashboard(),
          ],
        ),
      ),
    );
  }

  // واجهة الزبون
  Widget _buildCustomerDashboard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('الخدمات السريعة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildQuickCard('طلب تكسي سريع', Icons.local_taxi, Colors.amber, () {}),
            _buildQuickCard('طلبات المطاعم', Icons.restaurant, Colors.redAccent, () {}),
            _buildQuickCard('شحن طرود ومستندات', Icons.inventory_2, Colors.blue, () {}),
            _buildQuickCard('المتاجر والتسوق', Icons.shopping_bag, Colors.green, () {}),
          ],
        ),
      ],
    );
  }

  // واجهة صاحب العمل
  Widget _buildMerchantDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('لوحة تحكم المتجر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStatCard('إجمالي الطلبات', '48 طلب', Colors.blue)),
            const SizedBox(width: 10),
            Expanded(child: _buildStatCard('أرباح اليوم', '180,000 د.ع', Colors.green)),
          ],
        ),
        const SizedBox(height: 16),
        const Text('الطلبات الجديدة الواردة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading: const Icon(Icons.fastfood, color: Colors.orange),
          title: const Text('طلب #1024 - وجبتين برغر'),
          subtitle: const Text('الزبون: أحمد علي • المبلغ: 15,000 د.ع'),
          trailing: ElevatedButton(onPressed: () {}, child: const Text('قبول')),
        ),
      ],
    );
  }

  // واجهة المندوب
  Widget _buildDriverDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('طلبات التوصيل القريبة منك', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('طلب توصيل طرد', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Chip(label: Text('3.5 كم'), backgroundColor: Colors.orangeAccent),
                  ],
                ),
                const Text('من: مطعم الساعة • إلى: حي الجامعة'),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {},
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const Text('قبول ونسخ المسار', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuickCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.15), radius: 26, child: Icon(icon, color: color, size: 28)),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

// =============================================================
// 4. خريطة تفاعلية ومباشرة
// =============================================================
class LiveMapScreen extends StatelessWidget {
  const LiveMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تتبع موقع التوصيل المباشر'), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey.shade100,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 100, color: Colors.deepOrange),
                  SizedBox(height: 10),
                  Text('خريطة التتبع المباشرة للمندوب والزبون', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.directions_bike, color: Colors.deepOrange, size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text('الكابتن في الطريق إليك', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('الوقت المتبقي: 12 دقيقة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// =============================================================
// 5. شاشة المحادثة المباشرة (Live Chat)
// =============================================================
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محادثة الطلب المباشرة'), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(label: Text('مرحباً أستاذ، الطلب جاهز وأنا بالطريق')),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(label: Text('تمام كابتن، بانتظارك أمام العمارة'), backgroundColor: Colors.deepOrangeAccent),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                const Expanded(child: TextField(decoration: InputDecoration(hintText: 'اكتب رسالة للمندوب...', border: InputBorder.none))),
                IconButton(icon: const Icon(Icons.send, color: Colors.deepOrange), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =============================================================
// 6. صفحة "بلمحة" الخاصة بالمطور والحقوق
// =============================================================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بلمحة عن التطبيق والمطور'), backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.deepOrange,
              child: Icon(Icons.developer_mode, size: 45, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text('تطبيق توصيلك (Blee Plus)', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('نسخة متطورة تفوق التطبيقات التقليدية', style: TextStyle(fontSize: 13, color: Colors.grey)),
            const SizedBox(height: 20),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.badge, color: Colors.deepOrange),
                      title: Text('المطور والمنفذ'),
                      subtitle: Text('علاوي ال حمادي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone_in_talk, color: Colors.green),
                      title: Text('رقم الهاتف والتواصل'),
                      subtitle: Text('07880254887', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.auto_awesome, color: Colors.amber),
                      title: Text('مميزات النسخة'),
                      subtitle: Text('تتبع جغرافيا مباشر، واجهات ثلاثية الحسابات (زبون/متجر/دلفري)، شات مباشر، وإدارة طلبيات كاملة.'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('جميع الحقوق محفوظة للمطور علاوي ال حمادي ©', style: TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}