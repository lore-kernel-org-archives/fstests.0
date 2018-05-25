Received: from sandeen.net ([63.231.237.45]:54142 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934496AbeEYOBA (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 25 May 2018 10:01:00 -0400
Received: from [10.0.0.4] (erlite [10.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id C8D094872EA
        for <fstests@vger.kernel.org>; Fri, 25 May 2018 09:00:43 -0500 (CDT)
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] xfs/206: filter/fix for minor geometry reporting changes
Message-ID: <a359b1fc-6f31-4a9b-08e5-ed62078cdce8@sandeen.net>
Date: Fri, 25 May 2018 09:00:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

The pending common geometry printing function has removed the fiddly
little differences between the various utilities, so now we'll need
to accommodate that in xfs/206, which looks at mkfs & growfs output.

all now print "internal log" vs. just "internal"
ascii-ci now always has a "," after it

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/206 b/tests/xfs/206
index 01782b7b..d5edf1ae 100755
--- a/tests/xfs/206
+++ b/tests/xfs/206
@@ -73,13 +73,16 @@ echo "=== truncate file ==="
  dd if=/dev/zero of=$tmpfile bs=1 seek=19998630180864 count=1 >/dev/null 2>&1 \
  	|| _fail "!!! failed to truncate loopback file to correct size"
  
+# mkfs/growfs output has changed slightly over the years, this distills
+# it down to a common set of output parameters we care about
  mkfs_filter()
  {
  	sed -e 's/meta-data=[^ ]*/meta-data=FILE/' \
  	    -e 's/ *isize=[0-9]* / isize=N /' \
  	    -e "s/\(^log.*blocks=\)\([0-9]*,\)/\1XXXXX,/" \
+	    -e "s/internal log/internal    /" \
  	    -e "s/, projid32bit=[0-9]//" \
-	    -e "s/ ftype=[0-9]//" \
+	    -e "s/,\? ftype=[0-9]//" \
  	    -e "/.*reflink=/d" \
  	    -e "s/\(sectsz\)\(=[0-9]* *\)/\1=512   /" \
  	    -e "s/\(sunit=\)\([0-9]* blks,\)/\10 blks,/" \
diff --git a/tests/xfs/206.out b/tests/xfs/206.out
index 2db839d0..be335600 100644
--- a/tests/xfs/206.out
+++ b/tests/xfs/206.out
@@ -6,7 +6,7 @@ meta-data=FILE isize=N    agcount=52, agsize=76288719 blks
  data     =                       bsize=4096   blocks=3905982455, imaxpct=5
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0
-log      =internal log           bsize=4096   blocks=XXXXX, version=2
+log      =internal               bsize=4096   blocks=XXXXX, version=2
           =                       sectsz=512   sunit=0 blks
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  === xfs_growfs ===

