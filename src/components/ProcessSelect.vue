<template>
  <div class="processes-wrapper">
    <select class="process-list" v-model="selected">
      <option v-for="(process, index) in processes" :key="index">
        {{ process.name }}
      </option>
    </select>

    <button class="refresh_btn" @click="refreshProcessList">Refresh</button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

const emitter = require('tiny-emitter/instance');
const psList = require('ps-list');

const { remote } = require('electron');
const { BrowserWindow } = remote;

const debugWindow = BrowserWindow.getAllWindows()[0];

export default defineComponent({
  name: 'process-select',
  methods: {
    refreshProcessList() {
      this.selected = '';

      try {
        psList().then((ps: string[]) => (this.processes = ps));

        if (debugWindow) {
          debugWindow.webContents.send('debug data', {
            type: 'success',
            message: 'Got all processes list',
          });
        }
      } catch (error) {
        if (debugWindow) {
          debugWindow.webContents.send('debug data', {
            type: 'error',
            message: `Can't get processes list! ${error}`,
          });
        }
      }
    },
  },
  data() {
    return {
      selected: '' as string,
      processes: [] as string[],
    };
  },
  mounted() {
    this.refreshProcessList();
  },
  watch: {
    selected: {
      handler: (value: string) => {
        try {
          emitter.emit('process', value);

          if (debugWindow && value) {
            debugWindow.webContents.send('debug data', {
              type: 'success',
              message: `Got ${value} process ID`,
            });
          }
        } catch (error) {
          if (debugWindow) {
            debugWindow.webContents.send('debug data', {
              type: 'error',
              message: `Can't get process ID! ${error}`,
            });
          }
        }
      },
      deep: true,
    },
  },
});
</script>

<style lang="scss" scoped>
.processes-wrapper {
  width: 100%;
  max-width: 450px;
  white-space: nowrap;
  margin-top: 22%;
}

.process-list {
  display: block;
  font-weight: 500;
  background-color: #3b3c4a;
  color: white;
  width: 82%;
  border-radius: 0;
  font-size: 1rem;
  height: 2rem;
  line-height: 2rem;
  transition: all 0.2s ease-in-out;
  text-shadow: 0 0 1px black;
  float: left;
}

.refresh_btn {
  cursor: pointer;
  padding: 9px;
  background: #f62f6d;
  color: white;
  border: none;
  border-radius: 5px;
  margin-left: 10px;
}
</style>
