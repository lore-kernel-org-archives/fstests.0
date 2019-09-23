Received: from mga01.intel.com ([192.55.52.88]:2370 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394221AbfIWRxr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Sep 2019 13:53:47 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 14/16] src/locktest: Add truncate lease tests
Date: Mon, 23 Sep 2019 10:53:34 -0700
Message-Id: <20190923175336.2287-15-ira.weiny@intel.com>
In-Reply-To: <20190923175336.2287-1-ira.weiny@intel.com>
References: <20190923175336.2287-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

Add verification of signal reception on truncate:

	/*  9 */"Write lease gets SIGIO on truncate",
	/* 10 */"Read lease gets SIGIO on truncate",

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V1:
	Tests are now a separate array and are run with '-L' option.

 src/locktest.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/locktest.c b/src/locktest.c
index 9f8a892a21a0..2e7f2a19b1af 100644
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
@@ -574,6 +576,8 @@ char *lease_descriptions[] = {
     /*  6 */"Write lease gets SIGIO on read open",
     /*  7 */"Read lease does _not_ get SIGIO on read open",
     /*  8 */"Read lease gets SIGIO on write open",
+    /*  9 */"Write lease gets SIGIO on truncate",
+    /* 10 */"Read lease gets SIGIO on truncate",
 };
 
 static int64_t lease_tests[][6] =
@@ -654,6 +658,25 @@ static int64_t lease_tests[][6] =
 		{8,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
 		{8,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
 
+	/* Get SIGIO when Write lease is broken by Truncate */
+		{9,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
+		{9,	CMD_SETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{9,	CMD_GETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{9,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{9,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		CLIENT	},
+		{9,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{9,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read lease is broken by Truncate */
+		{10,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{10,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{10,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{10,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{10,	CMD_TRUNCATE,	FILE_SIZE/2,	0,	PASS,		SERVER	},
+		{10,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{10,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
 		{0,0,0,0,0,CLIENT}
@@ -717,6 +740,27 @@ initialize(HANDLE fd)
     }
 }
 
+static int do_truncate(size_t length)
+{
+    int rc;
+
+    if (debug)
+	fprintf(stderr, "truncating to %ld\n", length);
+
+again:
+    rc = truncate(filename, length);
+    if (rc && errno == EINTR)
+	goto again;
+
+    saved_errno = errno;
+
+    if (rc)
+	fprintf(stderr, "%s %d : %s\n",
+		__FILE__, errno, strerror(errno));
+
+    return (rc == 0 ? PASS:FAIL);
+}
+
 void release_lease(int fd)
 {
 	int rc;
@@ -1245,6 +1289,9 @@ int run(int64_t tests[][6], char *descriptions[])
 			case CMD_WAIT_SIGIO:
 			    result = do_wait_sigio(tests[index][TIME]);
 			    break;
+			case CMD_TRUNCATE:
+			    result = do_truncate(tests[index][OFFSET]);
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1356,6 +1403,9 @@ int run(int64_t tests[][6], char *descriptions[])
 		case CMD_WAIT_SIGIO:
 		    result = do_wait_sigio(ctl.offset);
 		    break;
+		case CMD_TRUNCATE:
+		    result = do_truncate(ctl.offset);
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		fprintf(stderr,"Failure in %d:%s\n",
-- 
2.20.1
