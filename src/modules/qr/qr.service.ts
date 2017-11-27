import { Component } from '@nestjs/common'
import { DatabaseService } from './../shared/db.service';

@Component()
export class QrService {

    constructor(private db: DatabaseService) {
    }

    public async getByCode(code) {
        return await (this.db.query(`
            select 
            m.*, 
            concat('[', concat(group_concat(distinct concat('"', concat(mul.url, '"'))), ']')) as images 
            from marcador m 
            left join marcador_multimedia mm on mm.fk_marcador = m.id 
            left join multimedia mul on mul.id = mm.fk_multimedia 
            where m.code = '${code}'
            group by m.id 
            `))

}