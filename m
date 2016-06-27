Received: from mx1.redhat.com ([209.132.183.28]:39944 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0Wk0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jun 2016 18:40:26 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E5EE64478
	for <fstests@vger.kernel.org>; Mon, 27 Jun 2016 22:40:26 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 0/3] Richacl tests
Date: Tue, 28 Jun 2016 00:40:19 +0200
Message-Id: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Here's an updated version with Eryu's feedback incorporated.  (The first patch
is an unchanged repost.)

Thanks,
Andreas

Andreas Gruenbacher (3):
  generic/026: This test doesn't require runas
  generic/093,099,237 shared/051: Add / use _require_runas and _runas
  generic/362-370: Add richacl tests

 common/config         |   2 +
 common/rc             |  57 ++++++++++++++++++++
 tests/generic/026     |   3 --
 tests/generic/093     |  14 +++--
 tests/generic/099     |  45 ++++++++--------
 tests/generic/237     |   6 +--
 tests/generic/362     | 125 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/362.out |  94 +++++++++++++++++++++++++++++++++
 tests/generic/363     | 117 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/363.out | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/364     |  98 +++++++++++++++++++++++++++++++++++
 tests/generic/364.out |  39 ++++++++++++++
 tests/generic/365     |  91 ++++++++++++++++++++++++++++++++
 tests/generic/365.out |   9 ++++
 tests/generic/366     |  85 ++++++++++++++++++++++++++++++
 tests/generic/366.out |  11 ++++
 tests/generic/367     |  84 ++++++++++++++++++++++++++++++
 tests/generic/367.out |  11 ++++
 tests/generic/368     |  84 ++++++++++++++++++++++++++++++
 tests/generic/368.out |   7 +++
 tests/generic/369     | 125 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/369.out |  24 +++++++++
 tests/generic/370     |  89 ++++++++++++++++++++++++++++++++
 tests/generic/370.out |  19 +++++++
 tests/generic/group   |   9 ++++
 tests/shared/051      |  48 +++++++++--------
 26 files changed, 1372 insertions(+), 64 deletions(-)
 create mode 100755 tests/generic/362
 create mode 100644 tests/generic/362.out
 create mode 100755 tests/generic/363
 create mode 100644 tests/generic/363.out
 create mode 100755 tests/generic/364
 create mode 100644 tests/generic/364.out
 create mode 100755 tests/generic/365
 create mode 100644 tests/generic/365.out
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out
 create mode 100755 tests/generic/368
 create mode 100644 tests/generic/368.out
 create mode 100755 tests/generic/369
 create mode 100644 tests/generic/369.out
 create mode 100755 tests/generic/370
 create mode 100644 tests/generic/370.out

-- 
2.5.5

