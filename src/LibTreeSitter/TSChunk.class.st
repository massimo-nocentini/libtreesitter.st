Class {
	#name : 'TSChunk',
	#superclass : 'Object',
	#instVars : [
		'language',
		'sourceCode'
	],
	#category : 'LibTreeSitter',
	#package : 'LibTreeSitter'
}

{ #category : 'evaluating' }
TSChunk >> asRSPangoShapeUsingFont: aFont [

	| tsLanguage chunks code selector shape |
	selector := language asSymbol.

	chunks := OrderedCollection new.

	code := sourceCode replaceAllTabsWithThreeSpaces
		        fixEmptyLinesForPango.

	shape := RSPangoText new
		         font: aFont;
		         text: code;
		         yourself.

	(TSLanguage respondsTo: selector) ifTrue: [
		tsLanguage := TSLanguage perform: selector.

		self withMatchesOn: code do: [ :matches :codeLines |
			tsLanguage matches: matches.

			tsLanguage
				populate: chunks
				offset: 1
				text: code
				counter: 1 ].

		shape attributesChunks: (chunks collect: #last) ].

	^ shape asCompositeShape
]

{ #category : 'visiting' }
TSChunk >> escapeTextInGMarkup: code [

	^ self withNewLuaStateDo: [ :L :ll |
		  | retcode |
		  retcode := ll
			             luaL_requiref: L name: 'cairo';
			             on: L push: #cairo;
			             lua: L
			             get: -1
			             field: 'g_markup_escape_text'
			             remove: true;
			             on: L push: code;
			             lua_pcall: L nargs: 1 nresults: 1.

		  self
			  assert: retcode == ll LUA_OK
			  description: 'failed to escape text.'.

		  ll on: L at: -1 ]
]

{ #category : 'accessing' }
TSChunk >> language: anObject [

	language := anObject
]

{ #category : 'accessing' }
TSChunk >> sourceCode: anObject [

	sourceCode := anObject
]

{ #category : 'visiting' }
TSChunk >> withMatchesOn: code do: recv [

	^ self withNewLuaStateDo: [ :L :ll |
		  | retcode matches srcLines |
		  retcode := ll
			             luaL_requiref: L name: 'tree-sitter';
			             on: L push: #'tree-sitter';
			             lua: L
			             get: -1
			             field: 'highlights_matches'
			             remove: true;
			             on: L push: language;
			             on: L push: code;
			             lua_pcall: L nargs: 2 nresults: 2.

		  self
			  assert: retcode == ll LUA_OK
			  description: 'failed to compute highlights.'.

		  matches := ll on: L at: -2.
		  srcLines := ll on: L at: -1.

		  matches ifNotNil: [ recv value: matches value: srcLines ] ]
]

{ #category : 'visiting' }
TSChunk >> withNewLuaStateDo: aCodeBlock [

	| ll |
	ll := LibLua uniqueInstance implementationPrimitive.

	^ ll withOpenedLibsStateDo: [ :L | aCodeBlock value: L value: ll ]
]
