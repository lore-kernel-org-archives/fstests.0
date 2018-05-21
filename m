Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750859AbeEUWw4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 18:52:56 -0400
From: Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: Add README.cifs
Date: Tue, 22 May 2018 08:52:47 +1000
Message-Id: <20180521225247.17811-1-lsahlber@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

This is a patch to provide quickstart instructions for how to use xfstest
for CIFS.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 README.cifs | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 README.cifs

diff --git a/README.cifs b/README.cifs
new file mode 100644
index 00000000..92efd24d
--- /dev/null
+++ b/README.cifs
@@ -0,0 +1,61 @@
+This describes how to get up and running using xfstests for the CIFS filesystem.
+
+There are additional information on testing cifs with xfstest on the samba
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
+Download the example configuration and name it local.config:
+
+  wget https://wiki.samba.org/images/9/99/Xfstests.local.config.txt \
+      -O local.config
+
+Update local.config and change SERVER, SHARE, SCRATCH, USERNAME, PASSWORD to
+match your shares.
+
+Create the /mnt/test and /mnt/share mountpoints.
+
+
+Exclusion files
+---------------
+Some tests do not yet work for SMB and some tests take very long so we may want
+to skip them. In CIFS we do this using exclusion files.
+
+Download the exclusion files for smb3 and for very slow tests:
+
+  wget https://wiki.samba.org/images/9/99/Xfstests.exclude.very-slow.txt \
+      -O tests/cifs/exclude.very-slow
+  wget https://wiki.samba.org/images/d/d9/Xfstests.exclude.known-broken-smb3.txt
+      -O tests/cifs/exclude.known-broken-smb3
+
+
+Running full set of tests
+=========================
+With some luck you should be ready to run your first xfstest now.
+
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
-- 
2.13.3

