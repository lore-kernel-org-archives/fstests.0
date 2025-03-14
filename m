Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917667485
	for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964188; cv=none; b=EWo5C3v8iNLKGlXERkE1YeOAgkVw7jnW4iYx8f44h19fK1P8unfNokQ9chqYwHFaZoWeZZRp4lFNv41TVwqM0/XV1MIX5HGAKRXi1rlFCyWwIy4cmf1jNdEPjN6qguVAaI5g248vKMCygJbbe47X1nSllxsD5LSny1sNjCo9ryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964188; c=relaxed/simple;
	bh=J2quSf1ys+yEDinyvgTSz0cvvV5443TD7LK5hh36iwI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VIv0r/jkbXXwfzlzr5LAv9m8XH4E+Qf9f/Hn+SkcKQfbRhCj2n1Dy3wjT+tWl2Vg8yBTKzp5KPgOIMyMWd/YblRQ+muJpxJMLIQz7EGXh7+kHbRlhB7ObZJjtksgawN6ff/Cqio5zqtsXuEZCtznpGgQwIJgwsjv8l1Bo7dICok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxXFmT6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxXFmT6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741964185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AxXHoj2jZvdY0Qa45AGzYnh34wcuLJN37JlYmZgLbHI=;
	b=RxXFmT6C1BrsDqqJI2IZ6uXDtpANy1bCVdM7jRXheBTInfHcQ4bwbcILccCis1r42SgKlf
	3Tm9F7X9bq8QNkzCMblLVC9FTOcXgc/rlXzC5zsPVFOIOvEZoiePQk0rTEdC4lGERdlq6L
	oqUrQeMKVyRmmFyKspHDz1IF0SlrMgw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-WYcX-kxTOuau3tqgFiax4Q-1; Fri, 14 Mar 2025 10:56:23 -0400
X-MC-Unique: WYcX-kxTOuau3tqgFiax4Q-1
X-Mimecast-MFC-AGG-ID: WYcX-kxTOuau3tqgFiax4Q_1741964182
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so44092275ab.2
        for <fstests@vger.kernel.org>; Fri, 14 Mar 2025 07:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741964182; x=1742568982;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AxXHoj2jZvdY0Qa45AGzYnh34wcuLJN37JlYmZgLbHI=;
        b=bOgTdzw74lg3O60uCzQ5wtQcwpgRagtElCc62T8gEcdHqf0B6dDPh3FKJM2NQR6aFu
         LiGRTOkv//R2ZDE0NpKhHdeg7phPccbJmSz8AhqSLHbkG8GOJyj5OxJoFQQLHjyumUrF
         4TuMco4VbBJ4TNpxZerYgmvBbdTSrpxwgREXPgQuV4tyF1bjUgvFd88o+PIPyIoQe8F5
         mCupEMuev6UenrzjygWz9jnrmgoq4EHsGCb4Z9G4GhPnNx6V+SCsqQ7QdQfQrpcT63Ys
         uK7kjedc4Xg4X0Gy2WM13z1/O7RDihNyaXpDBSfUhMw7jG2v87B9RfXZ5U0ng6zVEdV9
         1inQ==
X-Gm-Message-State: AOJu0YzG2BFWCdK8QmvFChAeDfdc+4hXZ3pyzmGPA3aMCFUD//bPlpyp
	b9/WLGqv0MInsuguQecs3CxU6fICUr+2pkqj6X2SlT+v1PeZzTxrGEEWauRW/SmcwdCRRoaMOJd
	RmzNOWp37sc2Vn4nFBIrkydQrqiXkXROvFsPoERFLPiFXpnJoUlM0kimWmqlVB4S78eeaxtDcjv
	CV8Pm6T8mC+o08zlH7U1pDUaxZUFsiUDzBE5bo415t
X-Gm-Gg: ASbGnctrCZo6p0jRTxbrsxF8C687yZDH5ooDU5UraFkBPCyU1LvpV6JVxlzTrTsy9S/
	agu4iWnfTQS/uEbIpwInS/uZWNNIwDK17AjxW4KZ+PGGTs6jdS6qkEQcSSs/4qcOxK5IVgTC1nm
	YQWJO0idVTEsNzEFAuOgPrGeaAUnom3QX/yKbmlp6JIOm4FlFCpRpZWVSaRU7zO8zgBy83JB/eX
	WKyZLFyOb11Od9QufabQs/GFoJaM5sMBHS91+TSOFbmFGw1osF2leLdoE2D2Pun3rGL2Ea6xfoZ
	w5rjVBWWtvXA7oNJ0jZI52U=
X-Received: by 2002:a92:ca48:0:b0:3d4:3fbf:966e with SMTP id e9e14a558f8ab-3d483a7ffb4mr22793535ab.14.1741964181801;
        Fri, 14 Mar 2025 07:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEIDOsOuLIEETWsoBG36KatI5fcAneDwwq83tB2G2ouObTYTvpoAG7JUMWZlsm87fMPtecUg==
X-Received: by 2002:a92:ca48:0:b0:3d4:3fbf:966e with SMTP id e9e14a558f8ab-3d483a7ffb4mr22793305ab.14.1741964181450;
        Fri, 14 Mar 2025 07:56:21 -0700 (PDT)
Received: from [10.0.0.176] ([65.128.97.82])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637fe7d1sm875828173.102.2025.03.14.07.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 07:56:21 -0700 (PDT)
Message-ID: <7ca733f5-f33a-4b2e-a70d-4a48a4904391@redhat.com>
Date: Fri, 14 Mar 2025 09:56:20 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Zorro Lang <zlang@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2] common/rc: explicitly test for engine availability in
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

V2: Be Better at Bash, thanks Zorro. Also add | sort | uniq to ensure
    we only test each requested engine once.

diff --git a/common/rc b/common/rc
index ca755055..ac443ec2 100644
--- a/common/rc
+++ b/common/rc
@@ -3977,12 +3977,19 @@ _require_scratch_dev_pool_equal_size()
 _require_fio()
 {
 	local job=$1
+	local eng
 
 	_require_command "$FIO_PROG" fio
 	if [ -z "$1" ]; then
 		return 1;
 	fi
 
+	# Explicitly check for every ioengine listed in the job
+	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
+		grep -wq $eng <($FIO_PROG --enghelp 2>/dev/null) || \
+			_notrun "fio engine $eng not available"
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

