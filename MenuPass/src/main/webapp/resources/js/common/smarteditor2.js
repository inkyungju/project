let oEditors = []

smartEditor = function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "editorTxt",
		sSkinURI: "/resources/smarteditor/SmartEditor2Skin.html",
		fCreator: "createSEditor2",
		htParams: { fOnBeforeUnload : function() {} }
	})
}

$(document).ready(function() {
	smartEditor()
})

function save() {
   // 스마트에디터 쓸때 쓰려고 만들어 논 값
   oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
   return;
}
