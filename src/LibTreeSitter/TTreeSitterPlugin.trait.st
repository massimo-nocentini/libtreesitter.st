Trait {
	#name : 'TTreeSitterPlugin',
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'primitives' }
TTreeSitterPlugin >> handleForLanguageC [

	<primitive: 'primitive_tree_sitter_c' module: 'TreeSitterPlugin'>
	self primitiveFail
]
