import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/attraction_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = "All";

  String get firstName {
    String fullName =
        user?.displayName ?? "Explorer";

    return fullName.split(" ").first;
  }

  final List<String> categories = [
    "All",
    "Beach",
    "Nature",
    "Wildlife",
    "Diving",
    "City",
    "Culture",
  ];

  final List<Attraction> attractions = [
    Attraction(
      name: "Danum Valley",
      image: "assets/images/danum_valley.jpg",
      category: "Nature",
      description: "Ancient rainforest and wildlife.",
    ),
    Attraction(
      name: "Desa Dairy Farm",
      image: "assets/images/desa_dairy_farm.jpg",
      category: "Nature",
      description: "New Zealand scenery in Sabah.",
    ),
    Attraction(
      name: "Gomantong Caves",
      image: "assets/images/gomantong_caves.jpg",
      category: "Nature",
      description: "Famous limestone cave system.",
    ),
    Attraction(
      name: "Kota Kinabalu",
      image: "assets/images/kota_kinabalu.jpg",
      category: "City",
      description: "Capital city of Sabah.",
    ),
    Attraction(
      name: "Manukan Island",
      image: "assets/images/manukan_island.jpg",
      category: "Beach",
      description: "Crystal clear waters.",
    ),
    Attraction(
      name: "Sandakan",
      image: "assets/images/sandakan.jpg",
      category: "City",
      description: "Wildlife gateway.",
    ),
    Attraction(
      name: "Selingan Island",
      image: "assets/images/selingan_island.jpg",
      category: "Beach",
      description: "Turtle island paradise.",
    ),
    Attraction(
      name: "Semporna",
      image: "assets/images/semporna.jpg",
      category: "Beach",
      description: "Beautiful coastal town.",
    ),
    Attraction(
      name: "Sepilok",
      image: "assets/images/sepilok.jpg",
      category: "Wildlife",
      description: "Orangutan sanctuary.",
    ),
    Attraction(
      name: "Sipadan",
      image: "assets/images/sipadan.jpg",
      category: "Diving",
      description: "World-class diving destination.",
    ),
    Attraction(
      name: "Tamparuli",
      image: "assets/images/tamparuli.jpg",
      category: "Culture",
      description: "Historic hanging bridge.",
    ),
    Attraction(
      name: "Tunku Abdul Rahman Park",
      image: "assets/images/tunku_abdul_rahman.jpg",
      category: "Beach",
      description: "Island park near KK.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Attraction> filteredAttractions =
        attractions.where((attraction) {
      bool categoryMatch =
          selectedCategory == "All" ||
              attraction.category ==
                  selectedCategory;

      bool searchMatch = attraction.name
              .toLowerCase()
              .contains(
                searchController.text.toLowerCase(),
              ) ||
          attraction.category
              .toLowerCase()
              .contains(
                searchController.text.toLowerCase(),
              ) ||
          attraction.description
              .toLowerCase()
              .contains(
                searchController.text.toLowerCase(),
              );

      return categoryMatch && searchMatch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: "Planner",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

Row(
  crossAxisAlignment:
      CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            "Hi $firstName 👋",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Travel Bah!",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "Let the adventures in Borneo begin",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),

    GestureDetector(
      onTap: () {
        // Profile page later
      },
      child: CircleAvatar(
        radius: 28,
        backgroundColor:
            Colors.deepPurple,
        child: Text(
          firstName[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 25),

Container(
  height: 58,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius:
        BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color:
            Colors.black.withOpacity(0.05),
        blurRadius: 10,
      ),
    ],
  ),

  child: TextField(
    controller: searchController,
    onChanged: (_) {
      setState(() {});
    },

    decoration: const InputDecoration(
      hintText:
          "Search destinations...",
      border: InputBorder.none,

      prefixIcon: Icon(
        Icons.search,
        color: Colors.deepPurple,
      ),

      suffixIcon: Icon(
        Icons.settings,
        color: Colors.deepPurple,
      ),
    ),
  ),
),

                const SizedBox(height: 25),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal,
                    itemCount:
                        categories.length,
                    itemBuilder:
                        (context, index) {
                      bool isSelected =
                          selectedCategory ==
                              categories[index];

                      return Padding(
                        padding:
                            const EdgeInsets.only(
                                right: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory =
                                  categories[
                                      index];
                            });
                          },
                          child: Container(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 20,
                            ),
                            decoration:
                                BoxDecoration(
                              color: isSelected
                                  ? Colors
                                      .deepPurple
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          25),
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style:
                                    TextStyle(
                                  color:
                                      isSelected
                                          ? Colors
                                              .white
                                          : Colors
                                              .black,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: const [
                    Text(
                      "Featured Escapes",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color:
                            Colors.deepPurple,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 450,
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal,
                    itemCount:
                        filteredAttractions
                            .length,
                    itemBuilder:
                        (context, index) {
                      final attraction =
                          filteredAttractions[
                              index];

                      return Container(
                        width: 280,
                        margin:
                            const EdgeInsets.only(
                                right: 18),
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      30),
                          image:
                              DecorationImage(
                            image: AssetImage(
                              attraction.image,
                            ),
                            fit:
                                BoxFit.cover,
                          ),
                        ),

                        child: Container(
                          padding:
                              const EdgeInsets
                                  .all(20),
                          decoration:
                              BoxDecoration(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        30),
                            gradient:
                                LinearGradient(
                              begin:
                                  Alignment
                                      .topCenter,
                              end:
                                  Alignment
                                      .bottomCenter,
                              colors: [
                                Colors
                                    .transparent,
                                Colors.black
                                    .withOpacity(
                                        0.8),
                              ],
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [

                              Align(
                                alignment:
                                    Alignment
                                        .topRight,
                                child:
                                    Container(
                                  decoration:
                                      const BoxDecoration(
                                    color: Colors
                                        .white,
                                    shape: BoxShape
                                        .circle,
                                  ),
                                  child:
                                      IconButton(
                                    icon:
                                        const Icon(
                                      Icons
                                          .favorite_border,
                                      color: Colors
                                          .deepPurple,
                                    ),
                                    onPressed:
                                        () {},
                                  ),
                                ),
                              ),

                              const Spacer(),

                              Text(
                                attraction.name,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white,
                                  fontSize:
                                      30,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 10),

                              Text(
                                attraction
                                    .description,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors
                                          .white70,
                                  fontSize:
                                      16,
                                ),
                              ),

                              const SizedBox(
                                  height: 20),

                              Row(
                                children: [

                                  Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal:
                                          15,
                                      vertical:
                                          10,
                                    ),
                                    decoration:
                                        BoxDecoration(
                                      color: Colors
                                          .deepPurple,
                                      borderRadius:
                                          BorderRadius.circular(
                                              30),
                                    ),
                                    child:
                                        Text(
                                      attraction
                                          .category,
                                      style:
                                          const TextStyle(
                                        color: Colors
                                            .white,
                                      ),
                                    ),
                                  ),

                                  const Spacer(),

                                  Container(
                                    decoration:
                                        const BoxDecoration(
                                      color: Colors
                                          .white,
                                      shape: BoxShape
                                          .circle,
                                    ),
                                    child:
                                        IconButton(
                                      onPressed:
                                          () {
                                        // open detail page later
                                      },
                                      icon:
                                          const Icon(
                                        Icons
                                            .arrow_forward,
                                        color: Colors
                                            .deepPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}