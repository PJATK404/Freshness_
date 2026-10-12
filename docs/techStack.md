## :broccoli: Freshness – Tech Stack

**:mobile_phone: Aplikacja mobilna**
- **Flutter (Dart)** – jedna baza kodu na Androida i iOS
- Działa **w 100% lokalnie** (offline, bez serwera, bez kont)
- `tflite_flutter` – uruchamianie modelu na telefonie
- `sqflite` – obsługa lokalnej bazy danych
- Aparat + galeria zdjęć

**:brain: Model AI**
- **MobileNetV3-Large** (pretrenowany na ImageNet)
- **Transfer learning** na naszych datasetach
- 1 sieć, **2 głowice**: rodzaj produktu + świeżość (świeży/zepsuty)
- Eksport do **TensorFlow Lite** + kwantyzacja **INT8** (~5–6 MB)
- Alternatywa: ONNX + ONNX Runtime

**:person_lifting_weights: Trening**
- **Python 3.12**
- **PyTorch** + **torchvision**
- Darmowe GPU: **Google Colab / Kaggle Notebooks**
- Datasety: Kaggle – *Fresh and Stale Images of Fruits and Vegetables*, *Fruits fresh and rotten for classification* (+ inne, które znajdziemy)

**:file_cabinet: Dane**
- **SQLite** – wartości odżywcze + historia skanów (lokalnie na telefonie)
- Źródło wartości odżywczych: **USDA FoodData Central** (darmowe, public domain)
- Skrypt w Pythonie: USDA → plik `.db` dołączany do apki

**:dart: Progi świeżości (pewność „świeży”)**
- ≥ 90% → :white_check_mark: Świeży
- 75–89% → :yellow_circle: Raczej świeży
- < 75% → :x: Raczej zepsuty

**:x: Odpadło z pierwotnego stacku i dlaczego**
- **FastAPI / Uvicorn / REST** – nie potrzebujemy serwera (ewentualnie później, do aktualizacji modelu)
- **PostgreSQL / SQLAlchemy** – SQLite w zupełności wystarczy
- **OpenCV** – torchvision + Flutter ogarniają przetwarzanie zdjęć
- **React Native** – wybraliśmy Fluttera
- **Python 3.10** – koniec wsparcia w październiku 2026, bierzemy 3.12

**:computer: Wymagania**
- Telefon: praktycznie każdy z ostatnich ~6–7 lat (2–3 GB RAM wystarczy)
- Do buildów na iOS potrzebny **Mac z Xcode**