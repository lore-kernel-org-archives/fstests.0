Return-Path: <SRS0=G3mi=5R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6559C43331
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Apr 2020 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32CC20714
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Apr 2020 17:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeM0qX7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDAR1E (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:27:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgDAR1E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2020 13:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585762023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oVrxx02yugM+8FmM+KpwFiNCNfEA4O68bwjVh2OrUEE=;
        b=LeM0qX7RFUEVCvXvE0Y0jxgY5lV45foXk+dhz2IbaDhmyf2Lknx+5jWXrP9q4+xm4Dn4HR
        BvEMj1oG6yt5iHC9iQKeVZxspt4W8hC/abH4PglUhABU+cE7HpmT9B/Xh1HjiypsVl95yP
        kEv9qFmML3kzoD7DX3m8dpM6XYn5tXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-3k1CqxyaMRaMEZKBUdW25Q-1; Wed, 01 Apr 2020 13:27:01 -0400
X-MC-Unique: 3k1CqxyaMRaMEZKBUdW25Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974868017FA
        for <fstests@vger.kernel.org>; Wed,  1 Apr 2020 17:27:00 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-116-213.phx2.redhat.com [10.3.116.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77DF35C28E
        for <fstests@vger.kernel.org>; Wed,  1 Apr 2020 17:27:00 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 6DC611A00C4; Wed,  1 Apr 2020 13:26:59 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2] generic/571: skip test on filesystems that don't support F_SETLEASE fcntl
Date:   Wed,  1 Apr 2020 13:26:59 -0400
Message-Id: <20200401172659.299308-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add an option to the locktest program to check for fcntl setlease
support, and skip the generic/571 test on filesystems where the check
returns EINVAL.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 common/rc         |  8 ++++++++
 src/locktest.c    | 14 +++++++++++++-
 tests/generic/571 |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 454f5ccf..504232fd 100644
--- a/common/rc
+++ b/common/rc
@@ -3501,6 +3501,14 @@ _require_test_fcntl_advisory_locks()
 		_notrun "Require fcntl advisory locks support"
 }
=20
+_require_test_fcntl_setlease()
+{
+	_require_test_program "locktest"
+	touch $TEST_DIR/setlease_testfile
+	$here/src/locktest -t $TEST_DIR/setlease_testfile >/dev/null 2>&1
+	[ $? -eq 22 ] && _notrun "Require fcntl setlease support"
+}
+
 _require_ofd_locks()
 {
 	# Give a test run by getlk wrlck on testfile.
diff --git a/src/locktest.c b/src/locktest.c
index 8696966f..0e7c3008 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -1030,6 +1030,7 @@ main(int argc, char *argv[])
     extern int	optind;
     int fail_count =3D 0;
     int run_leases =3D 0;
+    int test_setlease =3D 0;
    =20
     atexit(cleanup);
    =20
@@ -1042,7 +1043,7 @@ main(int argc, char *argv[])
 	    prog =3D p+1;
     }
=20
-    while ((c =3D getopt(argc, argv, "dLn:h:p:?")) !=3D EOF) {
+    while ((c =3D getopt(argc, argv, "dLn:h:p:t?")) !=3D EOF) {
 	switch (c) {
=20
 	case 'd':	/* debug flag */
@@ -1072,6 +1073,10 @@ main(int argc, char *argv[])
 	    }
 	    break;
=20
+	case 't':
+	    test_setlease =3D 1;
+	    break;
+
 	case '?':
 	default:
 	    errflag++;
@@ -1090,6 +1095,13 @@ main(int argc, char *argv[])
     if (do_open(O_RDWR) =3D=3D FAIL)
 	exit(1);
=20
+    if (test_setlease =3D=3D 1) {
+	fcntl(f_fd, F_SETLEASE, F_UNLCK);
+	saved_errno =3D errno;
+	close(f_fd);
+	exit(saved_errno);
+    }
+
     setbuf(stderr, NULL);
=20
     if (server) {
diff --git a/tests/generic/571 b/tests/generic/571
index 68c8a604..599e3e68 100755
--- a/tests/generic/571
+++ b/tests/generic/571
@@ -26,6 +26,7 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 _require_test_fcntl_advisory_locks
+_require_test_fcntl_setlease
=20
 _run_leasetest
=20
--=20
2.18.2

