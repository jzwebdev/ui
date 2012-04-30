//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Apr 23, 2012  6:10:07 PM
// Author: tomyeh

/**
 * The dashboard view.
 */
class Dashboard extends View {
	Dashboard() {
		layout.type = "linear";
		layout.orient = "vertical";

		appendChild(new TextView(html: '<h1 style="margin:0">Rikulo Simulator</h1>'));
		_addOrientation(this);
		_addLogView(this);
	}
	void _addOrientation(View parent) {
		View view = new View();
		_setHLayout(view);
		parent.appendChild(view);

		TextView text = new TextView("Orientation");
		view.appendChild(text);

		RadioGroup group = new RadioGroup();
		_setHLayout(group);
		group.layout.spacing = "0 5";
		view.appendChild(group);

		RadioButton vert = new RadioButton("vertical", checked: true);
		group.appendChild(vert);
		RadioButton horz = new RadioButton("horizontal");
		group.appendChild(horz);
		group.on.check.add(_orientListener);
	}
	static EventListener get _orientListener() {
		return (event) {
			simulator.setOrient(event.target.text == 'horizontal');
		};
	}
	void _addLogView(View view) {
		View logView = new View();
		logView.layout.type = "linear";
		logView.layout.orient = "vertical";
		logView.layout.spacing = "0";
		logView.profile.width = logView.profile.height = "flex";
		logView.classes.add("v-dashboard-log");
		view.appendChild(logView);
	}
	void _setHLayout(View view) {
		view.layout.type = "linear";
		view.layout.width = "content";
		view.profile.width = "flex";
		view.profile.height = "content";
	}
}
