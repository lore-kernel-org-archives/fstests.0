Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D79BC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Mar 2022 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiCBFoP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Mar 2022 00:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbiCBFoO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2022 00:44:14 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA7359A56
        for <fstests@vger.kernel.org>; Tue,  1 Mar 2022 21:43:07 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220302054302epoutp02f4071fef66f51f2fb87b1ea057081c51~YefrqlT4Z2511025110epoutp02-
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 05:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220302054302epoutp02f4071fef66f51f2fb87b1ea057081c51~YefrqlT4Z2511025110epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646199782;
        bh=BO6JvB1K1CLF91KJEyr3BRshnaYR4QnJl0k/P+IRdzY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kaNdXnNDJDvGevYL5WnJISeo01TksHhPCq+L3xhe7mWh/YluUOgj5q1z0b9xC/Yyn
         ZSMm+PzKG/77rM/qD8vJKLy7gXkVwb6UkI+tLCEhjKMRMzbpu2fTjkdWMYPfBQhWso
         whebFvttPOp3OZvJqMYbkPA1t/QUfFWYKLLg4BdE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220302054302epcas5p4050c3e479a3f609d88557f79231ec61c~YefrVcTYI0483304833epcas5p4G;
        Wed,  2 Mar 2022 05:43:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K7jgz51qsz4x9QF; Wed,  2 Mar
        2022 05:42:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.5E.46822.C120F126; Wed,  2 Mar 2022 14:35:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd~YX1gLxqdi1483814838epcas5p3F;
        Tue,  1 Mar 2022 21:34:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220301213455epsmtrp1a7c7264031eaefcd531d5c931201ae8e~YX1gLCvqV1945219452epsmtrp1B;
        Tue,  1 Mar 2022 21:34:55 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-9b-621f021cf6ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.65.29871.F719E126; Wed,  2 Mar 2022 06:34:55 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220301213454epsmtip28f06e4dc6cc62d7b86e5b1ae40d1fbf8~YX1fFd-D52648426484epsmtip2A;
        Tue,  1 Mar 2022 21:34:54 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     fstests@vger.kernel.org
Cc:     nitheshshetty@gmail.com, p.raghav@samsung.com, joshi.k@samsung.com,
        arnav.dawn@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH] generic/108: use sysfs values for logical,physical block
 size in scsi_debug
Date:   Wed,  2 Mar 2022 02:59:47 +0530
Message-Id: <20220301212947.28660-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmlq4Mk3ySwZoGc4s9Nz+zWpxu2ctu
        cfT/WzaLGxOeMlrseNLIaLHt93xmi89LW9gd2D12zrrL7rFpVSebR9+WVYwenzfJBbBEZdtk
        pCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2gpFCWmFMK
        FApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOOHr2
        C2vBT86KD83fWBsY93J0MXJySAiYSHTf+80CYgsJ7GaU6NrOA2F/YpTY1yDbxcgFZH9jlLi8
        exMbTMOd5zvZIBJ7GSXWnD8J5bQySRz6Momxi5GDg01AW+L0f7ANIgLSEp/674HVMAvMYZTY
        8XU+2DphgTiJHWdPsYPYLAKqEuenTmAEsXkFrCQuftjGBLFNWWLhw4OsEHFBiZMzn4D1MgvI
        SzRvnc0MMlRC4BS7xMLra5khGlwkNm1dxwJhC0u8Or6FHcKWknjZ38YO0dDNKPHjzH0mCGcG
        o0TzhGao5+wlLu75ywTyArOApsT6XfoQYVmJqafWMUFs5pPo/f0E6jpeiR3znsBdumb9Aqgx
        khLXvjdC2R4Sm3bsZAYZKSQQK7HwlcAERvlZSP6ZheSfWQiLFzAyr2KUTC0ozk1PLTYtMMpL
        LYdHbHJ+7iZGcELU8trB+PDBB71DjEwcjIcYJTiYlUR4L/6USRLiTUmsrEotyo8vKs1JLT7E
        aAoM5InMUqLJ+cCUnFcSb2hiaWBiZmZmYmlsZqgkzns6fUOikEB6YklqdmpqQWoRTB8TB6dU
        A9MUCau3WncddJ185Hb5de1LXyF+qWPWh5xb6lPkFeK9m6xyy/i/9HU0PC0KVruSaqVckW6i
        reWkL3aj/EyWpbHH77jfZ1ND7RRtGW4n/Dk94cimL5tiAx/63zrx4Srf1zcTdu1xqz5x0L5W
        asua3DWv9ov8zX0T99rqYpXK5472x5ukeNazPWmy1ol+ul63aVXKwmOCmu5cjEs/v827LupV
        P6f1hiLf+tnvK7x/VP+r3CQczen2YOWZv4ULBJretzy5l1uxbD/j5Pule5/cDqiocflxmLVg
        /1X+DU7bS6UO32+yK8w4Fzgl6vLMqfobhGanTvtt07dEtuP7UbvDd0+9vxduv7F1wrJ10lfm
        n+pWYinOSDTUYi4qTgQA6iRCEhEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvG79RLkkg8m7pC323PzManG6ZS+7
        xdH/b9ksbkx4ymix40kjo8W23/OZLT4vbWF3YPfYOesuu8emVZ1sHn1bVjF6fN4kF8ASxWWT
        kpqTWZZapG+XwJVx9OwX1oKfnBUfmr+xNjDu5ehi5OSQEDCRuPN8J1sXIxeHkMBuRome5U1M
        EAlJiWV/jzBD2MISK/89Z4coamaSuNJ9G8jh4GAT0JY4/R9skIiAtMSn/ntgg5gFFjFK3FjY
        xgaSEBaIkTh4ZR4LiM0ioCpxfuoERhCbV8BK4uKHbVDLlCUWPjzIChEXlDg58wlYPbOAvETz
        1tnMExj5ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzg4tTR3MG5f
        9UHvECMTB+MhRgkOZiUR3os/ZZKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKa
        nZpakFoEk2Xi4JRqYJJ7qCq8JLr24H+L1xyzdp3Qru+tUBPZHu3r9vNv5o9Fq3uMPv178XTD
        qvuT/ebt8CovL9VcE92Rw3/0VzbPK0FOY4sTn9q7NCZtuSznqOAqd0nl8DaeCacaf678aht3
        V8Zm3jq2aZf6VfR0LoYFhXGWZSye2H51y+Mdxc92JpZIeHWlXdi5fnX4lPOrtL4kS67pmvzk
        ecqP9Nvbw5u3t11fECo5ufzYg5+qfiuvr93n/r837XeKenqR/s+EJ8szzLcxhew0zCtd6chw
        3UJ3roEmy6EVJ5bm56RubdsY3qXv6BM3x/Tylv7aPz1/X7hP4P2wPzR+8pnGwB8PhTq0lees
        nbzT80G1wZ8Hn2/2mpxQYinOSDTUYi4qTgQAalheDL0CAAA=
X-CMS-MailID: 20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

scsi_debug device used for test, is created with assumption of 512 bytes
logical and physical block size.
This causes error in lvcreate step, when SCRATCH_DEV device lba is not
512 bytes. This can be solved by reading block size from sysfs of device.
If sysfs is missing fallback to 512 bytes as default.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 tests/generic/108 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/108 b/tests/generic/108
index ad43269f..db0e9bd0 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
 lvname=lv_$seq
 vgname=vg_$seq
 
+physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
+logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
+
 # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
-SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 300`
+SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
 

base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
-- 
2.25.1

