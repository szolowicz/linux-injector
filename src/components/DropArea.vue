<template>
  <div @click="selectDLL" class="drop">
    <div class="drop-text">{{ dropText }}</div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

const emitter = require('tiny-emitter/instance');
const { remote } = require('electron');
const { BrowserWindow, dialog } = remote;

const debugWindow = BrowserWindow.getAllWindows()[0];

export default defineComponent({
  name: 'drop-area',
  data() {
    return {
      dropText: 'Select or drop .so file here',
    };
  },
  methods: {
    selectDLL() {
      dialog
        .showOpenDialog(remote.getCurrentWindow(), {
          title: 'Select .so file',
          filters: [
            {
              name: '*.so',
              extensions: ['so'],
            },
          ],
        })
        .then((path: { canceled: boolean; filePaths: string[] }) => {
          if (path.canceled) {
            if (debugWindow) {
              debugWindow.webContents.send('debug data', {
                type: 'warn',
                message: 'User canceled select shared object file path',
              });
            }

            return;
          }

          this.dropText = path.filePaths[0];
          emitter.emit('path', path.filePaths[0]);

          if (debugWindow) {
            debugWindow.webContents.send('debug data', {
              type: 'success',
              message: `Got shared object file path - ${path.filePaths[0]}`,
            });
          }
        })
        .catch((error: Error) => {
          if (debugWindow) {
            debugWindow.webContents.send('debug data', {
              type: 'error',
              message: `Can't get shared object path! ${error}`,
            });
          }
        });
    },
  },
  mounted() {
    document.addEventListener('dragover', (event) => event.preventDefault());

    document.addEventListener('drop', (event) => {
      event.preventDefault();

      this.dropText = event.dataTransfer!.files[0].path;
      emitter.emit('path', event.dataTransfer!.files[0].path);
    });
  },
});
</script>

<style lang="scss" scoped>
.drop {
  cursor: pointer;
  margin-top: 10px;
  color: #fff;
  background: #3b3c4a;
  border: 2px dashed #f62f6d;
  border-radius: 5px;
  width: 100%;
  max-width: 376px;
  padding: 34px 34px;
  transition: 0.5s all;

  &-text {
    text-align: center;
    font-weight: 400;
    background: #3b3c4a;
    color: #f62f6d;
    opacity: 0.8;
  }
}
</style>
