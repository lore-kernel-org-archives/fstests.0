Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7853ECCA47F
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 07:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGSHbI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 03:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiGSHbE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 03:31:04 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960B322B25
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658215861; i=@fujitsu.com;
        bh=Zx/mnauP+NNrusmL7sP08no3bnxoHl97wJ0qhMLCLCU=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=CHARR1CmZckpcIddQSozpKA7CmUZUeldtkHNoXhbnpdIaqY+zKr/OWwc7sNJo19jN
         hfshm9KaOhmA8zJLNk+RBZ3cnzduu/+jMPBfXoQ/qIO//nTjy+UVyyvRZjpn+qKBMZ
         beIFoddidDsGdOIy7k0x6JKH1fs4pYWNN5IJq9SMscTqivpb9oeySaNCDQpIy/OOz1
         ul05RI/F29LEkmtx2VaKZRmzAtoIB7C2OwlKyZxBnOKpbyhxfMxmPFe7IP7Zd4SbUr
         45595zc444Zf1WFXSrF9TVq+CKNwQP5dVVh1qWTsjleurL2DbSAh/xqAMhDBECWJZi
         Cj5g3Heqt+hpw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRWlGSWpSXmKPExsViZ8OxWXdr7LU
  kg/e/xC1Ot+xld2D0+LxJLoAxijUzLym/IoE1Y+bOL8wFx7gq/szcwNzA+Iuji5GTQ0jgHKPE
  pJv1EPZBJomzH1S7GLmA7D2MEq8uL2IBSbAJaEo861zADGKLCMhK/J+xmgnEZhZQl1g+6ReQz
  cEhLGAoMeG6OEiYRUBVYvWWL4wgNq+Ah8TWj7NYQWwJAQWJKQ/fg43hFLCRaJv6nhVir7XEs3
  3NbBD1ghInZz5hgRgvIXHwxQtmiF5FiUsd3xgh7AqJ14cvQcXVJK6e28Q8gVFwFpL2WUjaFzA
  yrWK0SirKTM8oyU3MzNE1NDDQNTQ01TXRNTK21Eus0k3USy3VLU8tLtE11EssL9ZLLS7WK67M
  Tc5J0ctLLdnECAzflGKW9zsYm/p+6h1ilORgUhLlnap5LUmILyk/pTIjsTgjvqg0J7X4EKMMB
  4eSBG9COFBOsCg1PbUiLTMHGEswaQkOHiURXs0ooDRvcUFibnFmOkTqFKMxx9qGA3uZOabO/r
  efWYglLz8vVUqclzcaqFQApDSjNA9uECzGLzHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5mU
  BJgwhnsy8Erh9r4BOYQI6ZZLTFZBTShIRUlINTCLcISmu4XbnRVJ7vvhXv/Vb+ifkpKBohTmD
  z3+7BqeKUxsW98ybumld+YQHfWsi8hS+1+kn/XI4yew7tzpOzOOJqZnAlKm/neek2B29+EaCd
  c4f3/uLdh410fm2MK/b/gnDMyH1i2d6GEy5L2cfLZCf8jzhHy+/x4/X86+0fve+vzOU/8rPDo
  Xk4NjEbtNr0yNPsOtmPE9RV3I4yCy7RTgl1LNxjpHF7UdxM5fYbb62oceS/+a1a0uPethuXGt
  U9DqWsYPFVNtnXcPvhGhnMQFexr5PUd1Xn1ZGL12tURc/Kd9HuCa89HP9DeFAq5MLG+Z/Y/3e
  ukpLYv/O+lMLrrBqmi7/c3qJ/P/Wi3ZdSizFGYmGWsxFxYkAFVMmtmwDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-4.tower-587.messagelabs.com!1658215861!313860!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19112 invoked from network); 19 Jul 2022 07:31:01 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-4.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Jul 2022 07:31:01 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 006877C
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:31:01 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E7F7775
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:31:00 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Jul 2022 08:30:59 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 1/2] xfs/270: Fix syntax error
Date:   Tue, 19 Jul 2022 16:31:12 +0800
Message-ID: <1658219473-2310-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20220719051310.mptogjydytz233n4@zlang-mailbox>
References: <20220719051310.mptogjydytz233n4@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Without xfsprogs commit
f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()"),
this case will fail as below:

+/var/lib/xfstests/tests/xfs/270: line 51: [: !=: unary operator expected

With this xfsprogs bug, xfs_db can't get new_ro_compat value, so report
this bash syntax error.

Fix this and add a helper output for xfsprogs bug.

Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/xfs/270 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/270 b/tests/xfs/270
index b740c379..4954e943 100755
--- a/tests/xfs/270
+++ b/tests/xfs/270
@@ -47,9 +47,12 @@ _scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
 new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
 						2>/dev/null)
 
-# verify the new ro_compat field is correct.
-if [ $new_ro_compat != $ro_compat ]; then
+# verify the new ro_compat field is correct. Without xfsprogs commit
+# f4afdcb0ad ("xfs_db: clean up the salvage read callsites in set_cur()"),
+# we can't get new_ro_compat value.
+if [ "$new_ro_compat" != "$ro_compat" ]; then
 	echo "Unable to set new features_ro_compat. Wanted $ro_compat, got $new_ro_compat"
+	echo "May hit a known xfsprog bug"
 fi
 
 # rw mount with unknown ro-compat feature should fail
-- 
2.23.0

