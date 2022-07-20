Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EC4C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiGTQo3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbiGTQoV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 12:44:21 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9896365D69
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 09:44:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26KGi1L9023372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 12:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1658335442; bh=Ok/jP8rC+NKtItaJ6xxmvUqSk7vDAZAX3JyDEcSt2N4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TSK26SlPt3BU7cdMu0f+z/EWJvnWS3ecjSF/utqI0VE2MyRRdz4a1GMsA21ka+VEV
         ALCum7sAsPNFnjiArbcvc4ls8q8V35GESQZMg6LKiIu52DfR/ILpfU5IblsCiABY7t
         l5Ztyxyc8JUiKL2gnw5YX+soJ02bhKH7F91xCuQ9BhMgpRDaFpOo/Z1QuoW8vl6B37
         pT/E4Vl0vygi58ayxgfBW8hoNOqDL57fFZ0xUjYvIjimyQ1Sd2Ye0zeP1ZOLuT7EAa
         HZzK27RmZM241cWCErU1V5DMWLHDpqH/gBqUKdpS79NWl2FLO2lEHyFL3kPSNm3NEz
         pu1/VJiSEnLIA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0B0B815C3EC7; Wed, 20 Jul 2022 12:44:01 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 3/4] dmflakey: don't run dmflakey tests with an external log device
Date:   Wed, 20 Jul 2022 12:43:55 -0400
Message-Id: <20220720164356.4078789-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720164356.4078789-1-tytso@mit.edu>
References: <20220720164356.4078789-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

dmflakey works by dropping all writes before unmounting to simulate a
crash/power loss.  This doesn't work if there is an external log
device, since we only drop writes to the primary block device, and not
the external log device.  Fixing this for real would require somehow
arranging to atomically loading a new dmflakey table for two block
devices at the same time, so for now, just skip tests using dmflakey
if the external log device is enabled.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/dmflakey | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/dmflakey b/common/dmflakey
index 52da3b10..c2be78e9 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -12,6 +12,10 @@ _init_flakey()
 {
 	# Scratch device
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
+
+	if test "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ; then
+		_notrun "dmflakey tests don't work with an external log device"
+	fi
 	FLAKEY_DEV=/dev/mapper/flakey-test
 	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
 	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
-- 
2.31.0

