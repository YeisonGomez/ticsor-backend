import { NestFactory } from '@nestjs/core';
import { ApplicationModule } from './modules/app.module';
import { CONFIG } from './environment'
import * as bodyParser from 'body-parser';
import * as cors from 'cors';
import * as express from 'express';

const instance = express();
instance.use(bodyParser.urlencoded({ extended: true }));
instance.use(cors());
const app = NestFactory.create(ApplicationModule, instance);
app.listen(CONFIG.PORT, () => console.log(`Application is listening on port ${CONFIG.PORT}`));