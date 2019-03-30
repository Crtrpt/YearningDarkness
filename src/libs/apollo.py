import configparser


class Apollo(object):

    def __init__(self, conf_file="deploy.conf"):
        _conf = configparser.ConfigParser()
        _conf.read(conf_file)
        self.app_id = _conf.get("apollo")

    def app_list(self):
        pass

    def env_list(self):
        pass

    def cluster_list(self):
        pass

    def namespace_list(self):
        pass
