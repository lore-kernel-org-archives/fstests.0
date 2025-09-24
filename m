Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE531DDB9
	for <fstests@vger.kernel.org>; Wed, 24 Sep 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737314; cv=none; b=jwpYJl5C1Wz52NUQfxrpg82hgGrttUknlP6gOTtbSbLetJ2Pi9qrogsM+BdY28zK0OK5MRYv04BwsFbTHBvbLaOlEbvLq+whltV2bMczBktFNJDqJG5R3yG/PBW+oUvqmnlXwq349Lf6+oX217p8bDEDYrTGX1af27rSqVwyaAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737314; c=relaxed/simple;
	bh=X//Rn2fI3DLHUgNwkbA4aRdWue6HQYAKp/USZWOp8VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtcYlhsZhwzZb4pjdiMN6R9EGCRH7UQYLHPpluos6nTTvQ61FyjshaMJ2f+gJMWMpLvBZEzfW4RQNuxgJp6PT/5XBPbZUTd/lIg4HPwIPyAQ+5S6Q5k8cZuYfa3Je2LgbA0+okRSqeJVwi3MhIORZKY8r/3QCvO8cjBAeAblOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmnXkLsr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmnXkLsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758737311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VU+B/qNCzKrYviQyNrVARbLA9x1lyzqS1B2AGkL/7cc=;
	b=ZmnXkLsrrHI04fEJDPt4b0BVCW/NbmReGAvt3pmaG+zvb4QgRJnqM3r377XrzIm8qF5Yun
	uy2fzIVBe5pqiQknBElfUMAE0tNLnXbxEKeuNkOqU49a82kKCiW2Bgn8fPbxXaJojq20du
	Dp19I0ireI1IrzPU10zrN9vV0H81i14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-d1gEsXRgMSm2vZ6Ia2uscQ-1; Wed,
 24 Sep 2025 14:08:27 -0400
X-MC-Unique: d1gEsXRgMSm2vZ6Ia2uscQ-1
X-Mimecast-MFC-AGG-ID: d1gEsXRgMSm2vZ6Ia2uscQ_1758737304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F3F11800452;
	Wed, 24 Sep 2025 18:08:24 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD5CE1800451;
	Wed, 24 Sep 2025 18:08:23 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH] common/rc: destroy loop dev before fallback recreation
Date: Wed, 24 Sep 2025 14:12:35 -0400
Message-ID: <20250924181235.152502-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When running fstests on an s390x box I observed failure to unmount
filesystem errors due to stale loop devices being left around. This
root caused down to generic/361 leaving around an attached loop0
device. On further inspection, the test actually created two loop
devices (loop0 and loop1), and executed on and cleaned up the
latter.

The origin of the former appears to be that the initial losetup
command in _create_loop_device() fails due to $dio_args in this
environment, but still creates the loop device. For example:

 # losetup --direct-io=on -f --show /mnt/scratch/fs.img
 /dev/loop0
 losetup: /dev/loop0: set direct io failed: Invalid argument
 # losetup -a
 /dev/loop0: [64771]:131 (/mnt/scratch/fs.img)

The helper then goes on to create loop1, but it or the test never
deals with loop0. To avoid this problem, detach any old loop device
if one was set up before the fallback losetup command.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

This appears to be fallout from recent commit aa14b84a8d1a2 ("xfs/259:
try to force loop device block size"). I'm not really sure why losetup
creates the device with bad dio settings but not with block size. Maybe
it's more of a dynamic setting or whatever and that's why this was
previously a separate losetup command..? Anyways, this seems to work for
me..

Brian

 common/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/rc b/common/rc
index 81587dad..891f6b7e 100644
--- a/common/rc
+++ b/common/rc
@@ -4596,6 +4596,7 @@ _create_loop_device()
 	# size to the directio alignment of the underlying fs, so if we want to
 	# use our own sector size, we need to specify that at creation time.
 	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
+		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1
 		dev="$(losetup $args -f --show $file)" || \
 			_fail "Cannot assign $file to a loop device ($args)"
 	fi
-- 
2.51.0

