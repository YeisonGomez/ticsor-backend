import { Module, MiddlewareConsumer } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { QrController } from './qr.controller';
import { QrService } from './qr.service';
import { QRSchema } from './schemas/qr.schema';
import { SharedModule } from './../shared/shared.module';

@Module({
	imports: [MongooseModule.forFeature([{ name: 'QR', schema: QRSchema }]), SharedModule],
	providers: [QrService],
	controllers: [QrController]
})
export class QrModule {
	public configure(consumer: MiddlewareConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(QrController);
	}
}