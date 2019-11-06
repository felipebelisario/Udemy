import React from 'react'
import { createDrawerNavigator } from 'react-navigation'

import Simple from './components/Simple'
import Evenodd from './components/Evenodd'
import Inverter, { MegaSena } from './components/Mult'

export default createDrawerNavigator({
    MegaSena: {
        screen: () => <MegaSena numeros={8} />,
        navigationOptions: { title: 'Mega Sena' }
    },

    Inverter:{
        screen: () => <Inverter texto='React Native!' />
    },

    Evenodd: {
        screen: () => <Evenodd numero={30} />,
        navigationOptions: { title: 'Par & Impar' }
    },

    Simple: {
        screen: () => <Simple texto='Flexível!!!' />
    }
}, { drawerWidth: 300 })