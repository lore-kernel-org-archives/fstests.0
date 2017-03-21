Received: from mx1.redhat.com ([209.132.183.28]:58566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756536AbdCUJSL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 21 Mar 2017 05:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C661B3B731
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 09:18:10 +0000 (UTC)
Received: from dhcp-12-168.nay.redhat.com (unknown [10.66.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16A9A77BE6
        for <fstests@vger.kernel.org>; Tue, 21 Mar 2017 09:18:09 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 2/2] xfs/068: skip new fsstress operations mwrite and mread
Date: Tue, 21 Mar 2017 17:18:03 +0800
Message-Id: <1490087883-24453-2-git-send-email-zlang@redhat.com>
In-Reply-To: <1490087883-24453-1-git-send-email-zlang@redhat.com>
References: <1490087883-24453-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The output of x/068 will be perturbed by new fsstress operations.
For keep away breaking x/068's golden image, skip mread and
mwrite which are brought in by a new fsstress patch.

Reported-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/068 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/068 b/tests/xfs/068
index 4dac95e..568ba60 100755
--- a/tests/xfs/068
+++ b/tests/xfs/068
@@ -44,7 +44,7 @@ _supported_fs xfs
 _supported_os Linux
=20
 # need to ensure new fsstress operations don't perturb expected output
-FSSTRESS_AVOID=3D"-f insert=3D0 $FSSTRESS_AVOID"
+FSSTRESS_AVOID=3D"-f insert=3D0 -f mwrite=3D0 -f mread=3D0 $FSSTRESS_AVOID"
 _create_dumpdir_stress_num 4096
 _do_dump_restore
=20
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D96dJ5wHk8dO6CXdf0pO5mLBQS3qWZv67us9m4CvqANI&s=3DYADzqekwOHb89zRff6FLwVTT=
aMuOYo19VrQRxUAm1ms&e=3D=20
