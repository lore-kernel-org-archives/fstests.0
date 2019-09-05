Received: from mga12.intel.com ([192.55.52.136]:26797 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfIERaj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Sep 2019 13:30:39 -0400
From: ira.weiny@intel.com
Subject: [PATCH V2 1/2] src/leasetest: Add lease test executable
Date: Thu,  5 Sep 2019 10:30:25 -0700
Message-Id: <20190905173026.28114-2-ira.weiny@intel.com>
In-Reply-To: <20190905173026.28114-1-ira.weiny@intel.com>
References: <20190905173026.28114-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: john.hubbard@gmail.com, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Jeff Layton <jlayton@kernel.org>, Ira Weiny <ira.weiny@intel.com>
List-ID: <fstests@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

locktest uses a pattern which is suitable for lease testing so this
patch copies locktest as a framework and modifies it for lease testing.

Initial tests are built based on the existing fcntl() man page declared
functionality.

Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
	Adds tests which were covered here:
	https://marc.info/?l=fstests&m=156690934513424&w=2

 src/Makefile    |   2 +-
 src/leasetest.c | 859 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 860 insertions(+), 1 deletion(-)
 create mode 100644 src/leasetest.c

diff --git a/src/Makefile b/src/Makefile
index c4fcf370431f..c34b4add6695 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -28,7 +28,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
 	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
-	fscrypt-crypt-util bulkstat_null_ocount
+	fscrypt-crypt-util bulkstat_null_ocount leasetest
 
 SUBDIRS = log-writes perf
 
diff --git a/src/leasetest.c b/src/leasetest.c
new file mode 100644
index 000000000000..729aca851493
--- /dev/null
+++ b/src/leasetest.c
@@ -0,0 +1,859 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2000-2003 Silicon Graphics, Inc.
+ * Copyright (c) 2019 Intel Corp.
+ * All Rights Reserved.
+ */
+
+/*
+ * Synchronized lease exerciser
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <malloc.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+
+#include <unistd.h>
+#include <sys/types.h>
+#include <netdb.h>
+#include <endian.h>
+#include <byteswap.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+
+#define     HEX_2_ASC(x)    ((x) > 9) ? (x)-10+'a' : (x)+'0'
+#define 	FILE_SIZE	1024
+#define PLATFORM_INIT()     /*no-op*/
+#define PLATFORM_CLEANUP()  /*no-op*/
+#define LL                  "ll"
+
+extern int h_errno;
+
+#define inet_aton(STRING, INADDRP) \
+    (((INADDRP)->s_addr = inet_addr(STRING)) == -1 ? 0 : 1)
+
+/* this assumes 32 bit pointers */
+#define PTR_TO_U64(P) ((unsigned __int64)(unsigned int)(P))
+#define U64_TO_PTR(T,U) ((T)(void *)(unsigned int)(U))
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define bswap_uint16(x)         (uint16_t)bswap_16(x)
+#define bswap_uint32(x)         (uint32_t)bswap_32(x)
+#define bswap_uint64(x)         (uint64_t)bswap_64(x)
+#else
+#define bswap_uint16(x)         x
+#define bswap_uint32(x)         x
+#define bswap_uint64(x)         x
+#endif
+
+#define SOCKET              int
+#define SOCKET_READ         read
+#define SOCKET_WRITE        write
+#define SOCKET_CLOSE(S)     (close(S))
+#define INVALID_SOCKET      -1
+
+#define O_BINARY            0
+       
+#define HANDLE              int
+#define INVALID_HANDLE      -1
+#define SEEK(H, O)          (lseek(H, O, SEEK_SET))
+#define READ(H, B, L)       (read(H, B, L))
+#define WRITE(H, B, L)      (write(H, B, L))
+#define CLOSE(H)            (close(H))
+
+#define RAND()              (rand())
+#define SRAND(s)            (srand(s))
+#define SLEEP(s)            (sleep(s))
+
+#define MIN(A,B)            (((A)<(B))?(A):(B))
+#define MAX(A,B)            (((A)>(B))?(A):(B))
+
+#define ALLOC_ALIGNED(S)    (memalign(65536, S)) 
+#define FREE_ALIGNED(P)     (free(P)) 
+
+static char	*prog;
+static char	*filename = 0;
+static int	debug = 0;
+static int	server = 1;
+static int	port = 0;
+static int 	testnumber = -1;
+static int	saved_errno = 0;
+static int      got_sigio = 0;
+
+static SOCKET	s_fd = -1;              /* listen socket    */
+static SOCKET	c_fd = -1;	        /* IPC socket       */
+static HANDLE	f_fd = INVALID_HANDLE;	/* shared file      */
+
+#define 	CMD_SETLEASE	0
+#define 	CMD_GETLEASE	1
+#define		CMD_CLOSE	2
+#define		CMD_OPEN	3
+#define		CMD_SIGIO	4
+#define		CMD_WAIT_SIGIO	5
+
+#define		PASS 	1
+#define		FAIL	0
+
+#define		SERVER	0
+#define		CLIENT	1
+
+#define		TEST_NUM	0
+#define		COMMAND		1
+#define		ARG		2
+#define		FLAGS		ARG /* Arg and flags are used the same */
+#define		RESULT		3
+#define		WHO		4
+
+static char *get_cmd_str(int cmd)
+{
+	switch (cmd) {
+		case CMD_SETLEASE: return "Set Lease"; break;
+		case CMD_GETLEASE: return "Get Lease"; break;
+		case CMD_CLOSE:    return "Close"; break;
+		case CMD_OPEN:     return "Open"; break;
+	}
+	return "unknown";
+}
+
+/*
+ * When adding tests be sure to add to both the descriptions AND tests array. 
+ * Also, be sure to undo whatever is set for each test (eg unlock any locks)
+ * There is no need to have a matching client command for each server command
+ * (or vice versa)
+ */
+
+char *descriptions[] = {
+    /*  1 */"Take Read Lease",
+    /*  2 */"Take Write Lease",
+    /*  3 */"Fail Write Lease if file is open somewhere else",
+    /*  4 */"Fail Read Lease if opened with write permissions",
+    /*  5 */"Read lease gets SIGIO on write open",
+    /*  6 */"Write lease gets SIGIO on read open",
+    /*  7 */"No SIGIO is sent with read lock on read open",
+    /*  8 */"Read lease gets SIGIO on write open",
+};
+
+static int64_t tests[][5] =
+	/*	test #	Cmd		Arg|Flags	Result		Server|Client */
+	{ 	
+	/* Various simple tests exercising the list */
+
+/* SECTION 1: Simple verification of being able to take leases */
+	/* Take Read Lease */
+		{1,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+		{1,	CMD_OPEN,	O_RDONLY,	PASS,		CLIENT	},
+		{1,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{1,	CMD_OPEN,	O_RDONLY,	PASS,		SERVER	},
+		{1,	CMD_SETLEASE,	F_RDLCK,	PASS,		SERVER	},
+		{1,	CMD_GETLEASE,	F_RDLCK,	PASS,		SERVER	},
+		{1,	CMD_SETLEASE,	F_UNLCK,	PASS,		SERVER	},
+		{1,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{1,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+	/* Take Write Lease */
+		{2,	CMD_OPEN,	O_RDWR,		PASS,		SERVER	},
+		{2,	CMD_SETLEASE,	F_WRLCK,	PASS,		SERVER	},
+		{2,	CMD_GETLEASE,	F_WRLCK,	PASS,		SERVER	},
+		{2,	CMD_SETLEASE,	F_UNLCK,	PASS,		SERVER	},
+		{2,	CMD_CLOSE,	0,		PASS,		SERVER	},
+	/* Fail Write Lease with other users */
+		{3,	CMD_OPEN,	O_RDONLY,	PASS,		CLIENT  },
+		{3,	CMD_OPEN,	O_RDWR,		PASS,		SERVER	},
+		{3,	CMD_SETLEASE,	F_WRLCK,	FAIL,		SERVER	},
+		{3,	CMD_GETLEASE,	F_WRLCK,	FAIL,		SERVER	},
+		{3,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{3,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+	/* Fail Read Lease if opened for write */
+		{4,	CMD_OPEN,	O_RDWR,		PASS,		SERVER	},
+		{4,	CMD_SETLEASE,	F_RDLCK,	FAIL,		SERVER	},
+		{4,	CMD_GETLEASE,	F_RDLCK,	FAIL,		SERVER	},
+		{4,	CMD_CLOSE,	0,		PASS,		SERVER	},
+
+/* SECTION 2: Proper SIGIO notifications */
+	/* Get SIGIO when read lease is broken by write */
+		{5,	CMD_OPEN,	O_RDONLY,	PASS,		CLIENT	},
+		{5,	CMD_SETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{5,	CMD_GETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{5,	CMD_SIGIO,	0,		PASS,		CLIENT	},
+		{5,	CMD_OPEN,	O_RDWR,		PASS,		SERVER	},
+		{5,	CMD_WAIT_SIGIO,	5,		PASS,		CLIENT	},
+		{5,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{5,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+
+	/* Get SIGIO when write lease is broken by read */
+		{6,	CMD_OPEN,	O_RDWR,		PASS,		CLIENT	},
+		{6,	CMD_SETLEASE,	F_WRLCK,	PASS,		CLIENT	},
+		{6,	CMD_GETLEASE,	F_WRLCK,	PASS,		CLIENT	},
+		{6,	CMD_SIGIO,	0,		PASS,		CLIENT	},
+		{6,	CMD_OPEN,	O_RDONLY,	PASS,		SERVER	},
+		{6,	CMD_WAIT_SIGIO,	5,		PASS,		CLIENT	},
+		{6,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{6,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+
+	/* Don't get SIGIO when read lease is taken by read */
+		{7,	CMD_OPEN,	O_RDONLY,	PASS,		CLIENT	},
+		{7,	CMD_SETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{7,	CMD_GETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{7,	CMD_SIGIO,	0,		PASS,		CLIENT	},
+		{7,	CMD_OPEN,	O_RDONLY,	PASS,		SERVER	},
+		{7,	CMD_WAIT_SIGIO,	5,		FAIL,		CLIENT	},
+		{7,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{7,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+
+	/* Get SIGIO when Read lease is broken by Write */
+		{8,	CMD_OPEN,	O_RDONLY,	PASS,		CLIENT	},
+		{8,	CMD_SETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{8,	CMD_GETLEASE,	F_RDLCK,	PASS,		CLIENT	},
+		{8,	CMD_SIGIO,	0,		PASS,		CLIENT	},
+		{8,	CMD_OPEN,	O_RDWR,		PASS,		SERVER	},
+		{8,	CMD_WAIT_SIGIO,	5,		PASS,		CLIENT	},
+		{8,	CMD_CLOSE,	0,		PASS,		SERVER	},
+		{8,	CMD_CLOSE,	0,		PASS,		CLIENT	},
+
+	/* indicate end of array */
+	/* Must have an end for the SERVER and one for the CLIENT */
+		{0,0,0,0,SERVER},
+		{0,0,0,0,CLIENT}
+	};
+
+static struct {
+    int32_t		index;
+    int32_t		test;
+    int32_t		command;
+    int32_t		arg;
+    int32_t		result;
+    int32_t		error;
+} ctl;
+
+
+void
+usage(void)
+{
+    fprintf(stderr, "Usage: %s [options] sharedfile\n\
+\n\
+options:\n\
+  -p port	TCP/IP port number for client-server communication\n\
+  -d		enable debug tracing\n\
+  -n #		test number to run\n\
+  -h host	run as client and connect to server on remote host\n\
+  		[default run as server]\n", prog);
+    exit(1);
+}
+
+#define INIT_BUFSZ 512 
+
+void
+initialize(HANDLE fd)
+{
+    char*	ibuf;
+    int		j=0;
+    int		nwrite;
+    int 	offset = 0;
+    int 	togo = FILE_SIZE;
+
+    ibuf = (char*)malloc(INIT_BUFSZ);
+    memset(ibuf, ':', INIT_BUFSZ);
+
+    SEEK(fd, 0L);
+    while (togo) {
+	offset+=j;
+	j = togo > INIT_BUFSZ ? INIT_BUFSZ : togo;
+
+	if ((nwrite = WRITE(fd, ibuf, j)) != j) {
+	    if (nwrite < 0)
+		perror("initialize write:");
+	    else
+		fprintf(stderr, "initialize: write() returns %d, not %d as expected\n", 
+                        nwrite, j);
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+	togo -= j;
+    }
+}
+
+void release_lease(int fd)
+{
+	int rc;
+
+	rc = fcntl(fd, F_SETLEASE, F_UNLCK);
+	if (debug && rc != 0) {
+		fprintf(stderr, "Failed to remove lease %d : %d %s\n",
+			rc, errno, strerror(errno));
+	}
+}
+
+void lease_break(int sig, siginfo_t *info, void *p)
+{
+    if (debug > 1) {
+	fprintf(stderr, "lease break %d %p fd %d\n",
+		sig, info, info->si_fd);
+    }
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
+	if (debug) {
+		fprintf(stderr, "Set '%s' sigaction on %d\n",
+			strsignal(SIGIO), fd);
+	}
+
+	rc = fcntl(fd, F_SETSIG, SIGIO);
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
+    return (got_sigio ? PASS: FAIL);
+}
+
+int do_open(int flag)
+{
+    int flags = flag|O_CREAT|O_BINARY;
+
+    if(debug > 1) {
+	fprintf(stderr, "do_open %s 0x%x\n", filename, flags);
+    }
+
+    if ((f_fd = open(filename, flags, 0666)) == INVALID_HANDLE) {
+	perror("shared file create");
+	return FAIL;
+	/*NOTREACHED*/
+    }
+    return PASS;
+}
+
+static int do_lease(int cmd, int arg, int expected)
+{
+    int ret;
+
+    if(debug > 1) {
+	fprintf(stderr, "do_lease: cmd=%d arg=%d exp=%X\n",
+		cmd, arg, expected);
+    }
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
+	fprintf(stderr, "do_lease: ret = %d, errno = %d (%s)\n",
+		ret, errno, strerror(errno));
+
+    return(ret==0?PASS:FAIL);
+}
+
+int do_close(void)
+{	
+    if(debug > 1) {
+	fprintf(stderr, "do_close\n");
+    }
+
+    errno =0;
+    CLOSE(f_fd);
+    f_fd = INVALID_HANDLE;
+
+    saved_errno = errno;	    
+	
+    if (errno)
+	return FAIL;
+    return PASS;
+}
+
+static void init_ctl(int32_t index)
+{
+    ctl.test= (int32_t)tests[index][TEST_NUM];
+    ctl.command = (int32_t)tests[index][COMMAND];
+    ctl.arg = (int32_t)tests[index][ARG];
+    ctl.index = index;
+    ctl.result = (int32_t)tests[index][RESULT];
+    ctl.error = 0;
+}
+
+void
+send_ctl(void)
+{
+    int         nwrite;
+
+    if (debug > 1) {
+	fprintf(stderr, "send_ctl: test=%d, cmd=%d, arg=%d, index=%d, result=%d, error=%d\n", 
+                ctl.test, ctl.command, ctl.arg, ctl.index, ctl.result, ctl.error);
+    }
+
+    ctl.test= bswap_uint32(ctl.test);
+    ctl.command = bswap_uint32(ctl.command);
+    ctl.arg = bswap_uint32(ctl.arg);
+    ctl.index = bswap_uint32(ctl.index);
+    ctl.result = bswap_uint32(ctl.result);
+    ctl.error = bswap_uint32(ctl.error);
+    nwrite = SOCKET_WRITE(c_fd, (char*)&ctl, sizeof(ctl));
+
+    ctl.test= bswap_uint32(ctl.test);
+    ctl.command = bswap_uint32(ctl.command);
+    ctl.arg = bswap_uint32(ctl.arg);
+    ctl.index= bswap_uint32(ctl.index);
+    ctl.result = bswap_uint32(ctl.result);
+    ctl.error= bswap_uint32(ctl.error);
+    if (nwrite != sizeof(ctl)) {
+        if (nwrite < 0)
+            perror("send_ctl: write");
+        else
+            fprintf(stderr, "send_ctl[%d]: write() returns %d, not %zu as expected\n", 
+                    ctl.test, nwrite, sizeof(ctl));
+        exit(1);
+        /*NOTREACHED*/
+    }
+}
+
+void recv_ctl(void)
+{
+    int         nread;
+
+again:
+    if ((nread = SOCKET_READ(c_fd, (char*)&ctl, sizeof(ctl))) != sizeof(ctl)) {
+        if (nread < 0) {
+	    if (errno == EINTR)
+		goto again;
+            perror("recv_ctl: read");
+        } else {
+            fprintf(stderr, "recv_ctl[%d]: read() returns %d, not %zu as expected\n", 
+                    ctl.test, nread, sizeof(ctl));
+	    fprintf(stderr, "socket might has been closed by other leasetest\n");
+	} 
+        exit(1);
+        /*NOTREACHED*/
+    }
+    ctl.test= bswap_uint32(ctl.test);
+    ctl.command = bswap_uint32(ctl.command);
+    ctl.arg = bswap_uint32(ctl.arg);
+    ctl.index= bswap_uint32(ctl.index);
+    ctl.result = bswap_uint32(ctl.result);
+    ctl.error= bswap_uint32(ctl.error);
+
+    if (debug > 1) {
+	fprintf(stderr, "recv_ctl: test=%d, cmd=%d arg=%d, index=%d, result=%d, error=%d\n", 
+                ctl.test, ctl.command, ctl.arg, ctl.index, ctl.result, ctl.error);
+    }
+}
+
+void
+cleanup(void)
+{
+    if (f_fd>=0)
+        CLOSE(f_fd);
+    
+    if (c_fd>=0)
+        SOCKET_CLOSE(c_fd);
+    
+    if (s_fd>=0)
+        SOCKET_CLOSE(s_fd);
+    
+    PLATFORM_CLEANUP();
+}
+
+int
+main(int argc, char *argv[])
+{
+    int		i, sts;
+    int		c;
+    struct sockaddr_in	myAddr;
+    struct linger	noLinger = {1, 0};
+    char	*host = NULL;
+    char	*endnum;
+    int		errflag = 0;
+    char	*p;
+    extern char	*optarg;
+    extern int	optind;
+    int fail_count = 0;; 
+    
+    atexit(cleanup);
+    
+    PLATFORM_INIT();
+
+    /* trim command name of leading directory components */
+    prog = argv[0];
+    for (p = prog; *p; p++) {
+	if (*p == '/')
+	    prog = p+1;
+    }
+
+    while ((c = getopt(argc, argv, "dn:h:p:?")) != EOF) {
+	switch (c) {
+
+	case 'd':	/* debug flag */
+	    debug++;
+	    break;
+
+	case 'h':	/* (server) hostname */
+	    server = 0;
+	    host = optarg;
+	    break;
+
+	case 'n':
+	    testnumber = atoi(optarg);
+	    break;
+
+	case 'p':	/* TCP/IP port */
+	    port = (int)strtol(optarg, &endnum, 10);
+	    if (*endnum != '\0') {
+		fprintf(stderr, "%s: -p argument must be a numeric\n", 
+                        prog);
+		exit(1);
+		/*NOTREACHED*/
+	    }
+	    break;
+
+	case '?':
+	default:
+	    errflag++;
+	    break;
+	}
+    }
+
+    if (errflag || optind != argc-1) {
+	usage();
+	/*NOTREACHED*/
+    }
+
+    filename=argv[optind];
+    if (debug)
+	fprintf(stderr, "Working on file : %s\n", filename);
+    if (do_open(O_RDWR) == FAIL)
+	exit(1);
+
+    setbuf(stderr, NULL);
+
+    if (server) {
+        int one = 1;
+        
+	s_fd = socket(AF_INET, SOCK_STREAM, 0);
+	if (s_fd == INVALID_SOCKET) {
+	    perror("socket");
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+	if (setsockopt(s_fd, IPPROTO_TCP, TCP_NODELAY, (char*)&one, sizeof(one)) < 0) {
+	    perror("setsockopt(nodelay)");
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+        if (setsockopt(s_fd, SOL_SOCKET, SO_REUSEADDR, (char*)&one, sizeof(one))<0) {
+            perror("setsockopt(reuseaddr)");
+            exit(1);
+            /*NOTREACHED*/
+        }
+#ifdef SO_REUSEPORT
+        if (setsockopt(s_fd, SOL_SOCKET, SO_REUSEPORT, (char*)&one, sizeof(one))<0) {
+            perror("setsockopt(reuseport)");
+            exit(1);
+            /*NOTREACHED*/
+        }
+#endif
+
+	memset(&myAddr, 0, sizeof(myAddr));
+	myAddr.sin_family = AF_INET;
+	myAddr.sin_addr.s_addr = htonl(INADDR_ANY);
+	myAddr.sin_port = htons((short)port);
+	sts = bind(s_fd, (struct sockaddr*)&myAddr, sizeof(myAddr));
+	if (sts < 0) {
+	    perror("bind");
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+
+	sts = listen(s_fd, 5);	/* Max. of 5 pending connection requests */
+	if (sts == -1) {
+	    perror("listen");
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+
+	if (port == 0) {
+	        socklen_t addr_len = sizeof(myAddr);
+
+		if (getsockname(s_fd, &myAddr, &addr_len)) {
+		    perror("getsockname");
+		    exit(1);
+		}
+
+		port = ntohs(myAddr.sin_port);
+	}
+
+	printf("server port: %d\n", port);
+	fflush(stdout);
+
+	c_fd = accept(s_fd, NULL, NULL);
+	if (c_fd == INVALID_SOCKET) {
+	    perror("accept");
+	    exit(1);
+	    /*NOTREACHED*/
+	}
+
+	if (debug) fprintf(stderr, "Client accepted\n");
+	SRAND(12345L);
+    }
+    else { /* Client initialization */
+        struct hostent  *servInfo;
+
+        if ((servInfo = gethostbyname(host)) == NULL) {
+	    printf("Couldn't get hostbyname for %s", host);
+	    if (h_errno == HOST_NOT_FOUND)
+		printf(": host not found");
+	    printf("\n");
+            exit(1);
+            /*NOTREACHED*/
+        }
+
+        c_fd = socket(AF_INET, SOCK_STREAM, 0);
+        if (c_fd == INVALID_SOCKET) {
+            perror("socket");
+            exit(1);
+            /*NOTREACHED*/
+        }
+        /* avoid 200 ms delay */
+        if (setsockopt(c_fd, IPPROTO_TCP, TCP_NODELAY, (char *)&i, sizeof(i)) < 0) {
+            perror("setsockopt(nodelay)");
+            exit(1);
+            /*NOTREACHED*/
+        }
+        /* Don't linger on close */
+        if (setsockopt(c_fd, SOL_SOCKET, SO_LINGER, (char *)&noLinger, sizeof(noLinger)) < 0) {
+            perror("setsockopt(nolinger)");
+            exit(1);
+            /*NOTREACHED*/
+        }
+
+	memset(&myAddr, 0, sizeof(myAddr));	/* Arrgh! &myAddr, not myAddr */
+	myAddr.sin_family = AF_INET;
+	memcpy(&myAddr.sin_addr, servInfo->h_addr, servInfo->h_length);
+	myAddr.sin_port = htons((short)port);
+
+	if (connect(c_fd, (struct sockaddr*)&myAddr, sizeof(myAddr)) < 0) {
+            perror("unable to connect");
+            fprintf(stderr, "Server might still initializing the shared file\n ");
+            exit(1);
+            /*NOTREACHED*/
+	}
+
+	if (debug) fprintf(stderr, "Connected to server\n");
+	SRAND(6789L);
+    }
+
+    if (server)
+	/* only server need do shared file */
+	initialize(f_fd);
+
+    /*
+     * TCP/IP connection to be established, safe to proceed.
+     *
+     * real work is in here ...
+     */
+    i = 0;
+{
+    int index = 0;
+    int end = 0;
+    int result = 0;
+    int last_test = 0;
+    int test_count = 0;
+    int fail_flag = 0;
+    while(!end) {
+	if (server) {
+	    if(testnumber > 0) {
+		last_test = testnumber - 1;
+		while(tests[index][TEST_NUM] != testnumber && tests[index][TEST_NUM] != 0) {
+		    index++;
+		}
+	    }
+	    /* If we have a server command, deal with it */
+	    if(tests[index][WHO] == SERVER) {
+		if(debug>1)
+		    fprintf(stderr, "Got a server command (%d)\n", index);
+		if(tests[index][TEST_NUM] == 0) {
+		    index++;
+		    continue;
+		} 
+		memset(&ctl, 0, sizeof(ctl));
+		ctl.test = tests[index][TEST_NUM];
+
+		if(tests[index][TEST_NUM] != 0) {
+		    switch(tests[index][COMMAND]) {
+			case CMD_SETLEASE:
+			    result = do_lease(F_SETLEASE, tests[index][ARG], 0);
+			    break;
+			case CMD_GETLEASE:
+			    result = do_lease(F_GETLEASE, tests[index][ARG], tests[index][ARG]);
+			    break;
+			case CMD_CLOSE:
+			    result = do_close();
+			    break;
+			case CMD_OPEN:
+			    result = do_open(tests[index][FLAGS]);
+			    break;
+			default:
+			    result = !tests[index][RESULT];
+			    break;
+		    }
+		    if( result != tests[index][RESULT]) {
+			fail_flag++;
+			/* We have a failure */
+			if(debug)
+			    fprintf(stderr, "Server failure in test %d, while %sing - err = %d:%s\n", 
+					ctl.test,
+					get_cmd_str(tests[index][COMMAND]),
+					saved_errno, strerror(saved_errno));
+			fprintf(stderr, "Server failure in %lld:%s\n",
+					(long long)tests[index][TEST_NUM],
+					descriptions[tests[index][TEST_NUM] - 1]);
+		    }
+		}
+	    /* else send it off to the client */
+	    } else if (tests[index][WHO] == CLIENT) {
+		if(tests[index][TEST_NUM] == 0)
+		    end=1;
+
+		/* get the client to do something */
+		init_ctl(index);
+		if(debug > 1)
+		    fprintf(stderr, "Sending command to client (%d) - %s\n", 
+					index,
+					get_cmd_str(ctl.command));
+		send_ctl();
+
+		if(!end) {
+		    /* Get the clients response */
+		    recv_ctl();
+		    /* this is the whether the test passed or failed,
+		     * not what the command returned */
+		    if( ctl.result == FAIL ) {
+			fail_flag++;
+			if(debug)
+			    fprintf(stderr, "Client failure in test %d, while %sing - err = %d:%s\n",
+					ctl.test, get_cmd_str(ctl.command),
+					ctl.error, strerror(ctl.error));
+			fprintf(stderr, "Client failure in %d:%s\n",
+					ctl.test, descriptions[ctl.test - 1]);
+		    }
+		}
+	    }
+	    if (debug > 1) {
+		fprintf(stderr, "server sleeping ...\n");
+		SLEEP(1);
+	    }
+	    if(tests[index][TEST_NUM] != 0) {
+		if(last_test != tests[index][TEST_NUM]) {
+		    test_count++;
+		    if(fail_flag)
+			fail_count++;
+		    fail_flag = 0;
+
+		}
+		last_test = tests[index][TEST_NUM];
+	    }
+		
+	    index++;
+	} else { /* CLIENT */
+	    if(debug > 2)
+		fprintf(stderr,"client: waiting...\n");
+	    /* wait for the server to do something */
+	    recv_ctl();
+
+	    /* check for a client command */
+	    index = ctl.index;
+	    if (tests[index][WHO] != CLIENT) { 
+		fprintf(stderr, "not a client command index (%d)\n", index);
+		exit(1);
+	    }
+		
+	    if(ctl.test == 0) {
+		end = 1;
+		break;
+	    }
+
+	    switch(ctl.command) {
+		case CMD_SETLEASE:
+		    result = do_lease(F_SETLEASE, ctl.arg, 0);
+		    break;
+		case CMD_GETLEASE:
+		    result = do_lease(F_GETLEASE, ctl.arg, ctl.arg);
+		    break;
+		case CMD_CLOSE:
+		    result = do_close();
+		    break;
+		case CMD_OPEN:
+		    result = do_open(tests[index][FLAGS]);
+		    break;
+		case CMD_SIGIO:
+		    result = do_setup_sigio(f_fd);
+		    break;
+		case CMD_WAIT_SIGIO:
+		    result = do_wait_sigio(ctl.arg);
+		    break;
+	    }
+	    if( result != ctl.result ) {
+		if(debug)
+		    fprintf(stderr,"Got %d, wanted %d\n",
+				result, ctl.result);
+		ctl.result = FAIL;
+		ctl.error = saved_errno;
+		fail_count++;
+	    } else {
+		ctl.result = PASS;
+		ctl.error = 0;
+	    }
+	    if(debug > 2)
+		fprintf(stderr,"client: sending result to server (%d)\n", ctl.index);
+	    /* Send result to the server */
+	    send_ctl();
+	    if(tests[index][TEST_NUM] != 0) {
+		if(last_test != tests[index][TEST_NUM])
+		    test_count++;
+		last_test = tests[index][TEST_NUM];
+	    }
+	}
+    }
+    if(server)
+	printf("%d tests run, %d failed\n", test_count, fail_count);
+}
+    
+    exit(fail_count);
+    /*NOTREACHED*/
+}
+
+
-- 
2.20.1
