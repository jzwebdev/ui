//Sample Code: Layout Demostration

#import('dart:html');

#import('../../client/app/app.dart');
#import('../../client/view/view.dart');

class FreeLayoutDemo extends Activity {

	void onCreate_(View rootView) {
		title = "Free Layout Demo";

		rootView.style.backgroundColor = "#cca";

		View view = new View();
		view.style.backgroundColor = "#ddb";
		view.profile.anchor = "parent";
		view.profile.location = "center center";
		view.profile.width = "70%";
		view.profile.height = "80%";
		rootView.appendChild(view);

		//1. first level dependence
		for (final String loc in [
		"north start", "north center", "north end",
		"south start", "south center", "south end",
		"west start", "west center", "west end",
		"east start", "east center", "east end",
		"top left", "top center", "top right",
		"center left", "center center", "center right",
		"bottom left", "bottom center", "bottom right"]) {
			TextView txt = new TextView(loc);
			txt.style.border = "1px solid #555";
			txt.profile.anchorView = view;
			txt.profile.location = loc;
			rootView.appendChild(txt);
		}

		//2. second level dependence
		TextView txt = new TextView("north start");
		txt.style.border = "1px solid red";
		txt.profile.anchorView = rootView.lastChild;
		txt.profile.location = "north start";
		txt.profile.width = "flex";
		rootView.appendChild(txt);
	}
}

void main() {
	new FreeLayoutDemo().run();
}