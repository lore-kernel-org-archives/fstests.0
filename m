Received: from mx1.redhat.com ([209.132.183.28]:46746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbcF1Mrd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 28 Jun 2016 08:47:33 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E340C049E17
	for <fstests@vger.kernel.org>; Tue, 28 Jun 2016 12:47:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v7 3/3] generic/362-370: Add richacl tests
Date: Tue, 28 Jun 2016 14:47:25 +0200
Message-Id: <1467118046-27030-1-git-send-email-agruenba@redhat.com>
References: <1467067222-18286-1-git-send-email-agruenba@redhat.com> <1467067222-18286-4-git-send-email-agruenba@redhat.com> <20160628073058.GA23649@eguan.usersys.redhat.com> <CAHc6FU4BUDHVZA_Dq6oowvqz92wmXwb6bD6PtC6CZcrQ9+83iw@mail.gmail.com>
In-Reply-To: <CAHc6FU4BUDHVZA_Dq6oowvqz92wmXwb6bD6PtC6CZcrQ9+83iw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, Eryu Guan <eguan@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Here's an updated version.

Thanks,
Andreas

Andreas Gruenbacher (1):
  generic/362-370: Add richacl tests

 common/config         |   2 +
 common/rc             |  61 ++++++++++++++++++++++
 tests/generic/362     | 125 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/362.out |  94 ++++++++++++++++++++++++++++++++++
 tests/generic/363     | 118 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/363.out | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/364     |  98 +++++++++++++++++++++++++++++++++++
 tests/generic/364.out |  39 ++++++++++++++
 tests/generic/365     |  93 +++++++++++++++++++++++++++++++++
 tests/generic/365.out |   9 ++++
 tests/generic/366     |  86 +++++++++++++++++++++++++++++++
 tests/generic/366.out |  11 ++++
 tests/generic/367     |  85 ++++++++++++++++++++++++++++++
 tests/generic/367.out |  11 ++++
 tests/generic/368     |  85 ++++++++++++++++++++++++++++++
 tests/generic/368.out |   7 +++
 tests/generic/369     | 126 +++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/369.out |  24 +++++++++
 tests/generic/370     |  90 ++++++++++++++++++++++++++++++++
 tests/generic/370.out |  19 +++++++
 tests/generic/group   |   9 ++++
 21 files changed, 1331 insertions(+)
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

