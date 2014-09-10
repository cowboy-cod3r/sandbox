/*
 * File:    jarhub-update.thrift
 * Author:  Chris Eberle <chris.eberle@issinc.com>
 * Created: Fri Jul 9 13:26:10 2012
 *
 * Thrift interface file for jarhub-update
 */

namespace java com.issinc.ges.jarhubupdate.thrift

/* A description of the latest version */
struct VersionDescriptor {
  1: string version,
  2: i64 timestamp,
  3: string url,
  4: string filename,
}

/* Allows easier compatibility checks */
const i32 PROTOCOL_VERSION = 1

/* The main show */
service JarHubUpdateService {
  /* Ping the server */
  void ping(),

  /* Get the protocol version from the server */
  i32 getServerProtocolVersion(),

  /* Get the actual version number of the server (just for debugging purposes) */
  string getServerApplicationVersion(),

  /* Get the uptime of the server in seconds */
  i32 getServerUptime(),

  /* Register a client, just for logging purposes */
  void registerClient(1: string hostname, 2: string ip, 3: string version, 4: i64 timestamp),

  /* Get the latest version of jarhub, along with a url */
  VersionDescriptor getLatestVersion(1: string hostname),

  /* Register a debugger, just for fun */
  void registerDebuggerClient(1: string hostname, 2: string ip, 3: string version, 4: i64 timestamp),

  /* Get the latest version of jarhub, along with a url */
  VersionDescriptor getLatestDebuggerVersion(1: string hostname),

  /* Register a proxy client */
  void registerProxyClient(1: string hostname, 2: string ip, 3: string version, 4: i64 timestamp),

  /* Get the latest version of jarhub proxy, along with a url */
  VersionDescriptor getLatestProxyVersion(1: string hostname),
}
