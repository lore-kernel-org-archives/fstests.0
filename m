Received: from mga07.intel.com ([134.134.136.100]:45400 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbfIREQQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:16 -0400
From: ira.weiny@intel.com
Subject: [PATCH 11/13] src/locktest: Add truncate lease tests
Date: Tue, 17 Sep 2019 21:15:56 -0700
Message-Id: <20190918041558.2621-12-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Add verification of signal reception on truncate:

	/* 41 */"Write lease gets SIGIO on truncate",
	/* 42 */"Read lease gets SIGIO on truncate",

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/locktest.c b/src/locktest.c
index b1388336e318..b469a2270f82 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -102,6 +102,7 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define 	CMD_GETLEASE	8
 #define		CMD_SIGIO	9
 #define		CMD_WAIT_SIGIO	10
+#define		CMD_TRUNCATE	11
 
 #define		PASS 	1
 #define		FAIL	0
@@ -133,6 +134,7 @@ static char *get_cmd_str(int cmd)
 		case CMD_GETLEASE: return "Get Lease"; break;
 		case CMD_SIGIO:    return "Setup SIGIO"; break;
 		case CMD_WAIT_SIGIO: return "Wait for SIGIO"; break;
+		case CMD_TRUNCATE: return "Truncate"; break;
 	}
 	return "unknown";
 }
@@ -203,6 +205,8 @@ char *descriptions[] = {
     /* 38 */"Write lease gets SIGIO on read open",
     /* 39 */"Read lease does _not_ get SIGIO on read open",
     /* 40 */"Read lease gets SIGIO on write open",
+    /* 41 */"Write lease gets SIGIO on truncate",
+    /* 42 */"Read lease gets SIGIO on truncate",
 };
 
 static int64_t tests[][6] =
@@ -640,6 +644,25 @@ static int64_t tests[][6] =
 		{40,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
 		{40,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
 
+	/* Get SIGIO when Write lease is broken by Truncate */
+		{41,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
+		{41,	CMD_SETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{41,	CMD_GETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{41,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{41,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		CLIENT	},
+		{41,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{41,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read lease is broken by Truncate */
+		{42,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{42,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{42,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{42,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{42,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		SERVER	},
+		{42,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{42,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
 		{0,0,0,0,0,CLIENT}
@@ -703,6 +726,27 @@ initialize(HANDLE fd)
     }
 }
 
+static int do_truncate(size_t length)
+{
+    int rc;
+
+    if (debug > 1)
+	fprintf(stderr, "truncating to %ld\n", length);
+
+again:
+    rc = truncate(filename, length);
+    if (rc && errno == EINTR)
+	goto again;
+
+    saved_errno = errno;
+
+    if (debug && rc)
+	fprintf(stderr, "%s %d : %s\n",
+		__FILE__, errno, strerror(errno));
+
+    return (rc == 0 ? PASS:FAIL);
+}
+
 void release_lease(int fd)
 {
 	int rc;
@@ -1205,6 +1249,9 @@ main(int argc, char *argv[])
 			case CMD_WAIT_SIGIO:
 			    result = do_wait_sigio(tests[index][TIME]);
 			    break;
+			case CMD_TRUNCATE:
+			    result = do_truncate(tests[index][OFFSET]);
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1319,6 +1366,9 @@ main(int argc, char *argv[])
 		case CMD_WAIT_SIGIO:
 		    result = do_wait_sigio(ctl.offset);
 		    break;
+		case CMD_TRUNCATE:
+		    result = do_truncate(ctl.offset);
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		if(debug)
-- 
2.20.1
