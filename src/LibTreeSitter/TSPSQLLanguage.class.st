Class {
	#name : 'TSPSQLLanguage',
	#superclass : 'Object',
	#instVars : [
		'braces'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'initialization' }
TSPSQLLanguage >> initialize [

	super initialize.

	braces := 0.

	highlights
		at: 'comment' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( comment )) color asHexString).
				'style italic' };
		at: 'keyword' put: { 'weight bold' };
		at: 'operator' put: { 'weight bold' };
		at: 'label' put: { 'underline single' };
		at: 'function' put: {
				'style italic'.
				('foreground #'
				 , (SHStyleElement withTokens: #( selector )) color asHexString) };
		at: 'function.decl' put: {
				'style italic'.
				'weight bold'.
				('foreground #'
				 , (SHStyleElement withTokens: #( selector )) color asHexString) };
		at: 'number' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( number )) color asHexString).
				('family ' , LogicalFont pangoMath familyName) };
		at: 'type.builtin' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( pragma )) color asHexString).
				'weight bold' };
		at: 'variable' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'property' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'string' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'constant.builtin' put: { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'as yet unclassified' }
TSPSQLLanguage >> orderedPatterns [

	^ super orderedPatterns
]
