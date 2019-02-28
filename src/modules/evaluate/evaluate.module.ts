import { Module, NestModule, MiddlewareConsumer, RequestMethod } from '@nestjs/common';

import { AuthMiddleware } from '../shared/middlewares/user.middleware';
import { EvaluateController } from './evaluate.controller';
import { EvaluateService } from './evaluate.service';

import { SharedModule } from './../shared/shared.module';

@Module({
	providers: [EvaluateService],
	controllers: [EvaluateController],
	imports: [SharedModule]
})
export class EvaluateModule {
	public configure(consumer: MiddlewareConsumer) {
		consumer.apply(AuthMiddleware).forRoutes(EvaluateController);
	}
}