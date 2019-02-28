import { Injectable } from '@nestjs/common'
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { DatabaseService } from './../shared/db.service';

@Injectable()
export class QrService {

    constructor(
        private db: DatabaseService,
        @InjectModel('QR') private qrModel: Model<any>) {
    }

    public async getByCode(code) {
			let qr = {
				nombre: "test",
				descripcion: "TEST",
				tipo: "oficial",
				estado: "aceptado",
				fk_usuario: 1,
				code: code,
				images: [ "assets/ImagenesTicSor/Biblioteca/5.gif" ]
			};
			const createdCat = new this.qrModel(qr);
    	//await createdCat.save();
			return await this.qrModel.find({ code: code }).exec();
    }

}