import React from 'react'
import { Button, Alert, ToastAndroid, Platform } from 'react-native'

export default props => {
    const notificar = msg => {
        if(Platform.OS === 'android'){                  // Se estiver em Android
            ToastAndroid.show(msg, ToastAndroid.LONG)
        } else{                                         // Se estiver em Iphone
            Alert.alert('Informação', msg)      
        }
    }

    return (
        <Button title='Plataforma?' onPress = {() => notificar('Parabéns!')} />
    )

}