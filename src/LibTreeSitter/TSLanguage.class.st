Class {
	#name : 'TSLanguage',
	#superclass : 'Object',
	#traits : 'TExternalAddressHolder',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'highlights',
		'matches',
		'session',
		'handle'
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

{ #category : 'accessing' }
TSLanguage >> matches: anObject [

	matches := anObject
]

{ #category : 'instance creation' }
TSLanguage >> newLanguageHandle [

	self subclassResponsibility
]

{ #category : 'accessing' }
TSLanguage >> orderedPatterns [

	^ matches keys
]

{ #category : 'accessing' }
TSLanguage >> populate: chunks offset: i text: clean_text counter: counter [

	| sorted |
	sorted := SortedCollection sortUsing: [ :a :b |
		          a first = b first
			          ifTrue: [ a fourth > b fourth ]
			          ifFalse: [ a first < b first ] ].

	self orderedPatterns withIndexDo: [ :pattern :priority |
		matches at: pattern ifPresent: [ :captures |
			| specs |
			specs := self at: pattern.
			captures do: [ :capture |
				| abs from to |
				abs := capture at: 'absolute'.

				from := (abs at: 'from') + i - 2.
				to := (abs at: 'to') + i - 1.

				"capture at: 'content' put: (clean_text copyFrom: from to: to)."

				specs do: [ :spec |
					sorted add: {
							from.
							to.
							spec.
							priority } ] ] ] ].

	sorted withIndexDo: [ :tuple :j |
		chunks add: {
				counter.
				j.
				tuple first. "from"
				('{1} {2} {3}' format: tuple) } ]
]
