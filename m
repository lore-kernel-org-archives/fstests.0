Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1842AA9
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 19:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767208229; cv=none; b=rIjD2WDD/797M1DO/ZgqTz8Qw2XauznaHqmzwCHHkt2t3f8GOzIF9hsnTC8AEUhRdr0A0HGTG/hI+2fmZgzgDTwTIkp8Yw1tVjgpj5vD4o6OoGkscCxzXrhnQ4Tc6JtjcoijucmdhLUNxwSU74VHqYUzAo+waF69m0PvnNUIoes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767208229; c=relaxed/simple;
	bh=L+bx55IG0oi/6qL513BT9ieKUCtQ4E3Q80NX2st71Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t084iFOTRkCo5p5I3QsCN7Hs8dxSC6M2SOR9KYpT73i/QFrXlvBSoNxxKuGIr5Df6+kTEOMTa8jBEHypzkqB6PkT1bvXM46ph7VSPMfDfJiJyz/MWAaeDEjRv9USP7ZP3dgYXVikkUbjObupYAjBivvi4LqmgulvxW/Lq/C3BAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJOxJ2yf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJOxJ2yf"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a3d2f3299so130818766d6.2
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 11:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767208227; x=1767813027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InfkDfKnJC/TGy/s4hqv5rHwOHy73VHRVuiP7i3NDX8=;
        b=CJOxJ2yffJZ+lwcejIrpNL5epxfejh2rs+RMNEQ6bRUVaL5udHfM27Y9Qkswt0r+wB
         rLRAYjOF5GWtfc/34usqvRREwJROmvpikSFEmnUsQyKLVrhYz8HSdLfIjSCslXom9ifN
         9h7GbVhwMXZaW/3SCsqeQ1UeN8YxU8l0Q0SRZE7whljgDgta2M6Q86iwPHeNSp/kmm/Q
         48W+pU0/yuUQ6LjPCYfevmx7vDBPZGIaO4QJ8UgZYqBoKoWDao+Jb/uTWW4vPkYZu+8U
         GTdbaunnIqGl/aBSQ+9ZdqspgSgnVRTLNXEPad/VfcVaSUVWIAdItmh/Ybt5J74ZUAfn
         qyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767208227; x=1767813027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InfkDfKnJC/TGy/s4hqv5rHwOHy73VHRVuiP7i3NDX8=;
        b=b/3pcxiW+zQLyMMOT2jc2RwgJvbfDRj6l+85Byi1J9qGKtiRJmC4jF9cPfEBXiIZyy
         SOyejEW4ReLDUyalKDT/5IZBUpWbYz74zwxAxAN9GM8QWkfXXwT/UEx6naszgz7iWxuz
         O/fY2uJ4skVkI5ogyWEQ433F1SRn+pt7IfO1Zi6181m9T4YhsgfVL5RTM1MsvHQ1P8qL
         GDbT39NH4A2lIe2FhX5R8dVwjR1a+NUk/vi8z9lo43bYTunvb9Mi+vprbhnvFUjZWAzX
         dhMV3vtWNNWVNRvcou65EnmaFprr9F1aYkKRVYqX0xA3execpsUERY99DqVBdqSfg26m
         4Llw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/Guu5q3RA8bDSszzVfmQzfGA6D0E8Wer49UcKNbj9GPeEZN7uxKLdlPuNyElBc8AmXGYMsPZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FzK1PLo2hy6QFhRMmgDoR9PYaKt3ojbVtsZLkBsNEJdM3ZIu
	WU5qgkmjtwXc+Xe5MzCjcBRkc/OoIRFFyZCI4N0cMzAyLWm/nVVka6+ZTKJuq0uwBZYlVoPdC1+
	yQ0sUsN5mYejPr+x9mkLgda4p2/ItUuo=
X-Gm-Gg: AY/fxX5+NprxY4qXsxFBLk4Os1sIwFpJYfCA+UnesmtPDW2ofnwrQmAJAb8uIneDiWI
	UEjdrXXaD/DabpcUnyz5rnVpTRlMP57qbDZYjM1wOB9XkNESCgMwXY3Mx7+Q7lHvqrap74/YJCi
	2a/0Se9mjGwl1hsF18C0UwpwDUHbJRXg7aUxxSEBKNd4awIQ/XAJvs9C9cs8h6VhTHcM6A6JwEG
	LdCiMsvuc6bGyk8awKUWrtcJn838fw0vW+66G72JdbaTSzEx/9urcx3q0+ebVJFGeTefBs7jz9m
	JwqhUubprYjJmW9KQ1jsuZDyd7rxCV2JdR+LNZFbALWaP/tnyemWxsqHJj3oQMHkHNNKA6GGDD4
	6bcZClB2xjsbGBEqdPvKLolREbVYqmX8UxgSbDshAhXzBpoeFlGyFivFyhdANzw==
X-Google-Smtp-Source: AGHT+IGFvOVHKAfbWaxLwTBaQLaBZDR+CtOePRKb4JGLx8Iq6aW3LnwoCZAjpV3BzeRYkkAxEbXJka0H/u++X3xwCxg=
X-Received: by 2002:a05:6214:2f01:b0:88a:525a:8dba with SMTP id
 6a1803df08f44-88d86290cd2mr463411186d6.34.1767208226748; Wed, 31 Dec 2025
 11:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com> <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
In-Reply-To: <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 31 Dec 2025 13:10:15 -0600
X-Gm-Features: AQt7F2poghpQmcg3OaQyRccFsqmxJHSR99hGjdqmwPjmMHpBjSutS7Tql3d0FDQ
Message-ID: <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

But it does show gnu coreutils installed ... "gnu-coreutils is already
the newest version (9.5-1ubuntu4)."

On Wed, Dec 31, 2025 at 1:09=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> but I guess they are different packages that include 'od' now.   Was
> "GNU coreutils" now is in 'uutils coreutils' package
>
> On Wed, Dec 31, 2025 at 1:05=E2=80=AFPM Steve French <smfrench@gmail.com>=
 wrote:
> >
> > Very strange - it shows version 0.2.2 (while the working one shows vers=
ion 9.4)
> >
> > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > od (uutils coreutils) 0.2.2
> > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > DISTRIB_ID=3DUbuntu
> > DISTRIB_RELEASE=3D25.10
> > DISTRIB_CODENAME=3Dquesting
> > DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
> > PRETTY_NAME=3D"Ubuntu 25.10"
> > NAME=3D"Ubuntu"
> > VERSION_ID=3D"25.10"
> > VERSION=3D"25.10 (Questing Quokka)"
> >
> > On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> =
wrote:
> > >
> > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > I noticed that tests generic/029 and generic/030 and generic/031 no=
w
> > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> > > > issue in dumping test output (hexdump/od). This is testing with
> > > > 6.19-rc2 but it looks like a change to hexdump or od that likely br=
oke
> > > > this.  Any ideas?
> > > >
> > > > See e.g.
> > > >
> > > > generic/029  0s ... - output mismatch (see
> > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> > > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
> > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.=
bad
> > > >  2025-12-19 18:25:13.562003626 -0600
> > > >     @@ -42,10 +42,10 @@
> > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXX=
XXXXXXXXXXX<
> > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXX=
XXXXXXXXXXX<
> > > >      *
> > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXX=
XXXXXXXXXXY<
> > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXX=
XXXXXXXXXXY<
> > >
> > > Hi Steve,
> > >
> > > Sorry for this late reply, I just backed from holiday.
> > >
> > > What's the version of your "od" command in Ubuntu 25.10 ? e.g.
> > >   # od --version
> > >   od (GNU coreutils) 9.9
> > >
> > >
> > > The hexdump output is from the common/rc:_hexdump() helper, it actual=
ly runs
> > > "od -Ax -t x1z ..." command. If the output format of latest "od" comm=
and is
> > > changed, we used to use a *filter* to help the output to be compatibl=
e.
> > > For example:
> > >
> > >   _hexdump()
> > >   {
> > >         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
> > >   }
> > >
> > > If you have a better idea to do that with a simple 'sed' command line=
, that
> > > would be better.
> > >
> > > Thanks,
> > > Zorro
> > >
> > >
> > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYY=
YYYYYYYYYYY<
> > > >
> > > > and
> > > >
> > > >      80 generic/030  0s ... - output mismatch (see
> > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.2577486=
40 -0500
> > > >      82     +++
> > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > > > 2025-12-19 18:25:14.073196575 -0600
> > > >      83     @@ -4,50 +4,50 @@
> > > >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > > > >XXXXXXXXXXXXXXXX<
> > > >      86      *
> > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > >YYYYYYYYYYYYYYYY<
> > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > >YYYYYYYYYYYYYYYY<
> > > >      89      *
> > > >      90     -4e7000
> > > >      91     ...
> > > >      92     (Run 'diff -u
> > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> > > > see the entire diff)
> > > >      93 generic/031  1s ... - output mismatch (see
> > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.2577486=
40 -0500
> > > >      95     +++
> > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > > > 2025-12-19 18:25:14.411496471 -0600
> > > >      96     @@ -6,14 +6,14 @@
> > > >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > >................<
> > > >      99      *
> > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > >................<
> > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > > >................<
> > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > >................<
> > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > > >................<
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> > > >
> > >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve
