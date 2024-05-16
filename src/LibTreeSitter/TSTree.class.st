Class {
	#name : 'TSTree',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'finalization' }
TSTree class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_tree_delete' module: 'TreeSitterPlugin'>
	
]
