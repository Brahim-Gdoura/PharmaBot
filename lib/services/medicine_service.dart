import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharma_bot/models/medicine.dart';

class MedicineService {
  final CollectionReference _medicinesRef =
      FirebaseFirestore.instance.collection('medicines');

  Stream<List<Medicine>> getMedicines({String? category, String? searchQuery}) {
    Query query = _medicinesRef;

    // Appliquer le filtre de catégorie Firestore si différent de null
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Medicine.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .where((medicine) {
        // Appliquer la recherche locale si searchQuery est fourni
        if (searchQuery != null && searchQuery.isNotEmpty) {
          return medicine.name
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
        }
        return true;
      }).toList();
    });
  }

  Future<List<String>> getCategories() async {
    final snapshot = await _medicinesRef.get();
    final categories = snapshot.docs
        .map((doc) => doc['category'] as String? ?? 'General')
        .toSet()
        .toList();
    return ['All']..addAll(categories);
  }

  Future<void> addMedicine(Medicine med) async {
    await _medicinesRef.doc(med.id).set(med.toMap());
  }

  Future<void> updateMedicine(Medicine med) async {
    await _medicinesRef.doc(med.id).update(med.toMap());
  }

  Future<void> deleteMedicine(String id) async {
    await _medicinesRef.doc(id).delete();
  }

  Future<Medicine?> getMedicine(String id) async {
    DocumentSnapshot doc = await _medicinesRef.doc(id).get();
    return doc.exists
        ? Medicine.fromMap(doc.data() as Map<String, dynamic>, doc.id)
        : null;
  }
}
