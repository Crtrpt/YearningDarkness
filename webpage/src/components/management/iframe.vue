<style lang="less">
  @import '../../styles/common.less';
  @import '../order/components/table.less';
</style>
<template>
  <div >
    <iframe style="width:100%;height:800px" frameborder=0 :src="this.url" />
  </div>
</template>
<script>
  import '../../assets/tablesmargintop.css'

  import ICol from '../../../node_modules/iview/src/components/grid/col'

  export default {
    components: {
      ICol
    },
    name: 'iframe',
    data () {
      return {
        url: ''
      }
    },

    methods: {
    },

    beforeRouteEnter (to, from, next) {
      console.log(to)
        next(vm => {
            if (to.path !== undefined) {
              var path = to.path.split('/')[2]
              vm.url = `http://ops-web.devcloud.chupinxiu.com/${path}`
              console.log(vm.url)
            }
        })
    },

    mounted () {
    }
  }
</script>
