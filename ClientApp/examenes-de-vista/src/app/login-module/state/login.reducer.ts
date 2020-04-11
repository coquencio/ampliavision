export function reducer(state, action){

    switch (action.type){
        case 'SET_TOKEN':
            localStorage.setItem('token', action.payload);
            return {
                ...state,
                token: action.payload,
            };
        default:
            return state;
    }
}
