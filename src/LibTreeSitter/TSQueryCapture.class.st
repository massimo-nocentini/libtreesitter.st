Class {
	#name : 'TSQueryCapture',
	#superclass : 'Object',
	#instVars : [
		'name',
		'startPoint',
		'endPoint',
		'absolutePoint',
		'discoverIndex',
		'content'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
}

{ #category : 'accessing' }
TSQueryCapture >> content [

	^ content
]

{ #category : 'accessing' }
TSQueryCapture >> discoverIndex [

	^ discoverIndex
]

{ #category : 'accessing' }
TSQueryCapture >> endPoint [

	^ endPoint
]

{ #category : 'accessing' }
TSQueryCapture >> interval [

	^ absolutePoint x to: absolutePoint y
]

{ #category : 'accessing' }
TSQueryCapture >> name [

	^ name
]

{ #category : 'accessing' }
TSQueryCapture >> startPoint [

	^ startPoint
]
