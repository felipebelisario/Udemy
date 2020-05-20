import React from 'react'
import {Text} from 'react-native'
import Pattern from '../style/Pattern'

const Inverter = props => {
    const inv = props.texto.split('').reverse().join('')
    return <Text style={Pattern.ex}>{inv}</Text>
}

const MegaSena = props => {          // -> precisa de chaves
    const [min, max] = [1, 60]
    const numeros = Array(props.numeros || 6).fill(0)

    for(let i=0; i < numeros.length; i++){
        let novo = 0
        while (numeros.includes(novo)) {    // Deve ser um numero ainda nao presente no array
            novo = Math.floor(Math.random() * (max - min + 1)) + min    // Valor random entre max e min            
        }
        numeros[i] = novo
    }

    numeros.sort((a,b) => a - b)
    return <Text style={Pattern.ex}>{numeros.join(', ')}</Text>
}

export default Inverter // -> nao precisa de chaves
export { Inverter, MegaSena }