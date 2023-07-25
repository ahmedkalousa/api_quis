import 'package:api_quis/network.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Network network = Network();
  Map<String, dynamic> quote = {};
  String? image;
  late String url;
  String? tags;
  bool checkImg = false;
  bool checkQuote = false;

  void getImage() async {
    image = await network.fetchImage();
    checkImg = true;
    setState(() {});
  }

  void getData() async {
    quote = await network.fetchData();
    checkQuote = true;
    tags = quote['tags'];
    setState(() {});
  }

  @override
  void initState() {
    getData();
    getImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: checkImg == false || checkQuote == false
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('$image'),
                      fit: BoxFit.cover,
                      opacity: 0.4),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: IconButton(
                              color: Colors.grey[800],
                              icon: Icon(
                                Icons.refresh,
                                size: 60,
                              ),
                              onPressed: () {
                                getData();
                                getImage();
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 172),
                      Text(
                        '${quote['content']}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          color: Colors.grey[400],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '${quote['tags']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(55)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.share,
                                    size: 40,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Take Screen",
                                    style: TextStyle(fontSize: 24),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 24)
                        ],
                      ),
                      SizedBox(
                        height: 42,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
