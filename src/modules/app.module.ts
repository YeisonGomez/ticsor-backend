import { Module } from '@nestjs/common';
import { BoxsModule } from './boxs/boxs.module';
import { UserModule } from './users/users.module';
import { ScoreModule } from './score/score.module';

@Module({
    modules: [BoxsModule, UserModule],
})
export class ApplicationModule {}