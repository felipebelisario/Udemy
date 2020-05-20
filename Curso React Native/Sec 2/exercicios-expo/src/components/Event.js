import React from 'react'
import { View, Text, TextInput } from 'react-native'
import Pattern from '../style/Pattern'

export default class Event extends React.Component {
    state = {
        texto: ''
    }

    alterarTexto = texto => {
        this.setState({ texto })
    }

    render() {
        return (
            <View>
                <Text style={Pattern.fonte40}>{this.state.texto}</Text>
                <TextInput value={this.state.texto} style={Pattern.input} 
                    onChangeText={this.alterarTexto} />
            </View>
        )
    }
}