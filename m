Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14EC1DA61B
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798099; cv=none; b=exFnq9pfYoyDU95R3JAzVXofueCf3uZHP7sEH4AaL1eGiHEIu6JpPdQlCuBvw0phNOVk4ugjo1ljxUQpXeZaUn6kEHy1iTAdSTfJsGoXz+Xw1A0gh4Mh/jl5nW+V3lwcHp1ZejX17DAhY6Vu/OBtV8JRw94hIDuB5JiUlqeyK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798099; c=relaxed/simple;
	bh=UQYIXlBAlluU5Lvua096DFxJJg9sC85TBe0Yv9GTl2s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SkUMMoKQr+c+1ys6BpQ7nPnJtEJTL6ST+Rw6Auc2sqdDJwY55Mj9hu+pxak2OQCYMcK+Sl1l1fYmr1iy0PXy7gTHB3iiHTrVoq1GA9SOG10B22cAnaFbpiiNaLikp4EclKP3rFBRaOI3OYkfk9prLn++h/bzOUDq6pq3CvB3IDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKwBzeda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKwBzeda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741798095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LPeTJLg3s8hPRR9WkN6wIAOk8dasJi6ezIRylXz+CDE=;
	b=GKwBzeda6Rm2o0mBz51fXoBlJIrougIBy9/x9K5lXocRocqR66/hgiOHVHGBNrcIK3hqLV
	iszX5oeBoeclEC6YVNt2PMr3q0fvtUAh2d8G7kVUBlIYBgKtlNcw9+z0UBfRC0YtKIe1Ty
	dsiwoT4KxjWCciX7X0yoU3ABUVdHWP0=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-EMzzI42gP1KnaBl4lUL3Zw-1; Wed, 12 Mar 2025 12:48:14 -0400
X-MC-Unique: EMzzI42gP1KnaBl4lUL3Zw-1
X-Mimecast-MFC-AGG-ID: EMzzI42gP1KnaBl4lUL3Zw_1741798093
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d443811f04so50865ab.1
        for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 09:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741798093; x=1742402893;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPeTJLg3s8hPRR9WkN6wIAOk8dasJi6ezIRylXz+CDE=;
        b=N8ZrLGQ8FF/BrgVDIWurlROShm+T2TesdGyVAyjUPe/KdSectwRXDScYDNY/75n1qL
         Ky+bRV+0Acd6rn6bLX8itcID+0fz60YtXxM5HW4kkJnWyuwtvan49xJh9AcJYn4Qufik
         YUa/ZjplbsMsPp3TZb3ppkaev40Nxqz9mGAP7GELyrNxT112ktb8TolId3z5oYoptVf2
         u8/NPU5VtLUQBjqOz9Vyn7DmDnVjPa9MQlHlDqcT6rdda/I4WBh6PBtXbvGUbj4VsbgA
         IEamYuhITwa4ZA0meN7rNLalSS6b++REtFReFyDE231ppUConmezJ35ZtDMU0cwmgJfC
         Jcag==
X-Gm-Message-State: AOJu0Yz4HZk2JVVE0Y98f8pxDxyGbwKznaILWRKsxRjEZuXmWUvHo7Ay
	IE1t/D0s9BSQHOUf/lQC7m5aDHEhgFxSSR9CUGYDZF0faZV80h08ljf0xK/Ah1IvGGCtezS+JCd
	lgVUU9Nu4sZfje3jGcD0BA3U9P3eMiu5DhmkyV8K4bOn8O3lobHVH3VLmJalpB5b3Ly4gZNqXvk
	QOVswpOt1j4BKaGoCByEQWQTMqbfHmjg/OqKH302MC
X-Gm-Gg: ASbGnctd4hoG8QTk+swAsV8lkEKQOP0peTEj6Wd7JDDVx0sNjLfxMh+Yt18vZXibUmc
	moX2HAn4bcJHUC7q+AmPuAeczQx7fhED+quY8IXMDNJzaxYhg6J3XwBy/dambNw/zMS1CC6nlmL
	u0G9CRC3XzUa2WNjRX2FFB45/AoB+D9dPNAmxUMELzvK5DttxTv5dLdeFc6XDmi0YmIoTi8Scr5
	nb4E0cKXdeu8wBFcuCAtM9sufgSKcn0S97wVTd4+RKwjTm7IH92jJfgOIEmm9DXZLY6juHcWWKm
	vlggP/7j3HzwW1BVX3Y2vrQ=
X-Received: by 2002:a05:6e02:1848:b0:3d1:a34b:4d01 with SMTP id e9e14a558f8ab-3d44194369cmr237403135ab.8.1741798093296;
        Wed, 12 Mar 2025 09:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJI9oDYMgYPWLcQW3kIzspz6wW/OZDPWdKgOwifq8m+DVhF1m5KDdRc/6CTBrOIP/HVvra8w==
X-Received: by 2002:a05:6e02:1848:b0:3d1:a34b:4d01 with SMTP id e9e14a558f8ab-3d44194369cmr237402915ab.8.1741798092921;
        Wed, 12 Mar 2025 09:48:12 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f25081d35bsm659626173.100.2025.03.12.09.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:48:12 -0700 (PDT)
Message-ID: <b761e302-8b4e-4a79-b025-d344d7bf5a69@redhat.com>
Date: Wed, 12 Mar 2025 11:48:11 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] common/rc: explicitly test for engine availability in
 _require_fio
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The current test in _require_fio (--warnings-fatal --showcmd) does not
fail if an invalid/unavailable io engine is specified.

Add an explicit test that every requested io engine in the job file
is actually available.

Remove the "ioe_e4defrag" entries in ext4 tests - an engine with this
name has seemingly never existed, but in each case later stanzas
overrode the io engine, so it did not cause problems without this
explicit parsing and checking.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/rc b/common/rc
index ca755055..c155bb46 100644
--- a/common/rc
+++ b/common/rc
@@ -3983,6 +3983,12 @@ _require_fio()
 		return 1;
 	fi
 
+	# Explicitly check for every ioengine availability
+	for ENGINE in `grep ioengine= $job | awk -F= '{print $2}'; sort`; do
+		fio --enghelp | grep -qw $ENGINE || \
+			_notrun "fio engine $ENGINE not available"
+	done
+
 	$FIO_PROG --warnings-fatal --showcmd $job >> $seqres.full 2>&1
 	[ $? -eq 0 ] || _notrun "$FIO_PROG too old, see $seqres.full"
 }
diff --git a/tests/ext4/301 b/tests/ext4/301
index abf47d4b..a05b8e8a 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/302 b/tests/ext4/302
index 87820184..e0f5f2f9 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/303 b/tests/ext4/303
index 2381f047..0a83e86c 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -31,7 +31,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (3+1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}
diff --git a/tests/ext4/304 b/tests/ext4/304
index 53b522ee..5f2ae4bd 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -32,7 +32,6 @@ FILE_SIZE=$((BLK_DEV_SIZE * (512 / (2 + 1))))
 cat >$fio_config <<EOF
 # Common e4defrag regression tests
 [global]
-ioengine=ioe_e4defrag
 iodepth=1
 directory=${SCRATCH_MNT}
 filesize=${FILE_SIZE}

