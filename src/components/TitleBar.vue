<template>
  <div id="title-bar">
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="54"
      height="14"
      viewBox="0 0 54 14"
    >
      <g fill="none" fill-rule="evenodd" transform="translate(1 1)">
        <circle
          @click="close"
          cx="6"
          cy="6"
          r="6"
          fill="#FF5F56"
          stroke="#E0443E"
          stroke-width=".5"
        ></circle>
        <circle
          @click="minimize"
          cx="26"
          cy="6"
          r="6"
          fill="#FFBD2E"
          stroke="#DEA123"
          stroke-width=".5"
        ></circle>
      </g>
    </svg>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

const { remote } = require("electron");
const { BrowserWindow } = remote;

export default defineComponent({
  name: "title-bar",
  methods: {
    close() {
      BrowserWindow.getFocusedWindow().close();
    },
    minimize() {
      BrowserWindow.getFocusedWindow().minimize();
    }
  }
});
</script>

<style lang="scss" scoped>
#title-bar {
  -webkit-app-region: drag;
  position: fixed;
  top: 7px;
  left: 7px;
  width: 100%;
  height: 20px;

  > svg {
    -webkit-app-region: no-drag;
  }
}

circle {
  &:hover {
    opacity: 0.8;
  }

  &:active {
    opacity: 0.6;
  }
}
</style>
