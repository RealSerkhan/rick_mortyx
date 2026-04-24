import 'package:dart_kit/src/models/result.dart';

List<Result<T>> generateResultList<T>({
  int dataLength = 0,
  int errorLength = 0,
  int loadingLength = 0,
  T Function(int index)? dataGenerator,
  Object Function(int index)? errorGenerator,
}) =>
    [
      if (dataLength > 0)
        ...List.generate(
          dataLength,
          (index) => Result.data(ResultOrigin.other, dataGenerator!(index)),
        ),
      if (errorLength > 0)
        ...List.generate(
          errorLength,
          (index) => Result.error(ResultOrigin.other, errorGenerator!(index)),
        ),
      if (loadingLength > 0)
        ...List.generate(
          loadingLength,
          (index) => const Result.loading(ResultOrigin.other),
        ),
    ];

Stream<Result<T>> generateResultStream<T>({
  int dataLength = 0,
  int errorLength = 0,
  int loadingLength = 0,
  T Function(int index)? dataGenerator,
  Object Function(int index)? errorGenerator,
}) =>
    Stream.fromIterable(
      generateResultList(
        dataLength: dataLength,
        errorLength: errorLength,
        loadingLength: loadingLength,
        dataGenerator: dataGenerator,
        errorGenerator: errorGenerator,
      ),
    );
