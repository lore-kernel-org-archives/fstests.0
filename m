Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70912192D77
	for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531619; cv=none; b=N45G9EbJdyGchgxqgyNz0yZ+MhQLut/4gqriNKEGCB/i0q8TkLF319b2nWT1xo7myNB4EYldhNKE0ZwPHdJTLdb3Gz1zUOSBq4ULO3/qmHyfAacTaXKH8F0g9+pDbPfJGzEkDqL+SnfEUyrzAjBVCICtTJgMGcZpfFYiqBYyIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531619; c=relaxed/simple;
	bh=xBoFjKCLGh3t9tQ6V8jR6zbuuIIb7WZVjQOFe5NXOIw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=A50r3EQGdukbZKyCIkwNFNsD1Jy8hCki/V7venSHwmF2Z1JY/ozjzb2ZjEHLf33WIHP+3+RHu88mGihHMhLwSGVZNY82FfHbTq5I70cyUBy6RDV7FtDrYdytzLSdgiMm/H1jbEx0Z7V+sYIhahxSEWMNJLKcF7WlqEX4B2DJgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZDrZre8q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZDrZre8q"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2facf481587so3021391fa.1
        for <fstests@vger.kernel.org>; Wed, 09 Oct 2024 20:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728531615; x=1729136415; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYdoqcRyvuGhdouI7k53siU5lFdXx0ZxH1uXwx1Sf7o=;
        b=ZDrZre8q+XcQ6X6gwuw8zuwjDgzWxf4E79zfhkBLZAsGY5X6mr7hf862Upv/DbRqN1
         /aMY3sy+fCffbgY1VY/90XBGVoCefZfHmKpI/+AWQdp18t723u7Ik2Kr2yj/4oN/mj2H
         Ns+WV8/c5VsXkEnMkjKdKuPyjFnYxleLXNztEqkG7PFqez7/HNRNwXTMFRpVYpE3SYp/
         fsmpt3r3g9h9lRfTQwIDCTfj8HPnYOwQ9WZbtZX0RW7BWx6tx8H8W/1wTiR7oK7xurBZ
         uCeeHmG3Kyy0p1YtwqHBBADZS/drFXmj6ezd7lktm9Fzw3NO94JnUJIS1HE4jD77it/2
         VujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728531615; x=1729136415;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :autocrypt:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYdoqcRyvuGhdouI7k53siU5lFdXx0ZxH1uXwx1Sf7o=;
        b=BV0OdBNoqduhZJgZgV+kkQFc1X+VagdIm0mdRY/dNjeTJGp10AbyjSFp6Qvx+kblC8
         Kp8fg94iB3TJ6PDFao9lkaWIoeKZFOy4KIlxJwBKWiAa8iJuLHbSrq1QbJBmb6r4ZRcb
         hEbbZEzA+sDAjditqtVtUNULzXI6kLP7M+PBzQmF1yHM2LSjZyPI48yDeXQwtlxuNIWh
         88WB8pOfe0TeaOnSYkDC5rD/KA3JnvYZREjQxRJFBSc7UkK9ilUXHF/dI9KW0BJK4A2c
         RPdkjw3vzmbLSy36lTENT4fRSo2qfQ3DlpBbpUBid8vNCwrsLs2RkHSeBkLSf4pJrRnN
         4V4A==
X-Gm-Message-State: AOJu0YzV2k6oSbfUeVhdl5Sz+DXFTaO9OMlbgWG0AULJvRuSFDivwXLx
	4ZzcOx8WmuMY+V9de8BB2bxLvtn+qhkVh4ET4Xcx4kg8qHExiBkNJ6HBt/NKLsmOJETIdKfoD1C
	Buso=
X-Google-Smtp-Source: AGHT+IHpH4p31fOGa5pkfN3L3U24p/tpvpeK+PzNsww0yR0uQjYmmk8M2Zt6IGdkgZ3QokODNtMHjw==
X-Received: by 2002:a2e:719:0:b0:2f6:5f0a:9cfe with SMTP id 38308e7fff4ca-2fb187ce928mr20426521fa.30.1728531614828;
        Wed, 09 Oct 2024 20:40:14 -0700 (PDT)
Received: from [10.202.112.42] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e760asm1505215ad.174.2024.10.09.20.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:40:14 -0700 (PDT)
Message-ID: <aaf23db45854222bbcfa470b25812e42a2ab9eda.camel@suse.com>
Subject: [PATCH v3] generic/746: install two necessary files
From: An Long <lan@suse.com>
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: lan@suse.com
Date: Thu, 10 Oct 2024 11:40:20 +0800
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

Signed-off-by: An Long <lan@suse.com>
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

