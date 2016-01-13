Received: from mail-wm0-f53.google.com ([74.125.82.53]:33030 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbcAMVO6 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 13 Jan 2016 16:14:58 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so312752837wmf.0
        for <fstests@vger.kernel.org>; Wed, 13 Jan 2016 13:14:57 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 13 Jan 2016 13:14:56 -0800
Message-ID: <CAJ4mKGaujPbYfwY9GDUPTYQz5BqU6YG=+SRjOj+6hp0pUEEYOA@mail.gmail.com>
Subject: broken fsx compilation
From: Gregory Farnum <gfarnum@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

We use xfstests in the Ceph test lab and are finding that fsx is
failing to build correctly on those boxes (Ubuntu 14.04.3, nothing
especially odd about them that I'm aware of):

fsx.c: In function 'logdump':
fsx.c:298:3: error: unknown type name 'bool'
   bool overlap;
   ^

It works fine on my (old) Fedora dev box (and presumably on the boxes
of everybody who put it in the tree) so I assume there's something
going on with the build chain and environment, but it's not obvious
what that would be to me. And it's pretty simple to just add stdbool.h
to the header list like you're supposed to for C99 (I can't find any
updates to that for C11, but I don't know what your standards are or
if I'm missing something).
-Greg


==========


commit adb8c2cdfa6e30a411529d30c9df96ad47ec918f
Author: Greg Farnum <gfarnum@redhat.com>
Date:   Wed Jan 13 12:51:47 2016 -0800

    fsx: include stdbool.h

    Signed-off-by: Greg Farnum <gfarnum@redhat.com>

diff --git a/ltp/fsx.c b/ltp/fsx.c
index 28f109c..9005ef9 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -30,6 +30,7 @@
 #include <string.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <stdbool.h>
 #ifdef AIO
 #include <libaio.h>
 #endif
