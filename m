Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D82749C5
	for <fstests@vger.kernel.org>; Wed, 28 May 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423741; cv=none; b=gr8hpQNlbtgdA1ePgarBJD47nOUcz0LqVzyEg3uBD2tx/ZnHXfw5W90glHkcWA+euahgfNBtk2JoGLxMZa+Ic1gVWBhEj+zZQilyfvRcRznY4V4pGBd22HP+LbY/ymOkNkUdWH75csdhZSeDHEmDdPocqQcBVbWhM1yUrkHIXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423741; c=relaxed/simple;
	bh=73Wt2BAiOOK4eUKjX8jg4ShluQ+3Sb525Ei4QM4bTLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i9/cOP4q+lGrMbqHmoCZMureOVtv2M+kAJnnW688wVhMT3ZJkpDNDVJ0UJV4YdwC7wN/Ii83gqcUBTn3X2uTlFW9Y5I9NqYdhFRCH7ObsJ157WkzSamdH7BctlyeMUstgTQM3W7JYS2tK+J9xOYdKt0LNNY5pvdohUbPv/0zdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PRqfAgbD; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PRqfAgbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1748423739; x=1779959739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YNFWdhmmD51HM54WGrM2i/UZhUlcR5x08K+8fZJiTOQ=;
  b=PRqfAgbDNKFAo6nb4Q8c5oCjiEadfR/uaymQbj/kAAHTpim1c7TGjxps
   IXX1j5CD0yNra4FkMLefQeT9Z0Hm9KxntpoR0XSJSoAiz/+MdGsVfP2qb
   FlUtlWWnPG/yQ3Yp5xwjSzHznRYuzldRzXAKPzDMVvDLBlW6O9ysNs125
   KfQzK6pk2uqkx349k+SkzhqjcHDwHNNteI7qVE9K/E5PUn+cR73H/309q
   boOmMQZSu+xjwS2Otttp/87yAtJEidgKJfkCCeLegq5NW4vNrTAA+UOMW
   mpeMKj+FIG6ScxpUq75ce5NiS7BkxcfGXWL7a7w/MUen9JOjO8ZbLjLGv
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 18:15:31 +0900
X-IronPort-AV: E=Sophos;i="6.15,320,1739804400"; 
   d="scan'208";a="534970974"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 28 May 2025 18:15:31 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org,
	friendy.su@sony.com
Subject: [PATCH v1 0/7] add test requirements
Date: Wed, 28 May 2025 17:15:23 +0800
Message-ID: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches add test requirements to the following tests so that
they do not run on filesystems that do not support these requirements,
rather than causing the tests to fail.

Yuezhang Mo (7):
  generic/696: add _require_chmod
  generic/656: add _require_chown
  generic/754: add _require_symlinks
  generic/755: add _require_hardlinks
  generic/730: add _require_scratch_shutdown
  generic/645: add _require_chown
  generic/633: add test requirements

 tests/generic/633 | 6 ++++++
 tests/generic/645 | 1 +
 tests/generic/656 | 1 +
 tests/generic/696 | 1 +
 tests/generic/730 | 1 +
 tests/generic/754 | 1 +
 tests/generic/755 | 1 +
 7 files changed, 12 insertions(+)

-- 
2.25.1

