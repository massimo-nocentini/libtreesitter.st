Class {
	#name : 'TSQueryCapture',
	#superclass : 'Object',
	#instVars : [
		'name',
		'startPoint',
		'endPoint'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'accessing' }
TSQueryCapture >> endPoint [

	^ endPoint
]

{ #category : 'accessing' }
TSQueryCapture >> interval: cumulatedSizes [

	^ (cumulatedSizes at: self startPoint y) + self startPoint x to:
	  (cumulatedSizes at: self endPoint y) + self endPoint x
]

{ #category : 'accessing' }
TSQueryCapture >> name [

	^ name
]

{ #category : 'accessing' }
TSQueryCapture >> startPoint [

	^ startPoint
]
