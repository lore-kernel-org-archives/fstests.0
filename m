Received: from mga07.intel.com ([134.134.136.100]:64797 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753133AbcLGEFF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Dec 2016 23:05:05 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH] xfstests: fix build warnings and notify_others() bug
Date: Tue,  6 Dec 2016 21:04:01 -0700
Message-Id: <1481083441-4809-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, Dave Chinner <david@fromorbit.com>, Lukas Czerner <lczerner@redhat.com>, Allison Henderson <achender@vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Nathan Scott <nathans@sgi.com>
List-ID: <fstests@vger.kernel.org>

This patch addresses the following build warnings:

fsx.c: In function 'do_punch_hole':
fsx.c:940:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
   if (!quiet && testcalls > simulatedopcount)
   ^~
fsx.c:942:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
^~~~
fsx.c:947:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
   if (!quiet && testcalls > simulatedopcount)
   ^~
fsx.c:949:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
^~~~
fsx.c: In function 'do_zero_range':
fsx.c:995:3: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
   if (!quiet && testcalls > simulatedopcount)
   ^~
fsx.c:997:4: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
log4(OP_ZERO_RANGE, offset, length, FL_SKIPPED |
^~~~
[CC]    growfiles
growfiles.c: In function 'notify_others':
growfiles.c:1458:6: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
  if ( Forker_pids[ind] != Pid )
  ^~
growfiles.c:1462:10: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'if'
  kill(Forker_pids[ind], SIGUSR2);
  ^~~~

The warnings in fsx.c were just spacing issues of the form:

	if (length == 0) {
		if (!quiet && testcalls > simulatedopcount)
			prt("skipping zero length punch hole\n");
			log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
		return;
	}

Where the log4() call just needs to be unindented.  log4() calls elsewhere
in that same file are not protected with any sort of 'quiet' check, and
commonly follow prt() calls which are.  See doread(), domapread(), etc.

The warning from growfiles.c was actually a bug.  notify_others() is
looping through the Forker_pids[] array and sending SIGUSR2 to all other
processes.  However, with the current logic it only *logs* the kill for
other processes, and kills all other processes plus the Forker_pids[] entry
that matches 'Pid'.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Lukas Czerner <lczerner@redhat.com>
Cc: Allison Henderson <achender@vnet.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Nathan Scott <nathans@sgi.com>
---
 ltp/fsx.c       | 8 ++++----
 ltp/growfiles.c | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 74a3b74..3713bbe 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -939,14 +939,14 @@ do_punch_hole(unsigned offset, unsigned length)
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
 			prt("skipping zero length punch hole\n");
-			log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
+		log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
 		return;
 	}
 
 	if (file_size <= (loff_t)offset) {
 		if (!quiet && testcalls > simulatedopcount)
 			prt("skipping hole punch off the end of the file\n");
-			log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
+		log4(OP_PUNCH_HOLE, offset, length, FL_SKIPPED);
 		return;
 	}
 
@@ -994,8 +994,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
 	if (length == 0) {
 		if (!quiet && testcalls > simulatedopcount)
 			prt("skipping zero length zero range\n");
-			log4(OP_ZERO_RANGE, offset, length, FL_SKIPPED |
-			     (keep_size ? FL_KEEP_SIZE : FL_NONE));
+		log4(OP_ZERO_RANGE, offset, length, FL_SKIPPED |
+		     (keep_size ? FL_KEEP_SIZE : FL_NONE));
 		return;
 	}
 
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index 06f179f..fb91761 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -1455,11 +1455,12 @@ notify_others()
 	send_signals=1; /* only send signals once */
 
         for (ind=0; ind< Forker_npids; ind++) {
-	    if ( Forker_pids[ind] != Pid )
+	    if ( Forker_pids[ind] != Pid ) {
 	        if ( Debug > 1 )
 		    printf("%s%s: %d DEBUG2 %s/%d: Sending SIGUSR2 to pid %d\n",
 		        Progname, TagName, Pid, __FILE__, __LINE__, Forker_pids[ind]);
 	        kill(Forker_pids[ind], SIGUSR2);
+	    }
         }
     }
 
-- 
2.7.4

