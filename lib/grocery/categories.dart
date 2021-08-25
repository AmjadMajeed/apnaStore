import 'package:flutter/material.dart';
import 'package:flutter_ui/Cart/cartScreen.dart';
import 'package:flutter_ui/Models/category_model.dart';
import 'package:flutter_ui/grocery/my_cart.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int clickedIndex = -1;

  final List<Category> categories = [
    Category.name(
        'Fruits & Vegetables',
        'assets/images/fruits_vegetables.jpg',
        'Fruits & Vegetables Potato, Tomato, Brocoli, Onion',
        ['Fruits', 'Vegetables']),
    Category.name('Fresh Meat', 'assets/images/fresh_meat.jpg',
        'Mutton, Beef, Chicken, Fish', ['Chicken', 'Mutton', 'Veal', 'Beef']),
    Category.name('Fish & Seafood', 'assets/images/fish_seafood.jpg',
        'Boneless Fish, Prawns, Fish', ['Boneless fish']),
    Category.name('Grocery', 'assets/images/grocery.jpg',
        'Oil, Daalain, Spices & Herbs, Flour, Jams, Sauces', [
      'Oil & Ghee',
      'Spices, Salt, Sugar',
      'Daalain, Rice & Flour',
      'Sauces & Olives',
      'Jam, Honey & Spread',
      'Baking & Desserts'
    ]),
    Category.name(
        'Personal Care',
        'assets/images/personal_care.jpg',
        'Shampoo, Conditioner, Female Hygiene, Soap, Body Lotion, Creams, Razors, Gel',
        [
          'Women care',
          'Men care',
          'Skin care',
          'Hair care',
          'Soap, Hand Wash',
          'Dental care',
          'Shoe polish',
          'Personal care'
        ]),
    Category.name('Dry Fruits & Nuts', 'assets/images/dry_fruits_nuts.jpg',
        'Peanuts, Cashew nuts, Almonds etc', ['Dry Fruits & Nuts']),
    Category.name('Home Care', 'assets/images/home_care.png',
        'Cleaners, Detergents, Tissue, Repelients, Laundry', [
      'Floor, Bath Cleaning',
      'Laundry',
      'Kitchen Cleaning',
      'Other cleaners',
      'Repellent Mosquito',
      'Air Fresheners',
      'Tissue Papers',
      'Cleaning Accessories'
    ]),
    Category.name(
        'Baby Care',
        'assets/images/baby_care.jpg',
        'Diapers, Lotions, Baby Food',
        ['Diapers & Wipes', 'Food & Milk', 'Bath & Toothpaste']),
    Category.name('Bakery & Dairy', 'assets/images/bakry_dairy.jpg',
        'Milk, Butter, Cheese, Bread', [
      'Milk',
      'Breads',
      'Eggs',
      'Cream & Butter',
      'Cereals & Oats',
      'Cake & Rusk',
      'Cheese',
      'Yoghurt & Lassi'
    ]),
    Category.name('Beverages', 'assets/images/beverage.jpg',
        'Tea, Cold Drinks, Sharbat, Juices, Energy Drinks, Mineral Water', [
      'Sharbat',
      'Cold Drinks',
      'Juices',
      'Tea',
      'Energy Drinks',
      'Mineral & Soda Water',
      'Cold Tea, Coffe',
      'Instant Drinks',
      'Flavoured Milk'
    ]),
    Category.name('Instant Food', 'assets/images/instant_food.jpg',
        'Biscuits, Noodles, Chocolates, Nimko', [
      'Noodles & Pasta',
      'Biscuit & Cookies',
      'Chips & Nimko',
      'Chocolates',
      'Misc Food',
      'Can Food'
    ]),
    Category.name('Frozen & Chilled', 'assets/images/froozen_chilled.jpg',
        'Burger Pattie, Nuggets, Kabab, Frozen Deserts', [
      'French Fries Chips',
      'Frozen Parathay',
      'Chicken By Parts',
      'Sausages & Toppings',
      'Kabab & Kofta',
      'Burger Patties',
      'Nugget & Snacks',
      'Samosa & Rolls',
      'Frozen Fruits'
    ]),
    Category.name('OTC & Wellness', 'assets/images/otc_wellness.jpg',
        'Condoms, Lubricants, Dettol', ['OTC', 'Condoms']),
    Category.name('Pan Shop', 'assets/images/pan_shop.jpg',
        'Cigarettes, Cigars, Lighters, Mobile Cards', ['Candies']),
    Category.name('Pet Care', 'assets/images/pet_care.jpg',
        'Cat Food, Dog Food', ['Cat Food', 'Dog Food']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.green,
            size: 20,
          ),
        ),
        titleSpacing: 5,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.green,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  color: index == clickedIndex ? Colors.green : Colors.white,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (clickedIndex == index) {
                              clickedIndex = -1;
                            } else {
                              clickedIndex = index;
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    width: 80,
                                    height: 80,
                                    child: Image(
                                      image: AssetImage(
                                        '${categories[index].image}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${categories[index].title}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 190,
                                      child: Text(
                                        '${categories[index].description}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: index == clickedIndex
                                      ? Colors.lightGreenAccent
                                      : Colors.green,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      index == clickedIndex
                          ? SizedBox(
                              height: 5,
                            )
                          : Container(),
                      index == clickedIndex
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3))),
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      categories[index].subCategories!.length,
                                      (subIndex) {
                                    return Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                          bottom: BorderSide(
                                            color: Colors.grey.shade300,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Image(
                                              image: AssetImage(
                                                  '${categories[index].image}'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${categories[index].subCategories![subIndex]}',
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Container(
                  height: 5,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
