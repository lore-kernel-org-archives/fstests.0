Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C301C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Mar 2022 05:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiCXF42 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiCXF41 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Mar 2022 01:56:27 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC91F811BA
        for <fstests@vger.kernel.org>; Wed, 23 Mar 2022 22:54:55 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220324055451epoutp04ec1c43a17bb5a0e78fe5f5578a776b54~fO2SGusMK3018130181epoutp04W
        for <fstests@vger.kernel.org>; Thu, 24 Mar 2022 05:54:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220324055451epoutp04ec1c43a17bb5a0e78fe5f5578a776b54~fO2SGusMK3018130181epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648101291;
        bh=arVDzRfLe1n1Y/d4pmjBjwef1ydwdOZHUtuA2NIq/kI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QIOt09rliyCYK5p1Tg2x1ACAiDcka5Ifes2GNGf2Pgm41HEav8hKB16+c1vAl3Rod
         MjgDP04+O6Zv9L2+OCxuxDYkvchz4RmmUHEaNnFK7hBs9Qmm4bEpZKTDV9qSh2ORqz
         teHHql5OhdmiveX0Hd1Qk40gClMpg++j+5yNtP7I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220324055450epcas5p496fdf598a29397ed9ed319eac2e47cc6~fO2QxuoT_2626226262epcas5p4i;
        Thu, 24 Mar 2022 05:54:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KPDvQ18j8z4x9Py; Thu, 24 Mar
        2022 05:54:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.CF.05590.C970C326; Thu, 24 Mar 2022 14:54:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220323181155epcas5p4892cb43ae57077d34f56baa848f152ce~fFQjA8Odn0612606126epcas5p4K;
        Wed, 23 Mar 2022 18:11:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220323181155epsmtrp126b6027b71573c6060bf40cfb7b1b2dc~fFQjANq6Q2763527635epsmtrp1l;
        Wed, 23 Mar 2022 18:11:55 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-1c-623c079c7313
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.EC.03370.BE26B326; Thu, 24 Mar 2022 03:11:55 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220323181154epsmtip21dc5c8c3d284394b6762216cc86847a9~fFQhjSb7t2395923959epsmtip2f;
        Wed, 23 Mar 2022 18:11:54 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     fstests@vger.kernel.org
Cc:     nitheshshetty@gmail.com, p.raghav@samsung.com, joshi.k@samsung.com,
        arnav.dawn@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] generic/108: use blockdev utility to calculate physical and
 logical block size
Date:   Wed, 23 Mar 2022 23:36:43 +0530
Message-Id: <20220323180643.29164-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTQ3cOu02SQXeXmsWem59ZLS4/4bM4
        3bKX3eLo/7dsFjcmPGW02PGkkdFi2+/5zBafl7awWzyY94XdgdNj9bM5TB47Z91l99i0qpPN
        o2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgO5RUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+Wl
        llgZGhgYmQIVJmRn9Bx5zV7wkL3izv+b7A2Md9m6GDk5JARMJN6+62bvYuTiEBLYzSjR0DmZ
        BcL5xCjR86OJGcL5zChx6Oo1oAwHWMu1RzoQ8V2MErfm/oZqb2WSmLdyIRtIEZuAtsTp/xwg
        K0QEpCU+9d8DW8cs8JpR4tpMKRBbWCBRYtaCHkYQm0VAVWLW9RZmEJtXwErix5TtjBC79CX6
        7wtChAUlTs58wgIxRl6ieetsZogP7rFL3JrvCWG7SFy7cx7qM2GJV8e3sEPYUhIv+9vAzpQQ
        6GaU+HHmPhOEM4NRonlCM1SHvcTFPX+ZQBYzC2hKrN+lDxGWlZh6ah0TxGI+id7fT5gg4rwS
        O+bB2MoSa9YvgBojKXHteyOU7SGxvHcBK8hIIYFYiVPzNScwys9C8s4sJO/MQli8gJF5FaNk
        akFxbnpqsWmBcV5qOTxak/NzNzGCE6WW9w7GRw8+6B1iZOJgPMQowcGsJMJ7/7J1khBvSmJl
        VWpRfnxRaU5q8SFGU2AQT2SWEk3OB6bqvJJ4QxNLAxMzMzMTS2MzQyVx3lPpGxKFBNITS1Kz
        U1MLUotg+pg4OKUamEovOaQ5RScZbpvW+eFkwj4GKQ0Jzdc7Alb+6xV/aqFiEpVsV2Ky9ljT
        0iTdGxrdCkYvlsrysmnO8bgnLdn3dl3T1Q+TmE9MPPR51xfryORNu/kYTtyN/zGHX67KlmXl
        zDXaYmmCF0ruGpu3L1qwYO9724jdDWLC1U+DnjlIH1SYk/0zoVMz/5Oluv7dmC98z7JTr+b8
        +5a/ktM0yfeTTCB3vPrdEOFnRl0XtmjpMqrYBpZwGZmXMbqxph0N4VhW3Nb5UP5Xmdj+ZWl7
        ppt0+pTc+bTS8a2DrBTbhVVXGC9P5jjwN/uGh+n1lmOzUrc4qVwLaL2RpuP2cP3WyYH3IhaX
        t5Ue7DJd4dhzNIZZiaU4I9FQi7moOBEAGrzDch0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvO7rJOskg0n95hZ7bn5mtbj8hM/i
        dMtedouj/9+yWdyY8JTRYseTRkaLbb/nM1t8XtrCbvFg3hd2B06P1c/mMHnsnHWX3WPTqk42
        j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MroOfKaveAhe8Wd/zfZGxjvsnUxcnBICJhIXHuk
        08XIxSEksINR4vrHiexdjJxAcUmJZX+PMEPYwhIr/z1nhyhqZpK4+GgZO0gzm4C2xOn/HCA1
        IgLSEp/677GB1DALfGaUmDBjJ1izsEC8xLonX1hBbBYBVYlZ11vA4rwCVhI/pmxnhDhCX6L/
        viBEWFDi5MwnLCA2s4C8RPPW2cwTGPlmIUnNQpJawMi0ilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOGi1tHYw7ln1Qe8QIxMH4yFGCQ5mJRHexR/Mk4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgmuW0jCv03x6j3xfvrmfJiXTmn783sERP
        6WZPLJdphFrtjyYb36Oyto0Xoo5+l14pL7TNcWn8lb+uM3Oubf4dfqAv9Kobc6SCqXFXfAbz
        lXv1E47+PZh7x8gyrvSK98l+s9bmM3/s5z6MO7u9t3CfzAn2iSyMkceXG6hNWVU5Ozrham9d
        TsXlJsHO4O3Lvy7O0cl//Gzyz4PpTaqH4pkvXZQ53uKWx/ZLPelU5/kOGym7Cc4X3r6X3Syc
        tC9vyWlV7djzOw70MZ99feCgq6/lpit3CjwPLJeb9841qOP87PMHlvGWlzb7FV8P220pdPbJ
        i95niZ0LNrWlfLq8mV3wP3ellenObf+i+mqZs+KmK7EUZyQaajEXFScCAJktFDXJAgAA
X-CMS-MailID: 20220323181155epcas5p4892cb43ae57077d34f56baa848f152ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220323181155epcas5p4892cb43ae57077d34f56baa848f152ce
References: <CGME20220323181155epcas5p4892cb43ae57077d34f56baa848f152ce@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Reading sysfs to get physical and logical block fails,
if SCRATCH_DEV is partitioned device.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Reported-by: Darrick J. Wong <djwong@kernel.org>
Reported-by: Wang Yugui <wangyugui@e16-tech.com>
---
 tests/generic/108 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/108 b/tests/generic/108
index db0e9bd0..efe66ba5 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -42,8 +42,8 @@ _require_non_zoned_device $SCRATCH_DEV
 lvname=lv_$seq
 vgname=vg_$seq
 
-physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
-logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
+physical=`blockdev --getpbsz $SCRATCH_DEV`
+logical=`blockdev --getss $SCRATCH_DEV`
 
 # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
-- 
2.25.1

