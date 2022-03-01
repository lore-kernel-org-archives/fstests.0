Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1342C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Mar 2022 05:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiCBFoQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Mar 2022 00:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCBFoO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2022 00:44:14 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5238878B
        for <fstests@vger.kernel.org>; Tue,  1 Mar 2022 21:43:13 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220302054309epoutp012cc8c37651a96a368549c77f15eb92d9~YefyvxIfe2976329763epoutp01X
        for <fstests@vger.kernel.org>; Wed,  2 Mar 2022 05:43:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220302054309epoutp012cc8c37651a96a368549c77f15eb92d9~YefyvxIfe2976329763epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646199790;
        bh=K08UPjhlrK2JhhO7BLlAhplWpBiUTZql1aY87l2MOGg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EfQ0oMVErZN/JWDmmQUbCvpNegqrvgHl8YA99+F+1IjdVHaLLhJzWvqm7rxW4AVEb
         TPRsEfmhOkFZhk3iu8MT6+ge55hUtVKVWKDuif+ss1pgw8Ol82bNT+p5Ir75x6McZk
         yz+lqHkEnztvlskanpdJO1lZBgipiffFAh/vzLGA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220302054309epcas5p2ede51232501fa667d988cc6b44bfb9cd~Yefya8qio2564225642epcas5p2r;
        Wed,  2 Mar 2022 05:43:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4K7jh83Zwjz4x9QS; Wed,  2 Mar
        2022 05:43:04 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.3E.06423.7E30F126; Wed,  2 Mar 2022 14:43:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220301213529epcas5p2974c84878339d5661336533696d3938f~YX1-fQ3Aw0252402524epcas5p2P;
        Tue,  1 Mar 2022 21:35:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220301213529epsmtrp1b90f7ab74eba89366eba3ae2fed1959e~YX1-elL0Y1977619776epsmtrp1s;
        Tue,  1 Mar 2022 21:35:29 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-d9-621f03e74b21
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.95.29871.1A19E126; Wed,  2 Mar 2022 06:35:29 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220301213528epsmtip284c812eb7d4acc36ca06ac1586bf8233~YX1_bEj-d2432824328epsmtip20;
        Tue,  1 Mar 2022 21:35:27 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     fstests@vger.kernel.org
Cc:     nitheshshetty@gmail.com, p.raghav@samsung.com, joshi.k@samsung.com,
        arnav.dawn@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH] xfs/205,432,516: read sysfs for mkfs block size instead of
 hardcoded values
Date:   Wed,  2 Mar 2022 03:00:22 +0530
Message-Id: <20220301213022.28999-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmhu5zZvkkg88N4hZ7bn5mtTjdspfd
        4uj/t2wWNyY8ZbTY8aSR0WLb7/nMFp+XtrA7sHvsnHWX3WPTqk42j74tqxg9Pm+SC2CJyrbJ
        SE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpASaEsMacU
        KBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8b/x
        OnPBboGKR//SGxjf8HYxcnJICJhITL/8kqmLkYtDSGA3o8T+RZNZQBJCAp8YJRaeN4NIfGOU
        2LLkKhNMx62Nb6E69jJKrL31G8ppZZJonniBvYuRg4NNQFvi9H8OkAYRAWmJT/332EBqmAXm
        MErs+DofbIWwQJzE1rlbwGwWAVWJNe/WsYLYvAJWEh8OtrJDbFOWWPjwIFRcUOLkzCdg9cwC
        8hLNW2czgwyVEDjFLvH2/2kWiAYXiRMd/9kgbGGJV8e3QA2SknjZ38YO0dDNKPHjzH0mCGcG
        o0TzhGaoDnuJi3v+MoG8wCygKbF+lz5EWFZi6ql1TBCb+SR6fz+BhgWvxI55MLayxJr1C6DG
        SEpc+94IZXtIHN3fwwQJ1FiJ9qZ21gmM8rOQPDQLyUOzEDYvYGRexSiZWlCcm55abFpgmJda
        Do/Z5PzcTYzglKjluYPx7oMPeocYmTgYDzFKcDArifBe/CmTJMSbklhZlVqUH19UmpNafIjR
        FBjKE5mlRJPzgUk5ryTe0MTSwMTMzMzE0tjMUEmc93T6hkQhgfTEktTs1NSC1CKYPiYOTqkG
        Jp11C5TvNoXlHyrS/hFzct46b1nHkNcabRrz4goX60xX1Qn5eSH/P9v2tNc/D3+rfMByfedd
        hSOcUzqmbp8q13l3pWFhU4L1c+3a9VesWJ9LJbrWbheo3ma03jeCweHcKuED/Ct+vrmpN3vt
        i8zZz+dwnU1KPOFyl+nlxAdh85fInWv9cej/rviVay0mfpSMrFTaLPLn9KkSl8NTJYR3vn93
        qXSXUbdZYulN97VetxSkf6RyCAvPUpR6selZ3+S5CznnMs2+m+n89/Gr61+mrHk3TfeWwIWX
        By7z3vm01r/EcmuFfezxvZlTxaW+7k1PvX6z0/hxeuSnhd1XNPaZdd6dLP/oa9dXTb7bdfuv
        7f0QpcRSnJFoqMVcVJwIAMkvLQYSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSvO7CiXJJBlcWslrsufmZ1eJ0y152
        i6P/37JZ3JjwlNFix5NGRottv+czW3xe2sLuwO6xc9Zddo9NqzrZPPq2rGL0+LxJLoAlissm
        JTUnsyy1SN8ugSvjf+N15oLdAhWP/qU3ML7h7WLk5JAQMJG4tfEtUxcjF4eQwG5GiVOzO9kg
        EpISy/4eYYawhSVW/nvODlHUzCTR/O0RkMPBwSagLXH6PwdIjYiAtMSn/ntsIDXMAosYJW4s
        bAMbJCwQI/HvyzMmEJtFQFVizbt1rCA2r4CVxIeDrewQC5QlFj48CBUXlDg58wkLiM0sIC/R
        vHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOTS3NHYzb
        V33QO8TIxMF4iFGCg1lJhPfiT5kkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5ak
        ZqemFqQWwWSZODilGphkTs9jayk2s83ILp1xtfX1/a+d1zfmlJ29pW8tcCbpqZLI43vWl9N8
        PPUUTktcmcSpNaejKUin51rK2qlrDZuuaXXU3zofd2lrn5bdFhF5r4CPOS9+2aqdvZ9+dcft
        qp6zQU+cV/amF4V/FrWe/fDK+34Nmw2c/KdfzHsUH/3kc7dpmdcz3x3n/ylLPK4rrqq6PeWy
        vayjuNBDHSOlnjrJGBa/6QlGT6boZBssrG67PHW/l1rGjjrlCreaO6pz1/+ZcVMhqbLvaycL
        O8u+WU4Ry5sFHlS/DOSyNXrQfUKutYfLYIphs9vcvykG5lkPYm5rVMwoWbeN6b3mkfn921dP
        m15rPfnQjYTev09upSmxFGckGmoxFxUnAgCFfkhhvAIAAA==
X-CMS-MailID: 20220301213529epcas5p2974c84878339d5661336533696d3938f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220301213529epcas5p2974c84878339d5661336533696d3938f
References: <CGME20220301213529epcas5p2974c84878339d5661336533696d3938f@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

At present block size of 1024 is hardcoded for mkfs. This creates
problem when device block size is more than 1024. So we use sysfs values
of SCRATCH_DEV, if not found then default to 1024.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 tests/xfs/205 | 3 ++-
 tests/xfs/432 | 3 ++-
 tests/xfs/516 | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/xfs/205 b/tests/xfs/205
index 104f1f45..73e32c4d 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -22,7 +22,8 @@ _require_scratch_nocheck
 # bitmap consuming all the free space in our small data device.
 unset SCRATCH_RTDEV
 
-fsblksz=1024
+physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
+fsblksz=${physical:-1024}
 _scratch_mkfs_xfs -d size=$((32768*fsblksz)) -b size=$fsblksz >> $seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/432 b/tests/xfs/432
index 86012f0b..cd6367e2 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -49,7 +49,8 @@ echo "Format and mount"
 # block.  8187 hashes/dablk / 248 dirents/dirblock = ~33 dirblocks per
 # dablock.  33 dirblocks * 64k mean that we can expand a directory by
 # 2112k before we have to allocate another da btree block.
-_scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
+physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
+_scratch_mkfs -b size=${physical:-1k} -n size=64k > "$seqres.full" 2>&1
 _scratch_mount >> "$seqres.full" 2>&1
 
 metadump_file="$TEST_DIR/meta-$seq"
diff --git a/tests/xfs/516 b/tests/xfs/516
index 9e1b9931..b9d4f0c9 100755
--- a/tests/xfs/516
+++ b/tests/xfs/516
@@ -84,7 +84,8 @@ test_su_opts()
 	local mounted=0
 
 	echo "Format with 256k stripe unit; 4x stripe width" >> $seqres.full
-	_scratch_mkfs -b size=1k -d su=256k,sw=4 >> $seqres.full 2>&1
+	physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
+	_scratch_mkfs -b size=${physical:-1k} -d su=256k,sw=4 >> $seqres.full 2>&1
 
 	__test_mount_opts "$@"
 }

base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
-- 
2.25.1

