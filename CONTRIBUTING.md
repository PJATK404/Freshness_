# Zasady pracy w repozytorium

Cel: kod ma wyglądać tak, jakby napisała go jedna osoba. Większość zasad pilnuje CI, a reszta opiera się na tym dokumencie i review.

## Język

| Co | Język |
|---|---|
| Kod: nazwy zmiennych, funkcji, klas, plików, komentarze | **angielski** |
| Commity, tytuły PR, nazwy branchy | **angielski** |
| Teksty widoczne dla użytkownika (UI) | **polski** |
| Dokumentacja (`README`, `docs/`), opisy PR i issue | **polski** |

## Workflow Git

**Nie pracujemy na `main`.** Każda zmiana przechodzi przez branch i PR.

```bash
git switch main
git pull
git switch -c feat/12-scan-screen
# ... praca, commity ...
git push -u origin feat/12-scan-screen
# otwórz PR do main na GitHubie
```

### Nazwy branchy

Format: `<typ>/<opis-kebab-case>`. Numer issue na początku opisu jest mile widziany.

| Typ | Kiedy |
|---|---|
| `feat` | nowa funkcja w apce |
| `fix` | poprawka błędu |
| `ml` | trening, eksport modelu, datasety |
| `refactor` | zmiana kodu bez zmiany działania |
| `test` | tylko testy |
| `docs` | dokumentacja |
| `ci` | GitHub Actions |
| `chore` | konfiguracja, zależności, porządki |

✅ `feat/12-scan-screen`, `ml/two-head-model`, `fix/history-crash`
❌ `Feature/ScanScreen`, `kacper-test`, `fix_bug`

### Tytuły PR i commity ([Conventional Commits](https://www.conventionalcommits.org/))

Format: `<typ>(<scope>): <opis>`. Scope jest opcjonalny: `app`, `ml`, `data`, `repo`.

✅ `feat(app): add camera scan screen`
✅ `ml: add freshness head to MobileNetV3`
✅ `fix(app): handle missing nutrition data`
❌ `poprawki`, `WIP`, `Update main.dart`

Mergujemy przez **Squash and merge**, więc to tytuł PR trafia do historii `main`. Commity w samym branchu mogą być robocze.

### Pull Request

- Jeden PR odpowiada jednemu taskowi. Małe PR-y szybciej przechodzą review.
- Dodaj `Closes #<nr>` w opisie, żeby issue zamknęło się automatycznie.
- Merge jest możliwy dopiero, gdy **CI jest zielone** i jest **min. 1 approve**.
- Przed merge zaktualizuj branch względem `main` (przycisk *Update branch* albo `git pull origin main`).

## Konwencje kodu: Dart / Flutter (`app/`)

Bazujemy na [Effective Dart](https://dart.dev/effective-dart/style). Formatowanie robi `dart format`, a lint `app/analysis_options.yaml`.

| Element | Konwencja | Przykład |
|---|---|---|
| Pliki, katalogi | `snake_case` | `scan_screen.dart` |
| Klasy, enumy, typedefy, rozszerzenia | `PascalCase` | `ScanResult`, `FreshnessLevel` |
| Zmienne, funkcje, parametry, pola | `camelCase` | `confidenceScore`, `loadNutrition()` |
| Stałe | `camelCase` (nie `UPPER_CASE`) | `const freshThreshold = 0.9;` |
| Pola / metody prywatne | prefiks `_` | `_database` |
| Wartości logiczne | `is` / `has` / `can` | `isFresh`, `hasNutritionData` |

- Importy w `lib/` piszemy zawsze jako `package:freshness/...`, bez ścieżek względnych.
- Używamy pojedynczych cudzysłowów i `const`, gdzie się da, a zmienne lokalne oznaczamy jako `final`.
- **Warstwy** (zgodnie z DZW):
  - `ui/` to ekrany i widgety. Nie odwołują się bezpośrednio do SQLite ani do modelu.
  - `logic/` to logika: progi świeżości, klasyfikacja, stan ekranów.
  - `data/` zawiera dostęp do SQLite, modelu TFLite i assetów.
  - `core/` to elementy wspólne: stałe, motyw, narzędzia.
- Klasa ekranu kończy się na `Screen` (`ScanScreen`, plik `scan_screen.dart`). Repozytorium kończy się na `Repository`.
- Plik testu nazywamy `<plik>_test.dart` i trzymamy w `test/` w tej samej strukturze co w `lib/`.

## Konwencje kodu: Python (`ml/`)

Bazujemy na [PEP 8](https://peps.python.org/pep-0008/). Formatowanie i lint robi `ruff` (konfiguracja w `ml/pyproject.toml`).

| Element | Konwencja | Przykład |
|---|---|---|
| Moduły, pakiety, pliki | `snake_case` | `freshness_head.py` |
| Klasy | `PascalCase` | `FreshnessDataset` |
| Funkcje, zmienne, argumenty | `snake_case` | `train_one_epoch()`, `learning_rate` |
| Stałe | `UPPER_SNAKE_CASE` | `IMAGE_SIZE = 224` |
| Prywatne | prefiks `_` | `_load_split()` |

- Wymagane są type hinty w sygnaturach funkcji.
- Kod wielokrotnego użytku trafia do `src/freshness_ml/`, a notebooki tylko go importują i uruchamiają.
- Notebooki nazywamy `NN_snake_case.ipynb` (`01_explore_datasets.ipynb`) i commitujemy **bez outputów**.
- Plik testu nazywamy `test_<moduł>.py` i trzymamy w `ml/tests/`.

## Wspólne nazewnictwo domeny

Te same pojęcia nazywamy tak samo w Dart, Pythonie i bazie danych:

| Pojęcie | Dart | Python | SQLite |
|---|---|---|---|
| produkt (rodzaj warzywa/owocu) | `product` | `product` | `product` |
| świeżość | `freshness` | `freshness` | `freshness` |
| pewność modelu (0–1) | `confidence` | `confidence` | `confidence` |
| skan | `scan` | `scan` | `scan` |
| wartości odżywcze | `nutrition` | `nutrition` | `nutrition` |

Tabele i kolumny SQLite piszemy w `snake_case` i liczbie pojedynczej (`scan`, `created_at`). Etykiety klas modelu też w `snake_case` po angielsku (`banana`, `bell_pepper`).

## Czego nie commitujemy

- Datasetów i checkpointów (`ml/data/`, `ml/checkpoints/`, `*.pt`, `*.pth`). CI blokuje pliki > 10 MB.
- Sekretów, kluczy API, plików `.env`.
- Wygenerowanych plików builda (`build/`, `.dart_tool/`).
