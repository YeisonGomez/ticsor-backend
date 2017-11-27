import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class QrService {

    constructor(private db: DatabaseService) {
    }

    public async getByCode(code) {
        return await (this.db.query(`
            select 
            m.*
            from marcador m 
			where m.code = '${code}'
            `))
    }

    public async response(temary_id, email, resultado){        
        return await (this.db.query(`CALL CALIFICATE('${email}', '${temary_id}', '${resultado}')`))
    }

}