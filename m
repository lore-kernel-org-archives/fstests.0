Received: from mail-pl0-f68.google.com ([209.85.160.68]:46362 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeDEVHf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Apr 2018 17:07:35 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so18312844plc.13
        for <fstests@vger.kernel.org>; Thu, 05 Apr 2018 14:07:35 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [xfstests-bld PATCH] util/parse_cli: use getopt to parse the options
Date: Thu,  5 Apr 2018 14:06:44 -0700
Message-Id: <20180405210644.128564-1-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Use getopt to parse the options rather than the custom code that
iterates through $@.  This fixes many anomalies, such as long options
being accepted in the form '--opt ARG' but not '--opt=ARG'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/util/parse_cli | 69 ++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 52f518a..7043ab1 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -155,8 +155,56 @@ validate_config_name()
     fi
 }
 
-while [ "$1" != "" ]; do
-    case $1 in
+shortopts="ac:C:g:hI:m:n:No:O:r:vx:X:"
+longopts=(
+aio:
+archive
+bucket-subdir:
+cache:
+email:
+gce-zone:
+gs-bucket:
+help
+hooks:
+image-project:
+initrd:
+instance-name:
+kernel:
+local-ssd
+log
+machtype:
+no-action
+no-archive
+no-collapse
+no-email
+no-insert
+no-log
+no-preemptible
+no-punch
+no-region-shard
+no-virtio-rng
+no-zero
+numa:
+pmem-device
+preemptible
+testrunid:
+update-files
+update-xfstests
+update-xfstests-tar
+virtfs-model:
+virtfs-scratch:
+virtfs-test:
+virtfs:
+)
+longopts=$(echo "${longopts[*]}" | tr ' ' ,)
+
+if ! options=$(getopt -o "$shortopts" -l "$longopts" -- "$@"); then
+    print_help
+fi
+
+eval set -- "$options"
+while (( $# >= 1 )); do
+    case "$1" in
 	-a)
 	    DO_AEX=""
 	    ;;
@@ -419,6 +467,20 @@ while [ "$1" != "" ]; do
 	    supported_flavors kvm
 	    unset DO_ARCHIVE
 	    ;;
+	--)
+	    shift
+	    break
+	    ;;
+	*)
+	    echo 1>&2 "Invalid option: \"$1\""
+	    print_help
+	    ;;
+    esac
+    shift
+done
+
+while (( $# >= 1 )); do
+    case "$1" in
 	smoke)
 	    if test -n "$FSTESTCFG" ; then
 		echo "You can use either '-c' or 'smoke', not both! " \
@@ -459,9 +521,6 @@ while [ "$1" != "" ]; do
 	ver)
 	    ARG="cmd=ver"
 	    ;;
-	-*)
-	    print_help
-	    ;;
 	*)
 	    validate_test_name "$1"
 	    FSTESTSET="$FSTESTSET,$1"
-- 
2.17.0.484.g0c8726318c-goog

