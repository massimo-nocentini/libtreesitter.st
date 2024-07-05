Class {
	#name : 'TSQuery',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'errorOffset',
		'errorType',
		'language',
		'queryString'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
}

{ #category : 'finalization' }
TSQuery class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_query_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'checking' }
TSQuery >> check [

	self errorType = 0 ifFalse: [
		Error signal: 'Query creation failed.' withTag: self errorOffset ]
]

{ #category : 'accessing' }
TSQuery >> errorOffset [

	^ errorOffset
]

{ #category : 'accessing' }
TSQuery >> errorType [

	^ errorType
]

{ #category : 'testing' }
TSQuery >> matchesGroupByCategoryOnTree: tree [

	| captures |
	captures := Dictionary new.

	(self matchesOnTree: tree) do: [ :each |
		captures
			at: each name
			ifPresent: [ :collection | collection add: each ]
			ifAbsentPut: [ OrderedCollection with: each ] ].

	^ captures
]

{ #category : 'testing' }
TSQuery >> matchesOnTree: tree [

	^ self
		  matchesQueryHandle: self getHandle
		  treeHandle: tree getHandle
		  sourceCode: tree sourceCode
		  queryCaptureClass: TSQueryCapture
]

{ #category : 'primitives' }
TSQuery >> matchesQueryHandle: qHandle treeHandle: tHandle sourceCode: src queryCaptureClass: class [

	<primitive: 'primitive_ts_query_matches' module: 'TreeSitterPlugin'>
	^ #(  )
]
