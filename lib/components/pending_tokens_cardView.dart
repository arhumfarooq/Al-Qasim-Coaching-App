import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/components/pending_tokens_card.dart';
import 'package:qr_code_scanner/presentation/viewmodels/tokens_controller.dart';


class PendingTokensCardView extends GetView<PendingTokensController> {
  const PendingTokensCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return PendingTokensCard(
      isLoading: controller.isPendingLoading,
      pendingTokens: controller.pendingCount,
      onViewAll: () {},
      onRefresh: ()=>controller.loadTokens(true),
    );
  }
}
