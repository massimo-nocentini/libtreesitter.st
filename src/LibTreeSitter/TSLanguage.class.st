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
TSLanguage class >> javascript [

	^ TSJavascriptLanguage new
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

{ #category : 'visiting' }
TSLanguage >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitTSLanguage: self
]

{ #category : 'as yet unclassified' }
TSLanguage >> allocate [

	^ self newLanguageHandle
]

{ #category : 'converting' }
TSLanguage >> asGrammarJsShape [

	^ TSChunk new
		  language: self name;
		  sourceCode: self jsGrammarString;
		  asRSPangoShapeUsingFont: LogicalFont pangoMonospace
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

	| sharePath |
	sharePath := Smalltalk vm directory asFileReference parent / 'share'
	             / 'tree-sitter' / 'language' / self name / 'queries'
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
TSLanguage >> jsGrammarString [

	| sharePath |
	sharePath := Smalltalk vm directory asFileReference parent / 'share'
	             / 'tree-sitter' / 'language' / self name / 'grammar.js'.

	^ sharePath exists
		  ifTrue: [ sharePath contents ]
		  ifFalse: [ String empty ]
]

{ #category : 'query' }
TSLanguage >> languageHandle: lHandle queryString: qString queryClass: class [

	<primitive: 'primitive_ts_query_new' module: 'TreeSitterPlugin'>
	^ nil
]

{ #category : 'query' }
TSLanguage >> name [

	self subclassResponsibility
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
