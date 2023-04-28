Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD142C77B60
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Apr 2023 20:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjD1UHN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1UHM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Apr 2023 16:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE2E213C
        for <fstests@vger.kernel.org>; Fri, 28 Apr 2023 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682712385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eX3IbrZGzex8rDEWIwbHCtA6yEYf1iDXHTX3LQq4u/E=;
        b=JoO5nCb4ToUNWDqIN4lXuRJQQxOzLiPWBpA9j/T16sSxNUIi8yyTcJECY3lBldgJ7E7b9s
        EtwLaDT1ea/DAytdnRiFBRRy8MOyDoBUOPzn3SZqEJxFnPQGlnCfYxxUJXGP7Twi5n7W2e
        O54nSGTu4U6dJ839I3JqWJjDofCWy9E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-BJ3saOqPNyu4FBN-c-KfKQ-1; Fri, 28 Apr 2023 16:06:21 -0400
X-MC-Unique: BJ3saOqPNyu4FBN-c-KfKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BDB31C05147;
        Fri, 28 Apr 2023 20:06:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A5B51121314;
        Fri, 28 Apr 2023 20:06:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230424141042.450535-1-dhowells@redhat.com>
References: <20230424141042.450535-1-dhowells@redhat.com>
To:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Cc:     dhowells@redhat.com, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH v2 7/6] Doc changes for afs
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1185264.1682712377.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 28 Apr 2023 21:06:17 +0100
Message-ID: <1185265.1682712377@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

    =

Documentation changes for afs.
    =

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---
 README                 |    3 ++-
 README.config-sections |    7 +++++++
 common/rc              |    4 +++-
 doc/testing-afs.txt    |   36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 4ee877a9..7eb6ac1b 100644
--- a/README
+++ b/README
@@ -291,9 +291,10 @@ Running tests:
     - If you want to run all tests regardless of what group they are in
       (including dangerous tests), use the "all" group: ./check -g all
     - To randomize test order: ./check -r [test(s)]
-    - You can explicitly specify NFS/CIFS/OVERLAY, otherwise
+    - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
         - for running nfs tests: ./check -nfs [test(s)]
+        - for running afs tests: ./check -afs [test(s)]
         - for running cifs/smb3 tests: ./check -cifs [test(s)]
         - for overlay tests: ./check -overlay [test(s)]
           The TEST and SCRATCH partitions should be pre-formatted
diff --git a/README.config-sections b/README.config-sections
index 4f1a4dc6..a42d9d7b 100644
--- a/README.config-sections
+++ b/README.config-sections
@@ -128,3 +128,10 @@ TEST_DIR=3D/mnt/gluster/test
 TEST_DEV=3D192.168.1.1:testvol
 SCRATCH_MNT=3D/mnt/gluster/scratch
 SCRATCH_DEV=3D192.168.1.1:scratchvol
+
+[afs]
+FSTYP=3Dafs
+TEST_DEV=3D%example.com:xfstest.test
+TEST_DIR=3D/mnt/xfstest.test
+SCRATCH_DEV=3D%example.com:xfstest.scratch
+SCRATCH_MNT=3D/mnt/xfstest.scratch
diff --git a/common/rc b/common/rc
index 4dfc3301..e3805fcf 100644
--- a/common/rc
+++ b/common/rc
@@ -1617,9 +1617,11 @@ _require_scratch_nocheck()
 		fi
 		;;
 	afs)
+		# We only support RW volumes (marked with a '%')
+		# We don't support RO volumes (marked with a '#')
 		echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
-			_notrun "this test requires a valid \$SCRATCH_DEV"
+			_notrun "this test requires a valid \$SCRATCH_DEV (must be a RW volume=
)"
 		fi
 		if [ ! -d "$SCRATCH_MNT" ]; then
 			_notrun "this test requires a valid \$SCRATCH_MNT"
diff --git a/doc/testing-afs.txt b/doc/testing-afs.txt
new file mode 100644
index 00000000..75ed1331
--- /dev/null
+++ b/doc/testing-afs.txt
@@ -0,0 +1,36 @@
+				 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+				 TESTING AFS
+				 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+xfstests can be used with the Linux kernel AFS filesystem (kafs).  kafs m=
ounts
+each volume as a separate volume and, as such, allows them to be individu=
ally
+mounted on arbitrary paths.  This allows xfstests to be easily configured=
 to
+use specific volumes.  This doesn't work with OpenAFS, say, as that opera=
tes
+with everything in a single superblock.
+
+xfstests requires that the volumes specified by forced to use RW volumes =
by
+prefixing the mount device with '%' rather than '#' as per the format of =
a
+mountpoint string:
+
+	%<volume>
+
+using the workstation cell, or:
+
+	%<cell>:<volume>
+
+using an explicit cell.
+
+For example:
+
+	FSTYP=3Dafs
+	TEST_DEV=3D%example.com:xfstest.test
+	TEST_DIR=3D/mnt/xfstest.test
+	SCRATCH_DEV=3D%example.com:xfstest.scratch
+	SCRATCH_MNT=3D/mnt/xfstest.scratch
+
+will use the xfstest.test and xfstest.scratch volumes located in the
+example.com cell.
+
+
+Note that AFS in general and kafs in particular lack a number of features=
 that
+can be tested for and so a lot of tests will be skipped.

