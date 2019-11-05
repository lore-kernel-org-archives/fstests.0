Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F98C17460
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A403121D71
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbfKENT1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:19:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:51608 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388782AbfKENT1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Nov 2019 08:19:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34C5FAFF6
        for <fstests@vger.kernel.org>; Tue,  5 Nov 2019 13:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 061361E47E5; Tue,  5 Nov 2019 14:19:26 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2] generic/050 fixes
Date:   Tue,  5 Nov 2019 14:19:20 +0100
Message-Id: <20191105131922.24848-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Hello,

test generic/050 generates false failures on filesystems without journal
(e.g. ext4 in nojournal mode). The test actually makes some sense in
these cases to test behavior with read-only devices so I've decided to
fix the test by providing alternate output for such filesystems. Also
XFS with quota was already special-cased in the test and was faking the
output so the second patch transitions that to alternate output file as
well.

								Honza
