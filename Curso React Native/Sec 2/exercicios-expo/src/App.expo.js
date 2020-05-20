import React from 'react'
import { View, Text, StyleSheet } from 'react-native'

import Simple from './components/Simple'
import Evenodd from './components/Evenodd'
import Inverter, { MegaSena } from './components/Mult'


export default class App extends React.Component {	// Componente baseado em classe
	render() {
		return (
			<View style={styles.container}>
				<Simple texto="Flexível!"/>
				<Evenodd numero={17}/>
				<Inverter texto='Eae tiozão!' />
				<MegaSena numeros={6} />
			</View>
		)
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		justifyContent: 'center',
		alignItems: 'center',
	}
})