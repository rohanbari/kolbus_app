// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Data)
final dataProvider = DataProvider._();

final class DataProvider extends $AsyncNotifierProvider<Data, AppDataModel> {
  DataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataHash();

  @$internal
  @override
  Data create() => Data();
}

String _$dataHash() => r'd08538f2b507688fdffc966da9f9ec05f041bfee';

abstract class _$Data extends $AsyncNotifier<AppDataModel> {
  FutureOr<AppDataModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppDataModel>, AppDataModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppDataModel>, AppDataModel>,
              AsyncValue<AppDataModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
