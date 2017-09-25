import { Module, Shared } from '@nestjs/common';
import { ScoreController } from './score.controller';
import { ScoreService } from './score.service';
import { Score } from '../../providers/score.provider';
import { SharedModule } from './../shared/shared.module';

@Module({
    components: [ScoreService, Score],
    controllers: [ScoreController],
    modules: [SharedModule]
})
export class ScoreModule { }