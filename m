Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18280C433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3189611ED
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhDZUvA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:59682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhDZUu7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 16:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18DD9AEB9
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 20:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D18781F2B5D; Mon, 26 Apr 2021 22:50:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] fstests: Improve tmpfs handling
Date:   Mon, 26 Apr 2021 22:50:10 +0200
Message-Id: <20210426205012.13241-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello,

when testing tmpfs with fstests, I've noticed a couple of fstests failures
which are bugs in tests (usually expecting functionality tmpfs does not
provide). The following two patches fix them.

								Honza
