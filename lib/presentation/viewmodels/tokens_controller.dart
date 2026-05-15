import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/domain/repositories/tokens_repository.dart';
import '../../data/models/pending_token_model.dart';

class PendingTokensController extends GetxController {
  final PendingTokensRepository repository;

  PendingTokensController(this.repository);

  // Token lists
  final RxList<PendingTokenModel> pendingTokens = <PendingTokenModel>[].obs;
  final RxList<PendingTokenModel> completedTokens = <PendingTokenModel>[].obs;

  // Separate loading states
  final RxBool isTokenLoading = false.obs;

  final RxBool isPendingLoading = false.obs;

  final RxBool isCompletedLoading = false.obs;

  // Reactive counts
  final RxInt pendingCount = 0.obs;
  final RxInt completedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadTokens(true);
  }

Future<void> loadTokens(bool loadPending) async {
  // Safe initial value set
  WidgetsBinding.instance.addPostFrameCallback((_) {
    loadPending ? isPendingLoading.value = true : isCompletedLoading.value = true;
  });

  try {
    final result = await repository.fetchPendingTokens(); 

    final pending = result
        .where((e) => e.rashanDistribute == 'Pending' && e.flagType != 3)
        .toList();

    final distributed = result
        .where((e) => e.rashanDistribute == 'Distributed' && e.flagType != 3)
        .toList();

    pendingTokens.assignAll(pending);
    completedTokens.assignAll(distributed);

    pendingCount.value = pendingTokens.length;
    completedCount.value = completedTokens.length;
  } finally {
    // Safe reset value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPending ? isPendingLoading.value = false : isCompletedLoading.value = false;
    });
  }
}

}
