Class {
	#name : 'TSCLanguage',
	#superclass : 'TSLanguage',
	#instVars : [
		'braces'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'query' }
TSCLanguage >> highlightsQueryString [

	^ (self highlightsQueryStringForLanguageNamed: 'c') , '
	
(function_declarator
  declarator: (identifier) @function.decl)

'
]

{ #category : 'initialization' }
TSCLanguage >> initialize [

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
		at: 'type' put: {
				('foreground #'
				 , (SHStyleElement withTokens: #( pragma )) color asHexString).
				'weight bold' };
		at: 'variable' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'property' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( instVar )) color asHexString) };
		at: 'string' put: { ('foreground #'
			 , (SHStyleElement withTokens: #( string )) color asHexString) };
		at: 'constant' put: { ('foreground #'
			 , (SHStyleElement withTokens: { 'true' }) color asHexString) }
]

{ #category : 'query' }
TSCLanguage >> name [

	^ 'c'
]

{ #category : 'instance creation' }
TSCLanguage >> newLanguageHandle [

	<primitive: 'primitive_tree_sitter_c' module: 'TreeSitterPlugin'>
	self primitiveFail
]

{ #category : 'pattern' }
TSCLanguage >> orderedPatterns [

	^ { 'number'. 'string'. 'function.decl'. 'function'. 'variable'.
	  'constant'. 'property'. 'operator'. 'keyword'. 'comment'. 'type' }
]
