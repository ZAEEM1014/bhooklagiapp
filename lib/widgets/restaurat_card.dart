import 'package:flutter/material.dart';
import '../app/models/restaurant_model.dart';
import '../app/theme/app_colors.dart';

class RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard({
    Key? key,
    required this.restaurant,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard>
    with TickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
  }

  void _triggerFadeIn() {
    if (!_showOverlay) {
      setState(() => _showOverlay = true);
      _fadeController.forward(from: 0);
    }
  }

  void _triggerFadeOut() {
    _fadeController.reverse().whenComplete(() {
      if (mounted) setState(() => _showOverlay = false);
    });
  }

  void _onTap() async {
    await _fadeController.reverse();
    if (mounted) setState(() => _showOverlay = false);
    widget.onTap();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (_) => _triggerFadeIn(), // 👈 triggers during scroll
      onPointerUp: (_) => _triggerFadeOut(),
      onPointerCancel: (_) => _triggerFadeOut(),
      child: GestureDetector(
        onTap: _onTap,
        onTapDown: (_) => _triggerFadeIn(),
        onTapCancel: _triggerFadeOut,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Stack(
            children: [
              _buildCardContent(),
              if (_showOverlay) _buildFadeOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.restaurant.image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restaurant.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${widget.restaurant.deliveryTime} • ${widget.restaurant.category}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  if (widget.restaurant.freeDelivery)
                    Text(
                      "🙵 Free for first order",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  if (widget.restaurant.offer.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.restaurant.offer,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.orange, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.restaurant.rating} (${widget.restaurant.reviews}+)",
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFadeOverlay() {
    return Positioned.fill(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.border.withOpacity(0.25),
          ),
        ),
      ),
    );
  }
}
