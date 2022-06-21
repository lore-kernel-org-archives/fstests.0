Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D88EC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 16:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353590AbiFUQDH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353327AbiFUQCp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 12:02:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17B2DD6A
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 09:02:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1D44F21B28;
        Tue, 21 Jun 2022 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655827321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TBcVWJizbtyalVd4nFPIz7by2r50cF2vf4yy/+4ESLg=;
        b=xvO0XA9XRtD8J//BYYWqq5ITqUFBUnaUPyJUtVD92hBfnKUiTEeST81620No41fRJ7tCJR
        GJdpAmZwZY+LRKSVm6zKrWDyngcBYx9AAMKNtvM4X6TTc2ZT/cAnFTMfW8WqntMjrudmEP
        vK213tflKBRWHsy3Xh9YDI56MfrLnaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655827321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TBcVWJizbtyalVd4nFPIz7by2r50cF2vf4yy/+4ESLg=;
        b=9q0dM6WH2CyGQtDfSEA7FygPDfOOnicH0Uicw6yx/1bqu84Z1fCwd+bvhLCwudy5GN+INJ
        h2bTY339FZMIBpDw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 00D912C141;
        Tue, 21 Jun 2022 16:02:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Subject: [RFC PATCH 0/2] add option to rerun failed tests
Date:   Tue, 21 Jun 2022 18:01:51 +0200
Message-Id: <20220621160153.29591-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This RFC patchset adds support to loop on failed tests, as proposed by
Ted Ts'o in https://lwn.net/Articles/897061/:
  add a mode that will immediately rerun a failed test 25 or 100 times
  to establish a failure percentage.

There are a couple of things which I'd like to resolve before dropping
the RFC flag, but would appreciate early feedback on the approach here.
The caveats are:
- rerun tests will be tracked as a single failure in @try and @bad
  + xunit reports do not include any rerun details
- .bad files generated on failure will be overwritten by test reruns

For xunit reports, I think it'll make sense to stash the aggregates in a
separate <test>.agg-results file or something. Similarly for .bad file
overwrites, I could add a .<rerun #> suffix for capturing all failure
data.

Cheers, David

