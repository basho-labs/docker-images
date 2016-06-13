import groovy.json.*
import jenkins.model.*
import hudson.slaves.*

def     env       = System.getenv()
String  host      = env['HOST']
int     port      = env['PORT0']?.toInteger() ?: 8080

def     jenkins   = Jenkins.getInstance()
def     nodeMgr   = jenkins.getNodesObject()
def     launcher  = new JNLPLauncher()

Thread.start {
  def slavesJson = "http://leader.mesos:5050/slaves".toURL().getText()
  def nodes = []
  new JsonSlurper().parseText(slavesJson)["slaves"].each {
    def parts = it.id.split('-')
    name = "${parts[0]}-${parts[-1]}"
    def slave = new DumbSlave(name, "/tmp", launcher)
    nodeMgr.addNode(slave)
    nodes << [name, it.hostname, slave]
  }
  nodeMgr.save()

  nodes.each {
    println "connect-slave.sh $host:$port ${it[1]} ${it[0]} ${it[2].getComputer().getJnlpMac()}".execute().text
  }
}
