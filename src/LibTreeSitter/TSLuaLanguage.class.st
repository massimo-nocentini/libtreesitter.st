Class {
	#name : 'TSLuaLanguage',
	#superclass : 'Object',
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'initialization' }
TSLuaLanguage >> initialize [

	super initialize.

	highlights
		at: 'comment' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( comment )) color asHexString).
				'style italic' };
		at: 'keyword' put: { 'weight bold' };
		at: 'keyword.return' put: { 'weight bold' };
		at: 'keyword.function' put: { 'weight bold' };
		at: 'repeat' put: { 'weight bold' };
		at: 'conditional' put: { 'weight bold' };
		at: 'keyword.operator' put: { 'weight bold' };
		at: 'operator' put: { 'weight bold' };
		at: 'constructor' put: { 'weight bold' };
		at: 'function.builtin' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( 'self' )) color asHexString) };
		at: 'label' put: { 'underline single' };
		at: 'constant.builtin' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( 'nil' )) color asHexString) };
		at: 'number' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( number )) color asHexString).
				('family ' , LogicalFont pangoMath familyName) };
		at: 'type' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( pragma )) color asHexString).
				'weight bold' };
		at: 'variable' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'field' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'string' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'constant' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'parameter' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( argument )) color asHexString) };
		at: 'boolean' put: { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'as yet unclassified' }
TSLuaLanguage >> orderedPatterns [

	^ super orderedPatterns
]
