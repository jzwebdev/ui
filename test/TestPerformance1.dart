//Sample Code: LinearLayout Test Performance 1

import 'package:rikulo_ui/view.dart';

void main() {
  printc("started");
  final View mainView = new View()
    ..layout.text = "type: linear; orient: vertical"
    ..on.layout.listen((event) {
      if (event.target == event.currentTarget) //filter out children
        printc("done");
    });

  for (int i = 0; i < 50; ++i) {
    View hlayout = new View();
    hlayout.profile.text = "width: flex; height: content";
    hlayout.layout.type = "linear";
    hlayout.style.border = "1px solid #885";

    for (int j = 0; j < 50; ++j) {
      TextView view = new TextView("$i.$j");
      view.style.backgroundColor = "orange";
      view.style.lineHeight = "30px";
      view.style.textAlign = "center";
      view.profile.text = "width: 50; height: 30";
      //performance is much better if not to use "content" (default)
      //note: don't assign to view.width/height directly since it is slower (measureWidth_ will be called)
      hlayout.addChild(view);
    }

    mainView.addChild(hlayout);
  }
  mainView.addToDocument();
  printc("after view added");
}
