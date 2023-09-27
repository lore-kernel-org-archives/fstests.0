Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA426E80A92
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Sep 2023 06:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjI0GLO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI0GLN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2023 02:11:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E646B3
        for <fstests@vger.kernel.org>; Tue, 26 Sep 2023 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695795070; x=1727331070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k/zrTZjNSkcZVAgwGIPz4WwvkC4xyplEg5oLwEFD2hQ=;
  b=TYXRSUlfHYDouEBcCYBahWH2SJAnCbYQzXj78rKF6iuVVP4XjbauaUa+
   dg9tXMdct6RTSxKZjknaBjsefj8484212ZlNFW8UUvABIBcjA/bN7nqwH
   /NEFhm4thYUlx1g3ShAtGKEa8gVGkpz/fVV+gbmGzBb6VHHabt/Iv1vMP
   PDCREBcLPEVSMlha3E2GKVrWq9BuI/JUMCJtb93fUfuFeLFhtQxatKggl
   SvQs94zeR1Hv23pBLWy541qKoTCsHDXmQawu4lrIwJu0rqSPV+wWopijf
   mJDID6wJ5/cdskihLx3rS7kAGNybFrzxD9ECReUhd2p/LQw7g1128zjiJ
   g==;
X-CSE-ConnectionGUID: wHRzk2LVTWe6St3y8+KJUg==
X-CSE-MsgGUID: yB1PRjAgSgKSTFfDKIZr1Q==
X-IronPort-AV: E=Sophos;i="6.03,179,1694707200"; 
   d="scan'208";a="350410421"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2023 14:11:10 +0800
IronPort-SDR: RehEoGjh83Gzbn/c5EtMp/D/aXohduSUwPgy/hFCQKwCbhMhu1/bHwR+S5/wK0HNULHoJL4KYQ
 0+SkmpgsT/De3EkFIuZu02p6beHkvPWewK+okW6IElnDibCrUBmwy7Z5PREMd29olLhjR3rE40
 aKVjh5Q3Ccyx5zPZ7hgEzUDxNl3W6UgcPJzZOHuMPd5MOh16CjeP/fsXRdlNkT9pUIv6O6S0Qg
 ydlbys9yYQrIu4UiKUOUWNPPHhBItxAUqEGCwkVhwsn618svQoeDxVi+K7guZhHsjbr1WydIEY
 9vw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 22:23:36 -0700
IronPort-SDR: Ru4Bk1UOFEmdXVfU40H+e9jr+7sCadOVXEOGsLk2uFd6iJxI/L87OQar+gOsU+S7kEGi7I4mzV
 AOlwQrnwjv0iIu8CI49bkLL4fxO5ZZllmsdX0z2900pLYpKSO3NtVvD5qpS0ErX1xk2r756O66
 mqcX0O/BAz68wkZS08XHW7awar9WaE/PxGl1hL+LCM5a20n9q6fkhUYSFPPVdgOablEPENx02v
 jgzK3fKXLViucMBxKj8Cg/oxJmqbivXMgZPfaoQiWZ6ODI/4VQCIEXBivz51F1kjCgIE3xzbfE
 +zQ=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2023 23:11:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] common/rc: check error case and fail the test
Date:   Wed, 27 Sep 2023 15:11:00 +0900
Message-ID: <20230927061100.95365-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If we place /var/lib/xfstests on a read-only filesystem, commands in
_link_out_file_named() fail to modify the files. However, they won't fail
the test. As a result, the test case fails mysteriously with only "no
qualified output" printed.

Fix it by checking the error case.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 76a7e7740318..4e9bd34f7772 100644
--- a/common/rc
+++ b/common/rc
@@ -3431,8 +3431,8 @@ _link_out_file_named()
 		}
 		print $result
 		' <$seqfull.cfg)
-	rm -f $1
-	ln -fs $(basename $1).$suffix $1
+	rm -f $1 || _fail "_link_out_file_named: failed to remove existing output file"
+	ln -fs $(basename $1).$suffix $1 || _fail "_link_out_file_named: failed to setup output file"
 }
 
 _link_out_file()
-- 
2.42.0

