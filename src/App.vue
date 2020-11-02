<template>
  <router-view />
</template>

<style lang="scss">
* {
  user-select: none;
  box-sizing: border-box;

  &:focus {
    outline: none !important;
  }
}

button {
  -webkit-app-region: no-drag;
}

a {
  text-decoration: none;
}
</style>
