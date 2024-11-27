Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B84689
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683538; cv=none; b=Vu0lyujb5oZk3f1F7A7GRIS6cmDPHu3EWg0btEseEnY81qY6dkjtw7oboE5DIOPwG7UZdBFq6HRjtr/oO8U6ogNAdszA0yJzk5TxZVxs9/j0QR/DUCMyFZviOnq4APFqUgGEt8wujaV63/K3eGdcwcbtOy7j/LzlpXuloWQWs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683538; c=relaxed/simple;
	bh=q8k5vx+XGCEGi5YKN9SgztsduoIXgCC5hO6g0BFSyc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOoEj76ofjh7QiudNfnAP1HXD4Lf0F0Vh99mo3qp7vjgJXYpv7llz5hBHFSSMII2iD1jep+sc7mE/8JBtU51tVfs87JSD51g4dzmJjMK5kKFOOvgLtNN0k+e0lPwcRUQk73co65llhT0JJ/U6XCkyVl6woH4GNBuACMtJ3ZCAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xbN3lN+a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xbN3lN+a"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-211fcadd960so43172045ad.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683537; x=1733288337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5MeguoAYsRnRZ+x/PYPsW6nmhHR/r9v76Psdl4kuDkg=;
        b=xbN3lN+aeGF6m2kMQ4HbDr9IlIcUumdq+U6FozSt7+k86GcbgkJs0q/7I3YrrblvyB
         T4zjnHijU13w4SXM3fKyIZXoHk7FQCdS5XVL/03XdKmddLBMIbBO6hpNtzRQ49cat7B+
         FG0ARyjaTYSiSPY6mtMxb8c4xXesMjp9H0LwK2i/Ole0s9TsAG04w3kBpgCqAUyBilI8
         kxMhzDaKmz02sncKzN0lLspVaOipILbDorrBNxPDxyJ6xvtmFBx+8qCfyTmg9nrTcWe+
         yIHLgPozv1EcufG8huh8AmeKVtqi+J6ST36iKOKzmYlzjwywcS5jLh1hZubIDp//29pi
         1lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683537; x=1733288337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MeguoAYsRnRZ+x/PYPsW6nmhHR/r9v76Psdl4kuDkg=;
        b=fgppa1VTykvzy/hiPKQYZ5rJBxS7pt1fQCr5dpsGqsqzC416wxluRHUjKhki4JRRRo
         WebcsDucqRBiYwKp28KLZtjVj/wegUgHimQBooyks0WxEEk1xmFIcjDJtRwQXvbuHIje
         RQm0KLp8N9LVjXM0YExl9lQutl3lJ1BdnFfAux1ptf14mmtwajQJmuNIiR9QGQKLch+z
         fa10f8ki4vCaT09Gf/VqHmGx3b0EiHca9AYBQNsS3j6MYjuIQgkUEXxr8Lb8sSu/avQe
         FRvEgaGmpQplTjbX0kBzFP9n4+wiD/fwZv3uPmtPZbpyYiqhGE/D1wWazn8VYohCHzKx
         qOKQ==
X-Gm-Message-State: AOJu0Yzqhm8mUtdOXhcX6JCm1B5pu778q1EZF3HzZ65C7CrL/SZ8jcb6
	hxqls8Xui8rW9NY3k1Bf9l3vCS0zi7WNoOhkLgGlhwJ4Vy+zTLEbRpOU6yoXPvZldMfZZyZpzaH
	3
X-Gm-Gg: ASbGncurxPFEzgdX4V8056acbBcZTpT8DXUxETmBVR8wUv9DJZGUEtFXLNi4Z1X5xAl
	Ef5dHfOfBquMDqD1ozXL9lXEsudBGXMYuJVRYPwKX9mn+H9aV/fnZaschQxjnhtz+KjnrT0DZvg
	lUsbpftoUBNEybj3eJQKJiDr26cu9ENg4e9UGk+NVRU69+X7mjEMJxhjhIPu7gAMsSZP/IEvPwu
	71M0SuBESH9fueO/yeqgmrr5Tn2g+ueWq/jQrYwvSCpIepruqsU5tRt91Us4dvD1TtZuFH1XQQ7
	la7XcmHUJ/87aQ==
X-Google-Smtp-Source: AGHT+IHdBi/8Y97OpiUvVUM89W+kBuIsfpyeAeIYWiefHUSn/pCHB+++oM7O9HQA/DHEXJpOnQnwSA==
X-Received: by 2002:a17:902:f70b:b0:20e:71ee:568e with SMTP id d9443c01a7336-2150128c578mr25557305ad.13.1732683536799;
        Tue, 26 Nov 2024 20:58:56 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c7aesm93335695ad.55.2024.11.26.20.58.56
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:58:56 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3y-00000003ZWL-0NhD
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3y-0000000FQgb-0xLQ
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 39/40] fstests: quota grace periods unreliable under load
Date: Wed, 27 Nov 2024 15:52:09 +1100
Message-ID: <20241127045403.3665299-40-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Starting the quota grace period doesn't necessary happen predictably
when the system is under heavy load. This results in random test
failures where grace period timeouts are expected.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/601 | 7 ++++---
 tests/xfs/050     | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/generic/601 b/tests/generic/601
index 9860505ba..78b6a4aaa 100755
--- a/tests/generic/601
+++ b/tests/generic/601
@@ -52,9 +52,10 @@ $XFS_QUOTA_PROG -x -c "timer -u -i 100 $qa_user" $SCRATCH_MNT
 # raw ("since epoch") grace expiry
 get=`repquota -up $SCRATCH_MNT | grep  "^$qa_user" | awk '{print $NF}'`
 
-# Either the new expiry must match; or be one second after the set time, to
-# deal with the seconds counter incrementing.
-if [ "$get" != "$set" ] && [ "$get" -ne "$((set + 1))" ]; then
+# Either the new expiry must match or be soon after the set time as there
+# may be load related delays on setting the new timer. A 10s "grace" window
+# should be enough for everyone.
+if [ "$get" != "$set" ] && [ "$get" -gt "$((set + 10))" ]; then
 	echo "set grace to $set but got grace $get"
 fi
 
diff --git a/tests/xfs/050 b/tests/xfs/050
index 7baaaeaa3..78303bf78 100755
--- a/tests/xfs/050
+++ b/tests/xfs/050
@@ -115,6 +115,11 @@ _exercise()
 	echo
 	echo "*** push past the soft block limit" | tee -a $seqres.full
 	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 300
+
+	# sync so that the data is actually allocated as soft limit timers
+	# are not started until block allocation is done. This means the test
+	# will work even if remount sliently fails due to busy mounts
+	_scratch_sync
 	_qmount
 	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
 		-c "repquota -birnN -$type" $SCRATCH_DEV |
-- 
2.45.2

