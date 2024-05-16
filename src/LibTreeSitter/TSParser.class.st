Class {
	#name : 'TSParser',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'handle'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'finalization' }
TSParser class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_parser_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'as yet unclassified' }
TSParser >> allocate [

	<primitive: 'primitive_ts_parser_new' module: 'TreeSitterPlugin'>
	^ ExternalAddress null
]

{ #category : 'initialization' }
TSParser >> initialize [

	super initialize.

	handle := self allocate
]
