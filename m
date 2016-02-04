Received: from mgwym03.jp.fujitsu.com ([211.128.242.42]:22784 "EHLO
	mgwym03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbcBDAs4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 3 Feb 2016 19:48:56 -0500
Received: from g01jpfmpwkw02.exch.g01.fujitsu.local (g01jpfmpwkw02.exch.g01.fujitsu.local [10.0.193.56])
	by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 386C4AC01BB
	for <fstests@vger.kernel.org>; Thu,  4 Feb 2016 09:48:52 +0900 (JST)
From: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Subject: [PATCH] aio-dio-eof-race should be ignored by git
Message-ID: <56B29FD6.3010701@jp.fujitsu.com>
Date: Thu, 4 Feb 2016 09:48:22 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

src/aio-dio-regress/aio-dio-eof-race is a binary file built by make.
So it should not be tracked by git.

===============================================================================
$ make clean
...
$ git status
On branch sat-bugfixes
nothing to commit, working directory clean
$ make
...
$ git status
On branch sat-bugfixes
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	src/aio-dio-regress/aio-dio-eof-race
===============================================================================

Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5dc4f69..a6f47d3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,7 @@
 /src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiodio_sparse2
+/src/aio-dio-regress/aio-dio-eof-race
 /src/cloner
 /src/renameat2
 /src/t_rename_overwrite
-- 
2.7.0.rc3

