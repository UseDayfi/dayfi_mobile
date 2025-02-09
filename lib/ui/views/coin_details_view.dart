import 'package:dayfi/ui/common/stay_tuned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';

class CoinDetailScreen extends StatefulWidget {
  final String coinId;
  final String coinName;
  final dynamic coinPrice;
  final double priceChange;
  final dynamic marketCap;
  final dynamic popularity;

  const CoinDetailScreen({
    super.key,
    required this.coinId,
    required this.coinName,
    required this.coinPrice,
    required this.priceChange,
    required this.marketCap,
    required this.popularity,
  });

  @override
  _CoinDetailScreenState createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  final Dio _dio = Dio();
  bool isFavorite = false;
  String selectedTimeframe = "1W";
  Map<String, dynamic>? coinDetails;
  List<FlSpot> chartData = [];
  bool isLoading = true;
  String? errorMessage;
  bool isDescriptionExpanded = false;
  String currentApi = 'coingecko';

  final List<String> timeframes = ["1H", "1D", "1W", "1M", "6M", "1Y"];

  final Map<String, String> binanceSymbols = {
    'bitcoin': 'BTCUSDT',
    'ethereum': 'ETHUSDT',
    'cardano': 'ADAUSDT',
    'solana': 'SOLUSDT',
    'polygon': 'MATICUSDT',
    'stellar': 'XLMUSDT',
    'toncoin': 'TONUSDT',
  };

  final Map<String, String> timeframeIntervals = {
    "1H": "1m",
    "1D": "5m",
    "1W": "1h",
    "1M": "4h",
    "6M": "1d",
    "1Y": "1d",
  };

  final Map<String, int> timeframeDays = {
    "1H": 1,
    "1D": 1,
    "1W": 7,
    "1M": 30,
    "6M": 180,
    "1Y": 365,
  };

  @override
  void initState() {
    super.initState();
    fetchCoinDetails();
    fetchChartData();
  }

  Future<void> fetchCoinDetails() async {
    try {
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/${widget.coinId}',
        queryParameters: {
          'localization': false,
          'tickers': false,
          'community_data': false,
          'developer_data': false,
        },
      );

      setState(() {
        coinDetails = response.data;
        isLoading = false;
        currentApi = 'coingecko';
      });
    } catch (e) {
      print('CoinGecko API failed, trying Binance...');
      await _fetchBinanceDetails();
    }
  }

  Future<void> _fetchBinanceDetails() async {
    final binanceSymbol = binanceSymbols[widget.coinId];
    if (binanceSymbol == null) {
      setState(() {
        errorMessage = "Data temporarily unavailable";
        isLoading = false;
      });
      return;
    }

    try {
      final response = await _dio.get(
        'https://api.binance.com/api/v3/ticker/24h',
        queryParameters: {'symbol': binanceSymbol},
      );

      setState(() {
        coinDetails = {
          'market_data': {
            'current_price': {'usd': double.parse(response.data['lastPrice'])},
            'market_cap': {'usd': double.parse(response.data['quoteVolume'])},
            'total_volume': {'usd': double.parse(response.data['volume'])},
            'circulating_supply': null,
            'ath': {'usd': double.parse(response.data['highPrice'])},
          }
        };
        isLoading = false;
        currentApi = 'binance';
      });
    } catch (e) {
      setState(() {
        errorMessage = "Unable to fetch data. Please try again later.";
        isLoading = false;
      });
    }
  }

  Future<void> fetchChartData() async {
    if (currentApi == 'coingecko') {
      await _fetchCoinGeckoChartData();
    } else {
      await _fetchBinanceChartData();
    }
  }

  Future<void> _fetchCoinGeckoChartData() async {
    try {
      final days = timeframeDays[selectedTimeframe];
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/coins/${widget.coinId}/market_chart',
        queryParameters: {
          'vs_currency': 'usd',
          'days': days,
          'interval': days == 1 ? 'hourly' : 'daily',
        },
      );

      final prices = response.data['prices'] as List;
      setState(() {
        chartData = prices.asMap().entries.map((entry) {
          return FlSpot(
            entry.key.toDouble(),
            (entry.value[1] as num).toDouble(),
          );
        }).toList();
      });
    } catch (e) {
      print('CoinGecko chart data failed, trying Binance...');
      await _fetchBinanceChartData();
    }
  }

  Future<void> _fetchBinanceChartData() async {
    final binanceSymbol = binanceSymbols[widget.coinId];
    if (binanceSymbol == null) {
      setState(() {
        errorMessage = "Chart data unavailable";
      });
      return;
    }

    try {
      final interval = timeframeIntervals[selectedTimeframe];
      final response = await _dio.get(
        'https://api.binance.com/api/v3/klines',
        queryParameters: {
          'symbol': binanceSymbol,
          'interval': interval,
          'limit': 500,
        },
      );

      final klines = response.data as List;
      setState(() {
        chartData = klines.asMap().entries.map((entry) {
          return FlSpot(
            entry.key.toDouble(),
            double.parse(entry.value[4]), // Closing price
          );
        }).toList();
      });
    } catch (e) {
      setState(() {
        errorMessage = "Chart data temporarily unavailable";
      });
    }
  }

  // Future<void> _retryDataFetch() async {
  //   setState(() {
  //     isLoading = true;
  //     errorMessage = null;
  //   });
  //   await _initializeData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.coinName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () => setState(() => isFavorite = !isFavorite),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          fetchCoinDetails();
                          fetchChartData();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      _buildPriceChart(),
                      _buildTimeframeSelector(),
                      _buildFYI(context),
                      _buildAboutSection(),
                      _buildMarketStats(),
                      _buildResources(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                coinDetails?['image']['small'] ?? '',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "${widget.coinName} (${coinDetails?['symbol']?.toUpperCase()})",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "USD ${widget.coinPrice.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "+USD ${widget.priceChange.abs().toStringAsFixed(2)} (${widget.priceChange.toStringAsFixed(2)}%) 24h",
            style: TextStyle(
              fontSize: 16,
              color: widget.priceChange >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: timeframes.map((timeframe) {
          final isSelected = selectedTimeframe == timeframe;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedTimeframe = timeframe;
                });
                fetchChartData();
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    isSelected ? const Color(0xFFE6F4F1) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color:
                        isSelected ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
              ),
              child: Text(
                timeframe,
                style: TextStyle(
                  color: isSelected ? Colors.green : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFYI(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => showStayTunedDialog(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    child: Transform.rotate(
                        angle: 3.12,
                        child: CircleAvatar(
                            child: SvgPicture.asset('assets/svgs/send-2.svg'))),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Buy",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: colorPrimary100,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24,
            width: 1,
            // color: colorPrimary100,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => showStayTunedDialog(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 22,
                      child: SvgPicture.asset("assets/svgs/send-2.svg")),
                  const SizedBox(height: 4),
                  Text(
                    "Sell",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // color: colorPrimary100,
                      letterSpacing: -.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About Stellar",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            coinDetails?['description']['en'] ?? 'No description available.',
            maxLines: isDescriptionExpanded ? null : 3,
            overflow: isDescriptionExpanded ? null : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isDescriptionExpanded = !isDescriptionExpanded;
              });
            },
            child: Text(
              isDescriptionExpanded ? "See less" : "See more",
              style: const TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketStats() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Market stats",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
            ],
          ),
          const SizedBox(height: 16),
          _marketStatItem(
            "Market Cap",
            "USD ${(coinDetails?['market_data']['market_cap']['usd'] / 1e9).toStringAsFixed(1)}B",
            Icons.label_outline,
          ),
          _marketStatItem(
            "24h change",
            "${widget.priceChange.toStringAsFixed(2)}%",
            Icons.access_time,
          ),
          _marketStatItem(
            "Popularity",
            "#${widget.popularity}",
            Icons.local_fire_department_outlined,
          ),
        ],
      ),
    );
  }

  Widget _marketStatItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF6E3AA7)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResources() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resources",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              // Handle whitepaper tap
            },
            child: Row(
              children: [
                Icon(Icons.description_outlined,
                    color: const Color(0xFF6E3AA7)),
                const SizedBox(width: 8),
                const Text(
                  "WHITEPAPER",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: chartData,
              isCurved: true,
              color: const Color(0xFF2ECC71),
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF2ECC71).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
