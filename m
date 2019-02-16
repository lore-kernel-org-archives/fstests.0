Received: from mx1.redhat.com ([209.132.183.28]:52598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfBPHZq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 16 Feb 2019 02:25:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D3D85944F
        for <fstests@vger.kernel.org>; Sat, 16 Feb 2019 07:25:46 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28B105D9C6
        for <fstests@vger.kernel.org>; Sat, 16 Feb 2019 07:25:44 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] fsstress: avoid infinite zero byte reading
Date: Sat, 16 Feb 2019 15:25:40 +0800
Message-Id: <20190216072540.26272-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

copyrange_f and splice_f functions use a while loop to read a file,
it's fine if there's only one fsstress process(and its children),
but if some third part testing processes remove the file in the
middle phase of copyrange_f running, copyrange_f maybe always return
0, and the while loop can't be end. As below:

root     47184  xxxxxx S+ ./fsstress -R -d /mnt/scratch -n 10000 -p 20 -v
root     47187  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
root     47199  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
root     47314  xxxxxx S+ grep --color=auto fsstress
...
...
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
...
...
lr-x------. 1 root root 64 Jan 28 11:34 /proc/47187/fd/3 -> '/mnt/scratch/p2/f2 (deleted)'

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V2 remove 300 times loop, just return if get ret == 0

Thanks,
Zorro

 ltp/fsstress.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index 25e0c3e2..138f7ecf 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -2363,7 +2363,7 @@ copyrange_f(
 	int			v2;
 	int			fd1;
 	int			fd2;
-	size_t			ret;
+	size_t			ret = 0;
 	int			e;
 
 	/* Load paths */
@@ -2452,7 +2452,7 @@ copyrange_f(
 		if (ret < 0) {
 			if (errno != EAGAIN || tries++ >= 300)
 				break;
-		} else if (ret > len)
+		} else if (ret > len || ret == 0)
 			break;
 		else if (ret > 0)
 			len -= ret;
@@ -2908,6 +2908,9 @@ splice_f(int opno, long r)
 
 		len -= ret1;
 		total += ret1;
+		if (ret1 == 0) {
+			break;
+		}
 	}
 
 	if (ret1 < 0 || ret2 < 0)
-- 
2.17.2
