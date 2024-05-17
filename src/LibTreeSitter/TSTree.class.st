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

{ #category : 'as yet unclassified' }
TSTree >> astOfString: src [

	| cumulatedSizes |
	cumulatedSizes := src lines
		                  scan: [ :cumulatedSize :line |
		                  cumulatedSize + 1 + line size ]
		                  init: 0.

	^ self
		  onTreeHandle: self getHandle
		  src: src
		  cumulatedSizes: cumulatedSizes asArray
		  nodeClass: TSNode
]

{ #category : 'accessing' }
TSTree >> onTreeHandle: tHandle query: query class: class [

	<primitive: 'primitive_ts_query_new' module: 'TreeSitterPlugin'>
	^ nil
]

{ #category : 'as yet unclassified' }
TSTree >> onTreeHandle: tHandle src: src cumulatedSizes: cumulatedSizes nodeClass: class [

	<primitive: 'primitive_ts_ast' module: 'TreeSitterPlugin'>
	^ nil
]

{ #category : 'accessing' }
TSTree >> query: query [

	^ self onTreeHandle: self getHandle query: query class: TSQuery
]