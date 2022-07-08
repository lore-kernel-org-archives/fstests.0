Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06BCCA47B
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 08:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiGHIvw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 04:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiGHIvt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 04:51:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17F4823A5
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 01:51:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 65B271FEF8;
        Fri,  8 Jul 2022 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657270307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2+OZ5LQCnOEs7X/81aBr9upSwrtHWSP7+kJdcpj08dM=;
        b=O4Sr4OydoJuVGrOKxpIfka33UTYXFI0xsnzhzi5GrgqBAJUJ/JgYcO//iZi/c0G8hMUlo2
        FWPuc7tEjqfugSfcMM7l+lkfcI5qGOFAyTln6tdo0r627a55fz1vDDDYj3q0Q9CMeAtfAQ
        EbHajCOXiO3mvmcyT3jU1rc0+j9tqoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657270307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2+OZ5LQCnOEs7X/81aBr9upSwrtHWSP7+kJdcpj08dM=;
        b=uC02R3pqKaBSpjK9KxnMdjxi1g2AGmk/qF+8G/lCRYKkZa8XXtdy0r1cfcP4ZzmSq8iqFt
        Zp9YgeeS2yiB2PAA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3810B2C141;
        Fri,  8 Jul 2022 08:51:47 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     djwong@kernel.org, zlang@redhat.com
Subject: [PATCH v4 0/5] check: add option to rerun failed tests
Date:   Fri,  8 Jul 2022 10:51:37 +0200
Message-Id: <20220708085142.20991-1-ddiss@suse.de>
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

Changes since (v3), following Darrick's review:
- extended full/out.bad/etc. retention to cover more paths and remove
  stale .rerun# files

Changes since (v2), following Darrick's review:
- dropped RFC flag
- rebased atop v2022.07.03
- simplified test iterator
  + results stashed at the end of each iteration, rather than start of
    next / loop-exit
- dropped aggregate loop stats message from xunit report
- squashed full/dmesg/out.bad file retention patch with rerun patch

Changes since (v1):
- rebased atop upstream v2022.06.26
- added a few extra cleanup commits
- append details for every rerun to xunit output
  + provide aggregate stats via <testcase status=X>
- extend _stash_test_status to call report hook, as well as save failure
  artifacts with a .rerun# suffix

Diffstat:
 check         | 137 +++++++++++++++++++++++++++++++++++++-------------
 common/report |  90 ++++++++++++++++-----------------
 2 files changed, 144 insertions(+), 83 deletions(-)


