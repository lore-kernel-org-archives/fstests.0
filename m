Received: from mga17.intel.com ([192.55.52.151]:25899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfIREQP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 00:16:15 -0400
From: ira.weiny@intel.com
Subject: [PATCH 10/13] src/locktest: Add lease testing for basic signal reception
Date: Tue, 17 Sep 2019 21:15:55 -0700
Message-Id: <20190918041558.2621-11-ira.weiny@intel.com>
In-Reply-To: <20190918041558.2621-1-ira.weiny@intel.com>
References: <20190918041558.2621-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, dan.j.williams@intel.com, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

	/* 37 */"Read lease gets SIGIO on write open",
	/* 38 */"Write lease gets SIGIO on read open",
	/* 39 */"Read lease does _not_ get SIGIO on read open",
	/* 40 */"Read lease gets SIGIO on write open",

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 src/locktest.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index 8aa9249f5af8..b1388336e318 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -27,6 +27,8 @@
 #include <byteswap.h>
 #include <errno.h>
 #include <string.h>
+#include <signal.h>
+
 #define     HEX_2_ASC(x)    ((x) > 9) ? (x)-10+'a' : (x)+'0'
 #define 	FILE_SIZE	1024
 #define PLATFORM_INIT()     /*no-op*/
@@ -83,6 +85,7 @@ static int	server = 1;
 static int	port = 0;
 static int 	testnumber = -1;
 static int	saved_errno = 0;
+static int      got_sigio = 0;
 
 static SOCKET	s_fd = -1;              /* listen socket    */
 static SOCKET	c_fd = -1;	        /* IPC socket       */
@@ -97,6 +100,8 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		CMD_RDTEST	6
 #define 	CMD_SETLEASE	7
 #define 	CMD_GETLEASE	8
+#define		CMD_SIGIO	9
+#define		CMD_WAIT_SIGIO	10
 
 #define		PASS 	1
 #define		FAIL	0
@@ -112,6 +117,7 @@ static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
 #define		WHO		5
 #define		FLAGS		2 /* index 2 is also used for do_open() flag, see below */
 #define		ARG		FLAGS /* Arguments for Lease operations */
+#define		TIME		FLAGS /* Time for waiting on sigio */
 
 static char *get_cmd_str(int cmd)
 {
@@ -125,6 +131,8 @@ static char *get_cmd_str(int cmd)
 		case CMD_RDTEST: return "Truncate"; break;
 		case CMD_SETLEASE: return "Set Lease"; break;
 		case CMD_GETLEASE: return "Get Lease"; break;
+		case CMD_SIGIO:    return "Setup SIGIO"; break;
+		case CMD_WAIT_SIGIO: return "Wait for SIGIO"; break;
 	}
 	return "unknown";
 }
@@ -191,10 +199,15 @@ char *descriptions[] = {
     /* 34 */"Take Write Lease",
     /* 35 */"Fail Write Lease if file is open somewhere else",
     /* 36 */"Fail Read Lease if opened with write permissions",
+    /* 37 */"Read lease gets SIGIO on write open",
+    /* 38 */"Write lease gets SIGIO on read open",
+    /* 39 */"Read lease does _not_ get SIGIO on read open",
+    /* 40 */"Read lease gets SIGIO on write open",
 };
 
 static int64_t tests[][6] =
 	/*	test #	Action	[offset|flags|arg]	length		expected	server/client */
+	/*			[sigio_wait_time]						*/
 	{ 	
 	/* Various simple tests exercising the list */
 
@@ -586,6 +599,47 @@ static int64_t tests[][6] =
 		{36,	CMD_GETLEASE,	F_RDLCK,	0,	FAIL,		SERVER	},
 		{36,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
 
+/* SECTION 2: Proper SIGIO notifications */
+	/* Get SIGIO when read lease is broken by write */
+		{37,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{37,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{37,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{37,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{37,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{37,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{37,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{37,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when write lease is broken by read */
+		{38,	CMD_OPEN,	O_RDWR,		0,	PASS,		CLIENT	},
+		{38,	CMD_SETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{38,	CMD_GETLEASE,	F_WRLCK,	0,	PASS,		CLIENT	},
+		{38,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{38,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+		{38,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{38,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{38,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Don't get SIGIO when read lease is taken by read */
+		{39,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{39,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{39,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{39,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{39,	CMD_OPEN,	O_RDONLY,	0,	PASS,		SERVER	},
+		{39,	CMD_WAIT_SIGIO,	5,		0,	FAIL,		CLIENT	},
+		{39,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{39,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
+	/* Get SIGIO when Read lease is broken by Write */
+		{40,	CMD_OPEN,	O_RDONLY,	0,	PASS,		CLIENT	},
+		{40,	CMD_SETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{40,	CMD_GETLEASE,	F_RDLCK,	0,	PASS,		CLIENT	},
+		{40,	CMD_SIGIO,	0,		0,	PASS,		CLIENT	},
+		{40,	CMD_OPEN,	O_RDWR,		0,	PASS,		SERVER	},
+		{40,	CMD_WAIT_SIGIO,	5,		0,	PASS,		CLIENT	},
+		{40,	CMD_CLOSE,	0,		0,	PASS,		SERVER	},
+		{40,	CMD_CLOSE,	0,		0,	PASS,		CLIENT	},
+
 	/* indicate end of array */
 		{0,0,0,0,0,SERVER},
 		{0,0,0,0,0,CLIENT}
@@ -649,6 +703,67 @@ initialize(HANDLE fd)
     }
 }
 
+void release_lease(int fd)
+{
+	int rc;
+
+	rc = fcntl(fd, F_SETLEASE, F_UNLCK);
+	if (debug && rc != 0)
+		fprintf(stderr, "%s Failed to remove lease %d : %d %s\n",
+			__FILE__, rc, errno, strerror(errno));
+}
+
+void lease_break(int sig, siginfo_t *info, void *p)
+{
+    if (debug > 1)
+	fprintf(stderr, "lease break %d %p fd %d\n",
+		sig, info, info->si_fd);
+    got_sigio = 1;
+    release_lease(f_fd);
+}
+
+struct sigaction lease_break_action = {
+	.sa_sigaction = lease_break,
+	.sa_flags = SA_SIGINFO,
+};
+
+int do_setup_sigio(int fd)
+{
+	int rc;
+
+	got_sigio = 0;
+
+	rc = sigaction(SIGIO, &lease_break_action, NULL);
+	if (rc != 0)
+		return FAIL;
+
+	if (debug > 1)
+		fprintf(stderr, "Set '%s' sigaction on %d\n",
+			strsignal(SIGIO), fd);
+
+	rc = fcntl(fd, F_SETSIG, SIGIO);
+	if (debug && rc)
+		fprintf(stderr, "%s Set '%s' sigaction on %d\n",
+			__FILE__, strsignal(SIGIO), fd);
+
+	return (rc == 0 ? PASS : FAIL);
+}
+
+int do_wait_sigio(int32_t time)
+{
+    if (time <= 0)
+	return FAIL;
+
+    while (!got_sigio && time--) {
+	sleep(1);
+    }
+
+    if (debug > 1 && !got_sigio)
+	fprintf(stderr, "%s failed to get sigio\n",
+		__FILE__);
+
+    return (got_sigio ? PASS: FAIL);
+}
 
 int do_open(int flag)
 {
@@ -790,10 +905,13 @@ void recv_ctl(void)
 {
     int         nread;
 
+again:
     if ((nread = SOCKET_READ(c_fd, (char*)&ctl, sizeof(ctl))) != sizeof(ctl)) {
-        if (nread < 0)
+        if (nread < 0) {
+	    if (errno == EINTR)
+		goto again;
             perror("recv_ctl: read");
-        else {
+        } else {
             fprintf(stderr, "recv_ctl[%d]: read() returns %d, not %zu as expected\n", 
                     ctl.test, nread, sizeof(ctl));
 	    fprintf(stderr, "socket might has been closed by other locktest\n");
@@ -1081,6 +1199,12 @@ main(int argc, char *argv[])
 			case CMD_GETLEASE:
 			    result = do_lease(F_GETLEASE, tests[index][ARG], tests[index][ARG]);
 			    break;
+			case CMD_SIGIO:
+			    result = do_setup_sigio(f_fd);
+			    break;
+			case CMD_WAIT_SIGIO:
+			    result = do_wait_sigio(tests[index][TIME]);
+			    break;
 		    }
 		    if( result != tests[index][RESULT]) {
 			fail_flag++;
@@ -1189,6 +1313,12 @@ main(int argc, char *argv[])
 		case CMD_GETLEASE:
 		    result = do_lease(F_GETLEASE, ctl.offset, ctl.offset);
 		    break;
+		case CMD_SIGIO:
+		    result = do_setup_sigio(f_fd);
+		    break;
+		case CMD_WAIT_SIGIO:
+		    result = do_wait_sigio(ctl.offset);
+		    break;
 	    }
 	    if( result != ctl.result ) {
 		if(debug)
-- 
2.20.1
