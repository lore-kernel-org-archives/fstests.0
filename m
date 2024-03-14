Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75D87443F
	for <fstests@vger.kernel.org>; Thu, 14 Mar 2024 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437122; cv=none; b=BpddoMrLQBaI9WgBAa0wGwSsrQCtek069D6mOArMr94gz1z+qcqEfjKS+xvJz4JsFPqtBGm9kgYlqFrUbW9AMMmQLdJ8zi+y93PInkv5xU16hXeCLWp8RoVaUXeMwaokwPhdO4oAt9cq+JAYlk6PM+cynnTyaQAG7JYBvD6IgR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437122; c=relaxed/simple;
	bh=Xd+ESSJyvTqFXZMnzIcGre6Hrx8IUIcnofGGI4+NDI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoDdbcQhCpqDqRficeTRnXuJniiiA8JRGeMbnwnxndSbAXIogmE8ZzQ/c7J/rW3Ct1XlqgHE9nzBd2V8zIcODsxfIOCzs+NrGK5wllkZsnCO8j+/MdxR/U6VhbOyFU8RTfem8WmQ+0lPsFxDau9Rr/vrp/coJJoZlfmEe0Y6rG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B7Xcb+O4; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B7Xcb+O4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710437117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MOgrtxsq2bnsYDxxJjyU0h81M0XW4XlgFOipm29RQpk=;
	b=B7Xcb+O4DzJtdjfsnAEELcoMLmeY91aQpehqoguHX7mmc33IgYfje9LDc48vj7YbYLo3zm
	EN9KpYwxOZcUO++2ido2s1iKc4bVpmeFyEE+Ee3A10HvU/Q22Oe81x+Ojrr8NyxCMHQ4eQ
	IRkr0xqDvVvNu0Chn/xR7rlzPH9+4ls=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: fstests@vger.kernel.org
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 0/2] Ensure _scratch_fuzz_modify() works for other filesystems
Date: Thu, 14 Mar 2024 17:25:10 +0000
Message-ID: <20240314172512.28293-1-luis.henriques@linux.dev>
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

Luis Henriques (SUSE) (2):
  common/fuzzy: make _scratch_fuzz_modify work for non-xfs filesystems
  ext4/006: take into account updates to _scratch_fuzz_modify()

 common/fuzzy   | 16 +++++++++-------
 tests/ext4/006 |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

