import React from 'react'
import { View, Text, TouchableHighlight } from 'react-native'

export default class Counter extends React.Component {

    state = {
        numero: 0
    }

    moreOne = () => {
        this.setState({ numero: this.state.numero + 1 })
    }

    clear = () => {
        this.setState({ numero: 0 })
    }

    render() {
        return (
            <View>
                <Text style={{fontSize: 40, marginTop:400, marginLeft:200}}>{this.state.numero}</Text>
                <TouchableHighlight 
                    onPress={this.moreOne} 
                    onLongPress={this.clear}>
                    <Text style={{textAlign:'center'}}>Incrementar/Zerar</Text>
                </TouchableHighlight>
            </View>
        )
    }
}


