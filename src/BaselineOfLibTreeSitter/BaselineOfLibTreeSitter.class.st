Class {
	#name : 'BaselineOfLibTreeSitter',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfLibTreeSitter',
	#package : 'BaselineOfLibTreeSitter'
}

{ #category : 'baselines' }
BaselineOfLibTreeSitter >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			baseline: 'LibLuast'
			with: [ spec repository: 'github://massimo-nocentini/liblua.st' ].

		spec
			package: 'LibTreeSitter';
			package: 'LibTreeSitter-Tests' ]
]
