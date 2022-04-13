Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF59C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 16:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbiDMQrQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiDMQrE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 12:47:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5E3B3C4
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 09:44:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B691C21110;
        Wed, 13 Apr 2022 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649868270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aNdQaNeusL4b1UukususyIRWJbSsk0VfbtzC98Cs7rw=;
        b=deCDyKStH4HuBJxaymDRKvsJYj0qS2yRoiwWAPQcULnaKyYHaeG03t03wVSx9dgvpwH0/+
        X42H2M5aPiOJDgMtHy7A+1/RPDU6GhLUUv517iLyzNFCSiuVgv/XiJeT6oc5pEQZH30sqf
        UZHLOs22i0EacsMN92LRrwA/jPzCFL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649868270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=aNdQaNeusL4b1UukususyIRWJbSsk0VfbtzC98Cs7rw=;
        b=JhNHTeKKgRmviuQBtEWw1W3YgeelgF6J0xMOrYv9mAEr//63ogXrjZEAChPOi8yEozYQ2Z
        YWbt+Q6hQWylrlAA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9E30DA3BA4;
        Wed, 13 Apr 2022 16:44:30 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com
Subject: [PATCH v3 0/4]: generic/020: fix MAX_ATTRVAL_SIZE values
Date:   Wed, 13 Apr 2022 18:44:18 +0200
Message-Id: <20220413164422.30077-1-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

MAX_ATTRVAL_SIZE provides a per-filesystem maximum xattr value length
limit. There are a few problems with the current values:
- XFS, UDF and Btrfs are incorrectly hardcoded to use 64 bytes
  + This is a regression from the larger value used prior to fff4359d
  + Btrfs's should be calculated using nodesize and xattr name length
- NFS currently uses a 64K limit
  + This may be above the server's underlying failsystem limit, so use
    a conservative estimate instead

The changes are split into four patches to ease review, but feel free
to squash as deemed necessary.

Changes since v2:
- move _attr_get_max() helper into generic/020 and use test-local
  $max_attrs / $max_attrval_size variables
- minor commit message changes

 common/attr           |  75 ---------------------------
 tests/generic/020     | 116 +++++++++++++++++++++++++++++++++++++++---
 tests/generic/020.out |   2 +-
 3 files changed, 109 insertions(+), 84 deletions(-)

