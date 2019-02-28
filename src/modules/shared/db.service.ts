import { Injectable } from "@nestjs/common"
import { IConnectionConfig, IConnection, createConnection, createPool } from 'mysql';

import { CONFIG } from '../../environment'

//updateMovement(code, movimiento) Metodo para modificar el aributo movimiento del usuario 
//getAll() Consultar todos los usuarios

@Injectable()
export class DatabaseService {

  private pool: IConnection;

  constructor() {
    this.pool = createPool(CONFIG.DB);
  }

  /*private get connect(){
    return this.connection.connect((err)=> {(err)
      ? (console.error('Error connecting: ' + err.stack))
      : console.info('Database is connected as pid ' +  this.connection.threadId)
    })
  }*/

  public query(queryStr){
    return new Promise((resolve, reject) => {
      this.pool.query(queryStr, (err, results) => {
        return(err) ? reject(err) : resolve(results)
      })
    })
  }
}