export default props => {
    if(props.test) {
        return props.children   // Retorna o que esta dentro da tag
    } else{
        return false
    }
}