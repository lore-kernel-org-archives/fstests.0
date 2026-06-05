Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC2625
	for <fstests@vger.kernel.org>; Fri,  5 Jun 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780617822; cv=pass; b=cbgnEb9psqrMw9zBQ0Rm4EGKxdVej6POm9ZB6875B0GJ/hRi6Choy8hKF2eZVEixXbRS49scdSDlekTcNtFEhjI0E3BgmbNawhXxpfFQVpoOgX9xIoKCiCJvnOg/5ssy8b+TQzDnokDRY/sXB98WM/PbtWDHOpSf5xJeJh8lre4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780617822; c=relaxed/simple;
	bh=/ebqjboRpAtoqNw+zT2SVQrn1p62NAza7fObJe4yg4E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Sn0wAzbXetxM2SCSykya0lpRLypQqffRZY82ost80nF1aWHFpfMy40SlH4/UJX5fTumnrac03gFMNoxdUj12Mmf2kCl+t7jPTM/zPVNsFI0hD/9U8rCtBFL8Z15Dw/xbDQDyq6P2FsTwScDssqISZQIZd9cT5qi3P8Xp2abC4Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYAOZHzS; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYAOZHzS"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9639a2d4c53so387969241.0
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2026 17:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780617819; cv=none;
        d=google.com; s=arc-20240605;
        b=GFqw474MISKTw8jkCJumfoMvw+qQHUk5idq3Zvh1zE5sV4yZBJNJBJfch3U4kTKHyW
         w5J3B5mv3CdEYgawGSzsmOIyRIg4BxO02uJc6p7gSZIEAatFxL26CRvnoht8aJv3WViv
         VHrBY2oqZ+/BZJzFB3j+rdyVwkJ0v+R+SNfw2YTm0Pg964R/ojqX8+Vos/aGUChyrlKi
         dyYFYp8/cU+H6r5noUW0Z88STkXDPKaZeDsCN72JDpd4dR66bWw5+lf/PNg6n67ZPedR
         zFGeMg8hWgS3ryUyu1U1IN0qigHAK35JZtfVYmPQCEVruKfkkpNWe39uM/lAIMDiWoSi
         uj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uj0RHpLWu0V6RW4TtZF6lbBLClJFr63CMJ9PvYPyhNA=;
        fh=kaPSe7D36jO4lI2D8Pk1gRsgN0GugmxT8NbOyXqaYGA=;
        b=cGQyR+bqK7b/ZxHj4itQyBoZvCMA51ejuH+HAzQ+9b3m7Vpxnq7LnkgvHFPxG9UHDy
         5jI4lcHQ3heYEIyhpY+hU9eWxDEpkQcBhsmjAI9DDm8ZKtN2iCatUWL7qXGfBjWHEEN5
         6J23hahWLco0AfWkFFGu0y4RSlRXa9EPSEER0gtY2tCuVEZpN68AVAzoFotwml/0XpwK
         /QIGnoVmWAEd+eZiYyHRQReE7QN/RogJhDtk96M9oS/0RHY8V0OWRjYKKSnilCUWM0Qy
         XQVmFQ3z18hUrokOuLClMYUMPFa2jwk16/p4Hhm26k+7DEzgHFK9R+AcqauXdk9PCl2r
         U+7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780617819; x=1781222619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uj0RHpLWu0V6RW4TtZF6lbBLClJFr63CMJ9PvYPyhNA=;
        b=jYAOZHzSFwBViYQtdCiWXEsBofaULbEpEcunuw4BXgix5YVFYZb62/TuZnTiz2DCF0
         ONzx8aLV2Pzx62uQTp4uAnq562VjNO/6zIMnY+6KhN+D+VADa0AXmXM67e833IHkpnDG
         CVQ2L0P5D6HYUoAnD9IpF9stTIt6v2NpupWifcAnjfVZXLyH0N3ruzGxRZh3kbmBiWpA
         FZILrqwmq7DBS+Z/t+k3MVoY4u1EJ7JRZWJZmn3wNBeNsbw+NfSXcQkpEb86LRDmrCEX
         +P3rOoTnlWDbaFXqFX55IhCR5XZEo5Obffcv+WF5BXZNzsNvywIOWnMCg+e6s5i6+3rY
         kaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780617819; x=1781222619;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj0RHpLWu0V6RW4TtZF6lbBLClJFr63CMJ9PvYPyhNA=;
        b=Kbwa/u71r7vJTuOKGFdUTuFCTmrWsxMWWgC7OGUn3biJaeAHbW5zAc6QRz7xa3q2UP
         gHh+nxyWq5GOdugM19A/uQ+9dnQygKvWJYCPyURtX4cw9FCaoA+GymaUwC3X2IIYRba+
         i9yoLKf8h67y8D1xornwad7pIpp0FdjePVJWvTx8d3c2hWw7F14/EmD8mzJqoPjNZg/Q
         HjyODYirsUl74AlmCiOWvgUeF14DviOldbFHTX/BWhHIiK5Wo8W7KuDLgviZV4FeQ+Mj
         1iP+aXpn4L+XW9++6RY4snXdVeNJXdiNuOGXAOwcgRtmnLg2NhTY6dwwWwN1o9bN2NnS
         4YnQ==
X-Gm-Message-State: AOJu0Yxg+5Ni1AF22xx8vZKSKIyLVGdMXaT7IBzxqIE4gLFFYYtP8goV
	sKdDqcgSXh1SeoP9354RGI7ZxjEXRxvDSocOnajeKKsiJkGNwnJvbVNy14r/bTGNbG6NQ8Y558J
	k5RKNoMVTXYrix3C03E8260ONCyM5LYynTGYE2JE=
X-Gm-Gg: Acq92OH7FoIzX8bTnEQpuiI5b79B4t+Jeab8Q+WRzVlw/fFUKMDMU6iHCPtTt2nvb+h
	2ny88Lk733VZP1rUaqcXHNoEgdB9eVPj3PMANvb6N8zG/jQ5I/ewziMD85gzFuYmZPsrDhw5pRA
	bdPhdZlG8P5fowMGhh+6xDOzFxWxMOkv9/O1PtOgbqoYTCRwQMPwhse6DAGLUqxbvCeP0F4wtDY
	petu1c621ybkTkwC1yJPPsTYNmWytO40z7mph6A2/K6L9eWXlhwz3totrSIaxaDOhL28IgwtoE/
	yzD0Zn9TqO4r9fP6hXq9quK62yN3CKdKP0bZMnkyDjaQ8AQZhLdCdeDbODP6jIWnDeCiHA1Pjpw
	DLy6mLWW1qDGNiGhrscfaLLqzp8L6TzL11fq4HRuzd0UqFyhIOLOELf24NIDkOweQjegaAdAKxn
	NKAt5K1T3cR/5PDV8KVg868/MxfNU1GTJt
X-Received: by 2002:a05:6122:4585:b0:56f:6cc0:681e with SMTP id
 71dfb90a1353d-5ac53c9549amr602785e0c.1.1780617818634; Thu, 04 Jun 2026
 17:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Thu, 4 Jun 2026 19:03:26 -0500
X-Gm-Features: AVVi8CehvvB7_z4TEIKkzR2nIeau7ZAHNC8wLmR4NQ7OpH0tX0oNRl2_5UqFIRk
Message-ID: <CAH2r5mv2nhiBHJ3y71SvcQ0O4tqxJGrNRU7eRaSGfDrsvd_Cww@mail.gmail.com>
Subject: Capitalization change in linux tool breaks xfstests
To: fstests@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

xfstests generic/029, generic/030 and generic/031 now break with
current Ubuntu (26.04) due to a change in capitalization of hexdumps
in some tooling.  See below.  Has anyone found a way to workaround
this?

generic/029  1s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad)
    --- tests/generic/029.out 2025-08-22 09:54:32.256748004 -0500
    +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad
2026-05-30 17:23:49.298460413 -0500
    @@ -42,10 +42,10 @@
     000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
     000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
     *
    -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
    +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
     000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
     *
    ...
    (Run 'diff -u /home/smfrench/xfstests-dev/tests/generic/029.out
/home/smfrench/xfstests-dev/results//sambamfs/generic/029.out.bad'  to
see the entire diff)
generic/030  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad)
    --- tests/generic/030.out 2025-08-22 09:54:32.257748640 -0500
    +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad
2026-05-30 17:23:49.845293290 -0500
    @@ -4,50 +4,50 @@
     ==== Pre-Remount ===
     000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
     *
    -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
    +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
     *
    -4e7000
    ...
    (Run 'diff -u /home/smfrench/xfstests-dev/tests/generic/030.out
/home/smfrench/xfstests-dev/results//sambamfs/generic/030.out.bad'  to
see the entire diff)
generic/031  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//sambamfs/generic/031.out.bad)
    --- tests/generic/031.out 2025-08-22 09:54:32.257748640 -0500
    +++ /home/smfrench/xfstests-dev/results//sambamfs/generic/031.out.bad
2026-05-30 17:23:50.167877492 -0500
    @@ -6,14 +6,14 @@
     ==== Pre-Remount ===
     000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
     *
    -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
    -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
    +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd  >................<
    +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
    ...

-- 
Thanks,

Steve
