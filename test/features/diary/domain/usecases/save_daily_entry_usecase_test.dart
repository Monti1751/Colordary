import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:colordary/core/enums/emotion.dart';
import 'package:colordary/core/error/failures.dart';
import 'package:colordary/features/diary/domain/entities/daily_entry.dart';
import 'package:colordary/features/diary/domain/repositories/diary_repository.dart';
import 'package:colordary/features/diary/domain/usecases/save_daily_entry_usecase.dart';

class MockDiaryRepository extends Mock implements DiaryRepository {
  @override
  Future<void> saveEntry(DailyEntry? entry) async => super.noSuchMethod(
        Invocation.method(#saveEntry, [entry]),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      );
      
  @override
  Future<void> updateEntry(DailyEntry? entry) async => super.noSuchMethod(
        Invocation.method(#updateEntry, [entry]),
        returnValue: Future<void>.value(),
        returnValueForMissingStub: Future<void>.value(),
      );
}

void main() {
  late SaveDailyEntryUseCase usecase;
  late MockDiaryRepository mockRepository;

  setUp(() {
    mockRepository = MockDiaryRepository();
    usecase = SaveDailyEntryUseCase(mockRepository);
  });

  test('Debe lanzar ValidationFailure si se intenta guardar una fecha del pasado', () async {
    // Arrange: Creamos una fecha simulando hace 3 días
    final pastDate = DateTime.now().subtract(const Duration(days: 3));
    final entry = DailyEntry(
      date: pastDate,
      content: 'Intento de hacker el tiempo del diario',
      emotion: Emotion.angry,
    );

    // Act
    final result = await usecase(entry);

    // Assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) {
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, 'Solo se puede editar la entrada del día en curso.');
      },
      (_) => fail('Debería retornar un Failure de validación'),
    );
    // Verificamos que SQLite jamás se llegó a tocar
    verifyZeroInteractions(mockRepository);
  });

  test('Debe llamar al Repository.saveEntry() cuando la fecha analizada es HOY', () async {
    // Arrange
    final today = DateTime.now();
    final entry = DailyEntry(
      date: today,
      content: 'Todo legal',
      emotion: Emotion.happy,
    );

    when(mockRepository.saveEntry(any)).thenAnswer((_) async => Future.value());

    // Act
    final result = await usecase(entry);

    // Assert
    expect(result.isRight(), true);
    // Verificamos que SQLite fue convocado exactamente 1 vez
    verify(mockRepository.saveEntry(entry)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
