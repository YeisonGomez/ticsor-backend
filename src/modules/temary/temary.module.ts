import { Module, NestModule, MiddlewareConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { TemaryController } from './temary.controller';
import { TemaryService } from './temary.service';

import { SharedModule } from './../shared/shared.module';

@Module({
	providers: [TemaryService],
	controllers: [TemaryController],
	imports: [SharedModule]
})
export class TemaryModule {
	public configure(consumer: MiddlewareConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(TemaryController);
	}
}