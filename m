Return-Path: <SRS0=5Nbd=Y7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02EC43331
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1B21D79
	for <linux-fstests@archiver.kernel.org>; Thu,  7 Nov 2019 15:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjhwgAEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfKGPHb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:07:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43176 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729724AbfKGPHb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Nov 2019 10:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573139250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vj4FPOBm27KAXMLFqhFPJqMp3PwUTQ7IaE9jG1DXziA=;
        b=PjhwgAEHa/MDUK8lvw0k4Fo8v2o29654WT33/hFKCq6lPWqRi0sVNyUOt1g5Ob2UQoWgvg
        YvBNfD3vhB9q9j/TLPPFcjo2s5mFQs53NIFDD2rSiKs4Zc/ieJbOhrnaUuIe2Nbt4Gwb24
        yjPJBOCgqbNYJwMLAu5ptzQUXSzbopc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Rr6awKIrM721hfM9XqpgkA-1; Thu, 07 Nov 2019 10:07:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5757C800C61;
        Thu,  7 Nov 2019 15:07:27 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FB73600D3;
        Thu,  7 Nov 2019 15:07:27 +0000 (UTC)
To:     fstests <fstests@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/207: explicitly test for xflag character
Cc:     Amir Goldstein <amir73il@gmail.com>
Message-ID: <3ac76079-7a4f-0ad6-80e9-6175c3c55a68@redhat.com>
Date:   Thu, 7 Nov 2019 09:07:26 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Rr6awKIrM721hfM9XqpgkA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

With a recent change to xfs_io[1], the fsxattr.xflags output line
has added another flag column, so xfs/207 starts failing.

Rather than testing for an exact set of flags, test whether the
specific flag we are interested in is set or unset.

[1] xfs_io/lsattr: expose FS_XFLAG_HASATTR flag

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/207 b/tests/xfs/207
index e830534b..ed4e2e52 100755
--- a/tests/xfs/207
+++ b/tests/xfs/207
@@ -37,6 +37,15 @@ _require_cp_reflink
 _require_xfs_io_command "fiemap"
 _require_xfs_io_command "cowextsize"
=20
+# Takes the fsxattr.xflags line,
+# i.e. fsxattr.xflags =3D 0x0 [--------------C-]
+# and tests whether a flag character is set
+test_xflag()
+{
+    local flg=3D$1
+    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag un=
set"
+}
+
 rm -f $seqres.full
=20
 echo "Format and mount"
@@ -73,14 +82,14 @@ echo "Set cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
=20
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_sc=
ratch
+$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag=
 "C"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
=20
 echo "Unset cowextsize and check flag"
 $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
 _scratch_cycle_mount
=20
-$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | _filter_sc=
ratch
+$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag=
 "C"
 $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
=20
 status=3D0
diff --git a/tests/xfs/207.out b/tests/xfs/207.out
index f6dc17d1..dd2d0958 100644
--- a/tests/xfs/207.out
+++ b/tests/xfs/207.out
@@ -11,8 +11,8 @@ Check extsz and cowextsz settings on 1Mbyte file
 [0] SCRATCH_MNT/test-207/file2
 [1048576] SCRATCH_MNT/test-207/file2
 Set cowextsize and check flag
-fsxattr.xflags =3D 0x10000 [---------------C]
+C flag set
 [1048576] SCRATCH_MNT/test-207/file3
 Unset cowextsize and check flag
-fsxattr.xflags =3D 0x0 [----------------]
+C flag unset
 [0] SCRATCH_MNT/test-207/file3

