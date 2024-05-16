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

	self deny: TSLanguage c getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testHighlightsQueryForC [

	self assert: TSLanguage c highlightsQueryString size > 1000
]

{ #category : 'tests' }
TSChunkTest >> testInstantiatingParser [

	self deny: TSParser new getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testParsingCSimpleChunk [

	| tree |
	tree := TSParser new
		        language: TSLanguage c;
		        treeOfString:
			        'int main (int argc, char **argv) { printf("Hello world!"); }'.

	self deny: tree getHandle isNull
]

{ #category : 'tests' }
TSChunkTest >> testSettingLanguageCToParser [

	self assert: (TSParser new
			 language: TSLanguage c;
			 hasLanguageAssigned)
]
