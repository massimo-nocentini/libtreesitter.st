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
		spec baseline: 'VMPluginsPrimitives' with: [
			spec repository:
				'github://massimo-nocentini/vm-plugins-primitives.st' ].

		spec
			package: 'LibTreeSitter';
			package: 'LibTreeSitter-Tests' ]
]
