Received: from mail-oi0-f65.google.com ([209.85.218.65]:36222 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcAIDzG (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 8 Jan 2016 22:55:06 -0500
Received: by mail-oi0-f65.google.com with SMTP id a202so1492243oib.3
        for <fstests@vger.kernel.org>; Fri, 08 Jan 2016 19:55:06 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH V2 0/2] fstests: help user to troubleshoot the re-mount issue quickly
Date: Sat,  9 Jan 2016 11:54:51 +0800
Message-Id: <1452311693-27529-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

When I tried to fix a mount issue of tests/xfs/003 failure, I found the
root cause is my mistake that I added "/" to the end of TEST_DIR, eg.
export TEST_DIR=/root/xfstests/test/
This patch set is to let user find the correct cause quickly.

V2: Instead of adding comments, remove all trailing "/"s by readlink.
This is suggested by Eryu Guan.

Jia He (2):
  fstests: add user friendly prompts for already mounted point name
  fstests: canonicalize the mount points by removing the trailing "/"

 common/config | 5 +++++
 common/rc     | 8 ++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.1.4

