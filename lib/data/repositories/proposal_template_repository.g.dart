// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_template_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(proposalTemplateRepository)
final proposalTemplateRepositoryProvider =
    ProposalTemplateRepositoryProvider._();

final class ProposalTemplateRepositoryProvider
    extends
        $FunctionalProvider<
          ProposalTemplateRepository,
          ProposalTemplateRepository,
          ProposalTemplateRepository
        >
    with $Provider<ProposalTemplateRepository> {
  ProposalTemplateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proposalTemplateRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proposalTemplateRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProposalTemplateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProposalTemplateRepository create(Ref ref) {
    return proposalTemplateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProposalTemplateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProposalTemplateRepository>(value),
    );
  }
}

String _$proposalTemplateRepositoryHash() =>
    r'c3dbb9d015bf8e250c12abd05f9b15179174e66a';
