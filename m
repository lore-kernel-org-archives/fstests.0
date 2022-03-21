Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F29C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Mar 2022 09:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiCUJ0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Mar 2022 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345861AbiCUJ0n (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2022 05:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9F37143C6B
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647854715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS55SGSrvTiWxScQaEXm7jyZm9pXKXUr/yzATzcrgV4=;
        b=TlHv1v6AS9zOTRcotNBPfcLEQVBMGltZDIm7/Olvn81QJzqpca2vM84ZoZPJRxHJ1kxoUz
        M1ZUBC0fQxoymurFFlI4bp4xRYRNq+VJB09BhZ2OSJeSMS3LEXm5U6QGt579JLRaT9kKHk
        S7ZBQZh7LP49bXJcKnbZWLkaRz4SegM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-yD3Q2UiDOiiY780LOLQp9A-1; Mon, 21 Mar 2022 05:25:13 -0400
X-MC-Unique: yD3Q2UiDOiiY780LOLQp9A-1
Received: by mail-ed1-f70.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso8291535edh.1
        for <fstests@vger.kernel.org>; Mon, 21 Mar 2022 02:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AS55SGSrvTiWxScQaEXm7jyZm9pXKXUr/yzATzcrgV4=;
        b=lNC18Uc5iOseHZJDKjcbiRiiWe0F7E4vFGHv3Ad9Mm/cR6vAi5rw5jKc225dXPA2P+
         CkpbcVSQ3kgb4+NACwfDv0jE5zVkcxZ/11KtNGHUUM8EsxXuaMfJcm08YNsZ3etmExC0
         q6V+KN74d8nZ4ozlo5fVm9PkzixiJ9/HdmTHkQ/34ZLgvKkF4S9qOySkG95w9a5i8xlX
         HKBvCzmXVrErOPFNW/XmimFvHUKJe3szPvhh0GCWL9G2XAR+BBtGN/nGH4d80pEXzCX0
         20YJo2YfsQO5LC6Xd7u+Qhlpq4MCNE8ePQCOBdLEKTVSDC+1GmgITZlNl32mKS97zt6Q
         Yq4g==
X-Gm-Message-State: AOAM532v/PQ5Jb1ZuX9jDQT9zqy+Tn6x9z2RcYiNTiASK+geambArJiI
        w2FlHI1abxCH32DblsPFr7XjPJTOqw8RVCpj+UExvdvEDLjWS5KKfGc9CR7CECkCT+ax1mqzpIg
        J29OHcc/jvjBKXaB5
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id bg23-20020a170906a05700b006cf2736ba65mr19633787ejb.171.1647854711635;
        Mon, 21 Mar 2022 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRBzmRIty719wht77VsfRPS6ZMOQm/eWi8l+Uo7+NO9uKejnKxxl4z9PYZTeFHZqTTNmbMVg==
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id bg23-20020a170906a05700b006cf2736ba65mr19633768ejb.171.1647854711223;
        Mon, 21 Mar 2022 02:25:11 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm5001709ejl.185.2022.03.21.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:25:10 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     guan@eryu.me
Cc:     fstests@vger.kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH] README: restructure & format building manual
Date:   Mon, 21 Mar 2022 10:19:21 +0100
Message-Id: <20220321091920.482834-1-aalbersh@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <YjdYbcSnca891rLa@desktop>
References: <YjdYbcSnca891rLa@desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The commands for package managers for both Ubuntu and RHEL weren't
up-to-date. A few packages doesn't exist anymore or missing from the
latest repositories (e.g. liburing-devel, btrfs-progs-devel).
Ubuntu's list missed a few packages listed in RHEL's list. There are
a few repeating steps. The indent of avaliable environment variables
is not clear.

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
- Removal of repeating steps (install administrative tools,
  partitions content)
- Restructuring and formatting of "BUILDING THE FSQA SUITE" section
- Drop IRIXDEV references in variable set up
- Variables in 'Additional setup' divided into groups
- Move fsqa user/group creation and udf_test to 'Setup Environment'
  section

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 README | 372 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 235 insertions(+), 137 deletions(-)

diff --git a/README b/README
index 9f01aa10..36ebdadd 100644
--- a/README
+++ b/README
@@ -2,148 +2,246 @@ _______________________
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
+Ubuntu or Debian
+----------------
+
+1. Make sure that package list is up-to-date and install all necessary packages:
+
+   $ sudo apt-get update
+   $ sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
+        gcc git indent libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool \
+        libtool-bin liburing-dev libuuid1 lvm2 make psmisc python3 quota sed \
+        uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3
+
+2. Install packages for the filesystem(s) being tested:
+
+   $ sudo apt-get install exfatprogs f2fs-tools ocfs2-tools udftools xfsdump \
+        xfslibs-dev
+
+   For OverlayFS install:
+    - see https://github.com/hisilicon/overlayfs-progs
+
+Fedora
+------
+
+1. Install all necessary packages from standard repository:
+
+   $ sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
+        gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
+        libcap-devel libtool liburing-devel libuuid-devel lvm2 make psmisc \
+        python3 quota sed sqlite udftools  xfsprogs
+
+2. Install packages for the filesystem(s) being tested:
+
+    $ sudo yum install btrfs-progs exfatprogs f2fs-tools ocfs2-tools xfsdump \
+        xfsprogs-devel
+
+   For OverlayFS build and install:
+    - see https://github.com/hisilicon/overlayfs-progs
+
+RHEL or CentOS
+--------------
+
+1. Enable EPEL repository:
+    - see https://docs.fedoraproject.org/en-US/epel/#How_can_I_use_these_extra_packages.3F
+
+2. Install all necessary packages which are available from standard repository
+   and EPEL:
+
+   $ sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
+        gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
+        libcap-devel libtool libuuid-devel lvm2 make psmisc python3 quota sed \
+        sqlite udftools xfsprogs
+
+   Or, EPEL packages could be compiled from sources, see:
+    - https://dbench.samba.org/web/download.html
+    - https://www.gnu.org/software/indent/
+
+3. Build and install 'liburing':
+    - see https://github.com/axboe/liburing.
+
+4. Install packages for the filesystem(s) being tested:
+
+    For XFS install:
+     $ sudo yum install xfsdump xfsprogs-devel
+
+    For exfat install:
+     $ sudo yum install exfatprogs
+
+    For f2fs build and install:
+     - see https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/
+
+    For ocfs2 build and install:
+     - see https://github.com/markfasheh/ocfs2-tools
+
+    For OverlayFS build and install:
+     - see https://github.com/hisilicon/overlayfs-progs
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
+2. Create TEST device:
+    - format as the filesystem type you wish to test.
+    - should be at least 10GB in size.
+    - optionally populate with destroyable data.
+    - device contents may be destroyed.
+
+3. (optional) Create SCRATCH device.
+    - many tests depend on the SCRATCH device existing.
+    - not need to be formatted.
+    - should be at least 10GB in size.
+    - must be different to TEST device.
+    - device contents will be destroyed.
+
+4. (optional) Create SCRATCH device pool.
+    - needed for BTRFS testing
+    - specifies 3 or more independent SCRATCH devices via the SCRATCH_DEV_POOL
+      variable e.g SCRATCH_DEV_POOL="/dev/sda /dev/sdb /dev/sdc"
+    - device contents will be destroyed.
+    - SCRATCH device should be left unset, it will be overridden
+      by the SCRATCH_DEV_POOL implementation.
+
+5. Copy local.config.example to local.config and edit as needed. The TEST_DEV
+   and TEST_DIR are required.
+
+6. (optional) Create fsgqa test users and groups:
+
+   $ sudo useradd -m fsgqa
+   $ sudo useradd 123456-fsgqa
+   $ sudo useradd fsgqa2
+   $ sudo groupadd fsgqa
+
+   The "123456-fsgqa" user creation step can be safely skipped if your system
+   doesn't support names starting with digits, only a handful of tests require
+   it.
+
+7. (optional) If you wish to run the udf components of the suite install
+   mkudffs. Also download and build the Philips UDF Verification Software from
+   https://www.lscdweb.com/registered/udf_verifier.html, then copy the udf_test
+   binary to xfstests/src/.
+
+
+For example, to run the tests with loopback partitions:
+
+    # xfs_io -f -c "falloc 0 10g" test.img
+    # xfs_io -f -c "falloc 0 10g" scratch.img
+    # mkfs.xfs test.img
+    # losetup /dev/loop0 ./test.img
+    # losetup /dev/loop1 ./scratch.img
+    # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
+    # mkdir -p /mnt/scratch
+
+The config for the setup above is:
+
+    $ cat local.config
+    export TEST_DEV=/dev/loop0
+    export TEST_DIR=/mnt/test
+    export SCRATCH_DEV=/dev/loop1
+    export SCRATCH_MNT=/mnt/scratch
+
+From this point you can run some basic tests, see 'USING THE FSQA SUITE' below.
+
+Additional Setup
+----------------
+
+Some tests require additional configuration in your local.config. Add these
+variables to a local.config and keep that file in your workarea. Or add a case
+to the switch in common/config assigning these variables based on the hostname
+of your test machine. Or use 'setenv' to set them.
+
+Extra TEST device specifications:
+ - Set TEST_LOGDEV to "device for test-fs external log"
+ - Set TEST_RTDEV to "device for test-fs realtime data"
+ - If TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
+ - Set FSTYP to "the filesystem you want to test", the filesystem type is
+   devised from the TEST_DEV device, but you may want to override it; if
+   unset, the default is 'xfs'
+
+Extra SCRATCH device specifications:
+ - Set SCRATCH_LOGDEV to "device for scratch-fs external log"
+ - Set SCRATCH_RTDEV to "device for scratch-fs realtime data"
+ - If SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL environment
+
+Tape device specification for xfsdump testing:
+ - Set TAPE_DEV to "tape device for testing xfsdump".
+ - Set RMT_TAPE_DEV to "remote tape device for testing xfsdump"
+   variable set to "yes" will enable their use.
+ - Note that if testing xfsdump, make sure the tape devices have a tape which
+   can be overwritten.
+
+Extra XFS specification:
+ - Set TEST_XFS_REPAIR_REBUILD=1 to have _check_xfs_filesystem run
+   xfs_repair -n to check the filesystem; xfs_repair to rebuild metadata
+   indexes; and xfs_repair -n (a third time) to check the results of the
+   rebuilding.
+ - Set FORCE_XFS_CHECK_PROG=yes to have _check_xfs_filesystem run xfs_check
+   to check the filesystem. As of August 2021, xfs_repair finds all
+   filesystem corruptions found by xfs_check, and more, which means that
+   xfs_check is no longer run by default.
+ - xfs_scrub, if present, will always check the test and scratch
+   filesystems if they are still online at the end of the test. It is no
+   longer necessary to set TEST_XFS_SCRUB.
+
+Tools specification:
+ - dump:
+    - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS, ext* or
+      btrfs filesystems if a filesystem check fails.
+    - Set DUMP_COMPRESSOR to a compression program to compress metadumps of
+      filesystems. This program must accept '-f' and the name of a file to
+      compress; and it must accept '-d -f -k' and the name of a file to
+      decompress. In other words, it must emulate gzip.
+ - dmesg:
+    - Set KEEP_DMESG=yes to keep dmesg log after test
+ - kmemleak:
+    - Set USE_KMEMLEAK=yes to scan for memory leaks in the kernel after every
+      test, if the kernel supports kmemleak.
+ - fsstress:
+    - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
+      the end of fsstresss and fsx invocations, respectively, in case you wish
+      to exclude certain operational modes from these tests.
+
+Kernel/Modules related configuration:
+ - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload it between
+   test invocations. This assumes that the name of the module is the same
+   as FSTYP.
+ - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of time we
+   should try a patient module remove. The default is 50 seconds. Set this
+   to "forever" and we'll wait forever until the module is gone.
+ - Set KCONFIG_PATH to specify your preferred location of kernel config
+   file. The config is used by tests to check if kernel feature is enabled.
+
+Misc:
+ - If you wish to disable UDF verification test set the environment variable
+   DISABLE_UDF_TEST to 1.
+ - Set LOGWRITES_DEV to a block device to use for power fail testing.
+ - Set PERF_CONFIGNAME to a arbitrary string to be used for identifying
+   the test setup for running perf tests. This should be different for
+   each type of performance test you wish to run so that relevant results
+   are compared. For example 'spinningrust' for configurations that use
+   spinning disks and 'nvme' for tests using nvme drives.
+ - Set MIN_FSSIZE to specify the minimal size (bytes) of a filesystem we
+   can create. Setting this parameter will skip the tests creating a
+   filesystem less than MIN_FSSIZE.
+ - Set DIFF_LENGTH to "number of diff lines to print from a failed test",
+   by default 10, set to 0 to print the full diff
 
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
-             - Set DUMP_CORRUPT_FS=1 to record metadata dumps of XFS, ext* or
-               btrfs filesystems if a filesystem check fails.
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

