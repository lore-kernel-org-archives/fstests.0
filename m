Received: from mail-pg0-f68.google.com ([74.125.83.68]:36486 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdBFVoF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Feb 2017 16:44:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so10089353pgf.3
        for <fstests@vger.kernel.org>; Mon, 06 Feb 2017 13:44:05 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: be tolerant of /proc/slabinfo being missing
Date: Mon,  6 Feb 2017 13:42:33 -0800
Message-Id: <20170206214237.8838-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

In kernels compiled without /proc/slabinfo (CONFIG_SLABINFO),
runtests.sh would report errors when trying to save the contents of
/proc/slabinfo.  Update runtests.sh to consider /proc/slabinfo to be
optional, saving its contents only if present.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/runtests.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/runtests.sh b/kvm-xfstests/test-appliance/files/root/runtests.sh
index 377001b..6fd6999 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -190,7 +190,7 @@ do
     find $i -type f ! -name check.time -print | xargs rm -f 2> /dev/null
 done
 
-cp /proc/slabinfo /results/slabinfo.before
+[ -e /proc/slabinfo ] && cp /proc/slabinfo /results/slabinfo.before
 cp /proc/meminfo /results/meminfo.before
 
 free -m
@@ -321,7 +321,7 @@ do
 	if test ! -f /.dockerenv ; then
 	    echo 3 > /proc/sys/vm/drop_caches
 	fi
-	cp /proc/slabinfo "$RESULT_BASE/slabinfo.before"
+	[ -e /proc/slabinfo ] && cp /proc/slabinfo "$RESULT_BASE/slabinfo.before"
 	cp /proc/meminfo "$RESULT_BASE/meminfo.before"
 	echo -n "BEGIN TEST $i: $TESTNAME " ; date
 	logger "BEGIN TEST $i: $TESTNAME "
@@ -424,7 +424,7 @@ END	{ if (NR > 0) {
 	if test ! -f /.dockerenv ; then
 	    echo 3 > /proc/sys/vm/drop_caches
 	fi
-	cp /proc/slabinfo "$RESULT_BASE/slabinfo.after"
+	[ -e /proc/slabinfo ] && cp /proc/slabinfo "$RESULT_BASE/slabinfo.after"
 	cp /proc/meminfo "$RESULT_BASE/meminfo.after"
 	free -m
 	gce_run_hooks fs-config-end $i
@@ -434,5 +434,5 @@ END	{ if (NR > 0) {
 	logger "END TEST $i: $TESTNAME "
 done
 
-cp /proc/slabinfo /results/slabinfo.after
+[ -e /proc/slabinfo ] && cp /proc/slabinfo /results/slabinfo.after
 cp /proc/meminfo /results/meminfo.after
-- 
2.11.0.483.g087da7b7c-goog

