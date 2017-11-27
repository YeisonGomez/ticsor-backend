import { Module, NestModule, MiddlewaresConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { QrController } from './qr.controller';
import { QrService } from './qr.service';

import { SharedModule } from './../shared/shared.module';

@Module({
	components: [QrService],
	controllers: [QrController],
	modules: [SharedModule]
})
export class QrModule {
	public configure(consumer: MiddlewaresConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(QrController);
	}
}