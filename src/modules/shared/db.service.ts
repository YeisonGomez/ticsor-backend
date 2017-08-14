import { Component } from "@nestjs/common"
import { IConnectionConfig, IConnection, createConnection } from 'mysql';

import { CONFIG } from '../../environment'

@Component()
export class DatabaseService {

  private connection: IConnection;

  constructor() {
    this.connect
  }

  private get connect(){
    this.connection = createConnection(CONFIG.DB as IConnectionConfig);
    return this.connection.connect((err)=> {(err)
      ? (console.error('Error connecting: ' + err.stack))
      : console.info('Database is connected as pid ' +  this.connection.threadId)
    })
  }

  public query(queryStr): PromiseLike<any> | {results: Array<any>, fields: Array<Object>} {
    return new Promise((resolve, reject) => {
      this.connection.query(queryStr, (err, results) => {
        return(err) ? reject(err) : resolve(results)
      })
    })
  }
}