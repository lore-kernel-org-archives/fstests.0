Received: from mx1.redhat.com ([209.132.183.28]:59675 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbcGAQJN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 1 Jul 2016 12:09:13 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 0/2] xfstests: extended names fixes
Date: Fri,  1 Jul 2016 18:09:05 +0200
Message-Id: <1467389347-2055-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Two fixes for extended names for tests (tests/foo/123-bar-baz).

Jan Tulak (2):
  xfstests: Fix installation for extended names
  xfstests: filename handling for extended names in ./check was on a
    wrong place

 check                  | 27 ++++++++++++++-------------
 tests/btrfs/Makefile   | 21 +++++++++++++++++----
 tests/cifs/Makefile    | 21 +++++++++++++++++----
 tests/ext4/Makefile    | 21 +++++++++++++++++----
 tests/f2fs/Makefile    | 24 ++++++++++++++++++------
 tests/generic/Makefile | 21 +++++++++++++++++----
 tests/overlay/Makefile | 23 ++++++++++++++++++-----
 tests/shared/Makefile  | 21 +++++++++++++++++----
 tests/udf/Makefile     | 21 +++++++++++++++++----
 tests/xfs/Makefile     | 21 +++++++++++++++++----
 10 files changed, 169 insertions(+), 52 deletions(-)

-- 
2.5.5

