Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB549C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiBIW0s (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235504AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE47E016466
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XwfrC/j/2QuPyaMi1BUKKWvKRDzHJESk2Ms0iB801hs=; b=rNuLpwBZTSMQoygBeQmGy4uwWV
        mDIBX8IE7bynr7Zee4Ego2Oite9RabFO2GvWUiEQRIrXIJyUTs1bQep1uG3PCQ8fQIP8t7sR7wH4l
        1L9PakJKdwn6QBBfok1HIWyHvJBQ3AmTm9xqN+nG44d3F0eZhcqG+GKJrgBI0MEHK1G21Sq9WW9k0
        MXRs+0nV+LBXAJLLgkTz5g37rCHUHXSTBM2QDOQ/9O8+/xgN8SDlIKf3Jybp7CwXjBIWCCZ0ozFmv
        fRu2sKxigDhOQqtVT8tyjp/eNN8fenwCjry8dnFYpYSyntIbkJd/o9Eiz76AwZIZMT6yBsTknod9j
        4BZ6TuSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q73-E5; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 23/25] configure.ac: fix smbclient detection
Date:   Wed,  9 Feb 2022 14:26:08 -0800
Message-Id: <20220209222610.438470-24-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We need to ask smbclient for the cflags, otherwise
the headers won't be found.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b8c26fe..93763d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -113,7 +113,7 @@ fi
 AC_MSG_CHECKING(whether libsmbclient is available)
 ac_save_CFLAGS="$CFLAGS"
 ac_save_LIBS="$LIBS"
-CFLAGS="$CFLAGS $GLIB_CFLAGS"
+CFLAGS="$CFLAGS $GLIB_CFLAGS $(pkg-config --cflags smbclient)"
 LIBS="$GLIB_LIBS $LIBS -lsmbclient"
 AC_RUN_IFELSE([AC_LANG_SOURCE([[
 #include <stdio.h>
-- 
2.34.1

