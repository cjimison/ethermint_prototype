import axios from 'axios'

export default {
  login(email, password, cb) {
    axios.post('/portal/commands/v1/auth/login', {
      username: email,
      password: password,
    })
      .then(function(response) {
        const data = response.data.ok;
        //console.log("I got back " + JSON.stringify(data))
        cb(true, data)
      })
      .catch((err) => {
        cb(false, err)
      })
  },
  logout(email, password, cb) {
    axios.post('/portal/commands/v1/auth/login', {
      username: email,
      password: password,
    })
      .then(function(response) {
        const data = response.data.ok;
        cb(true, data)
      })
      .catch((err) => {
        cb(false, err)
      })
  },
  check(token, cb) {
    // Need to pull the access token out of the storage
    axios.get('/portal/commands/v1/auth/check', {
      headers: { 'access-token': token }
    })
      .then(function(response) {
        cb(true, response.data.ok);
      })
      .catch((err) => {
        cb(false, err);
      })
  },

  refresh() {

  },
  register() {

  },
  reset_password() {

  },
  change_password() {

  },
  forgot_username() {

  }
}