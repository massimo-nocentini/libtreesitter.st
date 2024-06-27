"
# Python grammar for Tree Sitter

I am a variant to allow TreeSitter to work with the Python language.

The original repo lies on [Github](https://github.com/tree-sitter/tree-sitter-python).
"
Class {
	#name : 'TSPythonLanguage',
	#superclass : 'TSLanguage',
	#category : 'LibTreeSitter-Languages',
	#package : 'LibTreeSitter',
	#tag : 'Languages'
}

{ #category : 'as yet unclassified' }
TSPythonLanguage class >> languageName [

	^ 'python'
]

{ #category : 'query' }
TSPythonLanguage >> newHighlightsStylesDictionary [

	^ super newHighlightsStylesDictionary
		  at: 'string.special.key' put: {
				  ('foreground #'
				   , (SHStyleElement withTokens: #( comment )) color asHexString).
				  'style italic'.
				  ('family ' , PangoLogicalFontManager pangoSans familyName) };
		  at: 'opening.brace' put: { 'weight bold' };
		  at: 'closing.brace' put: { 'weight bold' };
		  at: 'opening.squaredb' put: { 'weight bold'. 'style italic' };
		  at: 'closing.squaredb' put: { 'weight bold'. 'style italic' };
		  at: 'variable' put: {
				  ('foreground #'
				   , (SHStyleElement withTokens: #( number )) color asHexString).
				  ('family ' , PangoLogicalFontManager pangoMath familyName) };
		  at: 'comment' put: { ('foreground #'
			   , (SHStyleElement withTokens: #( string )) color asHexString) };
		  at: 'comment' put: {
				  ('foreground #'
				   , (SHStyleElement withTokens: #( comment )) color asHexString).
				  'style italic' };
		  at: 'number' put: {
				  ('foreground #'
				   , (SHStyleElement withTokens: #( number )) color asHexString).
				  ('family ' , PangoLogicalFontManager pangoMath familyName) };
		  at: 'keyword' put: { ('foreground #'
			   , (SHStyleElement withTokens: { 'true' }) color asHexString) };
		  yourself
]

{ #category : 'instance creation' }
TSPythonLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_python' module: 'TreeSitterPlugin'>
	self primitiveFail
]

{ #category : 'as yet unclassified' }
TSPythonLanguage >> orderedPatterns [

	^ { 'variable'. 'keyword'. 'number'. 'comment' }
]
