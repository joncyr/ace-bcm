# Main Daemon Settings
default['kafka']['version']      = '0.8.2.1-1'
default['kafka']['user']         = 'kafka'
default['kafka']['group']        = 'kafka'
default['kafka']['logs_dir']     = '/var/log/kafka'

# JVM Settings
default['kafka']['jvm']['heap_min']          = '1G'
default['kafka']['jvm']['heap_max']          = '1G'
default['kafka']['jvm']['performance_opts']  = "-server -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+CMSScavengeBeforeRemark -XX:+DisableExplicitGC -Djava.awt.headless=true"
default['kafka']['jvm']['server_log4j_opts'] = "-Dlog4j.configuration=file:/etc/kafka/log4j.properties"
default['kafka']['jvm']['client_log4j_opts'] = "-Dlog4j.configuration=file:/etc/kafka/tools-log4j.properties"

# Broker Settings
default['kafka']['broker.id'] = 0 # Must be set for each broker and must be unique

# Topic Settings
default['kafka']['delete.topic.enable'] = false

# Network Settings
default['kafka']['port']                        = 9092
default['kafka']['num.network.threads']         = 3
default['kafka']['num.io.threads']              = 8
default['kafka']['socket.send.buffer.bytes']    = 102400
default['kafka']['socket.receive.buffer.bytes'] = 102400
default['kafka']['socket.request.max.bytes']    = 104857600

# Log File (meaning the Kafka Journal, not syslog stuff) and Partition Settings
default['kafka']['log.dirs']                          = [ '/var/lib/kafka' ]
default['kafka']['num.partitions']                    = 1
default['kafka']['num.recovery.threads.per.data.dir'] = 1

# Log Flush Policy
default['kafka']['log.flush.interval.messages']       = nil
default['kafka']['log.flush.interval.ms']             = nil

# Log Retention and Size Policy
default['kafka']['log.retention.hours']             = 168 # 7 days
default['kafka']['log.retention.bytes']             = nil
default['kafka']['log.segment.bytes']               = 1073741824
default['kafka']['log.retention.check.interval.ms'] = 300000
default['kafka']['log.cleaner.enable']              = false

# Zookeeper Settings
default['kafka']['zookeeper.connect']               = [ 'localhost:2181' ]
default['kafka']['zookeeper.connection.timeout.ms'] = 6000
default['kafka']['zookeeper.prefix']                = 'kafka' # prefix in zookeeper tree
