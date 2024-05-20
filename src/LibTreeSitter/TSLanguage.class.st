Class {
	#name : 'TSLanguage',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'highlights',
		'session'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'languages' }
TSLanguage class >> c [

	^ TSCLanguage new
]

{ #category : 'finalization' }
TSLanguage class >> deallocateHandle: anExternalAddress [
	"nothing to do here"

	
]

{ #category : 'finalization' }
TSLanguage class >> freeLanguageHandle: anExternalAddress [

	<primitive: 'primitive_ts_language_delete' module: 'TreeSitterPlugin'>
	
]

{ #category : 'languages' }
TSLanguage class >> json [

	^ TSJsonLanguage new
]

{ #category : 'languages' }
TSLanguage class >> lua [

	^ TSLuaLanguage new
]

{ #category : 'languages' }
TSLanguage class >> psql [

	^ TSPSQLLanguage new
]

{ #category : 'as yet unclassified' }
TSLanguage >> allocate [

	^ self newLanguageHandle
]

{ #category : 'accessing' }
TSLanguage >> at: pattern [

	^ highlights at: pattern ifAbsent: [ #(  ) ]
]

{ #category : 'as yet unclassified' }
TSLanguage >> getHandle [

	session == Smalltalk session ifFalse: [
		handle := self allocate.
		session := Smalltalk session ].

	^ handle
]

{ #category : 'query' }
TSLanguage >> highlightsQuery [

	^ self query: self highlightsQueryString
]

{ #category : 'query' }
TSLanguage >> highlightsQueryString [

	self subclassResponsibility
]

{ #category : 'query' }
TSLanguage >> highlightsQueryStringForLanguageNamed: languageName [

	| sharePath |
	sharePath := Smalltalk vm directory asFileReference parent / 'share'
	             / 'tree-sitter' / 'query' / languageName
	             / 'highlights.scm'.

	^ sharePath exists
		  ifTrue: [ sharePath contents ]
		  ifFalse: [ String empty ]
]

{ #category : 'initialization' }
TSLanguage >> initialize [

	super initialize.

	handle := self allocate.
	highlights := Dictionary new
]

{ #category : 'query' }
TSLanguage >> languageHandle: lHandle queryString: qString queryClass: class [

	<primitive: 'primitive_ts_query_new' module: 'TreeSitterPlugin'>
	^ nil
]

{ #category : 'instance creation' }
TSLanguage >> newLanguageHandle [

	self subclassResponsibility
]

{ #category : 'accessing' }
TSLanguage >> orderedPatterns [

	^ #(  )
]

{ #category : 'accessing' }
TSLanguage >> parser [

	^ TSParser new
		  language: self;
		  yourself
]

{ #category : 'query' }
TSLanguage >> query: qString [

	^ self
		  languageHandle: self getHandle
		  queryString: qString
		  queryClass: TSQuery
]
