Received: from mail-pf0-f196.google.com ([209.85.192.196]:36160 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752964AbdEAREi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 May 2017 13:04:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id v14so28484051pfd.3
        for <fstests@vger.kernel.org>; Mon, 01 May 2017 10:04:38 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] test-appliance: limit checkpointing to gce-xfstests only
Date: Mon,  1 May 2017 10:04:32 -0700
Message-Id: <20170501170432.94512-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Results checkpointing by filesystem config, as introduced by
f3c85210f147 ("test-appliance: checkpoint fs configurations that are
completed") only really makes sense for gce-xfstests, which uses a new
results directory per GCE instance.  It doesn't make sense for
kvm-xfstests and android-xfstests because the same results directory may
be reused for many different test runs, with different kernels and/or
different sets of tests.  Therefore, for now limit the checkpointing to
gce-xfstests only.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/runtests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/runtests.sh b/kvm-xfstests/test-appliance/files/root/runtests.sh
index ec676a9..6544e1c 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -304,7 +304,8 @@ do
 	    XFS_IO_AVOID="${XFS_IO_AVOID/# /}"
 	fi
 	echo $FS/$i > /run/fstest-config
-	if grep -q "^$FS/$i\$" "$RESULTS/fstest-completed"
+	if test -n "$RUN_ON_GCE" && \
+		grep -q "^$FS/$i\$" "$RESULTS/fstest-completed"
 	then
 	    echo "$FS/$i: already run"
 	    /usr/local/lib/gce-logger already run
@@ -440,7 +441,9 @@ END	{ if (NR > 0) {
 	gce_run_hooks fs-config-end $i
 	umount "$TEST_DIR" >& /dev/null
 	umount "$SCRATCH_MNT" >& /dev/null
-	cat /run/fstest-config >> "$RESULTS/fstest-completed"
+	if test -n "$RUN_ON_GCE" ; then
+	    cat /run/fstest-config >> "$RESULTS/fstest-completed"
+	fi
 	echo -n "END TEST: $TESTNAME " ; date
 	logger "END TEST $i: $TESTNAME "
 done
-- 
2.13.0.rc0.306.g87b477812d-goog

