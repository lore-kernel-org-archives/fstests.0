Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7743AB9
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361642; cv=none; b=Zq47DNPubdKlstXp0f0zbPp2ZGm7A0cr3+lSfuPJeXVzcgQbphpTB7ZunO+KQwNI6qsXFB6tRjUjMZk6DhnB/gR0A82jkZL1FNX5ytf7lGW4eRFv9uVV3JIu9gnCgqI7M38PTVc94npJ9lpi5WsspZn56SZHzigtv+A7vYTOBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361642; c=relaxed/simple;
	bh=nraSc/lXWQHcKWhKF4hT7fiygTGoPehAyePnQ6wCUOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXjVA6P3m8SdP/bGI36OwxV9nUOsYZZllA8ZTATYgscIHTkYgZ6ZH5t46blm/kK/ZBYE6/s7rWEjQX4onHN9X47hgMQVS49Jqm+tDc+SOY6omedorUxyMGyJztH8lWNbTeezoNhmTqiCm2BFYGZm/cOlW5q9QkK3YMuepg+T2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efcrJBjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efcrJBjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727361639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1qyFYOnVnJZ3AD38B+U8auD1NeFwiApxzJegsUkCwAs=;
	b=efcrJBjdbnYiZU3TZU8ZN5p0K5pjY5fjD5Yx18oTZttg6cpyY742CLW4DDRrNhWCTp44Jc
	LwTh1rionAlAMKkFOrt7baSAPHHffvxctgtledSZDakamiABkNyLtYZETvNDOUsSkPey76
	349wIcbj2MUf52qQcTk3nAmMAqIpL3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-2uYsAg97PYeujht3Ek8qSA-1; Thu,
 26 Sep 2024 10:40:38 -0400
X-MC-Unique: 2uYsAg97PYeujht3Ek8qSA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7596318B3208
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:37 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 059AD1954B0E
	for <fstests@vger.kernel.org>; Thu, 26 Sep 2024 14:40:36 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Subject: [PATCH 0/2] fsx: support unshare range fallocate mode
Date: Thu, 26 Sep 2024 10:41:45 -0400
Message-ID: <20240926144147.106685-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi all,

Here's v1 of unshare range mode support for fsx. This includes only
minor tweaks from the RFC version and I tacked on a second patch to try
and fix up some missing fallocate flag ifdefs. Note again this applies
on top of the eof pollution mode series currently pending in the
upstream repo. Thoughts, reviews, flames appreciated.

Brian

v1:
- Minor cleanups, add ifdefs.
- Added patch to fix up missing fallocate flag ifdefs.
rfc: https://lore.kernel.org/fstests/20240906185606.136402-1-bfoster@redhat.com/

Brian Foster (2):
  fsx: support unshare range fallocate mode
  fsx: add missing fallocate flag ifdefs

 ltp/fsx.c | 122 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 94 insertions(+), 28 deletions(-)

-- 
2.46.1

