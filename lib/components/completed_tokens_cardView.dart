import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/components/completed_tokens_card.dart';
import 'package:qr_code_scanner/presentation/viewmodels/tokens_controller.dart';


class CompletedTokensCardview extends GetView<PendingTokensController> {
  const CompletedTokensCardview({super.key});

  @override
  Widget build(BuildContext context) {
    return CompletedTokensCard(
      isLoading: controller.isCompletedLoading,
      completedTokens: controller.completedCount,
      onViewAll: () {},
      onRefresh:()=> controller.loadTokens(false),
    );
  }
}
