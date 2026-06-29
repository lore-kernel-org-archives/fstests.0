Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B73BB40
	for <fstests@vger.kernel.org>; Mon, 29 Jun 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739832; cv=none; b=LiQPqUUrvpICciYL+8g/YSMSlr+SaUGLzlKHOh69EtSbWb8wbgNbWUAhaB2v7SaZUWnu3fcwrBo3GXZgFoEb+yg2orrkXfz4B8HF7lIv3m95YV6bdXpEx8PLmtAo5KoCPYCi/fDbYmBhNond6fTy2/KcYcysxjG5I6dOrauDkT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739832; c=relaxed/simple;
	bh=peEcRPLHv58zSNr0+SXGIh/UrH+KmRV3DKc+VLKiAMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5W8rK4J9aAeCAZQGRUUvSq9n6llxxQX08H/7g8ghmITm2qPBbW+hA9kwAE89cjtb/gB5rr2ufRjRjN+CcASVOTZG22olFoYBwLpFNckhbuYovNNbKAXuCh9dW91B7tfWSWGjjLG9lv9gZhJvJDGi+s7yGJYQxnMiyQFNg9XhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OygJDLIT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OygJDLIT"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so5163665e9.1
        for <fstests@vger.kernel.org>; Mon, 29 Jun 2026 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782739830; x=1783344630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5QQMQ2EhMMyxBOwDMd0N8ZQxiClSrzW03X5klbSyEP8=;
        b=OygJDLITxtX4hO3fZXa82/p69gVKECBXc6jbv3br6lZ86IJ9dTOJHzcA55p1ZlgICP
         U4l+1x8HMb9nS8WN6s6SL8+BTzcTZiaKsEjoyIol1FI1L//Vk8QfKAT1oiwviz1LVizQ
         PTM+ryA3iLMS/b+yDWbCeD5zoOEOQ3v9rrxZkTftO+fP9CLwdHN0VxSdJ3Mvwj4yf0Qx
         vk/ulunqZx3bhbdrNs1QxHgWvDy0VnNh48oeVLMd34fXfPV/+beDLyS/kZNe0jJWtX9a
         7GK/xdI+WN8/4fCFLcn5CNH2VaDpre+W2SVPaklrZjoe2CMUvKxqC4cGCSglwcBgar00
         4kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739830; x=1783344630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QQMQ2EhMMyxBOwDMd0N8ZQxiClSrzW03X5klbSyEP8=;
        b=kfv6zp90ONochY8GykJ4WvH+4HLQEQye2lPjBoHpssjpxTgbAgjQIxXkX8u+pfuCIr
         rcltXJNFcRT+LnbfutfB0vTQkRoHIelfjtHMc9ToB0PRbTMRyvyzRuMratSnuqTniOyQ
         0FO6QXsMp1hK6JSpISasdyFsUv9hGgMRC2VmrwGpyy1YHDHEdiSPlBhYRo+n3neGfBa4
         pekuY1eY6R5/q8HBju9bMvEUEnhmnvcDUYbJxxv+MRuCFtCpMwujzVTsLGBLFmgEj4t2
         Ntx+56yNbLikjPkvFoH6Js66m1xc48HusRjhRe+ne09Bxf5JHoJM6iXjpE8CSGm2iDju
         wqYQ==
X-Gm-Message-State: AOJu0Yz8IaYAXE93AHGHzgk9wSOK4dDCEvxj5w/bIKbyy1p9vgfSY0wI
	lU7npFSbyGhAucFFeOY/FmueJCojqay7I0NKM6w6QLMjFD2TwNaGqQnlkrQHapyyIww8iMwieZj
	kuSp7SRuokg==
X-Gm-Gg: AfdE7cns/nAw5pyNZgOakZTSJ/O1TlZGH2r9EsushjXxX7A0n4gHpB2SazQ1dvCvO3C
	a2G57maw4vo1ODYJLeM0owsR6BmeCs9HMOwtgXI49kZFGU3C2CKE94GI/qcbRT8+pg77B/5KRSB
	gz4Y5s9MVb/YoQUt+suR3p38AvvJvR9xjMa/VnV8WQnIphaN9jeDwVt1Kml1Tci0opwjeMIJj4Z
	o5d6NzsVBl0f+BFIBzPrAr34nINbjLqOCYscMvu8qMfQrg4aXpVYF1qB5BQPjDab/lBYaJhdJhu
	CmTPMtTeT1tbDKlMjuVOSaE8RuiXS2BQW0fijWfNF9dJbVQU78+7CzMNlg0kWADQDYJY3opudDD
	q+YYxcPFgGPZC7Y5AjFKx4/pDev8cN4pmK/oSJQ/qlYky/mxlu28VtKXbh+9nhRk0Q8USH7pq84
	/QPSITv90aXJ+oHm3z+5h916P5DUok7j/R
X-Received: by 2002:a05:600c:1c17:b0:492:7019:caca with SMTP id 5b1f17b1804b1-4927019cb17mr211645215e9.26.1782739829523;
        Mon, 29 Jun 2026 06:30:29 -0700 (PDT)
Received: from localhost.localdomain.com ([240e:304:4bb9:5900:2473:1306:a293:a912])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f64cfdcbsm92118185ad.62.2026.06.29.06.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 06:30:28 -0700 (PDT)
From: lan@suse.com
To: fstests@vger.kernel.org
Cc: An Long <lan@suse.com>
Subject: [PATCH] common/rc: fix mount options quoting in _mount
Date: Mon, 29 Jun 2026 21:29:35 +0800
Message-ID: <20260629132935.30559-1-lan@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: An Long <lan@suse.com>

In commit 078f320 ("treewide: convert all $MOUNT_PROG to _mount"),
direct calls to $MOUNT_PROG were converted to call the helper function
_mount.
However, the _mount helper was implemented using `$*` instead of `"$@"`.
This unquoted argument expansion triggers word splitting on any arguments
containing spaces (such as the overlay mount options containing spaces in
tests `overlay/083` and `overlay/086`), causing the mount to fail with
"mount: bad usage".
Fix this regression by using `"$@"` in the _mount helper, which correctly
preserves argument boundaries exactly as they were provided by the caller.
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 79189e7e..56dbea6f 100644
--- a/common/rc
+++ b/common/rc
@@ -296,10 +296,10 @@ _has_dmesg_since_option()
 
 _mount()
 {
-	$MOUNT_PROG $*
+	$MOUNT_PROG "$@"
 	ret=$?
 	if [ "$ret" -ne 0 ]; then
-		echo "\"$MOUNT_PROG $*\" failed at $(date)" >> "$seqres.mountfail?"
+		echo "\"$MOUNT_PROG $@\" failed at $(date)" >> "$seqres.mountfail?"
 		if _has_dmesg_since_option; then
 			dmesg --since '30s ago' >> "$seqres.mountfail?"
 		else
-- 
2.51.0

