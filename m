Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3117DC433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A426145B
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 09:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhD3JcZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:32:25 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.69]:43182 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhD3JcY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Apr 2021 05:32:24 -0400
Received: from [100.112.199.60] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-west-1.aws.symcld.net id 32/F5-53303-77ECB806; Fri, 30 Apr 2021 09:31:35 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRWlGSWpSXmKPExsViZ8MRolt+rjv
  BYOsVOYvTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN2PPgIHPBGtaKWXtmMTYwXmTpYuTiEBLoZJLo
  a/vCDOHsZpQ48OMbYxcjJwebgJ7Ekn97WEFsEQFZif8zVjOB2MwCOhJf7m1hA7GFBWwkJmx9C
  VbPIqAq8XTqX7A4r4CHxMtTt8DiEgIKElMevmeGiAtKnJz5hAVijoTEwRcvmCFqFCXOTl3HAm
  FXSnSuX8A4gZF3FpKWWUhaFjAyrWI0TyrKTM8oyU3MzNE1NDDQNTQ00jW0NNM1M9FLrNJN0ks
  t1S1PLS7RNdRLLC/WK67MTc5J0ctLLdnECAyulIIjDjsY77/+oHeIUZKDSUmUN9GoO0GILyk/
  pTIjsTgjvqg0J7X4EKMMB4eSBO//M0A5waLU9NSKtMwcYKDDpCU4eJREeLnPAqV5iwsSc4sz0
  yFSpxh1OS5fn7eIWYglLz8vVUqcdwvIDAGQoozSPLgRsKi7xCgrJczLyMDAIMRTkFqUm1mCKv
  +KUZyDUUmYVwJkFU9mXgncpldARzABHVF5pAvkiJJEhJRUAxNvJu+qer7iW8L3bhbmbv3nfPJ
  CgLTA94+H6wwqTjyyb1+3YW35Jv6a6wtNI9n+Gy15M2VOMZP++jxnrepve+wnyCtuX7WEd5I0
  Y2P53ttFTf8nxez2D1N2iqpN7Wcw+TO34YQ2347uVJeZeVsDfL8xRR7f4PpVpcixdHPTxZsBr
  l7W1bZ/cpOs/5mecBJ4uufblz87uyqUlxR/KlnrZWb8zox7wiqD469Y+6IyVAVEX+Ranl37Z0
  PP7vRp8/pKPD+7yk9Orjv0+K9X7Iq1L5nYdsXtaC+z59wQ9dB593UenYX2PM9f13rOerd7z+7
  nPYlvv/nLBq9n4Dydp22Wm/VUcoJnoGTHiaTSjazsXUosxRmJhlrMRcWJACQl9VE1AwAA
X-Env-Sender: huangjh.jy@fujitsu.com
X-Msg-Ref: server-21.tower-291.messagelabs.com!1619775095!55679!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.75.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32313 invoked from network); 30 Apr 2021 09:31:35 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-21.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Apr 2021 09:31:35 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13U9VZl8025927
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Fri, 30 Apr 2021 10:31:35 +0100
Received: from localhost.localdomain (10.167.220.33) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 30 Apr 2021 10:31:33 +0100
From:   Jinhui Huang <huangjh.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Subject: [PATCH] xfs/153: add _require_idmapped_mounts check
Date:   Fri, 30 Apr 2021 17:31:21 +0800
Message-ID: <1619775081-3941-1-git-send-email-huangjh.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.33]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When this case runs on system without mount_setattr syscall support, it
will report errors rather than skip. so we add _require_idmapped_mounts
to check if mount_setattr syscall is supported.

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 tests/xfs/153 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/153 b/tests/xfs/153
index ab2469d..19cfc46 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -39,6 +39,7 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
 _require_scratch
 _require_xfs_quota
 _require_user fsgqa
+_require_idmapped_mounts
 _require_test_program "idmapped-mounts/mount-idmapped"
 
 _scratch_mkfs >/dev/null 2>&1
-- 
1.8.3.1

