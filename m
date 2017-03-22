Received: from mx1.redhat.com ([209.132.183.28]:49200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757691AbdCVGqc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 Mar 2017 02:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CDD7880F63
        for <fstests@vger.kernel.org>; Wed, 22 Mar 2017 06:46:32 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] common/rc: support gluster volume start with a slash
Date: Wed, 22 Mar 2017 14:46:28 +0800
Message-Id: <1490165188-488-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: fstests@vger.kernel.org
Cc: ndevos@redhat.com
List-ID: <fstests@vger.kernel.org>

The format of glusterfs' TEST_DEV or SCRATCH_DEV is XXX:XXX or
XXX:/XXX, but xfstests can't accept the latter now. So change
the regular expression from "\w:\w" to ":/?", to accept more
glusterfs device format.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

According to the feedback from glusterfs developer:

"Yes, it would be good to have an optional "/" after the ":". It is not
required, but would probably help when someone runs the tests with the
"hostname:/volume" device format."

Maybe there's a slash before the gluster volume name. This patch
try to support this format.

Thanks,
Zorro

 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index edfba5d..e1ab2c6 100644
--- a/common/rc
+++ b/common/rc
@@ -1496,7 +1496,7 @@ _require_scratch_nocheck()
 {
     case "$FSTYP" in
 	glusterfs)
-		echo $SCRATCH_DEV | grep -q "\w:\w" > /dev/null 2>&1
+		echo $SCRATCH_DEV | egrep -q ":/?" > /dev/null 2>&1
 		if [ -z "$SCRATCH_DEV" -o "$?" !=3D "0" ]; then
 			_notrun "this test requires a valid \$SCRATCH_DEV"
 		fi
@@ -1584,7 +1584,7 @@ _require_test()
 {
     case "$FSTYP" in
 	glusterfs)
-		echo $TEST_DEV | grep -q "\w:\w" > /dev/null 2>&1
+		echo $TEST_DEV | egrep -q ":/?" > /dev/null 2>&1
 		if [ -z "$TEST_DEV" -o "$?" !=3D "0" ]; then
 			_notrun "this test requires a valid \$TEST_DEV"
 		fi
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DD7XbZsd7yutRqHmazZjNyotbWbu08eG5Bu4u1itNChY&s=3DEFZ_MaaT-v1fUHYAotFCcTeP=
wiySnu-lmwBWhryF2DQ&e=3D=20
