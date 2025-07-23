import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../widgets/app_button.dart';
import '../../../theme/app_colors.dart';
import '../controller/profile_controller.dart';


class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        elevation: 4,
        shadowColor: AppColors.black.withOpacity(0.15),
        title: const Text(
          'Account',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.settings, color: AppColors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            /// 🔹 Profile & Banner
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.userName.value,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: controller.onViewProfile,
                      child: const Text(
                        "View profile",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Save with bhookhlagi pro!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            SizedBox(height: 4),
                            Text("Free for 14 days", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("Start your free trial", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      const Icon(Icons.card_giftcard, color: Colors.white, size: 32),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// 🔹 Three Feature Containers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildFeatureBox(Icons.receipt_long, "Orders", controller.onOrdersTap),
                    buildFeatureBox(Icons.favorite_border, "Favourites", controller.onFavouritesTap),
                    buildFeatureBox(Icons.location_on_outlined, "Addresses", controller.onAddressesTap),
                  ],
                ),
                const SizedBox(height: 16),

                /// 🔹 Credit Box
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.payment, color: Colors.pink),
                          SizedBox(width: 8),
                          Text("Bhookhlagi Credit", style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Obx(() => Text("Rs. ${controller.credit.value.toStringAsFixed(2)}")),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            )),

            /// 🔹 Perks Section
            buildSectionTitle("Perks for you"),
            buildListItem(Icons.card_membership, "Try bhookhlagi pro for free now", onTap: controller.onTryPandapro),
            buildListItem(Icons.emoji_events_outlined, "bhookhlagi rewards", onTap: controller.onPandaRewards),
            buildListItem(Icons.local_activity_outlined, "Vouchers", onTap: controller.onVouchers),
            buildListItem(Icons.card_giftcard_outlined, "Invite friends", onTap: controller.onInviteFriends),

            const SizedBox(height: 24),
            buildSectionTitle("General"),
            buildListItem(Icons.help_outline, "Help center", onTap: controller.onHelpCenter),
            buildListItem(Icons.business_outlined, "bhookhlagi for business", onTap: controller.onBhookhlagiBusiness),
            buildListItem(Icons.description_outlined, "Terms & policies", onTap: controller.onTermsPolicies),

            const SizedBox(height: 24),
            AppButton(
              text: "Log out",
              onPressed: controller.onLogout,
            ),
            const SizedBox(height: 12),
            const Center(child: Text("Version 25.27.0", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureBox(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.black87),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget buildListItem(IconData icon, String text, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      onTap: onTap,
    );
  }
}
