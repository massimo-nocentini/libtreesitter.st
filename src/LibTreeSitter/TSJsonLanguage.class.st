Class {
	#name : 'TSJsonLanguage',
	#superclass : 'TSLanguage',
	#instVars : [
		'braces'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'query' }
TSJsonLanguage >> highlightsQueryString [

	^ (self highlightsQueryStringForLanguageNamed: 'json') , '

"{" @opening.brace

"}" @closing.brace

"[" @opening.squaredb

"]" @closing.squaredb

'
]

{ #category : 'initialization' }
TSJsonLanguage >> initialize [

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
