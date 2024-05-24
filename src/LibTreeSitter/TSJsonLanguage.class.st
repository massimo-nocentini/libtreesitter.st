Class {
	#name : 'TSJsonLanguage',
	#superclass : 'TSLanguage',
	#category : 'LibTreeSitter-Languages',
	#package : 'LibTreeSitter',
	#tag : 'Languages'
}

{ #category : 'as yet unclassified' }
TSJsonLanguage class >> languageName [

	^ 'json'
]

{ #category : 'as yet unclassified' }
TSJsonLanguage >> highlightsQueryString [

	^ super highlightsQueryString , '

"{" @opening.brace

"}" @closing.brace

"[" @opening.squaredb

"]" @closing.squaredb

'
]

{ #category : 'query' }
TSJsonLanguage >> newHighlightsStylesDictionary [

	^ super newHighlightsStylesDictionary
		  at: 'string.special.key' put: self gmarkupInstanceVarStyle;
		  at: 'opening.brace' put: self gmarkupBoldStyle;
		  at: 'closing.brace' put: self gmarkupBoldStyle;
		  at: 'opening.squaredb'
		  put: self gmarkupBoldStyle , self gmarkupItalicStyle;
		  at: 'closing.squaredb'
		  put: self gmarkupBoldStyle , self gmarkupItalicStyle;
		  at: 'number' put: self gmarkupNumberStyle;
		  at: 'string' put: self gmarkupStringStyle;
		  at: 'constant.builtin' put: self gmarkupBuiltinStyle;
		  yourself
]

{ #category : 'instance creation' }
TSJsonLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_json' module: 'TreeSitterPlugin'>
	self primitiveFail
]

{ #category : 'as yet unclassified' }
TSJsonLanguage >> orderedPatterns [

	^ { 'number'. 'string.special.key'. 'constant.builtin'.
	  'string'. 'opening.brace'. 'closing.brace'. 'opening.squaredb'.
	  'closing.squaredb' }
]
