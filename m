Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C99E86353
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758888523; cv=none; b=qeIoV4pScAi+lc1YLVGkRjf88HvSLt8/0vXA9unqSa//pknPNObHsMDA/DhZCd9fLk5i37/LWyGtq27oX8UtSFcT0+dOn29mjBQDr2u/4M7oq1CoEshdZOaTOFFfT8vCn8CHhvx3zYHuZTk3CBpE7yhARVO4rHi8w+b+1gzP6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758888523; c=relaxed/simple;
	bh=oxS5Z8DxejhVRs8AjfZlZYBGpgk5MOQQEVBuVOPm/h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFJd28ZGIaTzeeFsZEUFllb8Cq7N6udifrV5/5ILJLcMg0/P4pSmgSMXZuXcNORfZoI5H13hn2Pj7xX/qg34U5mardx6mGo/hxwuPYjr2qUGeApXU2a0QcGkG1tgjmfYWzbmztAkaV0ESr1wvFmR0QvcZttIr7AhO1N8iZOIJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTf4vnJ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTf4vnJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758888521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xA3ZAYYPUthY3FOGQdCaRdV4bXoymfBfBOZrbI6WPM4=;
	b=iTf4vnJ7Rt5yAny3KPxZPwcUqMeo3gsJY7YJx6EtzSyFUTgIRgx9jZmpd3V6StM5d5Dcw8
	PjN52NZFP4Pb9Eu3Dxohwc+Z3aGtxYxMduZ0klAfJ57Q8Sks5xENwBtqhgxvA4LV5EgzWB
	1t1yzB8EaAb8bwscCFqiwsOZ5EKk9Lw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-7FcSK703N1yKBVXJkU2T0w-1; Fri,
 26 Sep 2025 08:08:39 -0400
X-MC-Unique: 7FcSK703N1yKBVXJkU2T0w-1
X-Mimecast-MFC-AGG-ID: 7FcSK703N1yKBVXJkU2T0w_1758888518
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C3B8195605B;
	Fri, 26 Sep 2025 12:08:38 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.134])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E38951956095;
	Fri, 26 Sep 2025 12:08:37 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH v2] common/rc: destroy loop dev before fallback recreation
Date: Fri, 26 Sep 2025 08:12:49 -0400
Message-ID: <20250926121249.214798-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

v2:
- Add comment to document wonky losetup behavior.
v1: https://lore.kernel.org/fstests/20250924181235.152502-1-bfoster@redhat.com/

 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 81587dad..1ec84263 100644
--- a/common/rc
+++ b/common/rc
@@ -4596,6 +4596,9 @@ _create_loop_device()
 	# size to the directio alignment of the underlying fs, so if we want to
 	# use our own sector size, we need to specify that at creation time.
 	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
+		# losetup can return error for certain configuration settings
+		# but still create a loop device.
+		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1
 		dev="$(losetup $args -f --show $file)" || \
 			_fail "Cannot assign $file to a loop device ($args)"
 	fi
-- 
2.51.0

