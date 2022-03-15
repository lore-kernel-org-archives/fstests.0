Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E4C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Mar 2022 20:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiCOUTz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351647AbiCOUTx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Mar 2022 16:19:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299E255B8
        for <fstests@vger.kernel.org>; Tue, 15 Mar 2022 13:18:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220315201835euoutp02fada569f509cf22e97e6fb7bfd11c699~cp02bVKoX3109731097euoutp02C
        for <fstests@vger.kernel.org>; Tue, 15 Mar 2022 20:18:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220315201835euoutp02fada569f509cf22e97e6fb7bfd11c699~cp02bVKoX3109731097euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647375515;
        bh=xdsXQ8sddFoUuZW6GOfudqkLsQ5FyhLZrThfVDX2FQ8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=mYGJLz/LDcIBdnO6BlTQZ8MIZxzWLCFIAmuCVWD/1DJqawA9SP7Yw5w+QkPgAFbyJ
         lvK99mx1VbkBQu/g1lpC1zGLZn27UY+rAJZHtyb7VPGG6OYEmkICs4+l3y9Xn8gw3H
         wPr6gEeC1jXQ41j9TgJfTrAE7vq/75b6dV+vjA0w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220315201835eucas1p14f924fcee7eaff54d12e6aad40458529~cp02AVnPY1805818058eucas1p1X;
        Tue, 15 Mar 2022 20:18:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 88.71.10260.A94F0326; Tue, 15
        Mar 2022 20:18:34 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90~cp01S2ga41168611686eucas1p1K;
        Tue, 15 Mar 2022 20:18:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220315201834eusmtrp23f1350aa502e14ef4e717da840e33fa3~cp01SJdQm1458214582eusmtrp2N;
        Tue, 15 Mar 2022 20:18:34 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-4a-6230f49a6d43
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.C2.09404.A94F0326; Tue, 15
        Mar 2022 20:18:34 +0000 (GMT)
Received: from localhost (unknown [106.210.248.212]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220315201833eusmtip2aa9de0bfce94ffd103d2958bf62a2538~cp0062wj_2961129611eusmtip2d;
        Tue, 15 Mar 2022 20:18:33 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] btrfs/237: Use zone cap instead of zone size in fill_size
 and rest calculation
Date:   Tue, 15 Mar 2022 21:17:56 +0100
Message-Id: <20220315201756.18829-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTYRDNt7u0S2NlaT1GxKuIQQ2HUXS9iESJTTRqNP5QIdralavU0oJ3
        Imq1iIiKkmJFQQhYUFOpghRDhBJEKUigHmAQolCjSBUCHlgFLVuj/97Me++bN5OPxAXXPHzI
        WEUSo1JI5CIOjyh/NPw0UD8UIg2peBtK62pn0c6mZpy2aqq4dHfHIJf+ldaJ0c2OWoxuO29H
        9GChhkvfarcTqzzFZv1rrthUcpojNp/s8hBn3CtB4kHTdLG2+gy2ibOdt0LGyGP3MargsF28
        mLrqT7hywOuAruUEkYKK+GnIkwRqETh/tOBpiEcKKAOC0vyX7mIIwaihA7HFIIK3nQ7uX4vB
        nMVliRsIusqrPFyEgPqAoLlscRoiSQ41D46dHtNPoNZD3YuysYdwqgoDbeVTjosQUhJob+lH
        LkxQ/lCQrhkz8KmloDt2H7HDZsDl1m/uvjc8udxDuDD+p3+i7MpYVKAqSEjvO8V1DQZqDRS0
        xbFeIfTW33OH9oVRcy7G6s8hyNL8dBfZCNJr72KseTlkNMpdEKfmgrEymPWGw2innmAV46HN
        4c1GGA+Z5TqcbfMh9ZSAVYvAPNzjngpgO55DsFgM1qFXGHupKOjRNnLPo5n6/xbT/7eY/l+G
        PISXoMlMsjohmlEvVDD7g9SSBHWyIjpo994EE/rzhawj9V8qkKF3IMiCMBJZEJC4aAK/8X2w
        VMCXSQ4eYlR7d6qS5YzagqaShGgyf3fsHYmAipYkMfEMo2RUf1mM9PRJwS5cn1bdnjj7QIGl
        iOe17p3MTihtH+t7KZHVEB9q/G7uup4fGiV0FicW1oy8OZKhy8UrDMKb/ZdWdhde2DKx37In
        +nmqX8C4zd8yZWuys42VVXOC5eW+HtKtisInZwI3xbyGGFN4xPuRdZFvahpoy2OjsTvcWJMY
        9zDdplRNsbUNIGdYQF1Hxidy7c8lDYe6NPEbHTKvh48XEznSqKMDnZFffRSB2szSjjBn8eGI
        nuf+dtHZrC/jWkO0hh0NdZwQ++rhZ58xs3WZNoDve/FRywcpx9Ynvt001db6snXSgzzGFrHC
        Z7ojtdZiNGyIMzUdFtrmb0vy80/ZcXPkarHyl4hQx0gWzMNVaslvzoVuz7EDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xe7qzvhgkGXRsZ7OYfljR4vfZ88wW
        p1v2sls8vvOZ3eJv1z0mi/NvDzNZ3JjwlNHi89IWdos1N5+yOHB67Jx1l91j06pONo+drfdZ
        Pfq2rGL0+LxJzqP9QDdTAFuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+
        nU1Kak5mWWqRvl2CXsbRA++YCz7yV0y/2MzSwLiMt4uRk0NCwERixc6p7F2MXBxCAksZJZb2
        bGKCSEhI3F7YxAhhC0v8udbFBlH0nFHi648O1i5GDg42AS2Jxk52kBoRAT+JyZ1NTCA1zAIH
        mSR+X5nNBpIQFoiXuHDxIzOIzSKgKrG4pwWsgVfAUmJ643aoBfISMy99h4oLSpyc+YQFxGYG
        ijdvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIjYNuxn1t2MK58
        9VHvECMTB+MhRgkOZiUR3jMv9JOEeFMSK6tSi/Lji0pzUosPMZoC3TeRWUo0OR8Yg3kl8YZm
        BqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxMLMoRe+LOZ6qsDXuopJB5
        Mi/qzNHHfj83dbLazxKfJfH62aQzb1+0PNT0XFl5xvaM7r9Fa7a9/+D1YdHa7ZntvE/cKr/9
        Pa2hL77vXsHhdXvWz7CZ7Lh81bSLT65bHSiyP3f1988O/8t/OpqeLC0tvOL5VCu7cX5OYsOD
        K3WeqrnHSt6qnz15NEtR+3szu0G1OMuSKzqpkh0PDhywUDbv3Vraxmg6tStwz8EJljy7s/y+
        8j9o3KI2TUJH9VrezDdH+TJZqx+ZLfv/eSPnswkzLr56dfT2uVkL9kQXJu+f0Mxs87zo3jp9
        7vc7I/db62xQEY0remF4sMalVeTELp5DS5fGl3LPWmpz9D9Pi7myihJLcUaioRZzUXEiALmc
        IIgJAwAA
X-CMS-MailID: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90
References: <CGME20220315201834eucas1p14717bdbd666dd59b2ef4c86f42bfeb90@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test will break when zone capacity != zone size because the
calculation of the size to be filled is done using zone_size instead of
the actual capacity available per zone. Fix it by using zone capacity.

The support to extract zone capacity was added to blkzone only from
version 2.37. So zcap will be used only when the blkzone version is
greater or equal to 2.37.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 tests/btrfs/237 | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 96940549..6d3fe2f2 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -36,7 +36,21 @@ get_data_bg()
 }
 
 zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
-zonesize=$((zonesize << 9))
+size=$((zonesize << 9))
+
+# blkzone supports printing zone cap only after version 2.37
+_blkzone_req_major_ver=2
+_blkzone_req_minor_ver=37
+blkzone_ver=$($BLKZONE_PROG --version | cut -d " " -f 4 | cut -d "-" -f 1)
+blkzone_ver=( ${blkzone_ver//./ } )
+blkzone_major_ver=${blkzone_ver[0]}
+blkzone_minor_ver=${blkzone_ver[1]}
+if [[ $blkzone_major_ver -ge $_blkzone_req_major_ver &&\
+	$blkzone_minor_ver -ge $_blkzone_req_minor_ver ]]; then
+	zonecap=$($BLKZONE_PROG report -c 1 $SCRATCH_DEV |\
+		grep -Po "cap ([0x\d]+)+" | cut -d ' ' -f 2)
+	size=$((zonecap << 9))
+fi
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount -o commit=1 # 1s commit time to speed up test
@@ -53,8 +67,8 @@ reclaim_threshold=75
 echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
 fill_percent=$((reclaim_threshold + 2))
 rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
-fill_size=$((zonesize * fill_percent / 100))
-rest=$((zonesize * rest_percent / 100))
+fill_size=$((size * fill_percent / 100))
+rest=$((size * rest_percent / 100))
 
 # step 1, fill FS over $fillsize
 $XFS_IO_PROG -fc "pwrite 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
-- 
2.25.1

