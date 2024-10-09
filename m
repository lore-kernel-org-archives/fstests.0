Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306818E744
	for <fstests@vger.kernel.org>; Wed,  9 Oct 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463537; cv=none; b=OCqARQUuiS/9wNLIGQNqdQFzKM5NDg3awhNJy9/O51MG2F56Bvrp0EheQ8OVzX3cFiWr7QSJJheBwFGPHh/IRnv4b73rLXhCrTc2zcGaNPrFtn645/rU6zuHidAlPSF1Qkj9ra6tN45mPfr474toBVXh3hlIVQrH6sWHkxaYLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463537; c=relaxed/simple;
	bh=/8jHSgBJrPY2P17JIO9vZWYY0hb9fdfz69Z7F8WKP+g=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=eezE2pc35FaoqBq2wUBpoAaCLsIpvtRGsbIXf+sp6uXp+8xAybRb8iLZcHJvHiFxDEmyCLS5jbZhLq6kxrjJWzLuNAy+RR15SzYLLXNIHFffMfpgBoEc/ARFD2Bmd+yqkS3utIzYT9gsVgNc0nz66FahJ/PdB+dX7jNP7RTFpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Eu3Z13d7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Eu3Z13d7"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d2ddb61c8so1489019f8f.2
        for <fstests@vger.kernel.org>; Wed, 09 Oct 2024 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728463532; x=1729068332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKOl9qL7vGLDJYH66DYqcv1dtqxSuMbWYFM7/+4PJJQ=;
        b=Eu3Z13d7TP1BBxyz2kRkofRLdQSosClo5I1GHi/LTYEKkeRf6fysCPgtqtS7/U0mHs
         LOj1Dd/hWW+43L3JJaaIXA2OUy3ddEljL8/PruoeLG9KS0Vz6WA0ZQv677YPXeqTsJJn
         s6BCPb+ESLIBKrzmapnXvKcZyvWlXsdrFIhO6tvsOrzZRREYwvvEX/97ipILNyuD0336
         1kmRS3e8BJFz+gBe7AO41bbdBK2Ox8j0HdnDZE+1JQ515/jtcfFSgJX0AoQ8oDj0NFlQ
         t5NmHSD+YSTdnAx/dz98R8mCbn7kMPo/0Xo0ZvzwkG7p/aM78niPBOmUnZwTv9QPHl/R
         68HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463532; x=1729068332;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKOl9qL7vGLDJYH66DYqcv1dtqxSuMbWYFM7/+4PJJQ=;
        b=ZzCkZwesL4weSIZFM/NcgqB1/kHf9KyVfRzUMEyB1AHImlKnv95AkA4Erl7B4Jh3bW
         m7n8fgAJovHNKnk36X9UNyqG4IpJyk8oGx2NxkhoZc4Ix64VplL1XObAWjFEjGWiVI7E
         PlrPRGr6+1Danr0fLfnPWDoOinDl+Ix6rB5bX8CIteSY9XnccMJyPtpxukVmBtb3rkg7
         yinfsDOuF6J4oLuUW/WTZog08MSS4hORMbP3dDD5vOnqvYXCRNVN9Pu4/fQsTww2V6o3
         CI2E/p2Ir4Y4md9wxWhKg3ZXf+LEQmT85dRXJbvtBNP4RHNSnrM+Jqtx7RVIMSuJRkbO
         PZWw==
X-Gm-Message-State: AOJu0YxBDSOBIb9FoKDsJI07Zm25o+Ds8iVe7hfTEQ967zO1dk2U02/3
	Zx24/exvXclUA/54bcA68Zquny10yOCGs081p0hvHE8VBKYXcvRR6NBJqU89yz+rPUCiFMk58nc
	gW/g=
X-Google-Smtp-Source: AGHT+IHyhhOK3iM8k8MKDaYRfeq6S2g6hd9hQolq77yGMXfXwRcGlKg/SJgZiiCRW5r3xr/EmrkZkw==
X-Received: by 2002:adf:ed46:0:b0:37c:f96c:a089 with SMTP id ffacd0b85a97d-37d3aa5882cmr1368994f8f.31.1728463532309;
        Wed, 09 Oct 2024 01:45:32 -0700 (PDT)
Received: from [10.202.80.134] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afc7csm66578465ad.20.2024.10.09.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 01:45:31 -0700 (PDT)
Message-ID: <9d7ef6a9de1cdd2bbb6d91a407905254c4784c68.camel@suse.com>
Subject: [PATCH] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Wed, 09 Oct 2024 16:45:37 +0800
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
@@ -38,7 +38,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize
preallo_rw_pattern_reader \

 EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
              btrfs_crc32c_forged_name.py popdir.pl popattr.py \
-             soak_duration.awk
+             soak_duration.awk parse-dev-tree.awk parse-extent-
tree.awk

 SUBDIRS =3D log-writes perf

--=20
2.43.0

