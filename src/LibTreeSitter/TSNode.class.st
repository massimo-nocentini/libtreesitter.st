Class {
	#name : 'TSNode',
	#superclass : 'Object',
	#classTraits : 'TExternalAddressHolder classTrait',
	#instVars : [
		'fieldName',
		'siblingIndex',
		'typeName',
		'symbolId',
		'symbolName',
		'absolutePoint',
		'content',
		'startPoint',
		'endPoint',
		'isNull',
		'isNamed',
		'isMissing',
		'isExtra',
		'hasError',
		'children'
	],
	#category : 'LibTreeSitter-Core',
	#package : 'LibTreeSitter',
	#tag : 'Core'
}

{ #category : 'accessing' }
TSNode >> absolutePoint [

	^ absolutePoint
]

{ #category : 'converting' }
TSNode >> asPresenter [
	"<inspectorPresentationOrder: 930 title: 'MicTree'>"

	^ SpTreePresenter new
		  roots: { self };
		  children: [ :t | t children ];
		  display: [ :each |
			  String streamContents: [ :stream | each displayStringOn: stream ] ];
		  expandAll;
		  yourself
]

{ #category : 'accessing' }
TSNode >> children [

	^ children
]

{ #category : 'accessing' }
TSNode >> content [

	^ content
]

{ #category : 'accessing' }
TSNode >> endPoint [

	^ endPoint
]

{ #category : 'accessing' }
TSNode >> fieldName [

	^ fieldName
]

{ #category : 'accessing' }
TSNode >> hasError [

	^ hasError
]

{ #category : 'accessing' }
TSNode >> isExtra [

	^ isExtra
]

{ #category : 'accessing' }
TSNode >> isMissing [

	^ isMissing
]

{ #category : 'accessing' }
TSNode >> isNamed [

	^ isNamed
]

{ #category : 'accessing' }
TSNode >> isNull [

	^ isNull
]

{ #category : 'printing' }
TSNode >> printOn: aStream [

	aStream << self symbolName.

	self isNamed ifTrue: [
		aStream
			<< '(';
			<< self content;
			<< ')' ]
]

{ #category : 'accessing' }
TSNode >> siblingIndex [

	^ siblingIndex
]

{ #category : 'accessing' }
TSNode >> startPoint [

	^ startPoint
]

{ #category : 'accessing' }
TSNode >> symbolId [

	^ symbolId
]

{ #category : 'accessing' }
TSNode >> symbolName [

	^ symbolName
]

{ #category : 'accessing' }
TSNode >> typeName [

	^ typeName
]
