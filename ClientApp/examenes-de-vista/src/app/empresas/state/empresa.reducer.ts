export function reducerEmpresa(state, action){

    switch (action.type){
        case 'SET_EMPRESA':
            console.log(action.payload);
            return {
                ...state,
                empresaId: action.payload.id,
                nombreEmpresa: action.payload.nombre
            };
        default:
            return state;
    }
}
