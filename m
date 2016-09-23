Received: from mail-pa0-f46.google.com ([209.85.220.46]:33377 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761698AbcIWU44 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2016 16:56:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id hm5so43499567pac.0
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2016 13:56:55 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] [xfstests-bld] kvm-xfstests: forbid conflicting specifications of FSTESTCFG
Date: Fri, 23 Sep 2016 13:56:12 -0700
Message-Id: <1474664172-84173-3-git-send-email-ebiggers@google.com>
In-Reply-To: <1474664172-84173-1-git-send-email-ebiggers@google.com>
References: <1474664172-84173-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: tytso@mit.edu
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

It was possible to run kvm-xfstests with arguments like '-c encrypt
smoke', in which case FSTESTCFG ended up set to "4k" because 'smoke'
implies '-c 4k' and the second config specification overrode the first.
If the user tries something like this, fail with a helpful error message
rather than proceeding with a configuration that likely wasn't intended.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/util/parse_cli | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index 6dae32f..a170931 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-FSTESTCFG=all
+FSTESTCFG=""
 SNAPSHOT=",snapshot=on"
 DO_AEX="yes"
 API="1.3"
@@ -118,6 +118,12 @@ while [ "$1" != "" ]; do
 	    DO_AEX=""
 	    ;;
 	-c) shift
+	    if test -n "$FSTESTCFG" ; then
+		echo "The '-c' option (or 'smoke') can only be specified once. "
+		echo "If you want to run tests in multiple configurations," \
+			"use -c CFG1,CFG2,..."
+		exit 1
+	    fi
 	    for i in ${1//,/ }
 	    do
 		validate_config_name "$i"
@@ -317,6 +323,11 @@ while [ "$1" != "" ]; do
 	    fi
 	    ;;
 	smoke)
+	    if test -n "$FSTESTCFG" ; then
+		echo "You can use either '-c' or 'smoke', not both! " \
+			"'smoke' means '-c 4k -g quick'."
+		exit 1
+	    fi
 	    FSTESTCFG=4k
 	    FSTESTSET="$FSTESTSET,-g,quick"
 	    ;;
@@ -357,6 +368,10 @@ while [ "$1" != "" ]; do
     shift
 done
 
+if test -z "$FSTESTCFG" ; then
+    FSTESTCFG=all
+fi
+
 if test -z "$FSTESTSET" -a -z "$ARG"
 then
     echo -e "No tests specified!\n"
-- 
2.8.0.rc3.226.g39d4020

