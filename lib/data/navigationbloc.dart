import 'dart:async';

class NavigationBloc {
  final _navigationController = StreamController<int>();
  int _currentIndex = 0;

  // Stream for navigation index
  Stream<int> get navigationStream => _navigationController.stream;
  int get navigationIndex => _currentIndex;

  // Function to update navigation index
  void updateIndex(int index) {
    _currentIndex = index;
    _navigationController.add(_currentIndex);
  }

  // Dispose of the stream controller when done
  void dispose() {
    _navigationController.close();
  }
}