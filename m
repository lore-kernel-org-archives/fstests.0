Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51358149C6F
	for <fstests@vger.kernel.org>; Wed, 24 Dec 2025 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766606663; cv=none; b=I/ghl/ntxYhOukuTSkSVwCIqHqEwCwAWg0g3nGfp3p04WRP/PAuNNM0o37rbCo6dTKxSO8r4doF80ACPmAqHQHWrlyvZ30+NeR5eQeC7bVGm2O6vEz3ZY7hxr8a7bHrrvOWm8o48r8uwRtZF1fcmUxcjISq84cngSVW0kcrmUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766606663; c=relaxed/simple;
	bh=3xBdOUr2LwMD9RiNCz9QAZf9ex6XVjR85sH6jMs9sB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VercITRmfy6VCBKmrnz/X6Sjg4DtpUgXIuYEG0geT9LO/0Oo1rhFFhDP47lhrou7KfaEkojTHZynKLP1XlxCu19hgL5XoqxIc+lOoszkUiG78PRknu9q2o6wr35HuAS7xZXK0UcL3rZybAuw+Ai2I6AlBrbNVIIBdzfvvhysAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amTTGF60; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amTTGF60"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2d6df99c5so682447685a.1
        for <fstests@vger.kernel.org>; Wed, 24 Dec 2025 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766606661; x=1767211461; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPhVPPiNw6MKlbow25atk9fGm4codGMqL59Ol3u8OFE=;
        b=amTTGF60ctETW0Bkz5NLDwvEfYK5+m8exB4xOUwR7osDiTKiEyDyiatkawBmF4uRw4
         ESd4Nt5S02w+QJ01ER/ddIghIVmqns69o1wxR90C2iJQ95Aigy1JRDaSsloaetZ80ziJ
         WDdyAdvqtcgdWRx8z4yejdcn2JWmTvu+FPbs+yCyLhFTMBH2jzBRENPbhskpNZytHnFH
         asHucRKcyjL++EyD+6uJXlwcs5OFCmZLYptG6/A85d7A263Q+aLhZQ9v8NnsT3YFG78/
         5pmtcMjYTaXUzkYLS1SPXG6j5qlFTJK2ZfD0gyBBsBhEMU4s/IFz6UTaTp5T/BapG82y
         Vx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766606661; x=1767211461;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPhVPPiNw6MKlbow25atk9fGm4codGMqL59Ol3u8OFE=;
        b=r319IbNt/gz7d3arLkFVQLxElSEk8G+C11RSLOn8Fw6Be5HneLt5QiW5ldQY/9wEI0
         rjaf+XYptr6eTGAIXZoJBMTnT2keg1/sm7GXSV9+uviSawkv99qsCaNzX5YfbfkY9Zxm
         8CyHJfeVoZV/YweVURz1hdYxQm6vAtqa0ThmNgqk38zPiLdzsCAjFwzAPLBT8WfFbe0r
         eOmbVGkVeFGq4U6roOnjqdfKG0/k+X9WwQ+4osjhjd0N0ctBh97VAZfYXUfiGFyI8NTg
         icaNp6tbH0BlP9VNkFWT6XdFQQyKivqvDQZRAMmzVQkS2kotPCuIkRbIP9UxTz49thxB
         F15w==
X-Forwarded-Encrypted: i=1; AJvYcCWINk7O9DcJtB/wXrAQXEzA8hH7yUUvPWQOypPkM6TtyEPNcAe6su2HfamdXncAFgzREXUV+c++@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EVx7sPGk3U63feXBV3kroiXlk91ION2VRjqgeWnSqdQBCrT/
	+GUXakd5A+91bX4VtSvrvezbFlzik1EgWeTh7obSYXeHVZzuDu4NWdz8EvdcAlWdP+9Be6ohj+X
	rs3ZebaK1eC9PRz1Q7STL8JxPw9CKxdc=
X-Gm-Gg: AY/fxX6Djd2gEQva2ohrTcqCTWoLc3/RXPt18PFvaxC/TTiHIR1H6NFHZLyuf+TR/if
	WLVXxBYJ+6/7lZIs5/HdSrPtacq/zGtCBlj+kvD92Uye8TW+TOIWT46cS3FYPDVO5mOKpxkxYZ+
	yAesDRo4/V2g9+eFsSCBnp57liFTlDwAImyoXSNB/yvs3OkWhGXAdWWu9b1oY1Goyy8gO5Jc535
	EA4FHD4fVKGf/gC5teWxSJ9Gez6qA8NLPeNPMYiscXNAGLCtMUvpyWV+qYcYDi8cCFhe+jQeeis
	+4t7Bu6zBkqqTVdGK4DHJRC+6G/feOtjQNiCJGO/VQz844KJgvSOeecCg+pjofA17we8lPiI6Rb
	3qCr4WS62tE3rJ6IIIWQeeMFBCfv6VNah7zWibikqtGgfRBT6xw==
X-Google-Smtp-Source: AGHT+IGEt4HzspPV8HkKSybsfgjhjdtA5FuRyLYjIei8mE0VvTCyK3guw0HCkIHhwdX70RSlbB0F9c44AUoo5eioS1k=
X-Received: by 2002:a05:620a:1a95:b0:8b2:62ae:acba with SMTP id
 af79cd13be357-8bee76c8f78mr3023337485a.26.1766606661114; Wed, 24 Dec 2025
 12:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
In-Reply-To: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 24 Dec 2025 14:04:08 -0600
X-Gm-Features: AQt7F2p4uPeI7v_cVjE5Bd7LXFvI9B6imZy0k3MbRCAu_3crsa73QV0k_J_84bU
Message-ID: <CAH2r5mvR-dLz4W3LheOZbgFHqcjhm_YYgLH57qFmf7bggZmDiw@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@kernel.org>, Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, dchinner@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With current mainline it worked on Ubuntu 24.04 but fails every time
on current Ubuntu so presumably the output format of "hexdump" or "od"
tools have been upgraded and broke these three xfstests (generic/029
030 and 031)

Any ideas?


On Mon, Dec 22, 2025 at 6:33=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> I noticed that tests generic/029 and generic/030 and generic/031 now
> fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> issue in dumping test output (hexdump/od). This is testing with
> 6.19-rc2 but it looks like a change to hexdump or od that likely broke
> this.  Any ideas?
>
> See e.g.
>
> generic/029  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
>     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
>     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
>  2025-12-19 18:25:13.562003626 -0600
>     @@ -42,10 +42,10 @@
>      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXX=
XXXXX<
>      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXX=
XXXXX<
>      *
>     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXX=
XXXXY<
>     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXX=
XXXXY<
>      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYY=
YYYYY<
>
> and
>
>      80 generic/030  0s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
>      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -05=
00
>      82     +++
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> 2025-12-19 18:25:14.073196575 -0600
>      83     @@ -4,50 +4,50 @@
>      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
>      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> >XXXXXXXXXXXXXXXX<
>      86      *
>      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> >YYYYYYYYYYYYYYYY<
>      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> >YYYYYYYYYYYYYYYY<
>      89      *
>      90     -4e7000
>      91     ...
>      92     (Run 'diff -u
> /home/smfrench/xfstests-dev/tests/generic/030.out
> /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> see the entire diff)
>      93 generic/031  1s ... - output mismatch (see
> /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
>      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -05=
00
>      95     +++
> /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> 2025-12-19 18:25:14.411496471 -0600
>      96     @@ -6,14 +6,14 @@
>      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
>      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >................<
>      99      *
>     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> >................<
>     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> >................<
>     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> >................<
>     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> >................<
>
>
> --
> Thanks,
>
> Steve



--
Thanks,

Steve
