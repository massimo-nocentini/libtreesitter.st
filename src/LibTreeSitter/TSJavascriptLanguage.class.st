Class {
	#name : 'TSJavascriptLanguage',
	#superclass : 'TSLanguage',
	#category : 'LibTreeSitter-Languages',
	#package : 'LibTreeSitter',
	#tag : 'Languages'
}

{ #category : 'as yet unclassified' }
TSJavascriptLanguage class >> languageName [

	^ 'javascript'
]

{ #category : 'as yet unclassified' }
TSJavascriptLanguage >> newHighlightsStylesDictionary [

	^ super newHighlightsStylesDictionary
		  at: 'keyword' put: self gmarkupSyntaxStyle;
		  at: 'number' put: self gmarkupNumberStyle;
		  at: 'string' put: self gmarkupStringStyle;
		  at: 'constant.builtin' put: self gmarkupReservedWordsStyle;
		  at: 'comment' put: self gmarkupCommentStyle;
		  yourself
]

{ #category : 'instance creation' }
TSJavascriptLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_javascript' module: 'TreeSitterPlugin'>
	self primitiveFail
]
