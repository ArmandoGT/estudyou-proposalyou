// lib/shared/theme/app_theme.dart
//
// ─────────────────────────────────────────────────────────────────────────────
// ProposalYou — Sistema de temas (Material 3)
// ─────────────────────────────────────────────────────────────────────────────
//
// Define os temas claro e escuro do aplicativo utilizando Material 3
// com `ColorScheme.fromSeed()`. Os tokens de cor dos 3 tenants (Estudyou,
// Protseg, Protuni) estão como marcadores de decisão pendente até
// confirmação do brandbook de cada empresa.
//
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

// 🎨 TENANT TOKENS — substituir após confirmação de brandbook
//
// Estudyou : seedColor = Color(0xFF...) // ⚠️ DECISÃO PENDENTE: cor oficial
// Protseg  : seedColor = Color(0xFF...) // ⚠️ DECISÃO PENDENTE: cor oficial
// Protuni  : seedColor = Color(0xFF...) // ⚠️ DECISÃO PENDENTE: cor oficial
//
// Na FASE 2, o tema será dinâmico: a seedColor será selecionada com base
// na empresa ativa do usuário (provider_id). O AppTheme receberá o
// tenant como parâmetro para gerar o ColorScheme correspondente.

/// Sistema de temas do ProposalYou.
///
/// Classe selada (sealed) que expõe factories estáticas para os temas
/// claro e escuro. Utiliza Material 3 com geração de paleta automática
/// via [ColorScheme.fromSeed].
///
/// Exemplo de uso:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light(),
///   darkTheme: AppTheme.dark(),
/// )
/// ```
sealed class AppTheme {
  // ⚠️ DECISÃO PENDENTE: seedColor será dinâmica por tenant na FASE 2.
  // Por enquanto, utiliza uma cor neutra corporativa como placeholder.
  static const Color _defaultSeedColor = Color(0xFF1A73E8);

  // ───────────────────────────────────────────────────────────────────
  // TIPOGRAFIA
  // ───────────────────────────────────────────────────────────────────
  //
  // Utiliza a família de fontes padrão do sistema com pesos e tamanhos
  // seguindo as diretrizes do Material 3 TextTheme.
  // Na FASE 2, considerar importar Google Fonts (Inter, Roboto, Outfit)
  // via package google_fonts para maior controle tipográfico.
  // ───────────────────────────────────────────────────────────────────

  /// Tipografia base do aplicativo.
  ///
  /// Define todos os estilos de texto do Material 3:
  /// displayLarge → bodySmall, com pesos e tamanhos otimizados
  /// para leitura em dispositivos móveis.
  static TextTheme get _textTheme {
    return const TextTheme(
      // Display — Usado em telas de destaque (splash, onboarding)
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
      ),

      // Headline — Usado em cabeçalhos de seção
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.33,
      ),

      // Title — Usado em AppBar, cards e diálogos
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Label — Usado em botões, chips, badges
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      ),

      // Body — Usado em conteúdo textual geral
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────
  // TEMA CLARO
  // ───────────────────────────────────────────────────────────────────

  /// Cria o tema claro do aplicativo com Material 3.
  ///
  /// Utiliza [ColorScheme.fromSeed] para gerar automaticamente uma
  /// paleta de cores harmônica a partir da seedColor.
  static ThemeData light() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _defaultSeedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme,

      // ─────────────────────────────────────────────────────────────
      // AppBar — Estilo corporativo para o cabeçalho
      // ─────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // Card — Base para cards de métricas, clientes, propostas
      // ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // ─────────────────────────────────────────────────────────────
      // FilledButton — Botão principal de ações (Login, Salvar, etc.)
      // ─────────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // InputDecoration — Campos de formulário (email, senha, busca)
      // ─────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // NavigationBar — BottomNavigationBar do Material 3
      // ─────────────────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        elevation: 2,
        height: 72,
        indicatorColor: colorScheme.secondaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),

      // ─────────────────────────────────────────────────────────────
      // Divider — Separador visual entre seções
      // ─────────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        thickness: 1,
        space: 1,
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────
  // TEMA ESCURO
  // ───────────────────────────────────────────────────────────────────

  /// Cria o tema escuro do aplicativo com Material 3.
  ///
  /// Mesma seedColor do tema claro, com brightness alterado para
  /// [Brightness.dark]. O Material 3 gera automaticamente a paleta
  /// de cores escuras correspondente.
  static ThemeData dark() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _defaultSeedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme,

      // ─────────────────────────────────────────────────────────────
      // AppBar — Fundo escuro com boa legibilidade
      // ─────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: _textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // Card — Superfície elevada com bordas sutis no tema escuro
      // ─────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        color: colorScheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),

      // ─────────────────────────────────────────────────────────────
      // FilledButton — Mesmo padrão visual do tema claro
      // ─────────────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // InputDecoration — Campos com fundo escuro sutil
      // ─────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      // ─────────────────────────────────────────────────────────────
      // NavigationBar — Barra de navegação no tema escuro
      // ─────────────────────────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        elevation: 2,
        height: 72,
        indicatorColor: colorScheme.secondaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),

      // ─────────────────────────────────────────────────────────────
      // Divider — Separador com opacidade reduzida no tema escuro
      // ─────────────────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
