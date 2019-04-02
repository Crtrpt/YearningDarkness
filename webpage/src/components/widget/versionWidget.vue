<template>
  <div>
    <Select :value="value" placeholder="环境" @on-change="onChange">
      <Option v-for="i in env_list" :value="i.id" :key="i.id">{{ i.service_name }}</Option>
    </Select>
  </div>
</template>

<script>
export default {
  name: 'service_widget',
  components: [],
  props: ['value'],
  data: () => {
    return {
      env_list: [
        { id: 1, service_name: 'order_service' },
        { id: 2, service_name: 'product_service' },
        { id: 3, service_name: 'shopdevice_service' },
        { id: 4, service_name: 'app_service' },
        { id: 5, service_name: 'statement-service' },
        { id: 6, service_name: 'organization-service' },
        { id: 7, service_name: 'gateway' },
        { id: 8, service_name: 'ops-service' },
        { id: 9, service_name: 'push-service' },
        { id: 10, service_name: 'material-service' }
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
