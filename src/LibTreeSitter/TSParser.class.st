Class {
	#name : 'TSParser',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'handle',
		'assigned'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'language' }
TSParser class >> c [

	^ self new
		  language: TSLanguage c;
		  yourself
]

{ #category : 'finalization' }
TSParser class >> deallocateHandle: anExternalAddress [

	<primitive: 'primitive_ts_parser_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'as yet unclassified' }
TSParser >> allocate [

	<primitive: 'primitive_ts_parser_new' module: 'TreeSitterPlugin'>
	^ ExternalAddress null
]

{ #category : 'as yet unclassified' }
TSParser >> astOfString: src [

	^ (self treeOfString: src) astOfString: src
]

{ #category : 'accessing' }
TSParser >> hasLanguageAssigned [

	^ assigned
]

{ #category : 'initialization' }
TSParser >> initialize [

	super initialize.

	assigned := false.
	handle := self allocate
]

{ #category : 'accessing' }
TSParser >> language: lang [

	assigned := self
		            onParserHandle: self getHandle
		            setLanguageHandle: lang getHandle
]

{ #category : 'as yet unclassified' }
TSParser >> onParserHandle: pHandle parseString: src [

	<primitive: 'primitive_ts_parser_parse_string' module:
	'TreeSitterPlugin'>
	^ ExternalAddress null
]

{ #category : 'as yet unclassified' }
TSParser >> onParserHandle: pHandle setLanguageHandle: lHandle [

	<primitive: 'primitive_ts_parser_set_language' module:
	'TreeSitterPlugin'>
	^ false
]

{ #category : 'as yet unclassified' }
TSParser >> treeOfString: src [

	^ TSTree new
		  handle: (self onParserHandle: self getHandle parseString: src);
		  yourself
]
