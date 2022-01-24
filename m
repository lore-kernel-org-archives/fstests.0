Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F5C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiAXLKy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbiAXLKx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022654; x=1674558654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=idwp4jc/QAVEFUQVf8MZDIzrI3N1bIZ5u5TYl/0A1rs=;
  b=cnqsOow0z+gREA6MpU2p8MCiIre7hqg81eB5Ifp93ES4kK1CoqDEXUIa
   5SfAVBrsFDBszre7gaerSSfah2YdJv9ojfVswzMS8HRG5QIs22QTgeyUI
   ihFhqWLZN8TVNNkKCvMSPHPWGDfkD+3GdBYJ5cg1yxwwxCDVaN17v8FQ3
   5dXl4m29Ox57iVphR6zSemgoi8W9POS6FoD/OsSV/eZF6COGrdIx7sMuj
   h1UTjPcqZ+3Ssjng/q6AgMjmCWtcJ6rW+91u+IuDAZ/RGixJ0BxKYZKyf
   HdAlTuw+9PgdSQLzOubHsC5pY1g+0fiVQsl+0g8aTz4ADVv6ZESuLNqf7
   w==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220948"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:53 +0800
IronPort-SDR: Y3NO3wFbd5JxEerKYWClKxUrArpjECaFWZPQ5p9LZNSE+XMA4RPuqT6qJ+YfcaabHsFK1AnLSr
 jnPMkvrVl7UZwGCdBHhUWAqtOhQRjcwOGRndXq652BElsxUHrjFXqFaO9lrjrtZC55LczYgSuX
 aXnxNNeB64Q4a79iVQ5pZBGteQS2kWdG7codX3JBZuzz4DOA1oopi+irigqxu2LchGgE1OmjyR
 eg3Tbl62sHzOKJq/JzkX7MS1+GHsNVW5Z/BuR2wHVhlxYabWVU88RYxZBmXU9o+HgB3kWqEfER
 qukdTDG8dH9XM9ClFnstD2b6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:15 -0800
IronPort-SDR: 88RdVTT+HdYlmyPFk50JS3d42kn2S3QjtrCjQNDGTqyqgPBEUdf1OYQSVUyGdAhL52+EF4SYXS
 Nq6WrZ47NfhDT26JP1CPZXFf4Vtq2R1maPKSQr3paoPecQHG570kcDTv8+FFRbT1++tsdKfeze
 7S/cm0YxdnwKZOphUMc0cB6b7vUA9IONnbka0sT+eTtITsoKI0oqsqJnEbE93CHgr0FXjzYYOm
 8LcZe1vIlc4UVgO49vpgT/5KrbwODbZtWmSgzSSAmJpXTVu6R0lqBKMIbsngJtdsqy8g1/LHil
 bPU=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:51 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 0/7] fstests: fix _scratch_mkfs_sized failure handling
Date:   Mon, 24 Jan 2022 20:10:43 +0900
Message-Id: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When generic/204 is run for btrfs-zoned filesystem on zoned block devices with
GB size order, it takes very long time to complete. The test case creates 115MiB
filesystem on the scratch device and fills files in it within decent run time.
However, with btrfs-zoned condition, the test case creates filesystem as large
as the device size and it takes very long time to fill it all. Three causes were
identified for the long run time, and this series addresses them.

The first cause is mixed mode option that _scratch_mkfs_sized helper function
adds to mkfs.btrfs. This option was added for both regular btrfs and
zoned-btrfs. However, zoned-btrfs does not support mixed mode. The mkfs with
mixed mode fails and results in _scratch_mkfs_sized failure. The mixed mode
shall not be specified for btrfs-zoned filesystem.

The second cause is no check of return code from _scratch_mkfs_sized. The test
case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and does not
check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_sized
fails, the scratch device still has valid filesystem created by _scratch_mkfs.
Following test workload can be executed without failure, but the filesystem
does not have the size specified for _scratch_mkfs_sized. The return code of
_scratch_mkfs_sized shall be checked to catch the mkfs failure.

The third cause is unnecessary call of the _scratch_mkfs helper function in the
test case generic/204. This helper function is called together with _filter_mkfs
helper function to obtain block size of the test target filesystem. However, the
_filter_mkfs function works only for xfs, and does nothing for other filesystems
including btrfs. Such preparation unique to xfs shall be done only for xfs.

In this series, the first patch addresses the first cause. Following three
patches address the second cause. They cover not only generic/204 but also
other test cases which have the same problem. The last three patches address the
third problem. Two of them are preparation patches to clarify that the function
_filter_mkfs is xfs unique. And the last patch modifies generic/204 so that xfs
unique test preparation are run only for xfs.

Shin'ichiro Kawasaki (7):
  common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
  generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
  ext4/021: check _scratch_mkfs_sized return code
  xfs/015: check _scratch_mkfs_sized return code
  common: rename _filter_mkfs to _xfs_filter_mkfs
  common: move _xfs_filter_mkfs from common/filter to common/xfs
  generic/204: do xfs unique preparation only for xfs

 common/attr       |  2 +-
 common/filter     | 53 -----------------------------------------------
 common/rc         |  8 +++----
 common/xfs        | 45 +++++++++++++++++++++++++++++++++++++++-
 tests/ext4/021    |  2 +-
 tests/generic/171 |  2 +-
 tests/generic/172 |  2 +-
 tests/generic/173 |  2 +-
 tests/generic/174 |  2 +-
 tests/generic/204 | 26 ++++++++++++++---------
 tests/xfs/004     |  2 +-
 tests/xfs/007     |  2 +-
 tests/xfs/010     |  2 +-
 tests/xfs/013     |  2 +-
 tests/xfs/015     |  4 ++--
 tests/xfs/016     |  2 +-
 tests/xfs/029     |  2 +-
 tests/xfs/030     |  2 +-
 tests/xfs/031     |  6 +++---
 tests/xfs/033     |  4 ++--
 tests/xfs/041     |  2 +-
 tests/xfs/044     |  2 +-
 tests/xfs/050     |  2 +-
 tests/xfs/052     |  2 +-
 tests/xfs/058     |  2 +-
 tests/xfs/067     |  2 +-
 tests/xfs/070     |  2 +-
 tests/xfs/071     |  2 +-
 tests/xfs/073     |  2 +-
 tests/xfs/076     |  2 +-
 tests/xfs/078     |  2 +-
 tests/xfs/092     |  2 +-
 tests/xfs/104     |  6 +++---
 tests/xfs/108     |  2 +-
 tests/xfs/109     |  2 +-
 tests/xfs/110     |  2 +-
 tests/xfs/111     |  2 +-
 tests/xfs/144     |  2 +-
 tests/xfs/153     |  2 +-
 tests/xfs/163     |  4 ++--
 tests/xfs/168     |  6 +++---
 tests/xfs/176     |  2 +-
 tests/xfs/178     |  2 +-
 tests/xfs/186     |  2 +-
 tests/xfs/189     |  2 +-
 tests/xfs/250     |  2 +-
 tests/xfs/259     |  2 +-
 tests/xfs/276     |  2 +-
 tests/xfs/279     |  2 +-
 tests/xfs/288     |  2 +-
 tests/xfs/292     |  4 ++--
 tests/xfs/299     |  4 ++--
 tests/xfs/335     |  2 +-
 tests/xfs/336     |  2 +-
 tests/xfs/337     |  2 +-
 tests/xfs/341     |  2 +-
 tests/xfs/342     |  2 +-
 tests/xfs/443     |  2 +-
 tests/xfs/448     |  2 +-
 tests/xfs/490     |  2 +-
 tests/xfs/502     |  2 +-
 tests/xfs/513     |  2 +-
 tests/xfs/530     |  2 +-
 tests/xfs/533     |  2 +-
 64 files changed, 135 insertions(+), 139 deletions(-)

-- 
2.34.1

