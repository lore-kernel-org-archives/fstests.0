Received: from mail-ua0-f196.google.com ([209.85.217.196]:38791 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdHICeE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Aug 2017 22:34:04 -0400
Received: by mail-ua0-f196.google.com with SMTP id x24so3254091uah.5
        for <fstests@vger.kernel.org>; Tue, 08 Aug 2017 19:34:04 -0700 (PDT)
Date: Tue, 8 Aug 2017 23:33:58 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH] generic: add test 307 to acl group
Message-ID: <20170809023354.GA4002@debian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail.com=
>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index e13b568..b9cd0e8 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -309,7 +309,7 @@
 304 auto quick clone
 305 auto quick clone
 306 auto quick rw
-307 auto quick
+307 auto quick acl
 308 auto quick
 309 auto quick
 310 auto
--=20
2.1.4

