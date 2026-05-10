import 'package:flutter/material.dart';

import '../../data/dtos/provider_dto.dart';
import '../theme/brand_color_utils.dart';

class TenantBrandCard extends StatelessWidget {
  final ProviderDto? provider;
  final String title;
  final String? subtitle;

  const TenantBrandCard({
    super.key,
    required this.provider,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brandColor = parseBrandColor(provider?.corMarca, fallback: theme.colorScheme.primary);
    final logoUrl = provider?.logoUrl;
    final hasLogo = logoUrl != null && logoUrl.trim().isNotEmpty;

    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: brandColor.withValues(alpha: 0.35)),
          gradient: LinearGradient(
            colors: [
              brandColor.withValues(alpha: 0.10),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: brandColor.withValues(alpha: 0.15),
              backgroundImage: hasLogo ? NetworkImage(logoUrl) : null,
              child: !hasLogo
                  ? Icon(Icons.business, color: brandColor)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: brandColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider?.razaoSocial ?? 'Empresa não identificada',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  if (provider?.assinaturaPadrao?.trim().isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    Text(
                      provider!.assinaturaPadrao!.trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
