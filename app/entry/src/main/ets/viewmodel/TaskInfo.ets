import { oneWeekDictFunc } from '../common/utils/Utils';
export default class TaskInfo {
    id: number;
    date: string;
    taskID: number;
    targetValue: string;
    isAlarm: boolean;
    startTime: string;
    endTime: string;
    frequency: string;
    isDone: boolean;
    finValue: string;
    isOpen: boolean;

    constructor(id: number, date: string, taskID: number, targetValue: string, isAlarm: boolean, startTime: string,
                endTime: string, frequency: string, isDone: boolean, finValue: string, isOpen = false) {
        this.id = id;
        this.date = date;
        this.taskID = taskID;
        this.targetValue = targetValue;
        this.isAlarm = isAlarm;
        this.startTime = startTime;
        this.endTime = endTime;
        this.frequency = frequency;
        this.isDone = isDone;
        this.finValue = finValue;
        this.isOpen = isOpen;
    }
}

export enum taskType {
    'getup' = 1,
    'drinkWater',
    'eatApple',
    'smile',
    'brushTeeth',
    'sleepEarly'
}

export const oneWeek = oneWeekDictFunc();
