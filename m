Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E019DF95
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222415; cv=none; b=WXc5xYb+FQYyAQC6e1253LiJBmQ2XJneyUsVbxU1H83f+FBmOrcTsxHift0kdpaxbZBN68hAuKzJVrh7kTAeVs/KbwgDAnX+eX4coSwZQHvHI0yJ+uDI3jYCeSD0HjSstqPP2IaawoHfXc7p4zgUJxZzE5l7ZmhPMlq1Fv5QB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222415; c=relaxed/simple;
	bh=UXMt3iehzFlFfjqCCvLrPxoAje+krNaz9cB9pRL60Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fvOUME30WnAbJDkY23UJnI3Myek1VhG04S0/2Th+EqScMS9G07Sjaek9+ggqlmlJ72yC/0f3YYbD68yCvluacyzS0EuKmHKUA1QhcKGL/rVsLPItcXaZVG+Ep/I90H4MgmNsWIL//jwT2pAWS8lj1uhjnB+6BG8bXKZmuthFSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UkZLsisJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UkZLsisJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730222412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z/RjLQhDQA+hKv8lp/NFPhE8BCRyVLofzfTSi7e2w6s=;
	b=UkZLsisJnnhvg72Rkl8dn9Wika4Ul+VG/CQjF8xkooAa/3R/MaLncXY07gTBS/fFT3prpJ
	7UrhR/kS9SzinQr4DQipImY4jeoHfEogC1c65+4ONzjMMkBhOMezEm9K8MUQTV2mL30JWB
	ZOKWsj7jegxHRfy7kcRrAW7QdQTeyWE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-zWEIczE9O_2fjy4gRxrpsQ-1; Tue,
 29 Oct 2024 13:20:09 -0400
X-MC-Unique: zWEIczE9O_2fjy4gRxrpsQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D2719560BD;
	Tue, 29 Oct 2024 17:20:07 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.80.135])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D91A619560AA;
	Tue, 29 Oct 2024 17:20:06 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	hch@lst.de
Subject: [PATCH v2 0/2] fstests/xfs: a couple growfs log recovery tests
Date: Tue, 29 Oct 2024 13:21:33 -0400
Message-ID: <20241029172135.329428-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

v2:
- Miscellaneous cleanups to both tests.
v1: https://lore.kernel.org/fstests/20241017163405.173062-1-bfoster@redhat.com/

Brian Foster (2):
  xfs: online grow vs. log recovery stress test
  xfs: online grow vs. log recovery stress test (realtime version)

 tests/xfs/609     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/609.out |  2 ++
 tests/xfs/610     | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/610.out |  2 ++
 4 files changed, 168 insertions(+)
 create mode 100755 tests/xfs/609
 create mode 100644 tests/xfs/609.out
 create mode 100755 tests/xfs/610
 create mode 100644 tests/xfs/610.out

-- 
2.46.2

