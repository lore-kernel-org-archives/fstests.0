Received: from mx1.redhat.com ([209.132.183.28]:54162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeEUWy4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 18:54:56 -0400
Date: Mon, 21 May 2018 18:54:55 -0400 (EDT)
From: Ronnie Sahlberg <lsahlber@redhat.com>
Message-ID: <1511841748.3255064.1526943295585.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180517035553.18859-2-lsahlber@redhat.com>
References: <20180517035553.18859-1-lsahlber@redhat.com> <20180517035553.18859-2-lsahlber@redhat.com>
Subject: Re: [PATCH] cifs: Add README.cifs, example configs and blacklist
 files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

Please ignore this patch.  It is residuals from before I got git-send-email setup correctly.
The real patch is "[PATCH] cifs: Add README.cifs"

Sorry,
Ronnie Sahlberg



----- Original Message -----
From: "Ronnie Sahlberg" <lsahlber@redhat.com>
To: "fstests" <fstests@vger.kernel.org>
Cc: "Steve French" <smfrench@gmail.com>
Sent: Thursday, 17 May, 2018 1:55:53 PM
Subject: [PATCH] cifs: Add README.cifs, example configs and blacklist files

This is an initial patch to provide quickstart instructions for
how to use xfstest for CIFS.
It contains configuration examples as well as exclusion files
for tests that are either broken for SMB3 or just take unreasonably long
for causal testing.

Future patches will add similar exclude files for other dialects such as
SMB2, SMB2.1 and CIFS.

The aim is to have one canonical place where we have documentation on how to
set xfstest up for cifs testing and one canonical place where we document
which tests work and which does not.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 README.cifs                          |  87 ++++++++++++++++++++++++++++
 tests/cifs/exclude.known-broken-smb3 | 108 +++++++++++++++++++++++++++++++++++
 tests/cifs/exclude.very-slow         |   4 ++
 tests/cifs/local.config.example      |  32 +++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 README.cifs
 create mode 100644 tests/cifs/exclude.known-broken-smb3
 create mode 100644 tests/cifs/exclude.very-slow
 create mode 100644 tests/cifs/local.config.example

diff --git a/README.cifs b/README.cifs
new file mode 100644
index 00000000..71907a06
--- /dev/null
+++ b/README.cifs
@@ -0,0 +1,87 @@
+This describes how to run xfstests for the CIFS filesystem.
+
+There is additional information on testing cifs with xfstest on the samba
+wiki : https://wiki.samba.org/index.php/Xfstesting-cifs
+
+
+
+Quick Setup
+===========
+
+local.config
+------------
+Xfstests needs two cifs shares. One normal share and one scratch share.
+The data on the scratch share will be destroyed so set this up as a dedicate
+share on your server and do not store anything important in it.
+
+The first thing we need is to set up some stanzas for different smb dialects.
+These dialects can then be selected using the -s command line option making
+it a convenient way to pick a specific version of smb to test.
+
+In the root of the xfstests directory, edit the local.config and replace the
+content with the example below.
+This example is also available in the file ./tests/cifs/local.config.examples.
+
+Change SERVER, SHARE, SCRATCH, USERNAME, PASSWORD to match your shares.
+
+Create the /mnt/test and /mnt/share mountpoints.
+
+---local.config---begin---
+[cifs]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=1.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=1.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb2]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb21]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.1,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.1,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb3]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=3.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=3.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+---local.config---end---
+
+
+Your first test
+---------------
+With some luck you should be ready to run your first xfstest now.
+This will run only the cifs-specific tests and should finish within a few
+seconds.
+
+    sudo ./check -s smb3 -g cifs/quick
+
+Running full set of tests
+=========================
+When runnig the "full" set of tests there are multiple tests that are
+known to fail. Reasons can be that they just don't map well to cifs,
+we are missing features in cifs or there are bugs that needs to be fixed.
+
+For regression testing is useful to run all the tests that are known to work.
+We can acheive this per protocol version using exclude files and filter
+out the known broken tests.
+
+SMB3
+----
+
+    sudo ./check -s smb3 -E tests/cifs/exclude.known-broken-smb3 \
+        -E tests/cifs/exclude.very-slow
diff --git a/tests/cifs/exclude.known-broken-smb3 b/tests/cifs/exclude.known-broken-smb3
new file mode 100644
index 00000000..9f6dcd53
--- /dev/null
+++ b/tests/cifs/exclude.known-broken-smb3
@@ -0,0 +1,108 @@
+# Exclude list for tests that we know are broken in smb3
+#
+generic/011 # "dirstress 5 processes"
+generic/020 # EA keys are not case preserving
+generic/023 # Rename of directory onto directory. Wrong return code.
+generic/035 # SMB2+ does not allow rename onto an open file.
+generic/037
+generic/062
+generic/070 # xattr not supported
+generic/071
+generic/074
+generic/075 # fsx with zero data
+generic/081 # fsx failure
+generic/087 # ownership bug
+generic/088 # ownership bug
+generic/089
+generic/091
+generic/097
+generic/117 # cifs crash
+generic/120
+generic/126 # needs usermapping
+generic/127 # fsx failure
+generic/130
+generic/131 # no advisory locking
+generic/184 # mknod
+generic/192 # mtime/ctime failure
+generic/193 # needs usermapping
+generic/209 # aio readahead file corruption
+generic/236
+generic/237 # needs posix acl support
+generic/245 # Rename of directory onto directory. Wrong return code.
+generic/258 # "Testing for negative seconds since the epoch" fails to Samba works to Windows (not client problem - Samba server bug)
+generic/263 # fsx failure
+generic/270 # Adding quota support would be required for test 270
+generic/277
+generic/313 # mtime/ctime failure
+generic/314 # needs posix acl support
+generic/294
+generic/306
+generic/313
+generic/314
+generic/317
+generic/318
+generic/319
+generic/337
+generic/377
+generic/379
+generic/380
+generic/381
+generic/382
+generic/383
+generic/385
+generic/387
+generic/388
+generic/390
+generic/392
+generic/393
+generic/395
+generic/396
+generic/397
+generic/398
+generic/399
+generic/401
+generic/402
+generic/403
+generic/405
+generic/406
+generic/409
+generic/410
+generic/411
+generic/412
+generic/413
+generic/414
+generic/415
+generic/416
+generic/417
+generic/419
+generic/421
+generic/422
+generic/423
+generic/424
+generic/425
+generic/427
+generic/429
+generic/430
+generic/431
+generic/434
+generic/435
+generic/439
+generic/440
+generic/441
+generic/442
+generic/446
+generic/447
+generic/449
+generic/452
+generic/453
+generic/454
+generic/455
+generic/456
+generic/457
+generic/458
+generic/459
+generic/460
+generic/461
+generic/462
+generic/464
+generic/466
\ No newline at end of file
diff --git a/tests/cifs/exclude.very-slow b/tests/cifs/exclude.very-slow
new file mode 100644
index 00000000..aaee0537
--- /dev/null
+++ b/tests/cifs/exclude.very-slow
@@ -0,0 +1,4 @@
+# Exclude list for tests that are very slow on a network
+#
+generic/129
+generic/438
diff --git a/tests/cifs/local.config.example b/tests/cifs/local.config.example
new file mode 100644
index 00000000..01e4e1b6
--- /dev/null
+++ b/tests/cifs/local.config.example
@@ -0,0 +1,32 @@
+[cifs]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=1.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=1.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb2]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb21]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.1,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=2.1,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
+[smb3]
+FSTYP=cifs
+TEST_DEV=//SERVER/SHARE
+TEST_DIR=/mnt/test
+TEST_FS_MOUNT_OPTS='-ousername=USERNAME,password=PASSWORD,noperm,vers=3.0,mfsymlinks,actimeo=0'
+MOUNT_OPTIONS='-ousername=USERNAME,password=PASSWORD,noperm,vers=3.0,mfsymlinks,actimeo=0'
+SCRATCH_DEV=//SERVER/SCRATCH
+SCRATCH_MNT=/mnt/scratch
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
