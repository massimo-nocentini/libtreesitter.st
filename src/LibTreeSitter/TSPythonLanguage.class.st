Class {
	#name : 'TSPythonLanguage',
	#superclass : 'TSLanguage',
	#instVars : [
		'braces'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'initialization' }
TSPythonLanguage >> initialize [

	super initialize.

	braces := 0.

	highlights
		at: 'string.special.key' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( comment )) color asHexString).
				'style italic'.
				('family ' , LogicalFont pangoSans familyName) };
		at: 'opening.brace' put: { 'weight bold' };
		at: 'closing.brace' put: { 'weight bold' };
		at: 'opening.squaredb' put: { 'weight bold'. 'style italic' };
		at: 'closing.squaredb' put: { 'weight bold'. 'style italic' };
		at: 'variable' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( number )) color asHexString).
				('family ' , LogicalFont pangoMath familyName) };
		at: 'comment' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'number' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( number )) color asHexString).
				('family ' , LogicalFont pangoMath familyName) };
		at: 'keyword' put: { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'query' }
TSPythonLanguage >> name [

	^ 'python'
]

{ #category : 'instance creation' }
TSPythonLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_python' module: 'TreeSitterPlugin'>
	self primitiveFail
]

{ #category : 'as yet unclassified' }
TSPythonLanguage >> orderedPatterns [

	^ { 'variable'. 'keyword'. 'number' }
]
