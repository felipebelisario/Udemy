import React from 'react'
import PropTypes from 'prop-types'
import { Text } from 'react-native'

const ValidateProps = props =>
    <Text style={{ fontSize: 35 }}>
        {props.label}
        {props.ano + 2000}
    </Text>

ValidateProps.defaultProps = { // Para valores falsos, nulos ou undefined
    label: 'Ano'
}

ValidateProps.propTypes = {     // Obrigatorio e deve ser um numero
    ano: PropTypes.number.isRequired
}

export default ValidateProps