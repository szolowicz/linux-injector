<template>
  <div id="debug-window">
    <TitleBar />

    <div id="logo-wrap">
      <p>Debug mode</p>
    </div>

    <div id="console">
      <div :class="log.type" v-for="(log, index) in logs" :key="index">
        {{ log.message }}
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

import TitleBar from '@/components/TitleBar.vue';

const { ipcRenderer } = require('electron');

export default defineComponent({
  name: 'debug-console',
  components: {
    TitleBar
  },
  data() {
    return {
      logs: [] as string[]
    };
  },
  mounted() {
    ipcRenderer.on('debug data', (type: string, message: string) => {
      this.logs.push(message);
    });
  },
  beforeCreate() {
    document.title = 'linux-injector - Debug mode';
    document.body.className = 'debug';
  }
});
</script>

<style lang="scss">
$gray: #8f95a0;

body.debug {
  font: 11pt/1.25 Monaco, monospace;
  background: #0b0c1b;
  color: #fff;
  margin: 0;
  padding: 30px 10px;
  border: 1px solid $gray;

  #logo-wrap p {
    display: block;
    margin: 0 auto;
    text-align: center;
    position: relative;
    top: 10px;
  }
}
</style>

<style lang="scss" scoped>
.debug {
  color: Snow;
}

.success {
  color: LawnGreen;
}

.warn {
  color: GoldenRod;
}

.error {
  color: LightCoral;
}

#console {
  opacity: 0.9;
  background: rgba(0, 0, 0, 0.75);
  width: 95%;
  height: 260px;
  overflow: auto;
  margin: 30px auto;
  padding-left: 20px;
  padding-top: 20px;

  &::-webkit-scrollbar {
    width: 6px;
    height: 3px;

    &-button {
      background-color: transparent;
    }

    &-track {
      background-color: transparent;

      &-piece {
        background-color: transparent;
      }
    }

    &-thumb {
      height: 50px;
      background-color: #333;
      border-radius: 3px;
    }

    &-corner {
      background-color: transparent;
    }
  }

  &::-webkit-resizer {
    background-color: transparent;
  }
}
</style>
