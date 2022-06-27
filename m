Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01283C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239498AbiF0WXZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiF0WXY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:23:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7141A1114C
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:23:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2338D21D3A;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656368598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8sqwa0K7C2d3WuTtCQyx4ZBNIbiwvr9got5x/6SHohk=;
        b=ypzqkWJp9Vvf3fAXIXtKVsjebzKt4044a4lmB1anOTmvcy3VGEEOYOphGq7sYt6EXB6M/E
        mkSSnc4zG6drGYveSfXYbdJUGz/pV2+5ZMBTz6829NwMwiKILWogms60/8in9tzftWOgIa
        c1Zs0fYWeACo2esJ7GqsqXoAIseRhlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656368598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8sqwa0K7C2d3WuTtCQyx4ZBNIbiwvr9got5x/6SHohk=;
        b=VYbe7DgYhCJVnEfkxNHzysmTl+gu3nqCvZ8iWmpk3m5GETjxjJxWLjok4eyZNeFqDMT3qF
        wh5EDZ19WLwstgCA==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 073102C141;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Subject: [RFC PATCH v2 0/6] check: add option to rerun failed tests
Date:   Tue, 28 Jun 2022 00:22:50 +0200
Message-Id: <20220627222256.14175-1-ddiss@suse.de>
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

Changes since previous version (v1):
- rebased atop upstream v2022.06.26
- added a few extra cleanup commits
- append details for every rerun to xunit output
  + provide aggregate stats via <testcase status=X>
- extend _stash_test_status to call report hook, as well as save failure
  artifacts with a .rerun# suffix

Still flagged as RFC as I'd like to do a bit more testing and work out
whether the regular / xunit reporting output makes sense. Feedback
appreciated.

Diffstat:
 check         | 146 ++++++++++++++++++++++++++++++++++++++++++--------
 common/report |  96 ++++++++++++++++-----------------
 2 files changed, 170 insertions(+), 72 deletions(-)

Cheers, David

