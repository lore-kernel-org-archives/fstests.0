Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39721 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbaJAP11 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 1 Oct 2014 11:27:27 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 99EB6AD37
	for <fstests@vger.kernel.org>; Wed,  1 Oct 2014 15:27:26 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH] xfs/287: Make test fail graciously when xfsdump isn't installed
Date: Wed,  1 Oct 2014 17:27:19 +0200
Message-Id: <1412177239-27241-2-git-send-email-jack@suse.cz>
In-Reply-To: <1412177239-27241-1-git-send-email-jack@suse.cz>
References: <1412177239-27241-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Include common/dump into xfs/287 so that the test fails graciously when
xfsdump isn't installed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/xfs/287 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tests/xfs/287 b/tests/xfs/287
index 445610b..b9276a7 100755
--- a/tests/xfs/287
+++ b/tests/xfs/287
@@ -35,6 +35,7 @@ rm -f $seqres.full
 # get standard environment, filters and checks
 . ./common/rc
 . ./common/quota
+. ./common/dump
 
 _cleanup()
 {
-- 
1.6.0.2

