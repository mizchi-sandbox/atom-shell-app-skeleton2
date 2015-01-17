///<reference path='../../types.d.ts' />

import Aggregator = require('./aggregator');
import subscriber = require('./subscriber');
import defs = require('./defs');

class Main extends Overworld.Context<defs.Props, defs.State> {
  static component = require('../../components/main');
  static aggregator = new Aggregator;
  static subscriber = subscriber;
}

export = Main;
