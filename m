Received: from mail-pa0-f42.google.com ([209.85.220.42]:36556 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423712AbcFHSxZ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2016 14:53:25 -0400
Received: by mail-pa0-f42.google.com with SMTP id b5so4886650pas.3
        for <fstests@vger.kernel.org>; Wed, 08 Jun 2016 11:53:25 -0700 (PDT)
From: Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH] generic/131: dynamically allocate tcp listen port to avoid port clashes
Date: Wed,  8 Jun 2016 11:52:41 -0700
Message-Id: <1465411961-12707-1-git-send-email-tahsin@google.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Tahsin Erdogan <tahsin@google.com>
List-ID: <fstests@vger.kernel.org>

Current port selection algorithm is bound to have port clashes. To
eliminate clashes, let server pick an unused port and report it on
stdout.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
 src/locktest.c    | 16 +++++++++++++++-
 tests/generic/131 | 17 +++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/src/locktest.c b/src/locktest.c
index adf8ce0..eab48e2 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -95,7 +95,7 @@ static char	*filename = 0;
 static int	debug = 0;
 static int	server = 1;
 static int	maxio = 8192;
-static int	port = 7890;
+static int	port = 0;
 static int 	testnumber = -1;
 static int	saved_errno = 0;
 
@@ -899,6 +899,20 @@ main(int argc, char *argv[])
 	    /*NOTREACHED*/
 	}
 
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
 	c_fd = accept(s_fd, NULL, NULL);
 	if (c_fd == INVALID_SOCKET) {
 	    perror("accept");
diff --git a/tests/generic/131 b/tests/generic/131
index 3bcb0d1..d64ba55 100755
--- a/tests/generic/131
+++ b/tests/generic/131
@@ -49,21 +49,18 @@ _require_test_fcntl_advisory_locks
 
 TESTFILE=$TEST_DIR/lock_file
 
-# Grab a port which is hopefully unused
-if [ $$ -gt 1024 -a $$ -lt 32000 ]; then
-    PORT=$$
-elif [ $$ -lt 1024 ]; then
-    PORT=$(($$+1024))
-elif [ $$ -gt 32000 ]; then
-    PORT=$(($$%30000+1024))
-fi
-
 # Start the server
-src/locktest -p $PORT $TESTFILE 2>&1 > $TEST_DIR/server.out &
+src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
 locktest_pid1=$!
 
 sleep 1
 
+PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
+if [ -z $PORT ]; then
+	echo "Could not get server port"
+	exit 1
+fi
+
 # Start the client
 src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
 locktest_pid2=$!
-- 
2.8.0.rc3.226.g39d4020

