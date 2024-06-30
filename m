Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C914B95A
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=P21qYSUKTZkQGKPUrHl07v5kaFL/I0uId5ipt2wdf+kYbEZBnlcl5e+MflJN+mSutVSds7JlQeOMECTv4BbsIirWzM84zgQ21PHeQFHkv9kmSdSZESwVTlkcTr7nFFNiyvTctM1yrZqZhf3E7/K4PIG6t6/t9NY4fTXwMuDupXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=W9yldUhak0oAQZf4+rXraGneHoRaHA4kFtGk2/atIjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ejEEIO1jYVxuLkGRzkVym0FYthe/C9oQ4nafSmGW7xVg1R2aFO2DE9UDKBis4W4BBKBSIqPMm1aM72lBf2ZkmykP/SgiuxjHTCmrmL3tzVPX5eDOX9FqX0AalAdSetrj2Xa1oBXbA70FL8RzU6eTij38MtkWFBWszYllgRfUdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah2CK12A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah2CK12A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0F7EC116B1;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845522;
	bh=W9yldUhak0oAQZf4+rXraGneHoRaHA4kFtGk2/atIjE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ah2CK12Al7LHZDx1AAuws0ReQQm3/M2Yu5wpf/9b+g0ZGvZ45p7ciuAoO9lvIMWId
	 1j/OX6aU4gdrWpQlFlhB91/9bBypmfq+8VM6jo6HtIGDU01r8nnm6ZFOIBjHyFgM6M
	 0ekWo2AJjtXX9Cc/AsMu30Du/bo8mEklzl5oHgMrjJKptdod+0o+rQ8XMc9EfwKAyv
	 iZJKWLsyCmvkzNq0wIyq+SEc22cewGzuNoWYA3ZAORqPLZpFzFQekIfPy1j9/S5jSJ
	 ibwYIsPjDa9vipWW8Lz2iwkzxGbUn43HD45bjNnVkE4ZM7Ild18Yz7AYwkFbuO3cg0
	 b+fUWNY+mzbzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3874C2BD09;
	Mon,  1 Jul 2024 14:52:02 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Subject: [PATCH v2 0/5] common fixes
Date: Sun, 30 Jun 2024 23:52:39 +0200
Message-Id: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfTgWYC/x3LQQqAIBBA0avIrBsQydCuEi1Mp5qFGgoRSHdPW
 j4+v0GlwlRhFg0K3Vw5pw41CPCnSwchh25QUo1yUhZ9jjEn3PmhitJpr03YjPYW+nIV+kM/lvV
 9Pw+C1MBeAAAA
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=1524;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=W9yldUhak0oAQZf4+rXraGneHoRaHA4kFtGk2/atIjE=;
 b=q+x9dejRfzUC+9wzwKiVMLyiBIMNd/9zPRaTk6iGiGrQRwIrRczenZCdjFfesZxdeRGynfOA9
 8vTMAmmkD77DS/WQkTA+eOV9xmYB9J0ZMS+G4Il/Z/nPFUjtCrgnCf+
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

Config section fixes for scratch and recreation test devices.

Changes since v1:
* Drop tmpfs/449 patch.
Note: I will submit it in a different series with the feedback received.
* Applied review tags from Darrick and Zorro for patch 1.
* Do not inject specific TMPFS mount options in recreation and scratch
mount options. Instead,
  * Fix recreation test device by allowing section parsing to read
specific fs mount options when RECREATE_TEST_DEV is enabled.
  * Use _common_mount_opts() for scratch mounts instead of
_common_dev_mount_options() to allow parsing section fs specific mount
options for scratch devices.
* print only test mkfs and mount devices instead of adding scratch and
test sections.
* Add/export and report new TEST_MKFS_OPTIONS and TEST_MOUNT_OPTIONS.
* Change patch series subject.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
Daniel Gomez (5):
      common/config: fix RECREATE_TEST_DEV initialization
      common/rc: add recreation support for tmpfs
      common/config: enable section parsing when recreation
      common/rc: read config section mount options for scratch devs
      common/rc: print test mount options

 check         |  2 ++
 common/config |  4 ++--
 common/rc     | 26 +++++++++++++++++++++++---
 common/report |  1 +
 4 files changed, 28 insertions(+), 5 deletions(-)
---
base-commit: 83598d2f839d9c27d2fd4209124d7c288ea2861e
change-id: 20240629-common-fixes-0a5c58db85c9

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>


