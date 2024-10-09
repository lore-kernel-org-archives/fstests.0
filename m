Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD81E5729
	for <fstests@vger.kernel.org>; Wed,  9 Oct 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489377; cv=none; b=sU+b+6rjmKXF/m2oBpfS4ECSAHCvVzAf6/WcqITAASQA6Yb4Is25BznlqyQwGkG8ycA4UnJHykYpU1UGRr2oGDIo/7V9TQ2aYZGTZ8LjbWCWfu0bz8ko/PpPGE5T3Hs0b9E8M3jApoaopPEDW/VpdxwoLYEwqw0yyZFLlDZ2/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489377; c=relaxed/simple;
	bh=O7csKkyAUtW73EmBoE0yxykwnLZJ8NxHoBzPx8rkQxo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Iw95lw7lgPPriI/gf3BtnRQHLn0UuVIfmghprwY+/qhkgRqzdVjHNgpPnyW+FPd4mvHrWDzF0Ou012DSiG70Cs1rXi3ayhou0uC93NOV/e27paXYv5gB2oJhMLeXOiIuVpCAdAtdX5d0n5DlZKFrQrfOCocGee3Ovy9FNYnH8Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e7NvO40G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e7NvO40G"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so169133f8f.3
        for <fstests@vger.kernel.org>; Wed, 09 Oct 2024 08:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728489373; x=1729094173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xt+wLZV2LxzPNz2lSLFTi3nnfmZ6/6WPzHA17tFzTGg=;
        b=e7NvO40GZ1Yr89GuVLN3CcSbcDntjoFB7WeSS3mk7chASQAzm8N1GJDHU+sT6uqo14
         HhEkIoCPSNhWP9A5/0rIWu/uk/zMra2oSEoHDPiE4v3V+ngtS51n7kyfpZqzl2X87+25
         PHrJfC1HVKy6QEzCbs6LGycM85SQDPu4F3KUAWFr+oUtOxVywweHyiShF1XQn5oAvsJG
         V3ET/hnoi3L0Wwik0goimoJFBoH3XfnZJtqH8gPzzoIgT0A3EEMFKGX17HmiQZ64UYKt
         tONq/jd8WR93gp7XOcFkqhUpIO+78BhfnKzk6HOEOWADRhTUqfrBVMMUD1+GPOS4sNSY
         oilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489373; x=1729094173;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xt+wLZV2LxzPNz2lSLFTi3nnfmZ6/6WPzHA17tFzTGg=;
        b=SYXl3E4ndz/iKFo677ilK4sOtfIDj8DO1R4Vf4etasOmIF8wybV+h/afz/ol1mzAPL
         fZNi2msaBXwbygTbDQuUc/Y1mHcKXQPZAT/c85QmCJKGfMYLfsM7d0bgm9jU3hNP+MfR
         FVLr+xjuqqCJ/ELKmRTFATw3C3fnX9QlFXic1ozeb8amgtFZ/nx/ZKA0QZOM1hckBzyF
         O+Ssr8bZ0JwITmJrwHGJvNMZ5IHMRXlTNW3XnqlqcBcyL7nyO3WxdtVLyh4dPspLCWDN
         yC7cHrTg6YGNvyXctq1QrPiBqZFFgd3ZsM5QlbBq44+a6jxnOQYIygtnk5D8+iYRCq6B
         +WXQ==
X-Gm-Message-State: AOJu0YxFcm7qAf4sTffh3OwjbnA9670NITUp41izgYwNnpsGjifU135f
	K/ZLXmr/CUIpg3zFEhDUJKsrAP41RbqtFBZ1IUb0636c0upynjJT6BIpJ3y/Oj5djab/Qg+n2tl
	OCOA=
X-Google-Smtp-Source: AGHT+IFMDPIe8sOlhzOeHJs2mnT/k4d1TUYo6bLXOZKMhjtvVro3twHrsuOMLX9A7Hu6FXaRTQvIqg==
X-Received: by 2002:adf:f48c:0:b0:37c:cdbf:2cc0 with SMTP id ffacd0b85a97d-37d3ab106ddmr2570843f8f.53.1728489372548;
        Wed, 09 Oct 2024 08:56:12 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d693dbsm7943275b3a.180.2024.10.09.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:56:12 -0700 (PDT)
Message-ID: <878d46618e9851f7a019f675716630f9517f4e02.camel@suse.com>
Subject: [PATCH v2] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Wed, 09 Oct 2024 23:56:16 +0800
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

parse-dev-tree.awk and parse-extent-tree.awk are used by generic/746.
We need to make sure them are installed, otherwise generic/746 will
have problems if fstests is installed via "make install".
---
 src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 3097c29e..a0396332 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preal=
lo_rw_pattern_reader \

 EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
              btrfs_crc32c_forged_name.py popdir.pl popattr.py \
-             soak_duration.awk
+             soak_duration.awk parse-dev-tree.awk parse-extent-tree.awk

 SUBDIRS =3D log-writes perf

--=20
2.43.0

