<template>
  <div>
    <Select :value="value" placeholder="环境" @on-change="onChange">
      <Option v-for="i in env_list" :value="i.id" :key="i.id">{{ i.env_name }}</Option>
    </Select>
  </div>
</template>

<script>
export default {
  name: 'env_widget',
  components: [],
  props: ['value'],
  data: () => {
    return {
      env_list: [
        { id: 1, env_name: 'dev' },
        { id: 2, env_name: 'test' },
        { id: 3, env_name: 'stg' },
        { id: 4, env_name: 'prod' }
      ]
    }
  },
  methods: {
    onChange (v) {
      this.$emit('input', v)
    }
  }
}
</script>

<style lang="less">
</style> 
