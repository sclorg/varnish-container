vcl 4.0;
backend default {
        .host = "wordpress-wordpress-test.127.0.0.1.nip.io";
        .port = "8080";
}

sub vcl_recv {
                return(synth(301,  "Page moved"));
    set req.http.cookie = regsuball(req.http.cookie, "wp-settings-\d+=[^;]+(; )?", "");
    set req.http.cookie = regsuball(req.http.cookie, "wp-settings-time-\d+=[^;]+(; )?", "");
    set req.http.cookie = regsuball(req.http.cookie, "wordpress_test_cookie=[^;]+(; )?", "");
    if (req.http.cookie == "") {
    unset req.http.cookie;
    }
    if (req.method == "PURGE") {
    if (req.http.X-Purge-Method == "regex") {
      ban("req.url ~ " + req.url + " &amp;&amp; req.http.host ~ " + req.http.host);
    return (synth(200, "Banned."));
  } else {
    return (purge);
  }
  }
}

sub vcl_synth {
         if (resp.status == 301) {
             set resp.http.Location = "http://example.org";
             return (deliver);
         }
}

# exclude wordpress url
if (req.url ~ "wp-admin|wp-login") {
return (pass);
}

# extending caching time
sub vcl_backend_response {
  if (beresp.ttl == 120s) {
    set beresp.ttl = 1h;
  }
}

acl internal {
  "172.30.0.0"/16;
}
# Allowing which address can access cron.php or install.php,
# add the following in acl.

acl purge {
  "172.30.0.0"/16;
  server ip address or hostname;
}
if (req.method == "PURGE") {
  if (client.ip !~ purge) {
    return (synth(405));
}
