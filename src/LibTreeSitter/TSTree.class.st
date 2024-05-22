Class {
	#name : 'TSTree',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'sourceCode'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
}

{ #category : 'finalization' }
TSTree class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_tree_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'ast' }
TSTree >> ast [

	^ self onTreeHandle: self getHandle src: sourceCode nodeClass: TSNode
]

{ #category : 'ast' }
TSTree >> onTreeHandle: tHandle src: src nodeClass: class [

	<primitive: 'primitive_ts_ast' module: 'TreeSitterPlugin'>
	^ nil
]
