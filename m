Received: from mga17.intel.com ([192.55.52.151]:1326 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437916AbfIWRwN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:52:13 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 04/16] src/locktest: Add get_cmd_str
Date: Mon, 23 Sep 2019 10:51:52 -0700
Message-Id: <20190923175204.2139-5-ira.weiny@intel.com>
In-Reply-To: <20190923175204.2139-1-ira.weiny@intel.com>
References: <20190923175204.2139-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Rather than open code printing the strings, use a helper function.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index ce04ecba6205..825d9df3ddf8 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -109,6 +109,19 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		WHO		5
 #define		FLAGS		2 /* index 2 is also used for do_open() flag, see below */
 
+static char *get_cmd_str(int cmd)
+{
+	switch (cmd) {
+		case CMD_WRLOCK: return "write lock"; break;
+		case CMD_RDLOCK: return "read lock"; break;
+		case CMD_UNLOCK: return "unlock"; break;
+		case CMD_CLOSE:  return "close"; break;
+		case CMD_OPEN:   return "open"; break;
+		case CMD_WRTEST: return "Wait for SIGIO"; break;
+		case CMD_RDTEST: return "Truncate"; break;
+	}
+	return "unknown";
+}
 /* 
  * flags for Mac OS X do_open() 
  * O_RDONLY	0x0000
@@ -989,10 +1002,8 @@ main(int argc, char *argv[])
 			/* We have a failure */
 			if(debug)
 			    fprintf(stderr, "Server failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n", 
-					ctl.test, tests[index][COMMAND]==CMD_WRLOCK?"write lock":
-						tests[index][COMMAND]==CMD_RDLOCK?"read lock":
-						tests[index][COMMAND]==CMD_UNLOCK?"unlock":
-						tests[index][COMMAND]==CMD_OPEN?"open":"clos", 
+					ctl.test,
+					get_cmd_str(tests[index][COMMAND]),
 						(long long)tests[index][OFFSET],
 						(long long)tests[index][LENGTH],
 						saved_errno, strerror(saved_errno));
@@ -1009,10 +1020,8 @@ main(int argc, char *argv[])
 		} 
 		if(debug > 1)
 		    fprintf(stderr, "Sending command to client (%d) - %s - %lld:%lld\n", 
-					index, tests[index][COMMAND]==CMD_WRLOCK?"write lock":
-					tests[index][COMMAND]==CMD_RDLOCK?"read lock":
-					tests[index][COMMAND]==CMD_UNLOCK?"unlock": 
-					tests[index][COMMAND]==CMD_OPEN?"open":"clos", 
+					index,
+					get_cmd_str(ctl.command),
 					(long long)tests[index][OFFSET],
 					(long long)tests[index][LENGTH]);
 		/* get the client to do something */
@@ -1027,10 +1036,7 @@ main(int argc, char *argv[])
 			fail_flag++;
 			if(debug)
 			    fprintf(stderr, "Client failure in test %d, while %sing using offset %lld, length %lld - err = %d:%s\n",
-					ctl.test, ctl.command==CMD_WRLOCK?"write lock":
-					ctl.command==CMD_RDLOCK?"read lock":
-					ctl.command==CMD_UNLOCK?"unlock":
-					ctl.command==CMD_OPEN?"open":"clos",
+					ctl.test, get_cmd_str(ctl.command),
 					(long long)ctl.offset, (long long)ctl.length,
 					ctl.error, strerror(ctl.error));
 			fprintf(stderr, "Client failure in %lld:%s\n",
-- 
2.20.1
