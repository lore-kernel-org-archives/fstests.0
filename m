Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAA6C34026
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 16:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC17C208C4
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 16:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC63EWC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRQ6d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:58:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgBRQ6d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 11:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qv2oO8LNJWg8xfasEQwTLWZoQ+PUUZoL0eNcHzgBby4=;
        b=XC63EWC9k/yF1h3OOalVR59mHcV4+791+pLBteBrUNTGLSSLlW/ag+hQYy/BmF18YgM4f4
        53ZzVhxSOi8kOWPykHS2AQf0BVK67/icoekbrt2jSs0m4/LR6CbM6Q9jpCszxaeUriX0X/
        rcX9azC6n1ooC3Hb/37xGX9mY2UfSTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-LpL_xf_7M0adZSkN_q_7-g-1; Tue, 18 Feb 2020 11:58:29 -0500
X-MC-Unique: LpL_xf_7M0adZSkN_q_7-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34DEADB20
        for <fstests@vger.kernel.org>; Tue, 18 Feb 2020 16:58:28 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9907160BE1
        for <fstests@vger.kernel.org>; Tue, 18 Feb 2020 16:58:25 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] xfs/513: fix 4k allocsize fails on 64k pagesize
Date:   Wed, 19 Feb 2020 00:58:18 +0800
Message-Id: <20200218165818.21066-1-zlang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The minimal I/O preallocation size is page size. The allocsize=3D4k
always fails on 64k pagesize machine. So change the fs blocksize
allocsize test to allocsize=3D64k.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/513     | 4 ++--
 tests/xfs/513.out | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/513 b/tests/xfs/513
index 70bc2f1c..3c3f5163 100755
--- a/tests/xfs/513
+++ b/tests/xfs/513
@@ -178,13 +178,13 @@ do_test()
=20
 echo "** start xfs mount testing ..."
 # Test allocsize=3Dsize
-# Valid values for this option are page size (typically 4KiB) through to=
 1GiB
+# Valid values for this option are page size through to 1GiB
 do_mkfs
 if [ $dbsize -ge 1024 ];then
 	blsize=3D"$((dbsize / 1024))k"
 fi
 do_test "" pass "allocsize" "false"
-do_test "-o allocsize=3D$blsize" pass "allocsize=3D$blsize" "true"
+do_test "-o allocsize=3D64k" pass "allocsize=3D64k" "true"
 do_test "-o allocsize=3D1048576k" pass "allocsize=3D1048576k" "true"
 do_test "-o allocsize=3D$((dbsize / 2))" fail
 do_test "-o allocsize=3D2g" fail
diff --git a/tests/xfs/513.out b/tests/xfs/513.out
index 9be18dd8..2d9f8384 100644
--- a/tests/xfs/513.out
+++ b/tests/xfs/513.out
@@ -5,7 +5,7 @@ QA output created by 513
 ** start xfs mount testing ...
 FORMAT:=20
 TEST: "" "pass" "allocsize" "false"
-TEST: "-o allocsize=3D4k" "pass" "allocsize=3D4k" "true"
+TEST: "-o allocsize=3D64k" "pass" "allocsize=3D64k" "true"
 TEST: "-o allocsize=3D1048576k" "pass" "allocsize=3D1048576k" "true"
 TEST: "-o allocsize=3D2048" "fail"
 TEST: "-o allocsize=3D2g" "fail"
--=20
2.20.1

