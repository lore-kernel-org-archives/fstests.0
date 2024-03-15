Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CD4CB36
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522813; cv=none; b=elpV4BreYRgCuzpp0JPp+IJrMWDjLxoNjZCXHnsxlICzJWJ9aGSyrapvGMiXqmhcgKEv/+Xzc7MZomVFb/eO783qAOB8T5Vio1YSVBtJ/Rg/m04IUoeL7ozoWybZUUzV5Z+ltW4fwDO5S/8pVHuPnQggNXa0C4Y2a+XjE0QKrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522813; c=relaxed/simple;
	bh=Q8PdRXsqChdmychSRE7ickj4QKv9WJkyGyqBq1f66eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUMeYsSZRSiQ3mAi3F7ZA+KhyulsrnZnGTydCTwKiL7h4sKwk2RX/g21/WyaIjX5qQ8u5wxvDuMNrNwO1Dgv/y/VfrFyyfSVHy7gAferZ2IjeZEY0faLciJcTP3sxMEb/49YSCHtNgEEq9fRx8IR5hhNnO8J2gqP4B51Zv8vZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfxaVA/n; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfxaVA/n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710522809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r2CmgI0MQfc6P8vpumLfjrJfmJ+Fctf++QCbrin1C+I=;
	b=MfxaVA/n/PAgCg6BVyMNiHIrwbrFHm+DV8C2gJo5USrAxC98UXLfElV+w2JdCnAq2mEjpE
	Z2G7QBgCMOFtIkOasxVkbzAxZj4J/3qBCCtpNj+n7PCBCPO/80OS1vbYEMXDfVoVKan9Ni
	M1wwqc3EZcoEu/JGXj8OD4UPBCBf2vE=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 0/2] Ensure _scratch_fuzz_modify() works for other filesystems
Date: Fri, 15 Mar 2024 17:13:23 +0000
Message-ID: <20240315171325.2885-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi!

I guess test ext4/006 isn't executed very often, because as far as I can see
it has been broken for quite some time.  The problem is that the function
_scratch_fuzz_modify() is executing xfs-specific operations that will make
this test fail.

The first patch updates this function so that xfs-specific operations are
executed only when that filesystem is being tested.

The second patch simply updates the test to take into account the new output
of the function (and yeah, counting log lines is an ugly hack).

Changes since v1:
* Updated the second patch commit message to add further details on what
  changed with the test output.

Luis Henriques (SUSE) (2):
  common/fuzzy: make _scratch_fuzz_modify work for non-xfs filesystems
  ext4/006: take into account updates to _scratch_fuzz_modify()

 common/fuzzy   | 16 +++++++++-------
 tests/ext4/006 |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

