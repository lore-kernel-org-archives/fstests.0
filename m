Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320ABC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237216AbiAXLK4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiAXLK4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022657; x=1674558657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgEGgT9hg08/vaCtBuyGS4ntdQzvuj9kMy+3OGsW+xU=;
  b=buqXgVX87EKcICR31ZsUSDp4QP9hf8MMuZBCYHq54vEif/XmnyRYbiiv
   XniBfw99pTyFWciSoJidE7ZWmDn1b4NgBUQZE6JPFrG/+L6gVrmd7YiSM
   6BnA29hhtn2YitUCFlcChnA6c0qTU/AC5NOgeBAN/P0f/BeZrCOPySmYt
   Dg4VvY5zEhWFHHXSTjY8tqw2DbfzRSUcwy96A1LViGYYfwAnvTVVygOcF
   pD+PhQ+bZ1nIhC+6Lym61SeTnJoPrU9sKZTaBj75sIWqb87J8WFu+YgK5
   1I1fFjx90jCV/x+D9R51roSiruzNejWcbNLUoYkaSUq0oX6GwD94iw5t9
   A==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220965"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:56 +0800
IronPort-SDR: sOF+anerVxUYJalSlisq9O4YvhfFNeBqZq6cxEvE+NfAkGJF5z/HahDXC2kyy5FJI2Kt4+rU6F
 I8dVvICArOlb49aogDRkbe8USGNGtThEmYz7lkRdcFiqxO5lZ0CCh5fWTKcHwyc17wKP/tBlyH
 f4wNiYEeisg7916K2rvxEb8a03J6X1fRqgO148pfOzQLefQYiryM1A02+XSEd9fsBo56x5TOrb
 kTPGP3TWGIOk12Npd5jGFvuB1Sw23tJlJJ1yKOSP2Z1kDlJRFjEQnRZcEZGQsLtxm/IvUH660U
 fito1h+VPj2Zt5bdJTImZiXb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:19 -0800
IronPort-SDR: ApNbLJS+jhHjuOwdZ2crhHgdj+1EFGVmQxI5xqW7N+pZGdHvJEt22ay5ZHZGHznhVOywn0NsJB
 Dqcv0W3GyDCn/54I3W6MOnv/ElGR8wBYJdsZvEOU3N0tfIXn1j+moSghvYtHBb9BKtuMTwDOEu
 Fm5MGplFAsvKDJPk2yjtjheUpAfGPru4ojZAdRgQx4F6KZqGtirzv5BSH5E7tkNkyskP6BAwFu
 7Fw8TQ7cb3JYnyqvEZ1J2jicSFT4Gs9laNm9GQUUPbdAaJW1SNGjkMteN23zjDc+wvvoWIoHJQ
 jKA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:55 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 4/7] xfs/015: check _scratch_mkfs_sized return code
Date:   Mon, 24 Jan 2022 20:10:47 +0900
Message-Id: <20220124111050.183628-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test cases xfs/015 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/xfs/015 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/015 b/tests/xfs/015
index 86fa6336..2bb7b8d5 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -43,7 +43,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT 131072
 _scratch_unmount
 
-_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw
+_scratch_mkfs_sized $((32 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 # get original data blocks number and agcount
 . $tmp.mkfs
-- 
2.34.1

