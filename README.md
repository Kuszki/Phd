# Rozprawa Doktorska

Analiza metrologiczna algorytmów dyskretnej transformacji falkowej

Politechnika Śląska, Wydział Elektryczny

Katedra Metrologii, Elektroniki i Automatyki

# Streszczenie

W pracy przedstawiono metodę wyznaczania wartości niepewności rozszerzonych wielkości wyjściowych torów pomiarowych zawierających w swojej strukturze algorytmy transformacji falkowej. Przedstawiona metoda jest uniwersalna dla dowolnych algorytmów transformacji falkowej, które przetwarzają dane z dziedziny liczb rzeczywistych, niezależnie od stosowanych parametrów algorytmu. Przedstawiony w pracy model błędów, opisujący właściwości metrologiczne toru pomiarowego, umożliwia opis deterministycznych i niedeterministycznych sygnałów błędów oraz uwzględnia widmo przetwarzanego przez tor pomiarowy sygnału w ocenie jego właściwości. Na potrzeby pracy wprowadzono podział na statyczne, dynamiczne i losowe sygnały błędów oraz podział rozważający genezę analizowanego sygnału, wyróżniający sygnały błędów własnych i propagowanych. W pracy przedstawiono, w jaki sposób algorytmy transformacji falkowej przetwarzają obecne w sygnale wejściowym sygnały błędów oraz przedstawiono ich rolę we wprowadzaniu sygnałów błędów własnych. Aplikacja zaproponowanej metody wyznaczania wartości wypadkowej niepewności rozszerzonej jest możliwa w czasie rzeczywistym, również w przypadku zmiany parametrów związanych z modelem błędów analizowanego toru pomiarowego i nie wymaga w tym celu stosowania metody Monte-Carlo. Poza rozważaniami teoretycznymi, praca przedstawia przykład aplikacji zaproponowanej metody analizy, odpowiedni dla przypadku gdy projektant toru pomiarowego stosuje gotową implementację algorytmu transformacji falkowej i nie posiada eksperckiej wiedzy na temat działania tych algorytmów. Wszystkie przedstawione w pracy zależności zostały zweryfikowane symulacyjnie, za pomocą metody Monte-Carlo, oraz pomiarowo, stosując w tym celu zbudowany na potrzeby pracy tor pomiarowy. Praca poświęca najwięcej uwagi algorytmom dyskretnej transformacji falkowej, natomiast stosowanie zaproponowanej metody analizy jest możliwe również w przypadku pozostałych odmian algorytmu.

# Budowa

Do zbudowania dokumentu wymagane jest pakiet `TeX Live` (budowa projektu), program `GNU Octave` (generowanie wykresów), program `Inkscape` (konwersja wykresów) oraz pakiet `Libreoffice` (konwersja obrazków). Aby zbudować dokument, stosując gotowy skrypt, należy:

``` bash
git clone https://github.com/Kuszki/Phd # skolonować repozytorium
cd Phd                                  # przejść do katalogu projektu
./build.sh                              # zbudować projekt
```

gdzie dodatkowo dla skryptu `build.sh`:

```
-d, --draws        wymusza wygenerowanie wykresów i konwersję obrazów
-q, --quiet        wyłącza większość komunikatów podczas kompilacji
-r, --remove       usuwa wszystkie pliki w katalogu 'budowa'
-c, --convert      wymusza konwersję obrazków do pdf
-o, --octave       wymusza wygenerowanie wykresów
-s, --skip         pomija proces budowy pdfów
```

przy czym istnieje również możliwość wygenerowania pliku wskazującego różnicę pomiędzy podaną, a obecną gałęzią:

```
-cd wersja, --comment-diff wersja   generuj różnicę w stylu komentarzy pdf
-dd wersja, --detail-diff wersja    generuj różnicę zanzaczając je w tekście
-sd wersja, --simple-diff wersja    generuj jak -dd tylko dla zmienionych stron
```

Wszystkie zawarte w projekcie wykresy są generowane przez program `GNU Octave` podczas kompilacji oraz konwertowane wraz z innymi rysunkami do formatu `PDF`. Efektem budowy projektu są trzy pliki:

- `budowa/thesis.pdf` -- rozprawa doktorska,
- `budowa/slides.pdf` -- prezentacja wygłaszana podczas obrony,
- `budowa/answers.pdf` -- zestawienie pytań i odpowiedzi dla recenzentów,

oraz dodatkowy plik:

- `budowa/diff.pdf` -- różnice w pliku pdf rozprawy pomiędzy obecną i wskazaną wersją,

jeżeli wskazano wersję, dla której ma zostać wygenerowany plik opisujący różnicę.

# Licencja

Projekt dostępny jest na warunkach licencji [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0). Dozwolone jest rozpowszechnianie, modyfikowanie, dostosowywanie niniejszej pracy i tworzenie materiałów na dowolnym nośniku lub w dowolnym formacie, również w zastosowaniach komercyjnych, pod warunkiem wskazania twórcy oryginalnej pracy oraz zachowania identycznych warunków licencji na dzieło pochodne.

# Linki

- [Treść rozprawy oraz recenzji](https://bip.polsl.pl/nadania_dr/lukasz-drozdz)
- [Informacje o publicznej obronie](https://bip.polsl.pl/termin_dok/lukasz-drozdz)
