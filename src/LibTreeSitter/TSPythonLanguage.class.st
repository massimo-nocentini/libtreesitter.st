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
		  
		  at: 'keyword' put: self gmarkupSyntaxStyle;
		  at: 'comment' put: self gmarkupCommentStyle;
		  at: 'operator' put: self gmarkupBoldStyle;
		  at: 'number' put: self gmarkupNumberStyle;
		  at: 'string' put: self gmarkupStringStyle;
		  "at: 'constant' put: self gmarkupBuiltinStyle;
		  "at: 'function' put: {
				  'style italic'.
				  'weight bold'.
				  ('foreground #'
				   , (SHStyleElement withTokens: #( selector )) color asHexString) };
		  yourself
]

{ #category : 'instance creation' }
TSPythonLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_python' module: 'TreeSitterPlugin'>
	self primitiveFail
]
