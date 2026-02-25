Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314C392814
	for <fstests@vger.kernel.org>; Wed, 25 Feb 2026 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015267; cv=none; b=PUvOaDL6rt0yeRCWfh1Ju+XtzEyapUpdSMe5W75DvALWY1PAbmNXa74YukVRP+iuBH7PLkBHnRYbJpK27p7AJt4sGjFyifa3eIXQCGbjZbbKmD+4qLvqfIXt4A0jZCCbFMWvtPmuA0e9dRcU2ZklSgiQvLXZbAhN/LQG5MSQOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015267; c=relaxed/simple;
	bh=5GtqqvJlMs4Ad6K/m/iFbsXDskYbfmhS6K1Ce3INJHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SYkRf0l1E8A/UhBvEu+CfhW+PG/hrU5Be9jGhYd+Qkh2GrKJANyLw8JG8o6c/uFig0M98b1aFF96Smda08EgpNmeSrymhI7dMrDsKKNkjwlpce1IbjNcwUIejPDU8MCde6gISyM/a1uZe12Cd3Awk0/pGMe51dzS0+3sfORWHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RKTgt0d9; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RKTgt0d9"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772015266; x=1803551266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5GtqqvJlMs4Ad6K/m/iFbsXDskYbfmhS6K1Ce3INJHA=;
  b=RKTgt0d9As/0ZbMu63jrM11tBzc7zVLvkiA0p8DwMjN4BaBv8z6bJy17
   nvSlkdc0/mj5QEEDv4gaWEyToQHC1kY3ekgCHQ1Pwxs1g4AgzwHHtW/Rl
   HELBQcyfDFfE2I9iys5vzsnomjK2WsG1VrRiiD2UXEcunjV2OGa2x6DC7
   N/cDJJwWsOlESIjmoww8bTO9tnvAyhF+UAm9B2TFU6yhRxI8SdOrv1gfb
   lyLrF2o+AQJeIHwE62w3nXBL0aGZYd2rfuCjRQMB/ebWpxzZPWBlQHoDj
   x3Mwe9mpZw7uV1FPhuCK4abk9f7EJXptIZRQgSX+e1/ViXp+jURGZH1OY
   A==;
X-CSE-ConnectionGUID: QNPgJ+CKT5aGDCcRhCc4iw==
X-CSE-MsgGUID: vQrkXftfQpa9xDSkDNZDRg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="141040117"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2026 18:27:45 +0800
IronPort-SDR: 699ecea1_7KwASu3sbmy0onnlqqbXf84pZHgyObxlComnmJd0a5TzAr9
 ZQPGR3K3cYALhYkosX5RXnLHORvgs0ND6qnjaKA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 02:27:46 -0800
WDCIronportException: Internal
Received: from c02g55h7ml85.ad.shared (HELO neo.fritz.box) ([10.224.26.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Feb 2026 02:27:43 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/2] fstests: simplify per-fs _fixed_by_kernel_commit
Date: Wed, 25 Feb 2026 11:27:39 +0100
Message-ID: <20260225102741.174955-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zorro,

Christoph asked in https://lore.kernel.org/r/20260210155123.GA3552@lst.de
to introduce a _fixed_by_fs_commit helper, that encapulates the
 if [ $FSTYP" = fs ] && _fixed_by_kernel_commit XXXXXX "blah"
pattern.

Here's my take on it. I also thought about adding more helpers like:
- _fixed_by_btrfs_commit
- _fixed_by_xfs_commit
- _fixed_by_ext4_commit
but not sure if this is going too far.

Changes to v1:
- Change to full blown if then fi in _fixed_by_kernel_commit
- Add Christoph's Reviewed-by

Johannes Thumshirn (2):
  fstests: add _fixed_by_fs_commit helper
  fstests: use _fixed_by_fs_commit where appropriate

 common/rc         | 10 ++++++++++
 tests/generic/211 |  2 +-
 tests/generic/362 |  3 +--
 tests/generic/363 | 10 ++++------
 tests/generic/364 |  3 +--
 tests/generic/365 | 15 ++++++---------
 tests/generic/366 |  2 +-
 tests/generic/367 |  2 +-
 tests/generic/370 |  5 ++---
 tests/generic/471 |  2 +-
 tests/generic/562 |  3 +--
 tests/generic/623 |  2 +-
 tests/generic/631 |  3 +--
 tests/generic/646 |  2 +-
 tests/generic/649 |  2 +-
 tests/generic/650 |  2 +-
 tests/generic/695 |  2 +-
 tests/generic/700 |  2 +-
 tests/generic/701 |  2 +-
 tests/generic/702 |  2 +-
 tests/generic/703 |  3 +--
 tests/generic/704 |  2 +-
 tests/generic/706 |  3 +--
 tests/generic/707 |  2 +-
 tests/generic/708 |  3 +--
 tests/generic/733 | 10 ++--------
 tests/generic/736 |  2 +-
 tests/generic/738 |  2 +-
 tests/generic/741 |  2 +-
 tests/generic/742 |  3 +--
 tests/generic/748 |  2 +-
 tests/generic/755 |  2 +-
 tests/generic/757 |  2 +-
 tests/generic/761 |  2 +-
 tests/generic/763 |  2 +-
 tests/generic/764 |  2 +-
 tests/generic/766 |  8 +++-----
 tests/generic/771 |  2 +-
 tests/generic/779 |  2 +-
 tests/generic/782 |  2 +-
 tests/generic/784 |  2 +-
 tests/generic/785 |  2 +-
 42 files changed, 63 insertions(+), 75 deletions(-)

-- 
2.53.0

