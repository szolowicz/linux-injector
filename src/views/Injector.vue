<template>
  <div id="app">
    <TitleBar />

    <LogoHeader />

    <ProcessSelect />

    <DropArea />

    <InjectButton />

    <FooterInfo />

    <DebugMode />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";

import TitleBar from "@/components/TitleBar.vue";
import DropArea from "@/components/DropArea.vue";
import ProcessSelect from "@/components/ProcessSelect.vue";
import InjectButton from "@/components/InjectButton.vue";
import FooterInfo from "@/components/FooterInfo.vue";
import LogoHeader from "@/components/LogoHeader.vue";
import DebugMode from "@/components/DebugMode.vue";

export default defineComponent({
  name: "inject-button",
  components: {
    TitleBar,
    DropArea,
    ProcessSelect,
    InjectButton,
    FooterInfo,
    LogoHeader,
    DebugMode
  }
});
</script>

<style lang="scss" scoped>
$gray: #8f95a0;
$background: #0b0c1b;

#app {
  display: flex;
  overflow: hidden;
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  border: 1px solid $gray;
  background: $background;
  color: $gray;
  font-family: Circular, Roboto, Helvetica, Arial, sans-serif;
  font-weight: 400;
  -webkit-font-smoothing: antialiased;
}

#app {
  justify-content: center;
  align-items: center;
  flex-direction: column;
  flex: 1;
}
</style>
