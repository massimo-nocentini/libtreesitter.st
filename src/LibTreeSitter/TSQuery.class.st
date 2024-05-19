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
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'finalization' }
TSQuery class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_query_delete' module: 'TreeSitterPlugin'>
	
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
TSQuery >> matchesOnTree: tree [

	^ self
		  matchesQueryHandle: self getHandle
		  treeHandle: tree getHandle
		  class: TSQueryCapture
]

{ #category : 'as yet unclassified' }
TSQuery >> matchesQueryHandle: qHandle treeHandle: tHandle class: class [

	<primitive: 'primitive_ts_query_matches' module: 'TreeSitterPlugin'>
	^ #(  )
]
