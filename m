Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384FBC4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiAXLKz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:55 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbiAXLKz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022656; x=1674558656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqFAptI4CAvK6M8wR+plx0XzaNREix5nWvG4orfRMAg=;
  b=RonxtKC1G2bE6Nub32zy4TJ/NAWt8qKum9VpxivcSOKlUkjjJhU8VlxD
   qLM/zE2WU1pfcTUsLPqh9EM2SiNsKVbdYmtZMBiQVhSsYBTHb+TXjAcen
   tEe06hXEhpKXXwOz7pv+h3nDyJ+y8z7+MQsIa8zUb7SE8sa5wpTimfCZa
   DYbJS7OxJT0LOrBQs8G4oRGARdamJRJINmkPjl8F5jHg5zCjKYP7ODE8g
   kVGvqjxkunfkjQOLeuUSj7nJ+l/WZWsm0/uZN0+wfzoDb2putyNj/Oo56
   H/R0R8j7A6hapyu5pk7CkHmB2iXl8m31kjP0rx1Q+tKGHI+t9TO8BlHMM
   A==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220963"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:56 +0800
IronPort-SDR: UCDDeF2EOXtsZkRiBb4BU7UsnsEzC5PbismGRND9UoCOLDuvBUFXdTljDVQMV7RcAmd+Iy1Mtz
 Pp85oN/BJi3JRQyVKNTbaHrsVdzG98crpa3ugrCazlEBxNVjrolrwHoYk0eX1sXO6SEfDX1xuw
 HnrbzOAJnXTTeskG8OXJ74knmuERK8Tc18hZEMnHw9Zh22uFqk6gHMPE8DFv6LxQ3AR8jiT3TG
 kzY8BhU5lpP6uID0rFaUFOcPoYzoL7ETsvYwoq4jAH9b3R2Mee5G5dI7mVtzmYlFAUWD+iT/wz
 MeHUY4MVCkMlngLmeXPMzfKe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:18 -0800
IronPort-SDR: p3HEI5TZkWl5aK1YUFcwgx0/a4TUuDXOOVpjtWHAQ74Oc1/M4EyGtvjmtybhhpEjyv5jO81htL
 zwJ7lzr8FcrbXZ/TukrMfcjBW/011ZJ15BeNB3tmFLwddkSBIidRa2maVQ1wBbBJPA1WiGlCjd
 DbMgSGeeBlnTBb85F8tfa7hO9o2xUn1NDprkocpk8ImIAPi2eVuiJaHd67uvZolSRyDArjj+1C
 ygDWqtuQj2tMUXl6FC719D3Pbs0HhAzseLjrstvTgC9Tk9dhe0I4sG1TQEQW+UQ4sANdWzfSkY
 6zA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:54 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 3/7] ext4/021: check _scratch_mkfs_sized return code
Date:   Mon, 24 Jan 2022 20:10:46 +0900
Message-Id: <20220124111050.183628-4-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test cases ext4/021 calls _scratch_mkfs before _scratch_mkfs_sized,
and does not check return code of _scratch_mkfs_sized. Even if
_scratch_mkfs_sized failed, _scratch_mount after it cannot detect the
sized mkfs failure because _scratch_mkfs already created a file system
on the device. This results in unexpected test condition.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/ext4/021 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 62768c60..a9277abf 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -24,7 +24,7 @@ _scratch_unmount
 
 # With 4k block size, this amounts to 10M FS instance.
 fssize=$((2560 * $blocksize))
-_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
+_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
 _require_metadata_journaling $SCRATCH_DEV
 
 offset=0
-- 
2.34.1

