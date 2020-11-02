<template>
  <div class="footer-info">
    &copy; {{ new Date().getFullYear() }}
    <a href="//github.com/Lumm1t">Lumm1t</a>
  </div>
</template>

<script lang="ts">
const { shell } = require('electron');

export default {
  name: 'footer-info',
  mounted() {
    document.addEventListener('click', (event: Event) => {
      const target = event.target as any;
      if (target.tagName === 'A' && target.href.startsWith('http')) {
        event.preventDefault();
        shell.openExternal(target.href);
      }
    });
  }
};
</script>

<style lang="scss" scoped>
.footer-info {
  max-width: 350px;
  margin-top: 20px;
  font-size: 1rem;

  a {
    color: #f62f6d;
  }
}
</style>
