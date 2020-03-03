import network from '../../network'

const state = {
  username: "not set",
  email: "not set",
  meta: {},
  token: "not set",
  tokenExpires: 0,
  refreshToken: "not set",
  refreshExpires: 0
}

const getters = {
  authUserName(state) {
    return state.username;
  },
  authEmail(state) {
    return state.email;
  },
  authToken(state) {
    return state.token;
  },
  authMeta(state) {
    return state.meta;
  }
}

const mutations = {
  authUserInfo(state, data) {
    state.username = data.username;
    state.email = data.username;
    state.meta = data.meta;
    state.token = data.access_token;
    state.tokenExpires = data.access_expires_in;
    state.refreshToken = data.refresh_token;
    state.refreshExpires = data.refresh_expires_in;
  }
}

const actions = {
  authLogin(context, info) {
    network.auth.login(info.userName, info.password, (success, data) => {
      if (success) {
        data.username = info.userName;
        context.commit('authUserInfo', data);
      }
      info.handler(success, data);
    });
  }
}

export default {
  state,
  getters,
  mutations,
  actions,
}
