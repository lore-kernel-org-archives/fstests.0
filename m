Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ABFC433ED
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A8E61445
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhDWDYO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Apr 2021 23:24:14 -0400
Received: from mail3.bemta25.messagelabs.com ([195.245.230.83]:12392 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhDWDYO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Apr 2021 23:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619148217; i=@fujitsu.com;
        bh=JLqWWBK6E2nIFltx9NYbGnKkT85pdFxTUioe7MXAJoc=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=tVVp26iNdT+bPa84KVvDZSBxTKIjM6sTfbVaGkhHHiE/jsO/5I1KZXOOpQcOTmeCO
         T74u6t0SHee8IV/hbseSmV2blvk4RWqWCUukXC7fC4UhugAT+yoRCMWl1rz72s8cwZ
         eHRyx0ijXv+W6Le3TOTnPP2Z4S6hqrzsq8slEcsPMxS0b03q+3XPEey55O6C04l5w0
         bfuE2k+nW2lkJnnzaGzdCA+91csIaujP58f7vHnntAX532yuH6aCBK1fhB0ZWkDxsN
         TAAEKcWrWj4h+eji5so3Y5ToR8oStNCUQjrZ+77idv4U72t/9pdXs79T6bRAjYx3wx
         jzv0GapVpF+yw==
Received: from [100.112.198.228] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id A9/39-55620-9BD32806; Fri, 23 Apr 2021 03:23:37 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRWlGSWpSXmKPExsViZ8MRorvDtin
  B4OFdI4vTLXvZHRg9Pm+SC2CMYs3MS8qvSGDN6Lj3jbVgLmfFspmiDYyH2bsYuTiEBDqZJN5c
  X8kK4exmlJj3aQtTFyMnB5uApsSzzgXMILaIgKzE/xmrweLMAuoSyyf9ArOFBcwlbsydyw5is
  wioSqw7MZkNxOYV8JSY+PYNWK+EgILElIfvmSHighInZz5hgZgjIXHwxQuoGkWJSx3fGCHsSo
  nO9QsYJzDyzkLSMgtJywJGplWM5klFmekZJbmJmTm6hgYGuoaGRrqGlma6ZiZ6iVW6SXqppbr
  lqcUluoZ6ieXFesWVuck5KXp5qSWbGIGhlVJwxGEH4/3XH/QOMUpyMCmJ8kbxNyUI8SXlp1Rm
  JBZnxBeV5qQWH2KU4eBQkuC9YAOUEyxKTU+tSMvMAYY5TFqCg0dJhHcxSJq3uCAxtzgzHSJ1i
  lGX4/L1eYuYhVjy8vNSpcR5l4EUCYAUZZTmwY2AxdwlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4h
  yMSsK8aSBTeDLzSuA2vQI6ggnoiN2djSBHlCQipKQamHaor7te+M+ruicgdfrN7MviaVxv67R
  1I0IlRTcs+/evO8CmKnZeco5pyeGQFU2Lyt61xXVemcopeGfWu5nmS6xdbmZZzLeq7M90Sd3V
  VRvyVOi/qpf56TlPLlzaGVN4asOpnYq+rdc72D4Uvl/8W4nhUYvqlt+KbzIyFv+pEOyxubtST
  bW4PtBeorSzofVqaVKFnNmMnU5/mvfIFs2Ory2Zslc0/27FuvcekwVizh1VDQ9beMRZ1IKz6N
  fdgw0H9kiYzmPkWX59cSv7gSvhX6zUVvTxZNXIOa5gKfO5fIir5NFkk91zTYVNEqXrTgQ9f9v
  WtrUniJ2xZbW4hWqFOGdxSlOC9yW+yZ0zGvYqsRRnJBpqMRcVJwIAvev81zQDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-285.messagelabs.com!1619148216!1718121!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20292 invoked from network); 23 Apr 2021 03:23:36 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-7.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Apr 2021 03:23:36 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13N3Na2Q021107
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Fri, 23 Apr 2021 04:23:36 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 23 Apr 2021 04:23:34 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] xfs/144: Use _qsetup instead of qsetup
Date:   Fri, 23 Apr 2021 12:23:58 +0800
Message-ID: <1619151838-22476-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since xfstests commit 56908a2eb566c5("common/quota: move _qsetup() helper to common code"),
we have common _qsetup function. Even this case doesn't use enforce value like xfs/050 and xfs/299,
using _qsetup is more meaningful. So remove useless qsetup.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/144 | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/tests/xfs/144 b/tests/xfs/144
index c5995cc5..74988090 100755
--- a/tests/xfs/144
+++ b/tests/xfs/144
@@ -38,25 +38,6 @@ _require_scratch
 
 rm -f $seqres.full
 
-qsetup()
-{
-	opt=$1
-	enforce=0
-	if [ $opt = "u" -o $opt = "uno" ]; then
-		type=u
-		eval `_choose_uid`
-	elif [ $opt = "g" -o $opt = "gno" ]; then
-		type=g
-		eval `_choose_gid`
-	elif [ $opt = "p" -o $opt = "pno" ]; then
-		type=p
-		eval `_choose_prid`
-	fi
-	[ $opt = "u" -o $opt = "g" -o $opt = "p" ] && enforce=1
-
-	echo "Using type=$type id=$id" >> $seqres.full
-}
-
 exercise() {
 	_scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
 	cat $tmp.mkfs >>$seqres.full
@@ -66,7 +47,7 @@ exercise() {
 
 	_qmount
 
-	qsetup $1
+	_qsetup $1
 
 	echo "Using type=$type id=$id" >>$seqres.full
 
-- 
2.23.0

