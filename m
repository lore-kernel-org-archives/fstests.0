Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C7C07E98
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6814A61363
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Jul 2021 04:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhGEEFy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Jul 2021 00:05:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53455 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229515AbhGEEFy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Jul 2021 00:05:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16543FRd017795
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 00:03:15 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A9A0B15C3C91; Mon,  5 Jul 2021 00:03:13 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/2] skip tests that don't work with an external log
Date:   Mon,  5 Jul 2021 00:03:05 -0400
Message-Id: <20210705040307.3322709-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I recently tried running xfstests with an external log device, and
found a number of failures caused by the fact that we use dmflakey and
dmerror to take down a disk to simulate a power failure or a complete
hard disk failure.  But with an external log device, the tests don't
correctly simulate these scenarios, so skip them.

With these patches, testing with ext4 using an external log is passing
almost all of the auto group tests, with the exception of ext4/028
(which appears to be a genuine ext4 fsmap bug not handling external
log devices correctly).

Theodore Ts'o (2):
  dmflakey: don't run dmflakey tests with an external log device
  generic/475: skip test when using an external log device

 common/dmflakey   | 4 ++++
 tests/generic/475 | 4 ++++
 2 files changed, 8 insertions(+)

-- 
2.31.0

