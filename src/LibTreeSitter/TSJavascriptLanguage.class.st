Class {
	#name : 'TSJavascriptLanguage',
	#superclass : 'TSLanguage',
	#instVars : [
		'braces'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'query' }
TSJavascriptLanguage >> highlightsQueryString [

	^ self highlightsQueryStringForLanguageNamed: 'javascript'
]

{ #category : 'initialization' }
TSJavascriptLanguage >> initialize [

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
		at: 'number' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( number )) color asHexString).
				('family ' , LogicalFont pangoMath familyName) };
		at: 'string' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'constant.builtin' put: { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'query' }
TSJavascriptLanguage >> name [

	^ 'javascript'
]

{ #category : 'instance creation' }
TSJavascriptLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_javascript' module: 'TreeSitterPlugin'>
	self primitiveFail
]

{ #category : 'as yet unclassified' }
TSJavascriptLanguage >> orderedPatterns [

	^ { 'number'. 'string.special.key'. 'constant.builtin'.
	  'string'. 'opening.brace'. 'closing.brace'. 'opening.squaredb'.
	  'closing.squaredb' }
]