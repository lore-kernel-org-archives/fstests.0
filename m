Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8A149C53
	for <fstests@vger.kernel.org>; Wed, 28 Aug 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868881; cv=none; b=rQOawYg9sypwcelaf0+LutpB5ICw7s6hBeQCJQhse2oW7dwk5rMZWExusVMV3ZmF6D+R9bNGg7djjT7Ni/YaZiiqoN0rVFefzokDIigE4U937UDhLFU31GZymha3hB6QUsOvYvrmOupA/Dy9lY6CpCbUQ1kCF4/dLmgIyoMo/6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868881; c=relaxed/simple;
	bh=dCpgtWqxPDrrTQ2PCkorVmKKJSIljMGz1nChm/bJdu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ft+gscEKotH/8Zm1/qJ0qIokqFUInwuDpXHXFcGB8NwSYLWBbhZvGRcJvpqcDRC+wHh3TI6l9A4yZT07VxvrJbufx4ATYxZI3TNGXUwaF74drDbm65slh7CG/I6cTX4BZ3CGoYFpIaEJm/JE5DvEgwHi6FM/3FFlepzI1ajsRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwUlbT/v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwUlbT/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724868878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6JKSconfC+2wgnKdBFMcjcFwJ+SubtzD+n1gupZ0UI=;
	b=JwUlbT/vBSZSxDJiEaFFWWEkTY2JrGSfshjkxMvfmtA8zEMMq91oU6/vdKMXvOiIm4s43T
	KhJf2qj3buBY81Yuz0MIwWsBO5neGBqg8smVsYPKz7fMAMVkXepGXqKiv3T6qwSyw5WVZm
	Os3d1np4jv97oilzkCRpkB8AfVvhLxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-e1ZobT1aO-2olXFmSOPXYw-1; Wed,
 28 Aug 2024 14:14:37 -0400
X-MC-Unique: e1ZobT1aO-2olXFmSOPXYw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94BB21955D4E;
	Wed, 28 Aug 2024 18:14:34 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.16.95])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A99219560A3;
	Wed, 28 Aug 2024 18:14:33 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	djwong@kernel.org,
	josef@toxicpanda.com,
	david@fromorbit.com
Subject: [PATCH v2 0/4] fstests/fsx: test coverage for eof zeroing
Date: Wed, 28 Aug 2024 14:15:30 -0400
Message-ID: <20240828181534.41054-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi all,

Here's v2 of the patches for improved test coverage (via fsx) for EOF
related zeroing. The most notable change is that the discussion on v1
uncovered that some of the existing fsx behavior was wrong wrt to
simulated ops, so patch 1 is factored out as a standalone bug fix to
address that.

Brian

v2:
- Factored out patch 1 to fix simulation mode.
- Use MAP_FAILED, don't inject data for simulated ops.
- Rebase to latest master and renumber test.
- Use run_fsx and -S 0 by default (timestamp seed).
v1: https://lore.kernel.org/fstests/20240822144422.188462-1-bfoster@redhat.com/

Brian Foster (4):
  fsx: don't skip file size and buf updates on simulated ops
  fsx: factor out a file size update helper
  fsx: support eof page pollution for eof zeroing test coverage
  generic: test to run fsx eof pollution

 ltp/fsx.c             | 134 ++++++++++++++++++++++++++++++++----------
 tests/generic/363     |  23 ++++++++
 tests/generic/363.out |   2 +
 3 files changed, 127 insertions(+), 32 deletions(-)
 create mode 100755 tests/generic/363
 create mode 100644 tests/generic/363.out

-- 
2.45.0

