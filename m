Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E886C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Feb 2022 20:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiBUU2i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:28:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiBUU2h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Feb 2022 15:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61AB122BFF
        for <fstests@vger.kernel.org>; Mon, 21 Feb 2022 12:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645475290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ya+RQq1FGik04fp/aJOEkd3/+66ivJts6ZyMDfcFQa0=;
        b=ZMfUW4DibkwCYzI21g6OxqWKKHOcHWNFat6xT/5YXWkQjOzLGUBt++kF5jStz9MP3F+AGU
        qZ6WY1Hw14DoVHNOuVfKrEvy0TLmlmg2Zdly5wwESqaO0Hsv6xYPW8SiP7bZi4bDUMsW1Z
        F7fvYfLAjVHdrxv5nr7Iw5gYwddgRZg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-yv9HsNwwMrS-kp-O6Rtzrg-1; Mon, 21 Feb 2022 15:28:08 -0500
X-MC-Unique: yv9HsNwwMrS-kp-O6Rtzrg-1
Received: by mail-wr1-f70.google.com with SMTP id s22-20020adf9796000000b001e7e75ab581so7819482wrb.23
        for <fstests@vger.kernel.org>; Mon, 21 Feb 2022 12:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ya+RQq1FGik04fp/aJOEkd3/+66ivJts6ZyMDfcFQa0=;
        b=MTqsmE56qOTJJc+3k0Ch6+/bMcavb3inJbb0ygW0CIvB+NptaT/yJCZ1a+GFd8RLyZ
         yhSFop+hPI114m+9XtbCAHxqfeqPrWNkLfyJ8kqyTJy9CJjgY6p/7g9GjDt0crT/Mf56
         pXwIxInudMLD2zRclPdr37zvIMzeLUQrvVjowTb1w7JBNJwSoKoONXwgFz0NO5gvQEdi
         7gRGhvLyM81Osg/DJwIGYNvxqjsMwk/SkucCfpmSpuPPljJ1Ky9hGqBCVWv1YfPtFqa/
         rtnG0mmSTNOJ7oE36rSXkUIeYz/WMX6Mqyo+Vuzay1Q5TmRkwz2OoacTCPmeLvXW2hfM
         DUpg==
X-Gm-Message-State: AOAM532PqRYqxQ0T9/DNv5D606GWLkj15bp6k6Xk1JFT1VpW0ClFLj0B
        KwmEnWtr+r1XWj/zevgGrijEZiTk5j24AiU3ZTb/YQHGkoXHA04Bidvnwt6UWtPGU2B30SVxBQ1
        WRTxlb6jgqEsV6EGpktOJQdK2xIO0xjrtPucR7NXvEWCpyX+VXy/0+mMsgkRWYY45NfFC
X-Received: by 2002:a5d:6a43:0:b0:1e3:1830:802f with SMTP id t3-20020a5d6a43000000b001e31830802fmr16380693wrw.485.1645475287074;
        Mon, 21 Feb 2022 12:28:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlibuYXFP9Drid9oGhaNOywfs1A1f4KvbDkeNx1p9hWQcTlXqqNxc2ARC1JO2FN32MAyMIMw==
X-Received: by 2002:a5d:6a43:0:b0:1e3:1830:802f with SMTP id t3-20020a5d6a43000000b001e31830802fmr16380661wrw.485.1645475286559;
        Mon, 21 Feb 2022 12:28:06 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm519367wmq.6.2022.02.21.12.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:28:06 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH 1/1] README: restructure & format building manual
Date:   Mon, 21 Feb 2022 21:25:58 +0100
Message-Id: <20220221202558.603994-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220221202558.603994-1-aalbersh@redhat.com>
References: <20220221202558.603994-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The commands for package managers for both Ubuntu and RHEL weren't
up-to-date. A few packages doesn't exist anymore or missing from the
latest repositories (e.g. liburing-devel, btrfs-progs-devel). Ubuntu's
list missed a few packages listed in RHEL's list. There are a few repeating
steps. The indent of avaliable environment variables is not clear.

This patch:
- Update package dependencies for Ubuntu/Debian/RHEL/CentOS/Fedora
- Unify list of packages between Ubuntu/Debian and RHEL/CentOS/Fedora
- Add list of tool packages for other FS
- Add links to tools not in the standard repository for RHEL/CentOS
- Drop xfsprogs-qa-devel reference for old systems
- Replace note about EPEL with installation step with link to Fedora
  manual
- Add configuration examples in 'Setup Environment'
- Small clarification details, such as size of the partition and
  KCONFIG_PATH description
- Removal of repeating steps (install administrative tools, partitions
  content)
- Restructuring and formatting of "BUILDING THE FSQA SUITE" section
- Drop IRIXDEV references in variable set up

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 README | 342 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 205 insertions(+), 137 deletions(-)

diff --git a/README b/README
index e9284b22..99d102df 100644
--- a/README
+++ b/README
@@ -2,148 +2,216 @@ _______________________
 BUILDING THE FSQA SUITE
 _______________________
 
-- cd into the xfstests directory
-- install prerequisite packages
-  For example, for Ubuntu:
-	sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
-	e2fsprogs automake gcc libuuid1 quota attr make \
-	libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
-	uuid-runtime python sqlite3 liburing-dev libcap-dev
-  For Fedora, RHEL, or CentOS:
-	yum install acl attr automake bc dbench dump e2fsprogs fio \
-	gawk gcc indent libtool lvm2 make psmisc quota sed \
-	xfsdump xfsprogs \
-	libacl-devel libaio-devel libuuid-devel \
-	xfsprogs-devel btrfs-progs-devel python sqlite liburing-devel \
-	libcap-devel
-	(Older distributions may require xfsprogs-qa-devel as well.)
-	(Note that for RHEL and CentOS, you may need the EPEL repo.)
-- run make
-- run make install
-- create fsgqa test user ("sudo useradd -m fsgqa")
-- create fsgqa group ("sudo groupadd fsgqa")
-- create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
-  this 2nd user creation step can be safely skipped if your system
-  doesn't support names starting with digits, only a handful of tests
-  require it.
-- create fsgqa2 test user ("sudo useradd fsgqa2")
+Ubuntu, or Debian
+-----------------
+
+1. Make sure that package list is up-to-date and install all necessary packages:
+
+   $ sudo apt-get update
+   $ sudo apt-get install \
+           acl attr automake bc dbench fio gawk gcc git indent libtool lvm2 \
+           make psmisc python3 quota sed \
+           dump e2fsprogs \
+           xfsdump xfsprogs \
+           libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool-bin \
+           liburing-dev libuuid1 uuid-dev uuid-runtime \
+           linux-headers-$(uname -r) sqlite3 xfslibs-dev
+
+2. (Optional) For udf, exfat, f2fs, ocfs2 install:
+
+   $ sudo apt-get install \
+       udftools \
+       exfatprogs \
+       f2fs-tools \
+       ocfs2-tools
+
+   For OverlayFS install:
+    - see https://github.com/hisilicon/overlayfs-progs
+
+Fedora, RHEL, or CentOS
+-----------------------
+
+0. For RHEL and CentOS, enable EPEL repository:
+    - see https://docs.fedoraproject.org/en-US/epel/#How_can_I_use_these_extra_packages.3F
+
+1. Install all packages which are available from standard repository:
+
+   $ sudo yum install \
+        acl attr automake bc dbench fio indent gawk gcc git libtool lvm2 \
+        make psmisc python3 quota sed \
+        dump e2fsprogs \
+        xfsdump xfsprogs \
+        libcap-devel gdbm-devel kernel-devel libacl-devel libaio-devel \
+        libuuid-devel sqlite udftools xfsprogs-devel
+
+   Or, EPEL packages could be compiled from sources, see:
+    - https://dbench.samba.org/web/download.html
+    - https://www.gnu.org/software/indent/
+
+3. For Fedora, install also:
+
+    $ sudo yum install liburing-devel
+
+   For RHEL and CentOS:
+    - see https://github.com/axboe/liburing.
+
+4. (Optional) Install tools for particular filesystems:
+
+   For BTRFS on Fedora:
+    $ sudo yum install btrfs-progs
+
+   For exfat on Fedora, RHEL, or CentOS:
+    $ sudo yum install exfatprogs
+
+   For f2fs on Fedora install:
+    $ sudo yum install f2fs-tools
+   For f2fs on RHEL, or CentOS install:
+    - see https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/
+
+   For ocfs2 on Fedora install:
+    $ sudo yum install ocfs2-tools
+   For ocfs2 on RHEL or CentOS install:
+    - see https://github.com/markfasheh/ocfs2-tools
+
+   For OverlayFS install:
+    - see https://github.com/hisilicon/overlayfs-progs
+
+Build and install test, libs and utils
+--------------------------------------
+
+$ git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
+$ cd xfstests-dev
+$ make
+$ sudo make install
+
+Setup Environment
+-----------------
+
+1. Compile XFS/EXT4/BTRFS/etc. into your kernel or load as module. For example,
+   for XFS, enable XFS_FS in your kernel configuration, or compile it as a
+   module and load it with 'sudo modprobe xfs'. Most of the distributions will
+   have these filesystems already in the kernel/as module.
+
+2. Create one or two partitions (at least 10G each) to use for testing
+    - TEST partition - format as XFS, mount & optionally populate with
+      NON-IMPORTANT stuff
+    - SCRATCH partition (optional) - leave empty and expect this partition to be
+      clobbered by some tests. If this is not provided, many tests will not be
+      run. Note that SCRATCH and TEST must be two DIFFERENT partitions.
+    - BTRFS only: some btrfs test cases will need 3 or more independent SCRATCH
+      disks which should be set using SCRATCH_DEV_POOL (e.g.
+      SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc") with which SCRATCH_DEV
+      should be unused by the tester, and for the legacy support SCRATCH_DEV
+      will be set to the first disk of the SCRATCH_DEV_POOL by xfstests script.
+      Note that these partitions should not have anything usefull, as it will be
+      clobbered by tests.
+
+   For example, to run the tests with loopback partitions:
+   # dd if=/dev/zero of=./test.img bs=1M count=10000
+   # dd if=/dev/zero of=./scratch.img bs=1M count=10000
+   # mkfs.xfs test.img
+   # mkfs.xfs scratch.img
+   # losetup /dev/loop0 ./test.img
+   # losetup /dev/loop1 ./scratch.img
+   # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
+   # mkdir -p /mnt/scratch && mount /dev/loop1 /mnt/scratch
+
+3. Copy local.config.example to local.config and edit as needed. The TEST_DEV
+   and TEST_DIR are required.
+
+   For example, the config for the setup above is:
+   $ cat local.config
+   export TEST_DEV=/dev/loop0
+   export TEST_DIR=/mnt/test
+   export SCRATCH_DEV=/dev/loop1
+   export SCRATCH_MNT=/mnt/scratch
+
+From this point you can run some basic tests, see 'USING THE FSQA SUITE' below.
+
+Additional Setup
+----------------
+
+Some tests require additional configuration of the system and in your
+local.config. Add these variables to a local.config and keep that file in your
+workarea. Or add a case to the switch in common/config assigning these variables
+based on the hostname of your test machine. Or use 'setenv' to set them.
+
+ - Create fsgqa test users and groups:
+
+   $ sudo useradd -m fsgqa
+   $ sudo useradd 123456-fsgqa
+   $ sudo useradd fsgqa2
+   $ sudo groupadd fsgqa
+
+   The "123456-fsgqa" user creation step can be safely skipped if your system
+   doesn't support names starting with digits, only a handful of tests require
+   it.
+ - If you wish to run the udf components of the suite install mkudffs. Also
+   download and build the Philips UDF Verification Software from
+   https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
+   binary to xfstests/src/.
+ - If you wish to disable UDF verification test set the environment variable
+   DISABLE_UDF_TEST to 1.
+ - Set TAPE_DEV to "tape device for testing xfsdump". Note that if testing
+   xfsdump, make sure the tape devices have a tape which can be overwritten.
+ - Set RMT_TAPE_DEV to "remote tape device for testing xfsdump"
+ - Set SCRATCH_LOGDEV to "device for scratch-fs external log"
+ - Set SCRATCH_RTDEV to "device for scratch-fs realtime data"
+ - Set TEST_LOGDEV to "device for test-fs external log"
+ - Set TEST_RTDEV to "device for test-fs realtime data"
+ - If TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
+ - If SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL environment
+   variable set to "yes" will enable their use.
+ - Set DIFF_LENGTH to "number of diff lines to print from a failed test",
+   by default 10, set to 0 to print the full diff
+ - Set FSTYP to "the filesystem you want to test", the filesystem type is
+   devised from the TEST_DEV device, but you may want to override it; if
+   unset, the default is 'xfs'
+ - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
+   the end of fsstresss and fsx invocations, respectively, in case you wish
+   to exclude certain operational modes from these tests.
+ - Set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem run
+   xfs_repair -n to check the filesystem; xfs_repair to rebuild metadata
+   indexes; and xfs_repair -n (a third time) to check the results of the
+   rebuilding.
+ - xfs_scrub, if present, will always check the test and scratch
+   filesystems if they are still online at the end of the test. It is no
+   longer necessary to set TEST_XFS_SCRUB.
+ - Set LOGWRITES_DEV to a block device to use for power fail testing.
+ - Set PERF_CONFIGNAME to a arbitrary string to be used for identifying
+   the test setup for running perf tests. This should be different for
+   each type of performance test you wish to run so that relevant results
+   are compared. For example 'spinningrust' for configurations that use
+   spinning disks and 'nvme' for tests using nvme drives.
+ - Set USE_KMEMLEAK=yes to scan for memory leaks in the kernel after every
+   test, if the kernel supports kmemleak.
+ - Set KEEP_DMESG=yes to keep dmesg log after test
+ - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload it between
+   test invocations. This assumes that the name of the module is the same
+   as FSTYP.
+ - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS or ext*
+   filesystems if a filesystem check fails.
+ - Set DUMP_COMPRESSOR to a compression program to compress metadumps of
+   filesystems. This program must accept '-f' and the name of a file to
+   compress; and it must accept '-d -f -k' and the name of a file to
+   decompress. In other words, it must emulate gzip.
+ - Set MIN_FSSIZE to specify the minimal size (bytes) of a filesystem we
+   can create. Setting this parameter will skip the tests creating a
+   filesystem less than MIN_FSSIZE.
+ - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of time we
+   should try a patient module remove. The default is 50 seconds. Set this
+   to "forever" and we'll wait forever until the module is gone.
+ - Set FORCE_XFS_CHECK_PROG=yes to have _check_xfs_filesystem run xfs_check
+   to check the filesystem. As of August 2021, xfs_repair finds all
+   filesystem corruptions found by xfs_check, and more, which means that
+   xfs_check is no longer run by default.
+ - Set KCONFIG_PATH to specify your preferred location of kernel config
+   file. The config is used by tests to check if kernel feature is enabled.
 
 ______________________
 USING THE FSQA SUITE
 ______________________
 
-Preparing system for tests:
-
-    - compile XFS into your kernel or load XFS modules
-    - install administrative tools specific to the filesystem you wish to test
-    - If you wish to run the udf components of the suite install
-      mkudffs. Also download and build the Philips UDF Verification Software
-      from https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
-      binary to xfstests/src/. If you wish to disable UDF verification test
-      set the environment variable DISABLE_UDF_TEST to 1.
-
-    - create one or two partitions to use for testing
-        - one TEST partition
-            - format as XFS, mount & optionally populate with
-              NON-IMPORTANT stuff
-        - one SCRATCH partition (optional)
-            - leave empty and expect this partition to be clobbered
-              by some tests.  If this is not provided, many tests will
-              not be run.
-              (SCRATCH and TEST must be two DIFFERENT partitions)
-              OR
-        - for btrfs only: some btrfs test cases will need 3 or more independent
-              SCRATCH disks which should be set using SCRATCH_DEV_POOL (for eg:
-              SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc") with which
-              SCRATCH_DEV should be unused by the tester, and for the legacy
-              support SCRATCH_DEV will be set to the first disk of the
-              SCRATCH_DEV_POOL by xfstests script.
-
-    - setup your environment
-	Quick start:
-	- copy local.config.example to local.config and edit as needed
-	Or:
-        - setenv TEST_DEV "device containing TEST PARTITION"
-        - setenv TEST_DIR "mount point of TEST PARTITION"
-	- optionally:
-             - setenv SCRATCH_DEV "device containing SCRATCH PARTITION" OR
-               (btrfs only) setenv SCRATCH_DEV_POOL "to 3 or more SCRATCH disks for
-               testing btrfs raid concepts"
-             - setenv SCRATCH_MNT "mount point for SCRATCH PARTITION"
-             - setenv TAPE_DEV "tape device for testing xfsdump"
-             - setenv RMT_TAPE_DEV "remote tape device for testing xfsdump"
-             - setenv RMT_IRIXTAPE_DEV "remote IRIX tape device for testing xfsdump"
-	     - setenv SCRATCH_LOGDEV "device for scratch-fs external log"
-             - setenv SCRATCH_RTDEV "device for scratch-fs realtime data"
-	     - setenv TEST_LOGDEV "device for test-fs external log"
-             - setenv TEST_RTDEV "device for test-fs realtime data"
-             - if TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
-             - if SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
-               environment variable set to "yes" will enable their use.
-             - setenv DIFF_LENGTH "number of diff lines to print from a failed test",
-               by default 10, set to 0 to print the full diff
-             - setenv FSTYP "the filesystem you want to test", the filesystem
-               type is devised from the TEST_DEV device, but you may want to
-               override it; if unset, the default is 'xfs'
-             - setenv FSSTRESS_AVOID and/or FSX_AVOID, which contain options
-               added to the end of fsstresss and fsx invocations, respectively,
-               in case you wish to exclude certain operational modes from these
-               tests.
-             - set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem
-               run xfs_repair -n to check the filesystem; xfs_repair to rebuild
-               metadata indexes; and xfs_repair -n (a third time) to check the
-               results of the rebuilding.
-             - xfs_scrub, if present, will always check the test and scratch
-               filesystems if they are still online at the end of the test.
-               It is no longer necessary to set TEST_XFS_SCRUB.
-             - setenv LOGWRITES_DEV to a block device to use for power fail
-               testing.
-             - setenv PERF_CONFIGNAME to a arbitrary string to be used for
-               identifying the test setup for running perf tests.  This should
-               be different for each type of performance test you wish to run so
-               that relevant results are compared.  For example 'spinningrust'
-               for configurations that use spinning disks and 'nvme' for tests
-               using nvme drives.
-             - set USE_KMEMLEAK=yes to scan for memory leaks in the kernel
-               after every test, if the kernel supports kmemleak.
-             - set KEEP_DMESG=yes to keep dmesg log after test
-             - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload
-               it between test invocations.  This assumes that the name of
-               the module is the same as FSTYP.
-             - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS or ext*
-               filesystems if a filesystem check fails.
-             - Set DUMP_COMPRESSOR to a compression program to compress
-               metadumps of filesystems.  This program must accept '-f' and the
-               name of a file to compress; and it must accept '-d -f -k' and
-               the name of a file to decompress.  In other words, it must
-               emulate gzip.
-	     - Set MIN_FSSIZE to specify the minimal size (bytes) of a
-               filesystem we can create. Setting this parameter will
-               skip the tests creating a filesystem less than
-               MIN_FSSIZE.
-	     - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of
-	       time we should try a patient module remove. The default is 50
-	       seconds. Set this to "forever" and we'll wait forever until the
-	       module is gone.
-             - Set FORCE_XFS_CHECK_PROG=yes to have _check_xfs_filesystem run
-               xfs_check to check the filesystem.  As of August 2021,
-               xfs_repair finds all filesystem corruptions found by xfs_check,
-               and more, which means that xfs_check is no longer run by default.
-	     - Set KCONFIG_PATH to specify your preferred location of kernel
-	       config file.
-
-        - or add a case to the switch in common/config assigning
-          these variables based on the hostname of your test
-          machine
-	- or add these variables to a file called local.config and keep that
-	  file in your workarea.
-
-    - if testing xfsdump, make sure the tape devices have a
-      tape which can be overwritten.
-
-    - make sure $TEST_DEV is a mounted XFS partition
-    - make sure that $SCRATCH_DEV or $SCRATCH_DEV_POOL contains nothing useful
-
 Running tests:
 
     - cd xfstests
-- 
2.27.0

