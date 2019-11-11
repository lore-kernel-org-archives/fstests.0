Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4FFC43331
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 15:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BC22084F
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 15:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKPF3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:05:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:34038 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfKKPF3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Nov 2019 10:05:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A5D9B034;
        Mon, 11 Nov 2019 15:05:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DBC11E47E5; Mon, 11 Nov 2019 15:49:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3 v2] Fix generic/050 for filesystems without journal
Date:   Mon, 11 Nov 2019 15:49:50 +0100
Message-Id: <20191111144953.23871-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

this is the second revision of the patches to fix test generic/050 for
filesystems without journal (e.g. ext4 in nojournal mode) by converting the
test to have alternate outputs. We also cleanup special handling of XFS
with quotas in this test.

								Honza
