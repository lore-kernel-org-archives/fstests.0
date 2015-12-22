Received: from mx1.redhat.com ([209.132.183.28]:58576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbbLVUyG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 22 Dec 2015 15:54:06 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 2BF33219D
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 20:54:06 +0000 (UTC)
Received: from schleppi.home.com (vpn1-6-224.ams2.redhat.com [10.36.6.224])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tBMKs3S4007345
	for <fstests@vger.kernel.org>; Tue, 22 Dec 2015 15:54:04 -0500
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/6] fsx
Date: Tue, 22 Dec 2015 21:53:50 +0100
Message-Id: <1450817636-11416-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Here is a bunch of fixes / improvements to fsx.  The first patch was already
posted two weeks ago with no reaction yet; the rest is new.

Thanks,
Andreas

Andreas Gruenbacher (6):
  fsx: Small improvements and fixes
  fsx: Fix hex numbers in operation dump
  fsx: Report number of successful operations
  fsx: Generate test parameters in test()
  fsx: Improve operation logging
  fsx: Add mechanism to replay failed operations

 common/rc             |  14 ++
 ltp/fsx.c             | 415 +++++++++++++++++++++++++++++++++++++-------------
 tests/generic/091     |  12 --
 tests/generic/127.out |  12 +-
 tests/generic/231.out |  12 +-
 tests/generic/263     |  12 --
 6 files changed, 332 insertions(+), 145 deletions(-)

-- 
2.4.3

