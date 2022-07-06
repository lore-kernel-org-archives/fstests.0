Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAFC43334
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiGFLXi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiGFLXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 07:23:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839B13E19
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 04:23:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6B20A1F9D1;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657106608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ec0U1bT7OCctU5IphE4QqpT+ULWnt0SJkQJSCCyz6+8=;
        b=Q/zLYs01mjrvnL4DrdBpvZRET5mEwYvkm4j/BLr/CvJH5dmJuiWFEafRqmHZzWg7D524kd
        7tOyGpEZkC7DkjM53ZF0cBt5XJpKDJWlpPXylaRjqzzhuPPp/sMrbY48Gs7FZlfz0Inro7
        yNL56NmUBrDOJTwN0HM1W4lSf8EO+0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657106608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ec0U1bT7OCctU5IphE4QqpT+ULWnt0SJkQJSCCyz6+8=;
        b=C6snbc9MILk5+glsb4y1iAe8VCE3bIGMzgQZXSW/SlC6GKeap0Ok59VcYoCMl3y2bWLgZe
        zljmMJaD3M56aKDw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F8AA2C141;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Subject: [PATCH v3 0/5] check: add option to rerun failed tests
Date:   Wed,  6 Jul 2022 13:23:07 +0200
Message-Id: <20220706112312.4349-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset adds support to loop on failed tests, as proposed by
Ted Ts'o in https://lwn.net/Articles/897061/:
  add a mode that will immediately rerun a failed test 25 or 100 times
  to establish a failure percentage.

Changes since previous version (v2), following Darrick's review:
- dropped RFC flag
- rebased atop v2022.07.03
- simplified test iterator
  + results stashed at the end of each iteration, rather than start of
    next / loop-exit
- dropped aggregate loop stats message from xunit report
- squashed full/dmesg/out.bad file retention patch with rerun patch

Changes since previous version (v1):
- rebased atop upstream v2022.06.26
- added a few extra cleanup commits
- append details for every rerun to xunit output
  + provide aggregate stats via <testcase status=X>
- extend _stash_test_status to call report hook, as well as save failure
  artifacts with a .rerun# suffix

Diffstat:
 check         | 136 +++++++++++++++++++++++++++++++++++++-------------
 common/report |  90 ++++++++++++++++-----------------
 2 files changed, 143 insertions(+), 83 deletions(-)

