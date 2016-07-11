Received: from mx1.redhat.com ([209.132.183.28]:53373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbcGKJ0P (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jul 2016 05:26:15 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 0/4 v2] xfstests: extended names fixes
Date: Mon, 11 Jul 2016 11:26:05 +0200
Message-Id: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Some fixes for extended names in tests (tests/baz/123-foo-bar). This version
has more patches than previous, because I split the second patch into three.

Jan Tulak (4):
  xfstests: Fix installation for extended names
  fstests: filename handling for extended names in ./check was on a
    wrong place
  xfstests: remove unused variable
  xfstests: filename handling - fix early wildcard expansion

 check                  | 26 +++++++++++++-------------
 include/buildrules     | 31 +++++++++++++++++++++++++++++++
 tests/btrfs/Makefile   |  4 ++--
 tests/cifs/Makefile    |  4 ++--
 tests/ext4/Makefile    |  4 ++--
 tests/f2fs/Makefile    |  4 ++--
 tests/generic/Makefile |  4 ++--
 tests/overlay/Makefile |  4 ++--
 tests/shared/Makefile  |  4 ++--
 tests/udf/Makefile     |  4 ++--
 tests/xfs/Makefile     |  4 ++--
 11 files changed, 62 insertions(+), 31 deletions(-)

-- 
2.5.5

