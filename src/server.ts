import { NestFactory } from '@nestjs/core';
import { ApplicationModule } from './modules/app.module';
import { CONFIG } from './environment'
import * as bodyParser from 'body-parser';
import * as cors from 'cors';
import * as express from 'express';

async function bootstrap() {

  	const app = await NestFactory.create(ApplicationModule);
  	app.use(bodyParser.urlencoded({ extended: true }));
	app.use(cors());
  	await app.listen(CONFIG.PORT, () => console.log(`Application is listening on port ${CONFIG.PORT}`));
}
bootstrap();