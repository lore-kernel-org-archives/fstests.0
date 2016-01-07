Received: from mail-ob0-f176.google.com ([209.85.214.176]:34446 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbcAGGhh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 Jan 2016 01:37:37 -0500
Received: by mail-ob0-f176.google.com with SMTP id wp13so183991718obc.1
        for <fstests@vger.kernel.org>; Wed, 06 Jan 2016 22:37:36 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH 0/2] fstests: help user to troubleshoot the re-mount issue quickly
Date: Thu,  7 Jan 2016 14:37:27 +0800
Message-Id: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

When I tried to fix a mount issue of tests/xfs/003 failure, I found the 
root cause is my mistake that I added "/" to the end of TEST_DIR, eg.
export TEST_DIR=/root/xfstests/test/
This patch set is to let user find the correct cause quickly

Jia He (2):
  fstests: comments to prevent from adding "/" to the end of 2 environment variables
  fstests: give user friendly prompts for already mounted dir

 common/rc                | 8 ++++++--
 configs/example.config   | 1 +
 configs/localhost.config | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.1.4

