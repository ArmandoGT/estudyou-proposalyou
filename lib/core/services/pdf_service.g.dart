// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pdfService)
final pdfServiceProvider = PdfServiceProvider._();

final class PdfServiceProvider
    extends $FunctionalProvider<PdfService, PdfService, PdfService>
    with $Provider<PdfService> {
  PdfServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pdfServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pdfServiceHash();

  @$internal
  @override
  $ProviderElement<PdfService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfService create(Ref ref) {
    return pdfService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfService>(value),
    );
  }
}

String _$pdfServiceHash() => r'19ad0b10004e164b3d64700dcb59b2e75ae184cf';
