import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/partnership_service.dart';

final partnershipStreamProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return PartnershipService().getMyPartnership();
});

final activePartnershipProvider = Provider<Map<String, dynamic>?>((ref) {
  final asyncValue = ref.watch(partnershipStreamProvider);
  return asyncValue.when(
    data: (partnerships) {
      if (partnerships.isEmpty) return null;
      // For MVP, assume 1 partnership
      return partnerships.first;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});
