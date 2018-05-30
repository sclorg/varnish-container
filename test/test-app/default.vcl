vcl 4.0;
backend default {
        .host = "varnish.myproject.svc";
        .port = "8080";
}

sub vcl_recv {
                return(synth(301,  "Page moved"));
}

sub vcl_synth {
         if (resp.status == 301) {
             set resp.http.Location = "http://example.org";
             return (deliver);
         }
}
