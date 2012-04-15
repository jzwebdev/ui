//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Apr 13, 2012  2:40:15 PM
// Author: tomyeh
#library('artra:samples:viewport');

#import("dart:html");
#import('../../client/view/view.dart');

/**
 * A view port that demostrates how to use [View.innerLeft]
 * and [View.innerTop], such that the origin of child views
 * is not at the left-top corner of this view.
 */
class Viewport extends View {
	String _title = "";
	View _toolbar;

	Viewport([String title=""]) {
		innerLeft = innerTop = 30;
		_title = title;
		vclass = "v-Viewport";
	}

	String get title() => _title;
	void set title(String title) {
		if (title == null) title = "";
		_title = title;

		final Element n = getNode("title");
		if (n != null)
			n.innerHTML = title;
	}

	View get toolbar() => _toolbar;
	void set toolbar(View tbar) {
		if (_toolbar != null) {
			removeChild(_toolbar);
			_toolbar.style.position = ""; //reset
		}

		_toolbar = tbar;

		if (_toolbar != null) {
			insertBefore(_toolbar, firstChild);
			_syncToolbar();
		}
	}
	void _syncToolbar() {
		final Element tbar = getNode("toolbar");
		if (tbar != null) {
			_toolbar.left = tbar.$dom_offsetLeft;
			_toolbar.top = tbar.$dom_offsetTop;
		}
	}

	//@Override to returns the element representing the inner element.
	Element get innerNode() => getNode("inner");
	//@Override to skip the toolbar
	bool shallLayout_(View child) => child !== _toolbar;
	//@Override
	void domInner_(StringBuffer out) {
		out.add('<div class="v-Viewport-title" id="')
			.add(uuid).add('-title">').add(_title)
			.add('</div>');

		out.add('<div class="v-Viewport-toolbar" id="').add(uuid)
			.add('-toolbar">&nbsp;'); //&nbsp; makes this DIV positioned correctly
		if (_toolbar != null)
			_toolbar.draw(out);
		out.add('</div>');

		out.add('<div class="v-Viewport-inner" id="')
			.add(uuid).add('-inner">');

		for (View child = firstChild; child != null; child = child.nextSibling)
			if (child !== _toolbar)
				child.draw(out);

		out.add('</div>');
	}
	//@Override to insert the toolbar to the right place
	void insertChildToDocument_(View child, String html, View beforeChild) {
		if (child === _toolbar) {
			getNode("toolbar").insertAdjacentHTML("beforeEnd", html);
		} else {
			super.insertChildToDocument_(child, html, beforeChild === _toolbar ? null: beforeChild);
		}
	}
	void enterDocument_() {
		super.enterDocument_();

		if (_toolbar != null)
			_syncToolbar();
	}
}