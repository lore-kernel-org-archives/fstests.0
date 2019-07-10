Received: from youngberry.canonical.com ([91.189.89.112]:59977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfGJR65 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Jul 2019 13:58:57 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mfo@canonical.com>)
        id 1hlGrn-0007aw-Nj
        for fstests@vger.kernel.org; Wed, 10 Jul 2019 17:58:55 +0000
Received: by mail-qt1-f197.google.com with SMTP id s9so2981503qtn.14
        for <fstests@vger.kernel.org>; Wed, 10 Jul 2019 10:58:55 -0700 (PDT)
From: Mauricio Faria de Oliveira <mfo@canonical.com>
Subject: [PATCH] common/rc: print out kernel version too
Date: Wed, 10 Jul 2019 14:58:09 -0300
Message-Id: <20190710175809.13391-1-mfo@canonical.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The kernel version (uname -v) may also be needed in addition to
the kernel release (uname -r) in order to properly identify and
distinguish different kernel builds in some cases/distributions.

For example, in the Ubuntu kernel package the test/debug string
is usually a suffix to the version field, not the release field.

  $ uname -rv
  4.15.0-51-generic #55-Ubuntu SMP Wed May 15 14:27:21 UTC 2019

  $ uname -rv
  4.15.0-51-generic #55+test20190520b1 SMP Mon May 20 11:57:40 -03 2019

Looking at other OSes uname(1) man pages it looks like '-v' is
quite standard, and the Linux man page only cites '-p' and '-i'
as non-portable, so the change should be OK. The only caller is
the 'check' script for the header print out, so it's contained.

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index dcd591b33b87..000a7cc821cf 100644
--- a/common/rc
+++ b/common/rc
@@ -2794,7 +2794,7 @@ _full_platform_details()
 {
      local os=`uname -s`
      local host=`hostname -s`
-     local kernel=`uname -r`
+     local kernel=`uname -rv`
      local platform=`uname -m`
      echo "$os/$platform $host $kernel"
 }
-- 
2.17.1
