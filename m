Received: from mga17.intel.com ([192.55.52.151]:1416 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502234AbfIWRxr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:47 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 12/16] src/locktest: Add simple lease testing
Date: Mon, 23 Sep 2019 10:53:32 -0700
Message-Id: <20190923175336.2287-13-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

	/*  1 */"Take Read Lease",
	/*  2 */"Take Write Lease",
	/*  3 */"Fail Write Lease if file is open somewhere else",
	/*  4 */"Fail Read Lease if opened with write permissions",

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Tests are now a separate array and are run with '-L' option.

 src/locktest.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 076781badaa1..2147acc67ef7 100644
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
@@ -544,6 +550,56 @@ static int64_t lock_tests[][6] =
 		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		SERVER,	},
 		{32,	CMD_OPEN,	O_RDWR,		0,		PASS,		CLIENT,	},
 #endif /* macosx */
+
+	/* indicate end of array */
+		{0,0,0,0,0,SERVER},
+		{0,0,0,0,0,CLIENT}
+	};
+
+
+char *lease_descriptions[] = {
+    /*  1 */"Take Read Lease",
+    /*  2 */"Take Write Lease",
+    /*  3 */"Fail Write Lease if file is open somewhere else",
+    /*  4 */"Fail Read Lease if opened with write permissions",
+};
+
+static int64_t lease_tests[][6] =
+	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
+	{
+	/* Various tests to exercise leases */
+
+/* SECTION 1: Simple verification of being able to take leases */
+	/* Take Read Lease */
+		{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+		{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{1,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+		{1,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		SERVER	},
+		{1,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		SERVER	},
+		{1,	CMD_SETLEASE,	F_UNLCK,	0,	PASS,		SERVER	},
+		{1,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{1,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Take Write Lease */
+		{2,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{2,	CMD_SETLEASE,	F_WRLCK,	0,	PASS,		SERVER	},
+		{2,	CMD_GETLEASE,	F_WRLCK,	0,	PASS,		SERVER	},
+		{2,	CMD_SETLEASE,	F_UNLCK,	0,	PASS,		SERVER	},
+		{2,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+	/* Fail Write Lease with other users */
+		{3,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT  },
+		{3,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{3,	CMD_SETLEASE,	F_WRLCK,	0,	FAIL,		SERVER	},
+		{3,	CMD_GETLEASE,	F_WRLCK,	0,	FAIL,		SERVER	},
+		{3,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{3,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+	/* Fail Read Lease if opened for write */
+		{4,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{4,	CMD_SETLEASE,	F_RDLCK,	0,	FAIL,		SERVER	},
+		{4,	CMD_GETLEASE,	F_RDLCK,	0,	FAIL,		SERVER	},
+		{4,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
 		{0,0,0,0,0,CLIENT}
@@ -653,6 +709,32 @@ static int do_lock(int cmd, int type, int start, int length)
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
+    if(ret)
+	fprintf(stderr, "%s do_lease: ret = %d, errno = %d (%s)\n",
+		__FILE__, ret, errno, strerror(errno));
+
+    return(ret==0?PASS:FAIL);
+}
+
 int do_close(void)
 {	
     if(debug > 1) {
@@ -782,6 +864,7 @@ main(int argc, char *argv[])
     extern char	*optarg;
     extern int	optind;
     int fail_count = 0;
+    int run_leases = 0;
     
     atexit(cleanup);
     
@@ -794,13 +877,17 @@ main(int argc, char *argv[])
 	    prog = p+1;
     }
 
-    while ((c = getopt(argc, argv, "dn:h:p:?")) != EOF) {
+    while ((c = getopt(argc, argv, "dLn:h:p:?")) != EOF) {
 	switch (c) {
 
 	case 'd':	/* debug flag */
 	    debug++;
 	    break;
 
+	case 'L':	/* Lease testing */
+	    run_leases = 1;
+	    break;
+
 	case 'h':	/* (server) hostname */
 	    server = 0;
 	    host = optarg;
@@ -965,7 +1052,10 @@ main(int argc, char *argv[])
      *
      * real work is in here ...
      */
-    fail_count = run(lock_tests, lock_descriptions);
+    if (run_leases)
+	fail_count = run(lease_tests, lease_descriptions);
+    else
+	fail_count = run(lock_tests, lock_descriptions);
 
     exit(fail_count);
     /*NOTREACHED*/
@@ -1022,6 +1112,12 @@ int run(int64_t tests[][6], char *descriptions[])
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
@@ -1120,6 +1216,13 @@ int run(int64_t tests[][6], char *descriptions[])
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
 		fprintf(stderr,"Failure in %d:%s\n",
-- 
2.20.1
