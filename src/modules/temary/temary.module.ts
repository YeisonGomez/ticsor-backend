import { Module } from '@nestjs/common';
import { TemaryController } from './temary.controller';
import { TemaryService } from './temary.service';

import { SharedModule } from './../shared/shared.module';

@Module({
    components: [TemaryService],
    controllers: [TemaryController],
    modules: [SharedModule]
})
export class TemaryModule { }