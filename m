Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DD22538F
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208178; cv=none; b=FeNM6HNPyjYwTtO27gYkwDpA3VPI4UtcD3Tp+HsgejkojwqoOipkYwcNaDujoGuNRvdcXoeXYykd+C8aYHOWV7A26+JTfFC2n1bnWlU1tPgwGM0cH8jsts8ENUGxQZrow6N/3LT5IEan7cu1a+OSNVev899F1O7jjIFfiVAbrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208178; c=relaxed/simple;
	bh=vSVYivML2wEjl+sJu7uP6XkjTR5eZNLK9IRx+8fP9dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8iNLqOxXGTpNVitA3M5uwKkVIKOJrCgp83z9lxOZ8ybLkz36JLe2IbCA+j7t9W6rBp+Vs4nTVPi2buo/dJ9Br6Lq0UOKHbYHzcN/4Y15jj3EmBOXjmzM0YFE/m4R0YBsBdJLTYZFFx99NfRfjEkB2ckKK3d4WtWScJGJXtCeU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k64jEKjR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k64jEKjR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8be92e393f8so1161380285a.1
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 11:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208176; x=1767812976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5gcdPlZWT8vsv+ydRjUma3u7V33fb8/vKGKQsF8Y8c=;
        b=k64jEKjRVVhjTVVnTLU6Y7iMrTdgESfGCmiFojYtiKqYeoYRlgucwqzHQzdn6uC/RC
         sW0oglTwSuMWeQi77sV1BlXMas2ZX21SVZNg6e3dN/6I6R/SGCMgS/C2konK5E7EuD+W
         aTok3P14T52I7SeVZvwja3vN6sxGC5tc7rBUvodJH6p0vfbsV+gmK4gidKajdOuZ3Kfz
         kiiO7BUk/H/otQJoVaMVJKV9Pf03wqaOO/7GkR7B3WsUHIYkXfUkqo98hXIO9wyfE9J3
         N+UZ1LbNHtTIq4A0te+5DgMhms4lVBzgZBtGYsb/JmMPWJt5imZz8SLXUWTi+HLGbMN+
         bsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208176; x=1767812976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5gcdPlZWT8vsv+ydRjUma3u7V33fb8/vKGKQsF8Y8c=;
        b=HpH5hK9zmUuqV082tBMeGmGq8o5jGHFsdT9PkGo+A9mXhhcpSpAxXMJtudk1JPur/K
         Z+QUZlKmRXwC+Cr6koJDVjMV3J/jsWHbIDBaRBanq1f6bREpWYtx0uHMO7TTQNg7zkOn
         DT5ErMPfHqkMOFFQcQUVysWlZS9544qDNC5chL9bivzL2l5XiyR7jtPY+Q9P+5l8XVW7
         ZGMXuMQSBbGz/fWNV4uWULEbVrrP2mgdGKXCAhop81CNkfDP5cGALLPl1wXUaWFQp74F
         UDIK1FK8NVttc68EK6kNvgGFt4MyP98ayFBRjM9/1FmjDL40wopyn1TM4zo4r035I67o
         N0iw==
X-Forwarded-Encrypted: i=1; AJvYcCVvdYRnH4ClFMb1fhik31kPjvmlSL1oOssxSR5uH1X+jnuAyyFSagH69l+LEVJ4F1PPSocjMWw2@vger.kernel.org
X-Gm-Message-State: AOJu0YwDuwftP48a2nnunRJgSUUQflEjRuAKkG9JIOorRHzZZFRy9OnD
	v9+uG2HzngkEvoHa9Bal4f0Dg9O1bs0kPhb+cfOoKQXh1H9Y3y7EmCZlYduDj+oVL8sN02fLSLo
	4H+a0DE29HekSd3ynBS8yfhh49QyBeMvd1g==
X-Gm-Gg: AY/fxX7Pt1uBrC+aZXpY3t9ju7JsvGoFMKvB3wybMXm2bqVp+MWMhtNIFsmfWa7X+LH
	rorsIS12EmdfUisWg/sPnAeFO6eTko0fVTsO2AhRByCUrNyBdaKiIiGOnKw4a4UJRTG1uHVGR28
	/lir+oknASkP2x76U8DnN0Cz2Iv1JwHk9MpFJ8zSqgoLegQrt/U9zyOl5qpSGQmKNoaN7jMwP4c
	gbY2YB7Usw3LZNhFLmMTxR1wAI5Y0FD8DZ/b+nyMWjAUe49dFBg3rTQafbeZ5B3iMsqU7+WGo80
	dfpgk0+gtoRLRGTKPQJ1k7ZH6jCRI7H0VqAhYG2XX7a3n1dpjuYUx6mGcQdbWVPXYnD9tnVv0Ze
	cwXtqBshXaEA3IfGfVXHoCyAYig+ibsq0i3YezQxk7PTrbhyo2E4=
X-Google-Smtp-Source: AGHT+IHiFsNFZj23n3RB6eLdKeuqN/UULAlwyl9TQlJbhvdwnzgB1eBK00fSWGr4mpCxU078NWQz/yDKli+0Z/Xt26U=
X-Received: by 2002:a05:620a:1706:b0:8be:9218:4c62 with SMTP id
 af79cd13be357-8bee670c35dmr5964356885a.4.1767208175909; Wed, 31 Dec 2025
 11:09:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
In-Reply-To: <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 31 Dec 2025 13:09:24 -0600
X-Gm-Features: AQt7F2oNyYMPfKuEfb5Rol0bugu7zVxjPKxEnHnZpfDeUiIg4nYwTzRn4JpHPOM
Message-ID: <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

but I guess they are different packages that include 'od' now.   Was
"GNU coreutils" now is in 'uutils coreutils' package

On Wed, Dec 31, 2025 at 1:05=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Very strange - it shows version 0.2.2 (while the working one shows versio=
n 9.4)
>
> smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> od (uutils coreutils) 0.2.2
> smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> DISTRIB_ID=3DUbuntu
> DISTRIB_RELEASE=3D25.10
> DISTRIB_CODENAME=3Dquesting
> DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
> PRETTY_NAME=3D"Ubuntu 25.10"
> NAME=3D"Ubuntu"
> VERSION_ID=3D"25.10"
> VERSION=3D"25.10 (Questing Quokka)"
>
> On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> wr=
ote:
> >
> > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > I noticed that tests generic/029 and generic/030 and generic/031 now
> > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> > > issue in dumping test output (hexdump/od). This is testing with
> > > 6.19-rc2 but it looks like a change to hexdump or od that likely brok=
e
> > > this.  Any ideas?
> > >
> > > See e.g.
> > >
> > > generic/029  0s ... - output mismatch (see
> > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
> > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.ba=
d
> > >  2025-12-19 18:25:13.562003626 -0600
> > >     @@ -42,10 +42,10 @@
> > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXX=
XXXXXXXXX<
> > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXX=
XXXXXXXXX<
> > >      *
> > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXX=
XXXXXXXXY<
> > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXX=
XXXXXXXXY<
> >
> > Hi Steve,
> >
> > Sorry for this late reply, I just backed from holiday.
> >
> > What's the version of your "od" command in Ubuntu 25.10 ? e.g.
> >   # od --version
> >   od (GNU coreutils) 9.9
> >
> >
> > The hexdump output is from the common/rc:_hexdump() helper, it actually=
 runs
> > "od -Ax -t x1z ..." command. If the output format of latest "od" comman=
d is
> > changed, we used to use a *filter* to help the output to be compatible.
> > For example:
> >
> >   _hexdump()
> >   {
> >         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
> >   }
> >
> > If you have a better idea to do that with a simple 'sed' command line, =
that
> > would be better.
> >
> > Thanks,
> > Zorro
> >
> >
> > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYY=
YYYYYYYYY<
> > >
> > > and
> > >
> > >      80 generic/030  0s ... - output mismatch (see
> > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640=
 -0500
> > >      82     +++
> > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > > 2025-12-19 18:25:14.073196575 -0600
> > >      83     @@ -4,50 +4,50 @@
> > >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > > >XXXXXXXXXXXXXXXX<
> > >      86      *
> > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > >YYYYYYYYYYYYYYYY<
> > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > >YYYYYYYYYYYYYYYY<
> > >      89      *
> > >      90     -4e7000
> > >      91     ...
> > >      92     (Run 'diff -u
> > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> > > see the entire diff)
> > >      93 generic/031  1s ... - output mismatch (see
> > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640=
 -0500
> > >      95     +++
> > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > > 2025-12-19 18:25:14.411496471 -0600
> > >      96     @@ -6,14 +6,14 @@
> > >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >................<
> > >      99      *
> > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > >................<
> > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > >................<
> > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > >................<
> > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > >................<
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> > >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve
