Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBFC433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Apr 2021 04:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7158A6142B
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Apr 2021 04:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhDVEGR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Apr 2021 00:06:17 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:48683 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhDVEGH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Apr 2021 00:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619064331; i=@fujitsu.com;
        bh=WABwBDHBy6KAKU4BAnrZmZCFWcxlpshjqJU9Yo6B1WQ=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Zd0f4cScqM84uXUmel6Y1jtzcTufaqMzm5i7NkjEKoGPh8DMRrpF9+2sAhnGeAb5e
         ck55+dWfJRjpcJG/n2uujvmB8l/JxU7tppCXB50fKNV1Bk9jXCkdOlSDUJoCE4LW3c
         0+db23iqqt5LKR/Sr1tIWlOmgcdcquWOsMBn17rAn0A6cxdsZtSEH+QTz0u3mjElVn
         HGiCIEXkz2spg/vdDivaKD+YVT28vV6YnzCFH5LppsXzKy78KPvBCLFo5Ua4eoc2dT
         /V0tlocvycFdzyEghNNwXzaMnclWAeUejbmIxGbcnG0aHbUIBF+NjjUGsypc9yX0Zp
         eadHg42GdSAsg==
Received: from [100.112.192.143] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 6C/5E-14660-A06F0806; Thu, 22 Apr 2021 04:05:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRWlGSWpSXmKPExsViZ8MRqsv1rSH
  BYN4JFYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDNeDj/AVvBf46KB5/+szQwnmXvYuTiEBLoZJLo
  /L6PCcLZzSix+8BOli5GTg42AU2JZ50LmEFsEQFZif8zVgMVcXAwC/hJPJuQCxIWFvCQuLDpN
  Vg5i4CqxI6ZfWAlvEDxI3OSQMISAgoSUx6+B5vCKyAocXLmE7ByZgEJiYMvXjBD1ChKXOr4xg
  hhV0p0rl/AOIGRdxaSlllIWhYwMq1itEgqykzPKMlNzMzRNTQw0DU0NNI1tARiExO9xCrdRL3
  UUt3y1OISXUO9xPJiveLK3OScFL281JJNjMDQSik4MGEH4/7XH/QOMUpyMCmJ8m6/0pAgxJeU
  n1KZkVicEV9UmpNafIhRhoNDSYL33hegnGBRanpqRVpmDjDMYdISHDxKIrxLPgKleYsLEnOLM
  9MhUqcYjTkuX5+3iJlj5+nFi5iFWPLy81KlxHm/gkwSACnNKM2DGwSLv0uMslLCvIwMDAxCPA
  WpRbmZJajyrxjFORiVhHmLPwFN4cnMK4Hb9wroFCagU7Sn1IKcUpKIkJJqYLpz6wLTVL3WCd/
  EbtnGPU6Y/Nvwzdua0C2ci9u9Y+x4rXwFShgkFI1sMiZJBqWphEZqfm66/zn5ddZ3c/s21pIp
  WR5B59m8M9a1J6pVrrP+c0Fr2585tzqde9r+6HR1rxVKUQj/1nfioNXZW5dK9balPXi7PU7qt
  ZHQt84X0e+NP/9kEPF1czKU33da4PWNywFpz+NP3Focek7luOPFyBccIkxvZzbM9Y1dO2vVg8
  trC4sehLdo3md54mAtcJrDptzU1DrEKKuJt6fzz415K5t8/vXPn8bGVLN96ePjrJEH5QsuTVq
  +rILxqydLcknDv2Wbts/66iu+9e6lfxFrf0UqaH0+fdp4PkdiknX0SiWW4oxEQy3mouJEAMz0
  Rus6AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-27.tower-267.messagelabs.com!1619064330!264314!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1714 invoked from network); 22 Apr 2021 04:05:30 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-27.tower-267.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 22 Apr 2021 04:05:30 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13M45OdH028214
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Thu, 22 Apr 2021 05:05:30 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 22 Apr 2021 05:05:22 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        Jinhui Huang <huangjh.jy@fujitsu.com>
Subject: [PATCH] xfs/145: Remove useless -f option for xfs_quota command
Date:   Thu, 22 Apr 2021 13:05:43 +0800
Message-ID: <1619067943-3859-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since it is a xfs specifal case, we don't need to use foreign filesystem mode.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Jinhui Huang <huangjh.jy@fujitsu.com>
---
 tests/xfs/145 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/145 b/tests/xfs/145
index 3b3c375d..3ccbb923 100755
--- a/tests/xfs/145
+++ b/tests/xfs/145
@@ -51,7 +51,7 @@ $FILEFRAG_PROG -v $SCRATCH_MNT/testy 2>&1 | grep -q delalloc || \
 rm -f $SCRATCH_MNT/testy
 
 echo "Run test program"
-$XFS_QUOTA_PROG -f -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
+$XFS_QUOTA_PROG -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
 $here/src/chprojid_fail $SCRATCH_MNT/blah
 
 # The regression we're testing for is an accounting bug involving delalloc
@@ -64,7 +64,7 @@ $FILEFRAG_PROG -v $SCRATCH_MNT/blah 2>&1 | grep -q delalloc || \
 	echo "file didn't get delalloc extents, test invalid?"
 
 # Make a note of current quota status for diagnostic purposes
-$XFS_QUOTA_PROG -f -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
+$XFS_QUOTA_PROG -x -c 'report -ap' $SCRATCH_MNT >> $seqres.full
 
 # success, all done
 status=0
-- 
2.23.0

