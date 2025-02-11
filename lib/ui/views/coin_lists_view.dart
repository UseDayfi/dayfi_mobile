import 'dart:convert';

import 'package:dayfi/ui/views/coin_details_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinListScreen extends StatefulWidget {
  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  final Dio _dio = Dio();
  List coins = [];
  bool isLoading = true;
  String? errorMessage;
  String selectedFilter = 'market_cap';
  static const String CACHE_KEY = 'coin_data_cache';
  static const String LAST_FETCH_KEY = 'last_fetch_time';
  static const refreshThreshold = Duration(minutes: 5); // Cache for 5 minutes

  final List<String> allowedCoins = [
    'stellar',
    'toncoin',
    'paypal-usd',
    'tether-gold',
    'polygon',
    'celo-dollar',
    'solana',
    'cardano',
    'usd-coin',
    'tether',
    'ethereum',
    'bitcoin'
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(CACHE_KEY);
    final lastFetchTimeStr = prefs.getString(LAST_FETCH_KEY);

    if (cachedData != null && lastFetchTimeStr != null) {
      final lastFetchTime = DateTime.parse(lastFetchTimeStr);
      if (DateTime.now().difference(lastFetchTime) < refreshThreshold) {
        // Use cached data if it's still fresh
        if (mounted) {
          setState(() {
            coins = json.decode(cachedData);
            isLoading = false;
          });
          return;
        }
      }
    }
    // Fetch new data if cache is expired or doesn't exist
    await fetchCoins();
  }

  Future<void> _saveToCache(List coinsData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(CACHE_KEY, json.encode(coinsData));
    await prefs.setString(LAST_FETCH_KEY, DateTime.now().toIso8601String());
  }

  Future<void> fetchCoins() async {
    if (isLoading && coins.isNotEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'ids': allowedCoins.join(","),
          'order': 'market_cap_desc',
          'per_page': allowedCoins.length,
          'page': 1,
          'sparkline': false
        },
      );

      if (mounted) {
        final processedData = response.data
            .map((coin) => {
                  'id': coin['id'],
                  'name': coin['name'],
                  'abbv': coin['symbol'].toUpperCase(),
                  'price_usd': coin['current_price'] ?? 0.0,
                  'market_cap': coin['market_cap'] ?? 0,
                  'price_change': coin['price_change_percentage_24h'] ?? 0.0,
                  'icon': coin['image'] ?? '',
                })
            .toList();

        setState(() {
          coins = processedData;
          isLoading = false;
        });

        // Save to cache
        await _saveToCache(processedData);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = "Failed to load data. Please try again.";
          isLoading = false;
        });
      }
    }
  }

  // Add pull-to-refresh functionality
  Future<void> _onRefresh() async {
    await fetchCoins();
  }

  void sortCoins(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'price') {
        coins.sort((a, b) => b['price_usd'].compareTo(a['price_usd']));
      } else if (filter == 'market_cap') {
        coins.sort((a, b) => b['market_cap'].compareTo(a['market_cap']));
      } else if (filter == 'price_change') {
        coins.sort((a, b) => b['price_change'].compareTo(a['price_change']));
      } else if (filter == 'popular') {
        coins.sort((a, b) => allowedCoins
            .indexOf(a['id'])
            .compareTo(allowedCoins.indexOf(b['id'])));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xfff7f7f7),
        elevation: 0,
        automaticallyImplyLeading: false,
        title:
            Text("Coins", style: TextStyle(fontSize: 26, color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: _onRefresh,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(errorMessage!,
                            style: TextStyle(color: Colors.red)),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: fetchCoins, child: Text("Retry"))
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            "Featured",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              letterSpacing: .4,
                              color: Color.fromARGB(255, 49, 17, 34),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Featured Section (Stellar & Bitcoin)
                        _buildFeaturedSection(),

                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Wallets",
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: .4,
                                  color: Color.fromARGB(255, 49, 17, 34),
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width * .4,
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("Nigerian Naira",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text("NGN 0",
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 36),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Text(
                            "Availble Coins",
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              letterSpacing: .4,
                              color: Color.fromARGB(255, 49, 17, 34),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 12),

                        /// Filter Buttons
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _filterButton("Popular", 'popular'),
                                _filterButton("Market Cap", 'market_cap'),
                                _filterButton("24h Change", 'price_change'),
                                _filterButton("Price", 'price'),
                              ],
                            ),
                          ),
                        ),

                        /// Coin List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: coins.length,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          itemBuilder: (context, index) {
                            final coin = coins[index];
                            return Column(
                              children: [
                                const SizedBox(height: 8),
                                ListTile(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  selectedColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  title: Text(coin['name'],
                                      style: TextStyle(fontSize: 18)),
                                  leading: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        Color.fromARGB(255, 49, 17, 34)
                                            .withOpacity(0),
                                    child: Image.network(coin['icon']),
                                  ),
                                  subtitle: Text(coin['abbv']),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("USD ${coin['price_usd']}",
                                          style: TextStyle(fontSize: 16)),
                                      Text(
                                        "${coin['price_change'].toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          color: coin['price_change'] >= 0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CoinDetailScreen(
                                          coinId: coin['id'],
                                          coinName: coin['name'],
                                          coinPrice: coin['price_usd'],
                                          priceChange: coin['price_change'],
                                          marketCap:
                                              coin['market_cap'].toString(),
                                          popularity: "#N/A",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Divider(
                                  indent: 18,
                                  endIndent: 18,
                                  thickness: 0,
                                  height: 4,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    List featuredCoins = coins
        .where((coin) => coin['id'] == 'stellar' || coin['id'] == 'bitcoin')
        .toList();

    if (featuredCoins.length < 2)
      return SizedBox(); // Avoid rendering if data isn't available

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        children: featuredCoins.map((coin) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(coin['icon'], width: 30, height: 30),
                      Text(
                        "${coin['price_change'].toStringAsFixed(2)}%",
                        style: TextStyle(
                          color: coin['price_change'] >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coin['name'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(coin['abbv'],
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  Text("\$${coin['price_usd'].toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _filterButton(String title, String filter) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              selectedFilter == filter ? Colors.blue : Colors.grey.shade300,
          foregroundColor: Colors.black,
          // side: 
        ),
        onPressed: () => sortCoins(filter),
        child: Text(title),
      ),
    );
  }
}
