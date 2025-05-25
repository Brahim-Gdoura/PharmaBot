import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharma_bot/models/medicine.dart';
import 'package:pharma_bot/services/medicine_service.dart';
import 'package:pharma_bot/widgets/medicine_card.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final MedicineService _medicineService = MedicineService();

  // Liste des catégories à afficher
  final List<String> _categoryNames = [
    "All",
    "Teeth",
    "Heart",
    "Eyes",
    "Brain",
    "Ears",
  ];

  // Icônes correspondant à chaque catégorie
  final List<Icon> _categoryIcons = [
    const Icon(Icons.category, size: 30, color: Colors.blue),
    Icon(MdiIcons.tooth, size: 30, color: Colors.blue),
    Icon(MdiIcons.heartPlus, size: 30, color: Colors.blue),
    Icon(MdiIcons.eye, size: 30, color: Colors.blue),
    Icon(MdiIcons.brain, size: 30, color: Colors.blue),
    Icon(MdiIcons.earHearing, size: 30, color: Colors.blue),
  ];

  // Catégorie actuellement sélectionnée
  String _selectedCategory = "All";
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Bandeau supérieur coloré
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 188, 213, 254).withOpacity(0.8),
                    const Color.fromARGB(255, 205, 223, 252),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),

            // Contenu principal
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header utilisateur
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/user.jpg'),
                            ),
                            Icon(Icons.logout_outlined,
                                size: 30, color: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Hello, User!",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Your Health is Our\nFirst Priority",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        // Barre de recherche (non fonctionnelle pour l'instant)
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 20),
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value.trim().toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search medicines...",
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section des catégories
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Liste horizontale des catégories
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categoryNames.length,
                      itemBuilder: (context, index) {
                        final isSelected =
                            _categoryNames[index] == _selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = _categoryNames[index];
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue[100]
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 6,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(child: _categoryIcons[index]),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _categoryNames[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isSelected ? Colors.blue : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Titre de la section des médicaments
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Popular Medicines",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // Liste des médicaments filtrés
                  SizedBox(
                    height: 220,
                    child: StreamBuilder<List<Medicine>>(
                      stream: _medicineService.getMedicines(
                        category: _selectedCategory == "All"
                            ? null
                            : _selectedCategory,
                        searchQuery: _searchQuery,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text("Error fetching medicines"));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text("No medicines found"));
                        }

                        final medicines = snapshot.data!;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: medicines.length,
                          itemBuilder: (context, index) {
                            return MedicineCard(
                              medicine: medicines[index],
                              onTap: () {
                                // Redirection vers une page détail possible ici
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
