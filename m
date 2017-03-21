Received: from cn.fujitsu.com ([59.151.112.132]:26353 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756133AbdCUHx3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Mar 2017 03:53:29 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 3A04D49F9A76
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 15:53:25 +0800 (CST)
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Subject: [PATCH] fstests: generic/407: Use _reflink_range to avoid old xfs_io bug
Date: Tue, 21 Mar 2017 15:53:21 +0800
Message-ID: <20170321075321.17943-1-quwenruo@cn.fujitsu.com>
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Old xfs_io has a bug that even its man page shows that reflink can accept
one parameter, but in fact xfs_io reflink still needs full 4 parameters.

In this test case, it only needs to reflink the file and we know the
size of the file, so use _reflink_range() to replace open-coded reflink,
which makes the test case pass even its xfs_io is a little old and
doesn't accept single parameter.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 tests/generic/407 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/407 b/tests/generic/407
index 1103d40..7d5a865 100755
--- a/tests/generic/407
+++ b/tests/generic/407
@@ -65,7 +65,7 @@ echo "before clone: $mtime1 $ctime1" >> $seqres.full
=20
 # clone to trigger timestamp change
 sleep 1
-$XFS_IO_PROG -c "reflink $sourcefile " $destfile >> $seqres.full
+_reflink_range $sourcefile 0 $destfile 0 4k >> $seqres.full
=20
 # sample and verify that timestamps have changed.
 mtime2=3D`stat -c %Y $destfile`
--=20
2.9.3



--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DVRLBd4nRY05lI-c-yRlnuKZpYO64KNw0pyw9iNHFQcI&s=3DJnTVYbbrJ0vp5b3u6M-OValC=
D2E2X4ql6x03CbuBreI&e=3D=20
