Received: from mail-qt0-f194.google.com ([209.85.216.194]:33343 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdGSEGk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Jul 2017 00:06:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id 50so3716637qtz.0
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 21:06:40 -0700 (PDT)
Date: Wed, 19 Jul 2017 01:06:35 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [xfstests PATCH] common/attr: fix check for _require_attrs()
Message-ID: <20170719040632.GA6712@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>, Christoph Hellwig <hch@infradead.org>
List-ID: <fstests@vger.kernel.org>

As of now xfstests decides if a filesystem supports attributes by trying
to write one to the mount point. For some reason this fails on reiserfs,
making it impossible to run tests that _require_attrs.

Fix this by checking against $TEST_DIR/syscalltest instead of $TEST_DIR.

This is probably what was intended, since the syscalltest file is touched
right before running attr. It is also consistent with how the check for
acl support is done.

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
 common/attr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/attr b/common/attr
index c840ce4..21ebbcd 100644
--- a/common/attr
+++ b/common/attr
@@ -217,7 +217,7 @@ _require_attrs()
     # stored on disk.
     #
     touch $TEST_DIR/syscalltest
-    attr -s "user.xfstests" -V "attr" $TEST_DIR > $TEST_DIR/syscalltest.=
out 2>&1
+    attr -s "user.xfstests" -V "attr" $TEST_DIR/syscalltest > $TEST_DIR/=
syscalltest.out 2>&1
     cat $TEST_DIR/syscalltest.out >> $seqres.full
=20
     if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; the=
n
--=20
2.1.4

