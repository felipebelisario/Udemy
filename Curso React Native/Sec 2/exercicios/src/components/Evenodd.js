import React from 'react'
import {View, Text} from 'react-native'
import Pattern from '../style/Pattern'

function parOuImpar(num) {
    // if(num % 2 == 0){
    //     return <Text style={Pattern.ex}>Par</Text>
    // } else{
    //     return <Text style={Pattern.ex}>Impar</Text>
    // }

    const v = num % 2 == 0 ? 'Par' : 'Impar'
    return <Text style={Pattern.ex}>{v}</Text>
}

export default props => 
    <View>

        {parOuImpar(props.numero)}

        {/* {
            props.numero % 2 == 0
            ? <Text style={Pattern.ex}>Par</Text>
            : <Text style={Pattern.ex}>Impar</Text>
        } */}
    </View>