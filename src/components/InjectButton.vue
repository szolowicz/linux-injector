<template>
  <button @click="inject" id="inject" :disabled="!process || !path">
    Inject
  </button>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

const emitter = require('tiny-emitter/instance');
const { spawn } = require('child_process');

const { remote } = require('electron');
const { BrowserWindow } = remote;

const debugWindow = BrowserWindow.getAllWindows()[0];

export default defineComponent({
  name: 'inject-button',
  data() {
    return {
      process: '' as string,
      path: '' as string
    };
  },
  mounted() {
    emitter.on('process', (process: string) => (this.process = process));
    emitter.on('path', (path: string) => (this.path = path));
  },
  methods: {
    inject() {
      try {
        const injectStatus = spawn(
          './public/inject.sh',
          [`${this.process}`, `${this.path}`],
          {
            bash: true
          }
        );

        injectStatus.on('exit', () => {
          if (debugWindow) {
            debugWindow.webContents.send('debug data', {
              type: 'success',
              message: `Injected ${this.path} to ${this.process} successfully!`
            });
          }
        });
      } catch (error) {
        if (debugWindow) {
          debugWindow.webContents.send('debug data', {
            type: 'error',
            message: `Can't inject ${this.path} to ${this.process}! ${error}`
          });
        }
      }
    }
  }
});
</script>

<style lang="scss" scoped>
#inject {
  border: none;
  padding: 0 30px;
  will-change: opacity, color;
  white-space: nowrap;
  text-overflow: ellipsis;
  display: block;
  font-weight: 500;
  text-transform: uppercase;
  background: #f62f6d;
  width: 100%;
  max-width: 450px;
  color: #fff;
  border-radius: 0;
  margin-top: 30px;
  font-size: 1.4rem;
  line-height: 3rem;
  transition: all 0.2s ease-in-out;
  text-shadow: 0 0 32px black;

  &:not([disabled]) {
    cursor: pointer;
  }

  &:disabled {
    background: #8f95a0;
  }

  &:hover:not([disabled]) {
    transform: scale(1.05);
  }
}
</style>
