Class {
	#name : 'TSQuery',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'errorOffset',
		'errorType'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'finalization' }
TSQuery class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_query_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'as yet unclassified' }
TSQuery >> allocateQueryCursor [

	<primitive: 'primitive_ts_query_cursor_new' module:
	'TreeSitterPlugin'>
	^ ExternalAddress null
]

{ #category : 'as yet unclassified' }
TSQuery >> deallocateQueryCursor: anExternalAddress [

	<primitive: 'primitive_ts_query_cursor_delete' module:
	'TreeSitterPlugin'>
	
]

{ #category : 'accessing' }
TSQuery >> errorOffset [

	^ errorOffset
]

{ #category : 'accessing' }
TSQuery >> errorType [

	^ errorType
]

{ #category : 'as yet unclassified' }
TSQuery >> withQueryCursorDo: block [

	| cursorHandle |
	cursorHandle := self allocateQueryCursor.

	[ block value: cursorHandle ] ensure: [
		self deallocateQueryCursor: cursorHandle ]
]
