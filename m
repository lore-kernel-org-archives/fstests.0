Return-Path: <SRS0=OCqJ=YZ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AD7CA9ECF
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067A6217D9
	for <linux-fstests@archiver.kernel.org>; Fri,  1 Nov 2019 11:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKALAy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfKALAy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 1 Nov 2019 07:00:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74052B318
        for <fstests@vger.kernel.org>; Fri,  1 Nov 2019 11:00:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EFF41E482F; Fri,  1 Nov 2019 12:00:53 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Subject: [PATCH 0/2] Two fixups for quota tests
Date:   Fri,  1 Nov 2019 12:00:44 +0100
Message-Id: <20191101110046.24994-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

the two patches in this series fix up false test failures in generic/235
and generic/382 tests for ext2/ext3. In both cases the problem is the
tests assume particular amount of blocks is consumed but this is not the
case for ext2/ext3 due to indirect blocks.

								Honza
