Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7AA2D
	for <fstests@vger.kernel.org>; Wed, 18 Sep 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679279; cv=none; b=oHVqM1qISAOOcZmWJl7sN0U8ICC8dVDEsYqjGnyNr+8DkYmCmCt0gqOowhJOg2geD3zwed39r/+MJWYdkIqoR1qbyLxi7qFHp6cZoqZq6oaWCO74HTF5YiB7XTRLGNbXrSYCcjFaKhzWa2rDDgqetAVIohZPQWj3FRW7UsntQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679279; c=relaxed/simple;
	bh=yp/HTAt2ESJHYMR6IOO+ZII5AWzf+AYJf5Z5f0EQvEQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=AnoWn7DN94tt2fBXOZCNP/XeFNa6OT5N3zJSRMCGx/Dx3K6P8ZlZ0WsWbGTdYX+WMSbCkYwK3pKyBhGP5BUcRtXPVS2QT/lXevYCPki/7RHYFJ8sf0PHCpknbGc3Wg7EAIOWgJWSH0k4Kwsy4Q0fHtdc2ZDtrtTK97y378imrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgJLp0YA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgJLp0YA"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365cf5de24so8935621e87.1
        for <fstests@vger.kernel.org>; Wed, 18 Sep 2024 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726679275; x=1727284075; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=If3jF5p4kdOPkkbxVffi1+zuvNxvNYFWa0OY6yX90g0=;
        b=CgJLp0YAU5S7x694vJaRFhbMB7S92Qqnfc/5OHRkVHE38bWh0UNJBVDL1V31W83Fzp
         NWuJdud+bbjnjxfpyz06YJvB5bE5mU2GHWOBbBvcAPXZ4H75lhT94QUnlgsNodbmFSgI
         DmUuh8/Kp4Aun0lP57dmmlWbWAYkUic25njHMkCgyVrzSXaVe0s3vERAwNnG0t/VGwXe
         IvF5MUARdxGa8OPkw1OJ0by0UCLRYyih9SE/xtOqu4efu4cZzABR13uqOx8XRTE3/CXO
         RtnXKDrbDsledurti6PIInHllDPvDYXeRoLH7h6KHIPuuf7OC63gL1fUFlomT8rTnaBN
         4c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726679275; x=1727284075;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=If3jF5p4kdOPkkbxVffi1+zuvNxvNYFWa0OY6yX90g0=;
        b=h01J22vfOMx4NnPU8wsIJZbuHUeVkohktHW7iyMYKhDPBEvsoHvqWJIaQCNRISB3Y5
         1vlvcRE/nlbEfVdWgC3DdLVlH2Fsyv26O00uadapBzbfsYugzaQCWKlE3cHQcyIM8/ue
         eoLljSNzHlt5O+6ItR4utQi3cu0N3YGLO25wgrJl9HwXuYxT3r7hU5vx9nyOmQqi4s0P
         vbkKKZka50ySLWygbJ9iIWjpj92MCYbTv2eRhMJ4SHycr+OR0wRNjn9b/v5UPmO1vHQc
         ci1QdzkiQL+kX+9nX9vKvKTL4b07xCyqYSu0YhIhDRYoJKw4CTYVK1sxgs2UupNTINLf
         5C3w==
X-Gm-Message-State: AOJu0YzD4dOpMmgfsVzrv3r+4kNFqrNtMM3sfLcSvQfvheZqpyDDo3Xw
	UJyqsM4BhVRyzQNKwLGk3mDdTUeD8CTbaowWu1qK2GIn/kI32ksEGVUWs4zddS47HKg7D4kG8TY
	S2JkDLA==
X-Google-Smtp-Source: AGHT+IG+RI0fOAZ6+K1AxqaF0vPK2EhxF1Hi2BNz0OcQ7irE6ePCBoGIMR0ypU6pQWO4ifYLPbVh1Q==
X-Received: by 2002:a05:6512:220b:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-53678fe6535mr11949916e87.47.1726679274492;
        Wed, 18 Sep 2024 10:07:54 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a97437sm7161227b3a.13.2024.09.18.10.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:07:54 -0700 (PDT)
Message-ID: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
Subject: [PATCH] btrfs/315: update 315.out to adapt mount cmd
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org
Cc: An Long <lan@suse.com>
Date: Thu, 19 Sep 2024 01:07:53 +0800
Autocrypt: addr=lan@suse.com; prefer-encrypt=mutual; keydata=mQENBFvqfKcBCADKdcrLxNKpkBPfxZwVu1Q3ADpyWdnXZfyQOIO+1Z/WSDeXgr70HUhk/zu81WoO5WyXMK3N1dcS4KrOdNOmDp0H4G5hR+BIkgbIJpo4ekYWVdrAMT8oJgX5EgSIeuDdn2ZJ7K0EDLX9M7969gaw2nHWgBzj/ALGFdCE8zYkZAfPrwN80M5Xl+NBvOrTMypW78WOg5NdGd3E4jjgbKreHFdc9/Bmp2XKQKhjClelfM5aThhsM9wljzWdX1frN2AoAomHKuxKJGvZf30eHoXAs/ikHM4cvoUcY/8H8VgJO3mQMYEFWJR6qSbnfdy3T9Ns/Xy5QGj/XmATwhDg3BMBwvEZABEBAAG0FkFuIExvbmcgPGxhbkBzdXNlLmNvbT6JAU4EEwEIADgWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBmwA3KtD5SBuAwCACDifSf/raZ05H/0l2xAjZo9JFrWib391QLNbDYFi+Nm7nJ3ATse33ibLheOP0hJ07bsZo7uKNio8DIHDZ5CsTMd21ZvvJlNGT+l9BQV/OLRExCTcK9CpLcHoEI3M1niqL42QjVZPkKcjSwbTCa8mySNmIl64K0YTq1HnuWxShTHNlLBBkId9OMEnztgp9Ke4g+SxcU2+058v8ZTnM5wUp6fMsQelsfigJJfRqHbpy6Fap3XIY+1gKuNVIdyKWXovxtwd++fADyZVh/Zh5IKgp/1HyWE9g0MG6TUzJ+LV57jOrIJJbzl39HUp+5mFBI+RSHiJjoBZAQ7diUzT7+ns+0uQENBFvqfKcBCADCPC4telre7E8pAZITzcVsl1BP3PoMAaow4gh1SOO44J34GHJS7CRqpt4YfbPBEVmFZQiJEhb0GL2KH
 qg7J8hO7J9fmpEiCe1Vv+cK8DSxygXXL0fltVkQlgOjFlzYks+tv g58qti7uykoyavLPSu7yuGvDtzIxB3lXwUnvmS0X8MTBFIdK0s4vJOu/2cDIAnYCNdypZ8H44XtYZVDdB9r4E253y35Nd1QDjJFu/8BQxQXK5sReIYl5fRtz+4TzZQPxWt3/j62RmjY5elPEBTd2q4K6reqRuIwDBXjTWjEKylx9yw47nMH7TzIrXpSWLG08+F8Cb9KhUJysBN4tJY1ABEBAAGJATYEGAEIACAWIQSGtWkd+xUNZVZsuhNmwA3KtD5SBgUCW+p8pwIbDAAKCRBmwA3KtD5SBlJuCACzhZDj5+zuuqYMl07AiV5BqOkGmjghybACLtHjMZDbFOmxnvt7GOfTdf7ug1YguQQI6xIssqzGvXTJVgIfTP38dOSAssrYp78VyFtcAZMiN25GxOOqYlpwhKH1PAr04Ylizz/EZlbfCQ8XCFuTziZ7HwEyjTkvs5XUYJObEhj2Sv9ebhwm3vTZv0VTb8+BpxyQuuGYYakbH94D5Ne5gAC6FaCevXdeqjSCTzV6NZ5seldc3FogQ+TB+riX4G4SA4Nq36Xt4hpAoDoZhh25KsH/9Kq65+eyYKsCnpY+N3f4SAEf5NEODmGF9eKC0K8XcjhXGcpDmnae2tUnjWnjLBXO
Organization: SUSE QE LSG, QE 2, Beijing
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Mount error info changed since util-linux v2.40
(91ea38e libmount: report failed syscall name).
So add "mount" before "system call failed".

Signed-off-by: An Long <lan@suse.com>
---
 tests/btrfs/315.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
index 3ea7a35a..a19ae8d5 100644
--- a/tests/btrfs/315.out
+++ b/tests/btrfs/315.out
@@ -1,7 +1,7 @@
 QA output created by 315
 ---- seed_device_must_fail ----
 mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-
only.
-mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
+mount: TEST_DIR/315/tempfsid_mnt: mount system call failed: File
exists.
 ---- device_add_must_fail ----
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
--=20
2.43.0

