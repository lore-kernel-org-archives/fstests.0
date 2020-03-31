Return-Path: <SRS0=39K/=5Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C583FC43331
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 14:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A096207FF
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 14:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiNJFsPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgCaOvl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:51:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730528AbgCaOvl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Mar 2020 10:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585666299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JkZLteqpqY8QRNLDU0B47TyOuYMqhqbjidaNQvFzYdQ=;
        b=EiNJFsPMUMOZT2mpFv0a/bwJslLxt7T85sxCh0mb/I6gFlEo9qmnIUkq1Vuc1uZnKpPkAw
        sSIOELBqcPx+fvvOknSbZ6WGRtSUu0JWyCh2ENXpCyMmqx49Fa+NQ5TLbZU5NyKLYh84oI
        fPT8WkcMR2oT2ynNKze94KDutdzwotI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-VtsGn4bSNGGVJ5Z28jgz7g-1; Tue, 31 Mar 2020 10:51:37 -0400
X-MC-Unique: VtsGn4bSNGGVJ5Z28jgz7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE29C1005513
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2020 14:51:36 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-116-213.phx2.redhat.com [10.3.116.213])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E7105C3FA
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2020 14:51:36 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 506E01A011B; Tue, 31 Mar 2020 10:51:35 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/571: skip test on filesystems that don't support F_SETLEASE fcntl
Date:   Tue, 31 Mar 2020 10:51:35 -0400
Message-Id: <20200331145135.136672-1-smayhew@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

nfs and gfs2 (without localflocks) both use simple_nosetlease() for
their setlease f_op, so skip this test on those filesystem types.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 common/rc         | 13 +++++++++++++
 tests/generic/571 |  1 +
 2 files changed, 14 insertions(+)

diff --git a/common/rc b/common/rc
index 454f5ccf..ea0fd67f 100644
--- a/common/rc
+++ b/common/rc
@@ -3501,6 +3501,19 @@ _require_test_fcntl_advisory_locks()
 		_notrun "Require fcntl advisory locks support"
 }
=20
+_require_test_fcntl_setlease()
+{
+	case $FSTYP in
+	nfs)
+		_notrun "Setting leases not supported on $FSTYP"
+		;;
+	gfs2)
+		grep $TEST_DEV /proc/mounts | grep gfs2 | grep -q "localflocks" || \
+			_notrun "Setting leases not supported on $FSTYP without localflocks"
+		;;
+	esac
+}
+
 _require_ofd_locks()
 {
 	# Give a test run by getlk wrlck on testfile.
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

