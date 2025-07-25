import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserThing extends StatefulWidget {
  static const String screenRoot = 'user_thing';

  const UserThing({super.key});

  @override
  _UserThingState createState() => _UserThingState();
}

class _UserThingState extends State<UserThing>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'الكهرباء',
      'icon': Icons.bolt,
      'color': const Color(0xFF6A1B9A),
      'gradient': [const Color(0xFF9C27B0), const Color(0xFF6A1B9A)],
      'services': [
        {'name': 'دفع الفاتورة', 'icon': Icons.payment, 'premium': false},
        {
          'name': 'تحديد موقع العطل',
          'icon': Icons.location_on,
          'premium': false,
        },
        {
          'name': 'الاستهلاك الشهري',
          'icon': Icons.show_chart,
          'premium': false,
        },
        {'name': 'إرشادات التوفير', 'icon': Icons.eco, 'premium': false},
        {'name': 'ضريبة التأخير', 'icon': Icons.money_off, 'premium': false},
        {
          'name': 'الهدايا والعروض',
          'icon': Icons.card_giftcard,
          'premium': false,
        },
        {'name': 'الخدمات المميزة', 'icon': Icons.star, 'premium': true},
      ],
    },
    {
      'title': 'الماء',
      'icon': Icons.water_drop,
      'color': const Color(0xFF00ACC1),
      'gradient': [const Color(0xFF00BCD4), const Color(0xFF00838F)],
      'services': [
        {'name': 'دفع الفاتورة', 'icon': Icons.payment, 'premium': false},
        {'name': 'بلاغ تسرب المياه', 'icon': Icons.warning, 'premium': false},
        {
          'name': 'الاستهلاك الشهري',
          'icon': Icons.show_chart,
          'premium': false,
        },
        {'name': 'إرشادات الترشيد', 'icon': Icons.eco, 'premium': false},
        {'name': 'ضريبة التأخير', 'icon': Icons.money_off, 'premium': false},
        {
          'name': 'الهدايا والعروض',
          'icon': Icons.card_giftcard,
          'premium': false,
        },
        {'name': 'الخدمات المميزة', 'icon': Icons.star, 'premium': true},
      ],
    },
    {
      'title': 'النفايات',
      'icon': Icons.delete,
      'color': const Color(0xFF43A047),
      'gradient': [const Color(0xFF66BB6A), const Color(0xFF2E7D32)],
      'services': [
        {'name': 'دفع الرسوم', 'icon': Icons.payment, 'premium': false},
        {'name': 'طلب حاوية جديدة', 'icon': Icons.add_circle, 'premium': false},
        {
          'name': 'جدول النظافة',
          'icon': Icons.calendar_today,
          'premium': false,
        },
        {'name': 'إرشادات الفرز', 'icon': Icons.recycling, 'premium': false},
        {'name': 'ضريبة التأخير', 'icon': Icons.money_off, 'premium': false},
        {
          'name': 'الهدايا والعروض',
          'icon': Icons.card_giftcard,
          'premium': false,
        },
        {'name': 'الخدمات المميزة', 'icon': Icons.star, 'premium': true},
      ],
    },
  ];

  final List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _services.length, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildServiceContent(String serviceName) {
    if (serviceName.contains('ضريبة')) {
      return _buildLatePaymentTaxContent();
    } else if (serviceName.contains('هدايا')) {
      return _buildGiftsContent();
    } else {
      return const Text(
        'تفاصيل الخدمة ستظهر هنا مع إمكانية تنفيذ الإجراء المطلوب مباشرة',
        style: TextStyle(fontSize: 16),
      );
    }
  }

  Widget _buildDailyConsumptionCard(
    Color color,
    List<Color> gradient,
    String title,
  ) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.3), width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              gradient[0].withOpacity(0.9),
              gradient[1].withOpacity(0.9),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.today, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'الاستهلاك اليومي',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title == 'الماء' ? '250 لتر' : '25 كيلوواط/ساعة',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'اليوم: ${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: 0.65,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 6,
                            ),
                            Text(
                              '65%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: _services[_currentIndex]['color'],
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _services[_currentIndex]['gradient'],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('images/lbb.jpg', height: 30),
            ),
            const SizedBox(width: 10),
            Text(
              _services[_currentIndex]['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildNotificationButton(),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: _buildProfileButton(),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 4,
                  color: _services[_currentIndex]['color'],
                ),
                insets: const EdgeInsets.symmetric(horizontal: 24),
              ),
              labelColor: _services[_currentIndex]['color'],
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 14),
              tabs: _services.map((service) {
                return Tab(
                  icon: Icon(service['icon'], size: 28),
                  text: service['title'],
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.grey[200]!],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: _services.map((service) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (service['title'] != 'النفايات')
                    _buildDailyConsumptionCard(
                      service['color'],
                      service['gradient'],
                      service['title'],
                    ),
                  _buildServiceGrid(
                    service['services'],
                    service['color'],
                    service['gradient'],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _services[_currentIndex]['color'],
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.5), width: 2),
        ),
        onPressed: _showEmergencyDialog,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: _services[_currentIndex]['gradient'],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: _services[_currentIndex]['color'].withOpacity(0.4),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.emergency, size: 28, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            iconSize: 30,
            padding: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 240, 240, 240),
            onPressed: _showNotifications,
            tooltip: 'الإشعارات',
          ),
          if (_notifications.any((n) => !n['read']))
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 207, 202, 202),
                    width: 2,
                  ),
                ),
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: const Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white.withOpacity(0.3),
        child: IconButton(
          icon: const Icon(Icons.account_circle),
          iconSize: 30,
          padding: EdgeInsets.zero,
          color: Colors.white,
          onPressed: _showProfile,
        ),
      ),
    );
  }

  Widget _buildServiceGrid(
    List<dynamic> services,
    Color color,
    List<Color> gradient,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index], color, gradient);
        },
      ),
    );
  }

  Widget _buildServiceCard(
    Map<String, dynamic> service,
    Color color,
    List<Color> gradient,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _handleServiceTap(service['name']),
        splashColor: color.withOpacity(0.2),
        highlightColor: color.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, color.withOpacity(0.1)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              if (service['premium'])
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.4),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: gradient[0].withOpacity(0.3),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(service['icon'], color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      service['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleServiceTap(String serviceName) {
    if (serviceName.contains('دفع الفاتورة') ||
        serviceName.contains('دفع الرسوم')) {
      _showInvoiceDetails();
    } else {
      _showServiceDetails(serviceName);
    }
  }

  void _showInvoiceDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceDetailsScreen(
          serviceColor: _services[_currentIndex]['color'],
          serviceGradient: _services[_currentIndex]['gradient'],
          serviceTitle: _services[_currentIndex]['title'],
        ),
      ),
    );
  }

  void _showServiceDetails(String serviceName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildServiceContent(serviceName),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _services[_currentIndex]['color'],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'استمرار',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLatePaymentTaxContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ضريبة التأخير في الدفع:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        const Text(
          'تطبق ضريبة تأخير بنسبة 1% من قيمة الفاتورة عن كل شهر تأخير بعد الموعد النهائي للدفع.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: _services[_currentIndex]['color'],
            ),
            const SizedBox(width: 8),
            const Text('آخر موعد للدفع: 15 من كل شهر'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.money, color: _services[_currentIndex]['color']),
            const SizedBox(width: 8),
            const Text('الحد الأقصى للضريبة: 10% من قيمة الفاتورة'),
          ],
        ),
      ],
    );
  }

  Widget _buildGiftsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الهدايا والعروض الحالية:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 10),
        _buildGiftItem(
          'خصم 10%',
          'للمشتركين الذين يدفعون الفواتير قبل الموعد النهائي',
        ),
        _buildGiftItem('سحب شهري', 'على جوائز قيمة للمشتركين الملتزمين بالدفع'),
        _buildGiftItem('نقاط مكافآت', 'يمكن استبدالها بخدمات إضافية أو خصومات'),
      ],
    );
  }

  Widget _buildGiftItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.card_giftcard, color: _services[_currentIndex]['color']),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(0, 158, 8, 8),
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: _services[_currentIndex]['color'],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
              Divider(height: 1, thickness: 1, color: Colors.grey[200]),
              Expanded(
                child: _notifications.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا يوجد إشعارات',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'سيتم إعلامك هنا عند وجود إشعارات جديدة',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          final notification = _notifications[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: notification['read']
                                  ? Colors.white
                                  : Colors.grey[50],
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                leading: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: notification['color'].withOpacity(
                                      0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    notification['icon'],
                                    color: notification['color'],
                                  ),
                                ),
                                title: Text(
                                  notification['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: notification['read']
                                        ? Colors.grey[700]
                                        : Colors.black,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(notification['message']),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey[500],
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            notification['date'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: !notification['read']
                                    ? Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color:
                                              _services[_currentIndex]['color'],
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  _services[_currentIndex]['color']
                                                      .withOpacity(0.3),
                                              blurRadius: 4,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      )
                                    : null,
                                onTap: () {
                                  setState(() {
                                    notification['read'] = true;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProfile() {
    // يمكنك إضافة وظيفة عرض الملف الشخصي هنا
  }

  void _showEmergencyDialog() {
    // يمكنك إضافة وظيفة عرض نافذة الطوارئ هنا
  }
}

class InvoiceDetailsScreen extends StatelessWidget {
  final Color serviceColor;
  final List<Color> serviceGradient;
  final String serviceTitle;

  const InvoiceDetailsScreen({
    super.key,
    required this.serviceColor,
    required this.serviceGradient,
    required this.serviceTitle,
  });

  @override
  Widget build(BuildContext context) {
    final invoiceAmount = 250.0;
    final dueDate = DateTime.now().add(const Duration(days: 15));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: serviceColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: serviceGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('فاتورة $serviceTitle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة ملخص الفاتورة
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      serviceGradient[0].withOpacity(0.1),
                      serviceGradient[1].withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملخص الفاتورة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('المبلغ المستحق:'),
                        Text(
                          '$invoiceAmount د.ع',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تاريخ الاستحقاق:'),
                        Text(
                          DateFormat('yyyy-MM-dd').format(dueDate),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('رقم الفاتورة:'),
                        const Text(
                          'INV-2023-001',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.amber),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.amber),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'الرجاء السداد قبل تاريخ الاستحقاق لتجنب رسوم التأخير',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // طرق الدفع
            const Text(
              'طرق الدفع المتاحة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPaymentMethod(
              context,
              title: 'البطاقة الائتمانية',
              icon: Icons.credit_card,
              color: Colors.blue,
              onTap: () => _processPayment(context, 'البطاقة الائتمانية'),
            ),
            _buildPaymentMethod(
              context,
              title: 'المحفظة الإلكترونية',
              icon: Icons.account_balance_wallet,
              color: Colors.green,
              onTap: () => _processPayment(context, 'المحفظة الإلكترونية'),
            ),
            _buildPaymentMethod(
              context,
              title: 'التحويل البنكي',
              icon: Icons.account_balance,
              color: Colors.purple,
              onTap: () => _processPayment(context, 'التحويل البنكي'),
            ),
            _buildPaymentMethod(
              context,
              title: 'مدى',
              icon: Icons.payment,
              color: Colors.orange,
              onTap: () => _processPayment(context, 'مدى'),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: serviceColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          onPressed: () => _showPaymentConfirmation(context),
          child: const Text(
            'تأكيد الدفع',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_left, color: Colors.grey[600]),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, String method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('الدفع باستخدام $method'),
        content: const Text('سيتم تحويلك لصفحة الدفع لإتمام العملية'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showPaymentConfirmation(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: serviceColor),
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تم الدفع بنجاح'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('شكراً لك، تمت عملية الدفع بنجاح.'),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.receipt, color: serviceColor),
                const SizedBox(width: 8),
                const Text('رقم المرجع: PAY-2023-001'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.today, color: serviceColor),
                const SizedBox(width: 8),
                Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
