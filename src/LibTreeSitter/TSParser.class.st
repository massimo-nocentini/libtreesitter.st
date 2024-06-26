Class {
	#name : 'TSParser',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'assigned'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
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

{ #category : 'accessing' }
TSParser >> hasLanguageAssigned [

	^ assigned
]

{ #category : 'initialization' }
TSParser >> initialize [

	super initialize.

	assigned := false.
	handle := self allocate.

	self addToTheResourceManager
]

{ #category : 'accessing' }
TSParser >> language: lang [

	assigned := self
		            onParserHandle: self getHandle
		            setLanguageHandle: lang getHandle
]

{ #category : 'as yet unclassified' }
TSParser >> onParserHandle: pHandle parseString: src treeClass: class [

	<primitive: 'primitive_ts_parser_parse_string' module:
	'TreeSitterPlugin'>
	^ nil
]

{ #category : 'as yet unclassified' }
TSParser >> onParserHandle: pHandle setLanguageHandle: lHandle [

	<primitive: 'primitive_ts_parser_set_language' module:
	'TreeSitterPlugin'>
	^ false
]

{ #category : 'as yet unclassified' }
TSParser >> treeOfString: src [

	^ (self
		   onParserHandle: self getHandle
		   parseString: src withUnixLineEndings
		   treeClass: TSTree)
		  addToTheResourceManager;
		  yourself
]
