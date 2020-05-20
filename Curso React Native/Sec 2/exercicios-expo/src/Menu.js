import React from 'react'
import { createDrawerNavigator } from 'react-navigation'

import Simple from './components/Simple'
import Evenodd from './components/Evenodd'
import Inverter, { MegaSena } from './components/Mult'
import Counter from './components/Counter'
import Plataforms from './components/Plataforms'
import ValidateProps from './components/ValidateProps'
import Event from './components/Event'
import Avo from './components/DirectCommunication'

export default createDrawerNavigator({
    Avo: {
        screen: () => <Avo nome='João' sobrenome='Silva' />
    },
    
    Event: {
        screen: Event
    },

    ValidateProps: {
        screen: () => <ValidateProps label="Teste: " ano={18} />
    },

    Plataforms: {
        screen : Plataforms
    },

    Counter: {
        screen: () => <Counter/>,
        navigationOptions: { title: 'Counter' }
    },

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