Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64396C43219
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 02:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiBICjU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiBICCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 21:02:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466F3C0613CC
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sf43BNI2V4FpS9Kue2UAkbM7cOzgAITFR1lfK7pfdvY=; b=2ZKo8dbxVkv0gLgdL8A7mFt5Qk
        ipA+A+4B5ULnIx0FV1b3C6sOhfwNyc+ocF/pmql00mkWo5qDtBuBw2BBCQ/+h3Mi4PJqlaX34CG2b
        9424rmx7jiSu4SMIvsv3Z30mjacHF6C+eTyUw/2a6uWKmEezbdTS5XRTeHNrVzLlwX7SbNcCjqUp5
        FJmqkt76lgGeNHOc6Lp9OED4oiLw28CXbNOarokiKvReigKEYUZRQNkSeIgK54VbDdfqHA14zs2zF
        ajeXP5tj8Hmj3VgypvDz0CRDFxiawfEEhLINxXEZrG/uOw7RVdxcg+Mt9DllaxB7pRkWU7T9RVPRk
        VCK+S8lw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHcJO-00FxxV-2W; Wed, 09 Feb 2022 02:02:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/4] dbench: fixes for latest glibc
Date:   Tue,  8 Feb 2022 18:02:19 -0800
Message-Id: <20220209020223.3805346-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

debian testing dropped dbench...

I looked into it and it turns out that this has to do with it not
compiling anymore.

glibc nuked rpc/rpc.h and so libtirpc-devel is needed now.
This fixes this and few other minor issues when trying to
compile dbench on a modern distro.

fstests generic/241 uses dbench and so I'm Cc'ing the fstests
list as folks there would be interested. I'm not sure when and
if the dbench git repo from samba will be updated so I just
put this up on my git tree in case this helps others:

https://github.com/mcgrof/dbench

Luis Chamberlain (4):
  configure.in: rename to configure.ac
  config.h.in: run autoheader and update
  Makefile: address deprecation of /usr/include/rpc
  libnfs.c: fix compilation due to intptr_t move

 Makefile.in                  | 14 ++++++++------
 config.h.in                  | 18 ++++++++++++------
 configure.in => configure.ac |  0
 libnfs.c                     |  1 +
 4 files changed, 21 insertions(+), 12 deletions(-)
 rename configure.in => configure.ac (100%)

-- 
2.34.1

