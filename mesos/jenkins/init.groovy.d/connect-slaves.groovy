import hudson.model.*
import jenkins.model.*

Thread.start {
  sleep 10000

  def env = System.getenv()
  String host = env['HOST']
  int port = env['PORT0'].toInteger()

  for (slv in Hudson.instance.slaves){
    "connect-slave.sh $host:$port ${slv.name} ${slv.getComputer().getJnlpMac()}".execute()
  }
}
