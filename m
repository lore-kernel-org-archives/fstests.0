Received: from mga01.intel.com ([192.55.52.88]:12653 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfIREQN (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:13 -0400
From: ira.weiny@intel.com
Subject: [PATCH 09/13] src/locktest: Add simple lease testing
Date: Tue, 17 Sep 2019 21:15:54 -0700
Message-Id: <20190918041558.2621-10-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

	/* 33 */"Take Read Lease",
	/* 34 */"Take Write Lease",
	/* 35 */"Fail Write Lease if file is open somewhere else",
	/* 36 */"Fail Read Lease if opened with write permissions",

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 5 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 241e7c451724..8aa9249f5af8 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
+ * Copyright (c) 2019 Intel Corp.
  * All Rights Reserved.
  */
 
 /*
- * Synchronized byte range lock exerciser
+ * Synchronized byte range lock and lease exerciser
  */
 
 #include <stdio.h>
@@ -94,6 +95,8 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		CMD_OPEN	4
 #define		CMD_WRTEST	5
 #define		CMD_RDTEST	6
+#define 	CMD_SETLEASE	7
+#define 	CMD_GETLEASE	8
 
 #define		PASS 	1
 #define		FAIL	0
@@ -108,6 +111,7 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		RESULT		4
 #define		WHO		5
 #define		FLAGS		2 /* index 2 is also used for do_open() flag, see below */
+#define		ARG		FLAGS /* Arguments for Lease operations */
 
 static char *get_cmd_str(int cmd)
 {
@@ -119,6 +123,8 @@ static char *get_cmd_str(int cmd)
 		case CMD_OPEN:   return "open"; break;
 		case CMD_WRTEST: return "Wait for SIGIO"; break;
 		case CMD_RDTEST: return "Truncate"; break;
+		case CMD_SETLEASE: return "Set Lease"; break;
+		case CMD_GETLEASE: return "Get Lease"; break;
 	}
 	return "unknown";
 }
@@ -176,15 +182,19 @@ char *descriptions[] = {
     /* 27 */"Acquire whole file write lock and then close without unlocking (and attempt a lock)",
     /* 28 */"Acquire two read locks, close and reopen the file, and test if the inital lock is still there",
     /* 29 */"Verify that F_GETLK for F_WRLCK doesn't require that file be opened for write",
-    #if defined(macosx)
+    /* if defined(macosx) ; These must be defined to keep the array intact */
     /* 30 */"Close the opened file and open the file with SHLOCK, other client will try to open with SHLOCK too",
     /* 31 */"Close the opened file and open the file with SHLOCK, other client will try to open with EXLOCK",
-    /* 32 */"Close the opened file and open the file with EXLOCK, other client will try to open with EXLOCK too"
-    #endif
+    /* 32 */"Close the opened file and open the file with EXLOCK, other client will try to open with EXLOCK too",
+    /* endif */
+    /* 33 */"Take Read Lease",
+    /* 34 */"Take Write Lease",
+    /* 35 */"Fail Write Lease if file is open somewhere else",
+    /* 36 */"Fail Read Lease if opened with write permissions",
 };
 
 static int64_t tests[][6] =
-	/*	test #	Action	[offset|flags]	length		expected	server/client */
+	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
 	{ 	
 	/* Various simple tests exercising the list */
 
@@ -544,6 +554,38 @@ static int64_t tests[][6] =
 		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
 		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		CLIENT,	},
 #endif /* macosx */
+
+/* SECTION 5: Simple verification of being able to take leases */
+	/* Take Read Lease */
+		{33,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+		{33,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{33,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{33,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+		{33,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		SERVER	},
+		{33,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		SERVER	},
+		{33,	CMD_SETLEASE,	F_UNLCK,	0,	PASS,		SERVER	},
+		{33,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{33,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Take Write Lease */
+		{34,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{34,	CMD_SETLEASE,	F_WRLCK,	0,	PASS,		SERVER	},
+		{34,	CMD_GETLEASE,	F_WRLCK,	0,	PASS,		SERVER	},
+		{34,	CMD_SETLEASE,	F_UNLCK,	0,	PASS,		SERVER	},
+		{34,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	/* Fail Write Lease with other users */
+		{35,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT  },
+		{35,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{35,	CMD_SETLEASE,	F_WRLCK,	0,	FAIL,		SERVER	},
+		{35,	CMD_GETLEASE,	F_WRLCK,	0,	FAIL,		SERVER	},
+		{35,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{35,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+	/* Fail Read Lease if opened for write */
+		{36,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{36,	CMD_SETLEASE,	F_RDLCK,	0,	FAIL,		SERVER	},
+		{36,	CMD_GETLEASE,	F_RDLCK,	0,	FAIL,		SERVER	},
+		{36,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
 		{0,0,0,0,0,CLIENT}
@@ -653,6 +695,32 @@ static int do_lock(int cmd, int type, int start, int length)
     return(ret==0?PASS:FAIL);
 }
 
+static int do_lease(int cmd, int arg, int expected)
+{
+    int ret;
+
+    if(debug > 1)
+	fprintf(stderr, "do_lease: cmd=%d arg=%d exp=%X\n",
+		cmd, arg, expected);
+
+    if (f_fd < 0)
+	return f_fd;
+
+    errno = 0;
+
+    ret = fcntl(f_fd, cmd, arg);
+    saved_errno = errno;
+
+    if (expected && (expected == ret))
+	ret = 0;
+
+    if(debug > 1 && ret)
+	fprintf(stderr, "%s do_lease: ret = %d, errno = %d (%s)\n",
+		__FILE__, ret, errno, strerror(errno));
+
+    return(ret==0?PASS:FAIL);
+}
+
 int do_close(void)
 {	
     if(debug > 1) {
@@ -1007,6 +1075,12 @@ main(int argc, char *argv[])
 			case CMD_RDTEST:
 			    result = do_lock(F_GETLK, F_RDLCK, tests[index][OFFSET], tests[index][LENGTH]);
 			    break;
+			case CMD_SETLEASE:
+			    result = do_lease(F_SETLEASE, tests[index][ARG], 0);
+			    break;
+			case CMD_GETLEASE:
+			    result = do_lease(F_GETLEASE, tests[index][ARG], tests[index][ARG]);
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1108,6 +1182,13 @@ main(int argc, char *argv[])
 		case CMD_RDTEST:
 		    result = do_lock(F_GETLK, F_RDLCK, ctl.offset, ctl.length);
 		    break;
+		/* NOTE offset carries the argument values */
+		case CMD_SETLEASE:
+		    result = do_lease(F_SETLEASE, ctl.offset, 0);
+		    break;
+		case CMD_GETLEASE:
+		    result = do_lease(F_GETLEASE, ctl.offset, ctl.offset);
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		if(debug)
-- 
2.20.1
