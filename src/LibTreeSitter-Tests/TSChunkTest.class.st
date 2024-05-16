"
A TSChunkTest is a test class for testing the behavior of TSChunk
"
Class {
	#name : 'TSChunkTest',
	#superclass : 'TestCase',
	#category : 'LibTreeSitter-Tests',
	#package : 'LibTreeSitter-Tests'
}

{ #category : 'tests' }
TSChunkTest >> testAllocatingLanguageHandleForC [

	| called |
	called := false.
	TSLanguage c withLanguageHandleDo: [ :handle |
		self deny: handle isNull.
		called := true ].

	self assert: called
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryForC [

	self assert: TSLanguage c highlightsQueryString size > 1000
]
