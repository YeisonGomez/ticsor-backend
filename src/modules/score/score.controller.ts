import { Controller, Get, Res, Post, Put, Delete, Param, Body, HttpStatus } from '@nestjs/common';
import { Response } from 'express';
import { ScoreService } from './score.service';
import { Score } from '../../providers/score.provider';
import { CONFIG } from '../../environment'

@Controller('score')
export class ScoreController {

    constructor(private scoreService: ScoreService, private score: Score) { }
}