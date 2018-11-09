Received: from mx1.redhat.com ([209.132.183.28]:56898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbeKIN6K (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 9 Nov 2018 08:58:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9E788B102
        for <fstests@vger.kernel.org>; Fri,  9 Nov 2018 04:19:25 +0000 (UTC)
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/398: filter out extra string from newer mv
Date: Fri,  9 Nov 2018 12:19:13 +0800
Message-Id: <20181109041913.31032-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Xiong Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

mv command produces a leading string "renamed" from some time.
This breaks generic/398. Adding a _filter_mv to filter it out.
Tested this patch on Fedora 28.

sh-4.2$ rpm -qf /usr/bin/mv
coreutils-8.22-23.el7.x86_64
sh-4.2$ mv -v 1 2
=E2=80=981=E2=80=99 -> =E2=80=982=E2=80=99
sh-4.2$

h-4.4# rpm -qf /usr/bin/mv
coreutils-8.30-5.el8.x86_64
sh-4.4# mv -v 1 2
renamed '1' -> '2'
sh-4.4#

igned-off-by: Xiong Murphy Zhou <xzhou@redhat.com>
---
 common/filter     | 6 ++++++
 tests/generic/398 | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/common/filter b/common/filter
index e87740dd..ed082d24 100644
--- a/common/filter
+++ b/common/filter
@@ -504,6 +504,12 @@ _filter_mknod()
 	sed -e "s/mknod: [\`']\(.*\)': File exists/mknod: \1: File exists/"
 }
=20
+# Remove leading "rename" in "mv -v" output
+_filter_mv()
+{
+	sed -e "s/^renamed //"
+}
+
 _filter_lostfound()
 {
 	sed -e '/^lost+found$/d'
diff --git a/tests/generic/398 b/tests/generic/398
index 58b54af0..efb8348c 100755
--- a/tests/generic/398
+++ b/tests/generic/398
@@ -95,7 +95,7 @@ ln -v $edir1/efile1 $udir/efile1 |& _filter_scratch
 rm $udir/efile1 # undo
=20
 echo -e "\n*** Rename encrypted =3D> unencrypted ***"
-mv -v $edir1/efile1 $udir/efile1 |& _filter_scratch
+mv -v $edir1/efile1 $udir/efile1 |& _filter_scratch |& _filter_mv
 mv $udir/efile1 $edir1/efile1 # undo
=20
=20
@@ -119,9 +119,9 @@ src/renameat2 -x $edir1/efile1 $udir/ufile |& _filter=
_scratch
=20
 echo -e "\n\n*** Special file tests ***"
 mkfifo $edir1/fifo
-mv -v $edir1/fifo $edir2/fifo | _filter_scratch
-mv -v $edir2/fifo $udir/fifo | _filter_scratch
-mv -v $udir/fifo $edir1/fifo | _filter_scratch
+mv -v $edir1/fifo $edir2/fifo | _filter_scratch |& _filter_mv
+mv -v $edir2/fifo $udir/fifo | _filter_scratch |& _filter_mv
+mv -v $udir/fifo $edir1/fifo | _filter_scratch |& _filter_mv
 mkfifo $udir/fifo
 src/renameat2 -x $udir/fifo $edir1/fifo
 ln -v $edir1/fifo $edir2/fifo | _filter_scratch
--=20
2.17.0.252.gfe0a9ea
