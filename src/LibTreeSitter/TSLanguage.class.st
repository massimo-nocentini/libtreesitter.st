Class {
	#name : 'TSLanguage',
	#superclass : 'Object',
	#traits : 'TGMarkupStyleProvider',
	#classTraits : 'TGMarkupStyleProvider classTrait',
	#instVars : [
		'handle',
		'highlights',
		'session'
	],
	#classVars : [
		'Languages'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
}

{ #category : 'languages' }
TSLanguage class >> c [

	^ TSCLanguage new
]

{ #category : 'finalization' }
TSLanguage class >> deallocateHandle: anExternalAddress [
	"nothing to do here"

	"<primitive: 'primitive_ts_language_delete' module: 'TreeSitterPlugin'>"

	
]

{ #category : 'as yet unclassified' }
TSLanguage class >> discoverLanguages [

	| dict |
	dict := Dictionary new.

	self subclasses do: [ :each | dict at: each languageName put: each ].

	^ dict
]

{ #category : 'as yet unclassified' }
TSLanguage class >> initialize [

	Languages := self discoverLanguages
]

{ #category : 'languages' }
TSLanguage class >> javascript [

	^ TSJavascriptLanguage new
]

{ #category : 'languages' }
TSLanguage class >> json [

	^ TSJsonLanguage new
]

{ #category : 'accessing' }
TSLanguage class >> languageName [

	self subclassResponsibility
]

{ #category : 'as yet unclassified' }
TSLanguage class >> languageNamed: langName ifPresent: pBlock ifAbsent: aBlock [

	^ Languages
		  at: langName
		  ifPresent: [ :aClass | pBlock value: aClass new ]
		  ifAbsent: aBlock
]

{ #category : 'languages' }
TSLanguage class >> python [

	^ TSPythonLanguage new
]

{ #category : 'visiting' }
TSLanguage >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitTSLanguage: self
]

{ #category : 'converting' }
TSLanguage >> asGrammarJsShape [

	^ TSChunk new
		  language: 'javascript';
		  sourceCode: self jsGrammarString;
		  asRSPangoShapeUsingFont: LogicalFont pangoMonospace
]

{ #category : 'accessing' }
TSLanguage >> at: pattern [

	^ highlights at: pattern ifAbsent: [ #(  ) ]
]

{ #category : 'accessing' }
TSLanguage >> getHandle [

	session == Smalltalk session ifFalse: [
		handle := self newLanguageHandle.
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
	sharePath := self shareDirectoryAsFileReference / 'language'
	             / self name / 'queries' / 'highlights.scm'.

	^ sharePath exists
		  ifTrue: [ sharePath contents ]
		  ifFalse: [ String empty ]
]

{ #category : 'initialization' }
TSLanguage >> initialize [

	super initialize.

	handle := self newLanguageHandle.

	highlights := self newHighlightsStylesDictionary
]

{ #category : 'query' }
TSLanguage >> jsGrammarString [

	| sharePath |
	sharePath := self shareDirectoryAsFileReference / 'language'
	             / self name / 'grammar.js'.

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

	^ self class languageName
]

{ #category : 'query' }
TSLanguage >> newHighlightsStylesDictionary [

	^ Dictionary new
]

{ #category : 'instance creation' }
TSLanguage >> newLanguageHandle [

	self subclassResponsibility
]

{ #category : 'accessing' }
TSLanguage >> orderedPatterns [

	^ highlights keys
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
		  queryString: qString withUnixLineEndings
		  queryClass: TSQuery
]

{ #category : 'accessing' }
TSLanguage >> shareDirectoryAsFileReference [

	| sharePath |
	sharePath := Smalltalk vm directory asFileReference.

	Smalltalk os isWindows ifFalse: [ sharePath := sharePath parent ].

	^ sharePath / 'share' / 'tree-sitter'
]
