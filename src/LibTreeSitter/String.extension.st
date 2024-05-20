Extension { #name : 'String' }

{ #category : '*LibTreeSitter' }
String >> cumulatedLineSizes [

	| pad |
	pad := Smalltalk platform lineEnding size.
	
	^ self lines
		  scan: [ :cumulatedSize :line | cumulatedSize + pad + line size ]
		  init: 0
]
