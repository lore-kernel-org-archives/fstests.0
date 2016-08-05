Received: from mx1.redhat.com ([209.132.183.28]:44262 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161437AbcHEPq2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 5 Aug 2016 11:46:28 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EF2F749
	for <fstests@vger.kernel.org>; Fri,  5 Aug 2016 15:46:28 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u75FkRQV015365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 5 Aug 2016 11:46:28 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] document Fedora, RHEL, and CentOS dependencies
Message-ID: <fa952893-01ab-596d-13e9-ed4171be7f4a@redhat.com>
Date: Fri, 5 Aug 2016 10:46:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Document all build and runtime requirements for xfstests
on Fedora/RHEL/CentOS boxes, as was done earlier for Ubuntu.

Minor other README edits as well.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

(I wonder if it would be worth adding an install-deps script...)

diff --git a/README b/README
index 2647e12..5aaad01 100644
--- a/README
+++ b/README
@@ -10,6 +10,13 @@ Building Linux:
 		 automake gcc libuuid1 quota attr libattr1-dev make
 		 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench
 		 uuid-runtime"
+	  For Fedora, RHEL, or CentOS:
+		"yum install acl attr awk bc dbench dump e2fsprogs fio gawk
+		 indent lvm2 psmisc quota sed xfsdump xfsprogs
+		 libacl-devel libattr-devel libaio-devel libuuid-devel
+		 openssl-devel xfsprogs-devel btrfs-progs-devel"
+		(Older distributions may require xfsprogs-qa-devel as well.)
+		(Note that for RHEL and CentOS, you may need the EPEL repo.)
 	- run make
 	- run make install
 	- create fsgqa test user ("sudo useradd fsgqa")
@@ -27,8 +34,8 @@ ______________________
 Preparing system for tests (IRIX and Linux):
 
     - compile XFS into your kernel or load XFS modules
-    - install user tools including mkfs.xfs, xfs_db & xfs_bmap
-    - If you wish to run the udf components of the suite install 
+    - install administrative tools specific to the filesystem you wish to test
+    - If you wish to run the udf components of the suite install
       mkfs_udf and udf_db for IRIX and mkudffs for Linux. Also download and 
       build the Philips UDF Verification Software from 
       http://www.extra.research.philips.com/udf/, then copy the udf_test 
@@ -54,6 +61,9 @@ Preparing system for tests (IRIX and Linux):
               SCRATCH_DEV_POOL by xfstests script.
               
     - setup your environment
+	Quick start:
+	- copy config.local.example to config.local and edit as needed
+	Or:
         - setenv TEST_DEV "device containing TEST PARTITION"
         - setenv TEST_DIR "mount point of TEST PARTITION"   
        	- optionally:

