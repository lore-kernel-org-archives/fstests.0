Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02675C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 06:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69CE610C8
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 06:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDZG5e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 02:57:34 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.1]:14333 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231945AbhDZG5d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Apr 2021 02:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1619420211; i=@fujitsu.com;
        bh=R7DGqUpxkf3Ejr2aULe4tLGyIWWliJAY0mJSl5Jfmcw=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=K35RlauqPbp3nMJhiNC8/Kcj/i5wbMoR2hvfgVRfY6G1cSCOwEwnySlBLRKnwiudb
         0WSHeB5R3HjKzB/eaIbWVIyu/t+h8TjLIsxyrp0R0HlA9H1ln8kaQFVpcsrFWHcPyI
         1mboFhQynbjUTYiyE4ilX3GQv91UQkbcGI8YiYiL5E79ivTvSerEZi5TcL3/CJkUcm
         QySVwlN2Z7dhfHt1qNYSuKBXn20XeZBBVeterxPsl7/dHdQB1YPodgIndmKEi0FXNg
         I2wpa3zKclup4hIdOw46xN49DfM0MSJHXkKxd84wQLipJ7uTaPaDl9/MFyARrmgjIq
         rVTVXxlESVQsg==
Received: from [100.113.2.110] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.symcld.net id A5/4F-07430-33466806; Mon, 26 Apr 2021 06:56:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRWlGSWpSXmKPExsViZ8MRqmuc0pZ
  g8PAxj8WFdasZLS4/4bM43bKX3YHZY+esu+wem1Z1snl83iQXwBzFmpmXlF+RwJrx8OVn9oJt
  HBUvd1xhbWBcxd7FyMkhJPCaUaJ3YkkXIxeQvZtRYs6mJlaQBJuApsSzzgXMILaIgK7EhM3n2
  EBsZgEniTnrTjGB2MIC1hIH7v5iBLFZBFQlbrSeAbN5BTwlni08AVYvIaAgMeXhe2aIuKDEyZ
  lPWCDmSEgcfPGCGaJGUeJSxzdGCLtSonP9AsYJjLyzkLTMQtKygJFpFaNlUlFmekZJbmJmjq6
  hgYGuoaGxrpGukaGZXmKVbqJeaqlucmpeSVEiUFYvsbxYr7gyNzknRS8vtWQTIzAIUwqZbuxg
  /Pb6g94hRkkOJiVR3gbG1gQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErwFiW0JQoJFqempFWmZO
  cCIgElLcPAoifBeiQdK8xYXJOYWZ6ZDpE4x6nJsnrt0EbMQS15+XqqUOG8myAwBkKKM0jy4Eb
  DovMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmHdtEtAUnsy8ErhNr4COYAI6gq+uFeSIkkS
  ElFQD00lelttBZ3/eD7jnu1bpC//i8JC3L61/ee1bVn/rApOu8pzqwq1PWrpNy2ZL3LxR1Ojg
  9+rVHnH9khN32/TvXzU72lR/2c+lc+1xq1ddkydFTz9xbTfP0qORFzevdCuLMOTfVnLlwP2mp
  WHzb6kuSS5cfWH5k+mv6jXcXDnP3BO5auXHHx77uC540zSDi/rNVhZq5xaE+q89ufHNpK9+ot
  aW/39tstg040D7r2t6ezbu/vwzPHF90KaYooXLDpcfNjBX4aoLP9nZ5PBVbCbDD68Jv88evXT
  Y5Vz/ysk6epEsdaZndx+9EP1Id3L7ngvp/xfrbf76jqOjuerkG4Ptvy0PmiXt1vHe6H7rx2Vt
  B/8TSizFGYmGWsxFxYkA3zxISUkDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-32.tower-232.messagelabs.com!1619420210!650388!1
X-Originating-IP: [62.60.8.85]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27104 invoked from network); 26 Apr 2021 06:56:51 -0000
Received: from unknown (HELO mailhost4.uk.fujitsu.com) (62.60.8.85)
  by server-32.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2021 06:56:51 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost4.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 13Q6ud6L002944
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 26 Apr 2021 07:56:44 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 07:56:36 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <djwong@kernel.org>, <amir73il@gmail.com>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/631: Remove useless nfs_export=off
Date:   Mon, 26 Apr 2021 15:57:03 +0800
Message-ID: <1619423823-21256-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The nfs_export feature was introduced since kernel v4.16-rc1 after
commit f168f1098dd9038 ("ovl: add support for "nfs_export" configuration").
On old kernel, this case will result in infinite loop because overlay
mount failed because of unrecognized mount options nfs_export=off.

In kernel documentation, overlay.rst said "the mount options index=off,nfs_export=on
are conflicting for a read-write mount and will result in an error.".
So using single index=off is also ok in here.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/631 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/631 b/tests/generic/631
index c43f3de3..0fa47e49 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -74,7 +74,7 @@ worker() {
 	local l="lowerdir=$SCRATCH_MNT/lowerdir:$SCRATCH_MNT/lowerdir1"
 	local u="upperdir=$SCRATCH_MNT/upperdir$tag"
 	local w="workdir=$SCRATCH_MNT/workdir$tag"
-	local i="index=off,nfs_export=off"
+	local i="index=off"
 
 	touch $SCRATCH_MNT/workers/$tag
 	while test -e $SCRATCH_MNT/running; do
-- 
2.23.0

