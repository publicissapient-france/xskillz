import createEngine from 'redux-storage-engine-localstorage';
import { createLoader } from 'redux-storage';

const localStorageKey = 'ea-homecare-devvvvvvv';

export const engine = createEngine(localStorageKey);
export const load = createLoader(engine);
