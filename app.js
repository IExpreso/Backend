const express = require('express');
const path = require('path');
const favicon = require('serve-favicon');
const logger = require('morgan');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');

const index = require('./routes/index');
const users = require('./routes/users');
const signup = require('./routes/signup');
const login = require('./routes/login');

const app = express();
const env = process.env.NODE_ENV || 'development';
const secret  = require(__dirname + '/config/config.json')[env]['secret'];

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', index);
app.use('/login', login);
app.use('/signup', signup);
app.use('/users', users);

app.use('/app/*', (req, res, next) => {
  let token = req.body.token || req.query.token || req.headers['x-access-token'];
  if (token)
    jwt.verify(token, secret, (err, decoded) => {
      if (err) {
        return res.status(401).send({
          success: false,
          message: 'Failed to authenticate'
        });
      } else {
        req.decoded = decoded;
        next();
      }
    });
  else
    return res.status(403).send({
      success: false,
      message: 'No token provided'
    });
});

// catch 404 and forward to error handler
app.use((req, res, next) => {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use((err, req, res, next) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
