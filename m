Received: from mx1.redhat.com ([209.132.183.28]:50168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755575AbdKJCrE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Nov 2017 21:47:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0548DC04AC5B
        for <fstests@vger.kernel.org>; Fri, 10 Nov 2017 02:47:04 +0000 (UTC)
From: Xiong Zhou <xzhou@redhat.com>
Subject: [PATCH v5] generic: add OFD lock tests
Date: Fri, 10 Nov 2017 10:46:55 +0800
Message-Id: <1510282015-9907-1-git-send-email-xzhou@redhat.com>
In-Reply-To: <20171028092955.GA17339@eguan.usersys.redhat.com>
References: <20171028092955.GA17339@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Xiong Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test OFD locks. Use fcntl F_OFD_SETLK/F_OFD_GETLK, to verify
we are being given correct advices through getlk by kernel.

The basic idea is placing lock L0 on an opened testfile
in process P0, then fork(), so this lock is inherited into
its child process P1 if it is OFD lock.

In parent P0, we close the fd then tell getlk to go.
In child  P1, we keep holding the lock till getlk done.

In another process P2, do fcntl getlk with lock L1 after
P0 has closed the fd and while P1 is holding the lock.

If we set a POSIX lock, it will be released completely in
both P0 and P1 by closing that fd.

In the end, we check the returned flock.l_type by getlk
to see if the lock mechanism works fine.

We can test different combainations by specify different lock
types, lock range, POSIX or OFD lock, and these situations:
  + that the two locks are conflicting or not;
  + one OFD lock and one POSIX lock;
  + that open testfile RDONLY or RDWR.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---

v5:
  Add fork() and close fd in setlk routine;
  Add test racing with posix lock;
  Only init the sem set in setlk routine;
  Add checking for sem set is newly created;
  Add checking for sem_otime to avoid the race;
  Wait setlk routine pid in test script;
  More comments.


 .gitignore            |   1 +
 common/rc             |  11 ++
 src/Makefile          |   3 +-
 src/t_ofd_locks.c     | 419 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/467     | 209 +++++++++++++++++++++++++
 tests/generic/467.out |  31 ++++
 tests/generic/group   |   1 +
 7 files changed, 674 insertions(+), 1 deletion(-)
 create mode 100644 src/t_ofd_locks.c
 create mode 100755 tests/generic/467
 create mode 100644 tests/generic/467.out

diff --git a/.gitignore b/.gitignore
index 2014c08..77acb42 100644
--- a/.gitignore
+++ b/.gitignore
@@ -126,6 +126,7 @@
 /src/t_mmap_write_ro
 /src/t_mmap_writev
 /src/t_mtab
+/src/t_ofd_locks
 /src/t_readdir_1
 /src/t_readdir_2
 /src/t_rename_overwrite
diff --git a/common/rc b/common/rc
index 0de1db4..f90ceb9 100644
--- a/common/rc
+++ b/common/rc
@@ -3195,6 +3195,17 @@ _require_test_fcntl_advisory_locks()
 		_notrun "Require fcntl advisory locks support"
 }
 
+_require_ofd_locks()
+{
+	# Give a test run by getlk wrlck on testfile.
+	# If the running kernel does not support OFD locks,
+	# EINVAL will be returned.
+	_require_test_program "t_ofd_locks"
+	touch $TEST_DIR/ofd_testfile
+	src/t_ofd_locks -t $TEST_DIR/ofd_testfile > /dev/null 2>&1
+	[ $? -eq 22 ] && _notrun "Require OFD locks support"
+}
+
 _require_test_lsattr()
 {
 	testio=$(lsattr -d $TEST_DIR 2>&1)
diff --git a/src/Makefile b/src/Makefile
index 3eb25b1..f37af74 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,7 +13,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	multi_open_unlink dmiperf unwritten_sync genhashnames t_holes \
 	t_mmap_writev t_truncate_cmtime dirhash_collide t_rename_overwrite \
 	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
-	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro
+	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
+	t_ofd_locks
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
new file mode 100644
index 0000000..9133047
--- /dev/null
+++ b/src/t_ofd_locks.c
@@ -0,0 +1,419 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/ipc.h>
+#include <sys/sem.h>
+
+/*
+ * In distributions that do not have these macros ready in
+ * glibc-headers, compilation fails. Adding them here to avoid
+ * build errors, relevant tests would fail at the helper which
+ * requires OFD locks support and notrun if the kernel does not
+ * support OFD locks. If the kernel does support OFD locks,
+ * we are good to go.
+ *
+ */
+#ifndef F_OFD_GETLK
+#define F_OFD_GETLK    36
+#endif
+
+#ifndef F_OFD_SETLK
+#define F_OFD_SETLK    37
+#endif
+
+#ifndef F_OFD_SETLKW
+#define F_OFD_SETLKW   38
+#endif
+
+/*
+ * Usually we run getlk routine after running setlk routine
+ * in background. However, getlk could be executed before setlk
+ * sometimes, which is invalid for our tests. So we use semaphore
+ * to synchronize between getlk and setlk.
+ *
+ * When set OFD   lock, it will be held after close fd.
+ *
+ * When set POSIX lock, it will be released after close fd.
+ *
+ * setlk routine:				 * getlk routine:
+ *						 *
+ *   start					 *   start
+ *     |					 *     |
+ *  open file					 *  open file
+ *     |					 *     |
+ *  init sem					 *     |
+ *     |					 *     |
+ * wait init sem done				 * wait init sem done
+ *     |					 *     |
+ *   setlk					 *     |
+ *     |					 *     |
+ *     |------------fork()---------|		 *     |
+ *     |                           |		 *     |
+ *     |(child)            (parent)|		 *     |
+ *     |                           |		 *     |
+ *     |                      close fd		 *     |
+ *     |                           |		 *     |
+ *     |                     set sem0=0          * wait sem0==0
+ *     |                           |		 *     |
+ *     |                           |		 *   getlk
+ *     |                           |		 *     |
+ *  wait sem1==0                   |    	 *  set sem1=0
+ *     |                           |		 *     |
+ *    exit                   wait child 	 *     |
+ *                                 |		 *  check result
+ *                             cleanup  	 *     |
+ *                                 |		 *     |
+ *                               exit		 *    exit
+ */
+
+/* This is required by semctl to set semaphore value */
+union semun {
+	int              val;    /* Value for SETVAL */
+	struct semid_ds *buf;    /* Buffer for IPC_STAT, IPC_SET */
+	unsigned short  *array;  /* Array for GETALL, SETALL */
+	struct seminfo  *__buf;  /* Buffer for IPC_INFO
+				    (Linux-specific) */
+};
+
+int fd;
+int semid;
+
+static void err_exit(char *op, int errn)
+{
+	fprintf(stderr, "%s: %s\n", op, strerror(errn));
+	if (fd > 0)
+		close(fd);
+	if (semid > 0 && semctl(semid, 2, IPC_RMID) == -1)
+		perror("exit rmid");
+	exit(errn);
+}
+
+/*
+ * Six flags that used to specify operation details.
+ * They can be specified via command line options.
+ *
+ * option: -P
+ * posix : 1 <--> test posix lock
+ *	   0 <--> test OFD lock (default)
+ *
+ * option: -s/-g
+ * lock_cmd : 1 <--> setlk (default)
+ *	      0 <--> getlk
+ *
+ * option: -r/-w
+ * lock_rw : 1 <--> set/get wrlck (default)
+ *	     0 <--> set/get rdlck
+ *
+ * option: -o num
+ * lock_start : l_start to getlk
+ *
+ * option: -R/-W
+ * open_rw : 1 <--> open file RDWR (default)
+ *	     0 <--> open file RDONLY
+ *
+ * This option is for _require_ofd_locks helper, just do
+ * fcntl setlk then return errno.
+ * option: -t
+ * testrun : 1 <--> this is a testrun, return after setlk
+ *	     0 <--> this is not a testrun, run as usual
+ *
+ */
+static void usage(char *arg0)
+{
+	printf("Usage: %s [-sgrwo:l:RWPt] filename\n", arg0);
+	printf("\t-s/-g : to setlk or to getlk\n");
+	printf("\t-P : POSIX locks\n");
+	printf("\t-r/-w : set/get rdlck/wrlck\n");
+	printf("\t-o num : offset start to lock, default 0\n");
+	printf("\t-l num : lock length, default 10\n");
+	printf("\t-R/-W : open file RDONLY/RDWR\n\n");
+	printf("\tUsually we run a setlk routine in background and then\n");
+	printf("\trun a getlk routine to check. They must be paired, or\n");
+	printf("\ttest will hang.\n\n");
+	exit(0);
+}
+
+int main(int argc, char **argv)
+{
+	pid_t pid;
+	int posix = 0;
+	int lock_cmd = 1;
+	int lock_rw = 1;
+	int lock_start = 0;
+	int lock_l = 10;
+	int open_rw = 1;
+	int testrun = 0;
+	int setlk_macro = F_OFD_SETLKW;
+	int getlk_macro = F_OFD_GETLK;
+	struct timespec ts;
+
+	key_t semkey;
+	unsigned short vals[2];
+	union semun semu;
+	struct semid_ds sem_ds;
+	struct sembuf sop;
+	int opt, ret, retry;
+
+	while((opt = getopt(argc, argv, "sgrwo:l:PRWt")) != -1) {
+		switch(opt) {
+		case 's':
+			lock_cmd = 1;
+			break;
+		case 'g':
+			lock_cmd = 0;
+			break;
+		case 'r':
+			lock_rw = 0;
+			break;
+		case 'w':
+			lock_rw = 1;
+			break;
+		case 'o':
+			lock_start = atoi(optarg);
+			break;
+		case 'l':
+			lock_l = atoi(optarg);
+			break;
+		case 'P':
+			posix = 1;
+			break;
+		case 'R':
+			open_rw = 0;
+			break;
+		case 'W':
+			open_rw = 1;
+			break;
+		case 't':
+			testrun = 1;
+			break;
+		default:
+			usage(argv[0]);
+			return -1;
+		}
+	}
+
+	struct flock flk = {
+		.l_whence = SEEK_SET,
+		.l_start = lock_start,
+		.l_len = lock_l,     /* lock range [0,9] */
+		.l_type = F_RDLCK,
+	};
+
+	if (optind >= argc) {
+		usage(argv[0]);
+		return -1;
+	}
+
+	if (posix == 0) {
+		flk.l_pid = 0;
+		setlk_macro = F_OFD_SETLKW;
+		getlk_macro = F_OFD_GETLK;
+	} else {
+		setlk_macro = F_SETLKW;
+		getlk_macro = F_GETLK;
+	}
+
+	if (lock_rw == 1)
+		flk.l_type = F_WRLCK;
+	else
+		flk.l_type = F_RDLCK;
+
+	if (open_rw == 0)
+		fd = open(argv[optind], O_RDONLY);
+	else
+		fd = open(argv[optind], O_RDWR);
+	if (fd == -1)
+		err_exit("open", errno);
+
+	/*
+	 * In a testun, we do a fcntl getlk call and exit
+	 * immediately no matter it succeeds or not.
+	 */
+	if (testrun == 1) {
+		fcntl(fd, F_OFD_GETLK, &flk);
+		err_exit("test_ofd_getlk", errno);
+	}
+
+	if((semkey = ftok(argv[optind], 255)) == -1)
+		err_exit("ftok", errno);
+
+	/* setlk */
+	if (lock_cmd == 1) {
+		/*
+		 * Init the semaphore, with a key related to the
+		 * testfile. getlk routine will wait untill this sem
+		 * has been created and iniialized.
+		 *
+		 * We must make sure the semaphore set is newly created,
+		 * rather then the one left from last run. In which case
+		 * getlk will exit immediately and left setlk routine
+		 * waiting forever. Also because newly created semaphore
+		 * has zero sem_otime, which is used here to sync with
+		 * getlk routine.
+		 */
+		retry = 0;
+		do {
+			semid = semget(semkey, 2, IPC_CREAT|IPC_EXCL);
+			if (semid < 0 && errno == EEXIST) {
+				/* remove sem set after one round of test */
+				if (semctl(semid, 2, IPC_RMID, semu) == -1)
+					err_exit("rmid 0", errno);
+				retry++;
+			} else if (semid < 0)
+				err_exit("semget", errno);
+			else
+				retry = 10;
+		} while (retry < 5);
+		/* We can't create a new semaphore set in 5 tries */
+		if (retry == 5)
+			err_exit("semget", errno);
+
+		/* Init both new sem to 1 */
+		vals[0] = 1;
+		vals[1] = 1;
+		semu.array = vals;
+		if (semctl(semid, 2, SETALL, semu) == -1)
+			err_exit("init sem", errno);
+
+		/* Inc both new sem to 2 */
+		sop.sem_num = 0;
+		sop.sem_op = 1;
+		sop.sem_flg = 0;
+		ts.tv_sec = 15;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("inc sem0 2", errno);
+
+		sop.sem_num = 1;
+		sop.sem_op = 1;
+		sop.sem_flg = 0;
+		ts.tv_sec = 15;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("inc sem1 2", errno);
+
+		/*
+		 * Wait initialization complete. semctl(2) only update
+		 * sem_ctime, semop(2) will update sem_otime.
+		 */
+		ret = -1;
+		do {
+			memset(&sem_ds, 0, sizeof(sem_ds));
+			semu.buf = &sem_ds;
+			ret = semctl(semid, 0, IPC_STAT, semu);
+		} while (!(ret == 0 && sem_ds.sem_otime != 0));
+
+		if (fcntl(fd, setlk_macro, &flk) < 0)
+			err_exit("setlkw", errno);
+
+
+		/*
+		 * fork from here after sems have been initialized,
+		 * and lock has been placed.
+		 *
+		 * Then, in parent we close the fd then tell getlk to go;
+		 * in child we keep holding the lock till getlk done.
+		 *
+		 */
+		pid = fork();
+		if (pid > 0) {
+			/*
+			 * Release posix lock completely in parent and child.
+			 * OFD lock is still held by opened file in child.
+			 */
+			if (close(fd) == -1)
+				perror("close");
+
+			/* set sem0 = 0 (setlk and close fd done) */
+			semu.val = 0;
+			if (semctl(semid, 0, SETVAL, semu) == -1)
+				err_exit("set sem0 0", errno);
+
+			/* wait child done */
+			int status;
+			waitpid(pid, &status, 0);
+			exit(0);
+		}
+
+		/* hold lock and wait sem1 == 0 (getlk done) */
+		sop.sem_num = 1;
+		sop.sem_op = 0;
+		sop.sem_flg = 0;
+		ts.tv_sec = 15;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("wait sem1 0", errno);
+
+		/* remove sem set after one round of test */
+		if (semctl(semid, 2, IPC_RMID, semu) == -1)
+			err_exit("rmid", errno);
+
+		close(fd);
+		exit(0);
+	}
+
+	/* getlck */
+	if (lock_cmd == 0) {
+		/* wait sem created and initialized */
+		do {
+			semid = semget(semkey, 2, 0);
+			if (semid != -1)
+				break;
+			if (errno == ENOENT)
+				continue;
+			else
+				err_exit("getlk_semget", errno);
+		} while (1);
+
+		do {
+			memset(&sem_ds, 0, sizeof(sem_ds));
+			semu.buf = &sem_ds;
+			ret = semctl(semid, 0, IPC_STAT, semu);
+		} while (!(ret == 0 && sem_ds.sem_otime != 0));
+
+		/* wait sem0 == 0 (setlk and close fd done) */
+		sop.sem_num = 0;
+		sop.sem_op = 0;
+		sop.sem_flg = 0;
+		ts.tv_sec = 15;
+		ts.tv_nsec = 0;
+		if (semtimedop(semid, &sop, 1, &ts) == -1)
+			err_exit("wait sem0 0", errno);
+
+		if (fcntl(fd, getlk_macro, &flk) < 0)
+			err_exit("getlk", errno);
+
+		/* set sem1 = 0 (getlk done) */
+		semu.val = 0;
+		if (semctl(semid, 1, SETVAL, semu) == -1)
+			err_exit("set sem1 0", errno);
+
+		/* check result */
+		switch (flk.l_type) {
+		case F_UNLCK:
+			printf("lock could be placed\n");
+			break;
+		case F_RDLCK:
+			printf("get rdlck\n");
+			break;
+		case F_WRLCK:
+			printf("get wrlck\n");
+			break;
+		default:
+			printf("unknown lock type\n");
+			break;
+		}
+		close(fd);
+	}
+	return 0;
+}
diff --git a/tests/generic/467 b/tests/generic/467
new file mode 100755
index 0000000..972c40e
--- /dev/null
+++ b/tests/generic/467
@@ -0,0 +1,209 @@
+#! /bin/bash
+# FS QA Test 467
+#
+# Test OFD locks. Use fcntl F_OFD_SETLK/F_OFD_GETLK, to verify
+# we are being given correct advices through getlk by kernel.
+#
+# The basic idea is placing lock L0 on an opened testfile
+# in process P0, then fork(), so this lock is inherited into
+# its child process P1 if it is an OFD lock.
+
+# In parent P0, we close the fd then tell getlk to go.
+#
+# In child  P1, we keep holding the lock till getlk done.
+#
+# In another process P2, do fcntl getlk with lock L1 after
+# P0 has closed the fd and while P1 is holding the lock.
+#
+# If we set a POSIX lock, it will be released completely in
+# both P0 and P1 by closing that fd.
+#
+# In the end, we check the returned flock.l_type by getlk
+# to see if the lock mechanism works fine.
+#
+#  setlk routine:			 * getlk routine:
+#    start				 *   start
+#      |				 *     |
+#   open file				 *  open file
+#      |				 *     |
+#   init sem				 *     |
+#      |				 *     |
+#  wait init sem done			 * wait init sem done
+#      |				 *     |
+#    setlk				 *     |
+#      |				 *     |
+#      |---------fork()---------|	 *     |
+#      |                        |	 *     |
+#      |(child P1)   (parent P0)|	 *     | (P2)
+#      |                        |	 *     |
+#      |                   close fd	 *     |
+#      |                        |	 *     |
+#      |                 set sem0=0	 *  wait sem0==0
+#      |                        |	 *     |
+#      |                        |	 *   getlk
+#      |                        |	 *     |
+#   wait sem1==0                |    	 *  set sem1=0
+#      |                        |	 *     |
+#     exit                wait child 	 *     |
+#                               |	 *  check result
+#                           cleanup  	 *     |
+#                               |	 *     |
+#                             exit	 *    exit
+#
+# We can test different combainations by specify different lock
+# types, lock range, POSIX or OFD lock, and these situations:
+#	+ that the two locks are conflicting or not;
+#	+ one OFD lock and one POSIX lock,
+#		OFD   lock is inherited through fork
+#		POSIX lock is NOT inherited through fork
+#		OFD   lock will NOT be released by close fd in P0
+#		POSIX lock will be released by close fd in P0;
+#	+ that open testfile RDONLY or RDWR.
+#
+#-----------------------------------------------------------------------
+# Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#-----------------------------------------------------------------------
+#
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_ofd_locks
+
+# real QA test starts here
+# prepare a 4k testfile in TEST_DIR
+$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
+	$TEST_DIR/testfile >> $seqres.full 2>&1
+
+do_test()
+{
+	local soptions="$1"
+	local goptions="$2"
+	# add options and getlk output for debug
+	echo $* >> $seqres.full 2>&1
+	# -s : do setlk
+	$here/src/t_ofd_locks $soptions $TEST_DIR/testfile &
+	# -g : do getlk
+	$here/src/t_ofd_locks $goptions $TEST_DIR/testfile | \
+		tee -a $seqres.full
+	wait $!
+}
+
+# Always setlk at range [0,9], getlk at range [0,9] [5,24] or [20,29].
+# To open file RDONLY or RDWR should not break the locks.
+# POSIX locks should be released after closed fd, so it wont conflict
+# with other locks in tests
+
+# -P : operate posix lock
+# -w : operate on F_WRLCK
+# -r : operate on F_RDLCK
+# -R : open file RDONLY
+# -W : open file RDWR
+# -o : file offset where the lock starts
+# -l : lock length
+
+# setlk wrlck [0,9], getlk wrlck [0,9], expect wrlck
+do_test "-s -w -o 0 -l 10 -W" "-g -w -o 0 -l 10 -W" "wrlck"
+# setlk wrlck [0,9], getlk posix wrlck [5,24], expect wrlck
+do_test "-s -w -o 0 -l 10 -W" "-g -w -o 5 -l 20 -W -P" "wrlck"
+# setlk wrlck [0,9], getlk wrlck [20,29], expect unlck
+do_test "-s -w -o 0 -l 10 -W" "-g -w -o 20 -l 10 -W" "unlck"
+# setlk posix wrlck [0,9], getlk wrlck [5,24], expect unlck
+do_test "-s -w -o 0 -l 10 -W -P" "-g -w -o 5 -l 20 -W" "unlck"
+# setlk posix wrlck [0,9], getlk wrlck [20,29], expect unlck
+do_test "-s -w -o 0 -l 10 -W -P" "-g -w -o 20 -l 10 -W" "unlck"
+
+# setlk wrlck [0,9], getlk rdlck [0,9], expect wrlck
+do_test "-s -w -o 0 -l 10 -W" "-g -r -o 0 -l 10 -W" "wrlck"
+# setlk wrlck [0,9], getlk posix rdlck [5,24], expect wrlck
+do_test "-s -w -o 0 -l 10" "-g -r -o 5 -l 20 -P" "wrlck"
+# setlk wrlck [0,9], getlk rdlck [20,29], expect unlck
+do_test "-s -w -o 0 -l 10" "-g -r -o 20 -l 10" "unlck"
+# setlk posix wrlck [0,9], getlk rdlck [5,24], expect unlck
+do_test "-s -w -o 0 -l 10 -P" "-g -r -o 5 -l 20" "unlck"
+# setlk posix wrlck [0,9], getlk rdlck [20,29], expect unlck
+do_test "-s -w -o 0 -l 10 -P" "-g -r -o 20 -l 10" "unlck"
+
+# setlk rdlck [0,9], getlk wrlck [0,9], open RDONLY, expect rdlck
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 0 -l 10 -R" "rdlck"
+# setlk rdlck [0,9], getlk wrlck [5,24], open RDONLY, expect rdlck
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 5 -l 20 -R -P" "rdlck"
+# setlk posix rdlck [0,9], getlk wrlck [5,24], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 5 -l 20 -R" "unlck"
+
+# setlk rdlck [0,9], getlk wrlck [0,9], expect rdlck
+do_test "-s -r -o 0 -l 10" "-g -w -o 0 -l 10" "rdlck"
+# setlk rdlck [0,9], getlk posix wrlck [5,24], expect rdlck
+do_test "-s -r -o 0 -l 10" "-g -w -o 5 -l 20 -P" "rdlck"
+# setlk posix rdlck [0,9], getlk wrlck [5,24], expect unlck
+do_test "-s -r -o 0 -l 10 -P" "-g -w -o 5 -l 20" "unlck"
+
+# setlk rdlck [0,9], getlk wrlck [20,29], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R" "-g -w -o 20 -l 10 -R" "unlck"
+# setlk posix rdlck [0,9], getlk wrlck [20,29], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R -P" "-g -w -o 20 -l 10 -R" "unlck"
+# setlk rdlck [0,9], getlk wrlck [20,29], expect unlck
+do_test "-s -r -o 0 -l 10" "-g -w -o 20 -l 10" "unlck"
+# setlk posix rdlck [0,9], getlk wrlck [20,29], expect unlck
+do_test "-s -r -o 0 -l 10 -P" "-g -w -o 20 -l 10" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [0,9], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [0,9], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 0 -l 10 -R -P" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [0,9], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 0 -l 10 -R" "unlck"
+# setlk rdlck [0,9], getlk rdlck [0,9], expect unlck
+do_test "-s -r -o 0 -l 10" "-g -r -o 0 -l 10" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [0,9], expect unlck
+do_test "-s -r -o 0 -l 10 -P" "-g -r -o 0 -l 10" "unlck"
+
+# setlk rdlck [0,9], getlk rdlck [20,29], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R" "unlck"
+# setlk rdlck [0,9], getlk posix rdlck [20,29], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R" "-g -r -o 20 -l 10 -R -P" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [20,29], open RDONLY, expect unlck
+do_test "-s -r -o 0 -l 10 -R -P" "-g -r -o 20 -l 10 -R" "unlck"
+# setlk rdlck [0,9], getlk rdlck [20,29], expect unlck
+do_test "-s -r -o 0 -l 10" "-g -r -o 20 -l 10" "unlck"
+# setlk posix rdlck [0,9], getlk rdlck [20,29], expect unlck
+do_test "-s -r -o 0 -l 10 -P" "-g -r -o 20 -l 10" "unlck"
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/467.out b/tests/generic/467.out
new file mode 100644
index 0000000..577cfe2
--- /dev/null
+++ b/tests/generic/467.out
@@ -0,0 +1,31 @@
+QA output created by 467
+get wrlck
+get wrlck
+lock could be placed
+lock could be placed
+lock could be placed
+get wrlck
+get wrlck
+lock could be placed
+lock could be placed
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+get rdlck
+get rdlck
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
+lock could be placed
diff --git a/tests/generic/group b/tests/generic/group
index abaa9db..9bea64c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -469,3 +469,4 @@
 464 auto rw
 465 auto rw quick aio
 466 auto quick rw
+467 auto quick
-- 
1.8.3.1

