Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47561E9B1C
	for <fstests@vger.kernel.org>; Fri,  2 Jan 2026 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767387726; cv=none; b=g5+u7jIMYC1rX3N5P04k7LiB+m9dZ2sH1cJd7QYE+3avRZyYKhUIgHkcHdkEl7YleJMbtIcL+tVy4FvrdSxjC6T2MSii6FXTVStQlf4UjKMIRBT3p4OIJLHHU+DcBLL+di+YGjoeJpW61DXbGTQZepr8hAb/fEDnLxjy4axoxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767387726; c=relaxed/simple;
	bh=jNTl19yezbCrS0zpkO+vXeNhnyUrkvDqe75FNE9brpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUtB+7d9K089n1LCVA7nlKD2rJ/Z4XekAlTWDZc5bQVg40p5xBwuowezC1h1ZM7H7JbYc+o30o5h2qAqL/6UUleAVB/BWTyfg30CeRiR71I6Vla3C8OcuhHPTj7PKycQv78PEO1Y1t2SRhD9GO+OPCgcLSWP1rdDOJfVQ/C1OlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgH85j1f; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgH85j1f"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee328b8e38so145676401cf.0
        for <fstests@vger.kernel.org>; Fri, 02 Jan 2026 13:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767387724; x=1767992524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWUDr0NPFd5u1esM4jCmXT4MqIwy6mY7DqMvffoN1IE=;
        b=cgH85j1fhPenRdnDGf1f3Oh6YbUhvsUPKeBkeZIPUx7KVDZPd9+Plw5N85pw5erAhL
         wdPl6GBAvdJftMMIYTuHQ88wtGwv8rvvm7bzT4OQsO4IN7oz9XLaOabcYZBaN6bSs9Dj
         fSx0yPu57cMdfe8Xs9ANiLtMbIPymEKhks4bbsOq+eL/lsYYpHrdWXmxgI66BVDwm7PS
         SIPDvSJ9wI8S4d+4mlQMiRNAGtpxg/Ak4T8rra7+8Yv60+fzBa1zUQiu6OYVuLJSpZcI
         lAdxoeNhYDi7lZc3kOYDkhHJs/mC0fipixEmT+OQiFf97FO0Ng+bJdlNVodCi2RHSxem
         cJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767387724; x=1767992524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWUDr0NPFd5u1esM4jCmXT4MqIwy6mY7DqMvffoN1IE=;
        b=uqyan8D2sf/qKfpNueTo12EgHL9Y74YNWLdsLg+75Jt93DUgijG1+iNAh3CgwHz0fi
         Lqk7rCOG37olM345retw2Ps3y6C+WsNCG9QRtR3ShU0WbhzmiNnMfqdN0MUIAz74JiQ6
         7pdTsKjR5gh2cFQTky30snanFBKmNA3WYy0ZKMReUNERqToVYR3fCWEkLhBEiXKNXeQY
         5G/XnMsxway59QmEgyzEEbdE6ZmeadqqVCec7rlDtNrbao0pt09RyBE8NEseXg0p+Vkv
         L/T2GIB6W4NNj30qdUOFxEvI8xTiBRh9OJteLhYxD3+0owd/3cRc6JdYlvEe+rlEESOq
         j9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcUiI2SWaPvjPlMtqFNjtlFV/biUDpUtbz0VaujWm2sRMo5fdkies192OrTVLbna8XfbG1jUhm@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUoJNqcQ8qyegCmtTpNkjWFyxPiMm5Byx27wqm87Zft9MLEPR
	zhPG/J2sKaRx/zDQ+mh/+zj1zSPDhsc4KN58B10MstzyItg5X+8HUsQHN51rxJTaJ1qRFFOdSKl
	7jR9mxKOSRUJIBCqu0wE/11asQGPHJvI=
X-Gm-Gg: AY/fxX6t0T0rCq0kiEtoy5bsQcRs9rQ8ZgyOr36fx3p1Vv8Kn37dIhQfBF0IDsTyWqZ
	m8dtpTwGaZBy8g1CTkhEIfYuKPm8psh3bjIm2jwJyolgHrjQM+Mn5Pa5IGHMJBX6kYFVkSgKxcz
	Sp3kneZz2QahY3zuOuAjJhB+jK/GAkImS1pq8iWDvX+FxASYEY9oKgfTXkTDCEHfORmsNEf/DdE
	0EJaUD00hDIJozPwBwieKx6XkF5Atr+nt1OTTMBAJq5OsdndrLV3DSmHePEJMghYvsksIpR6ABj
	CcdtsASqhGKTK6vOc42Y9ezsp7FljSJ9Jr4cdniIStl/wVQfnba/ALYCH0y7CKDNDBo0VnRo5A9
	+8sNPoIuhmDfEPAKl7HQWR2HzKsntPmfQhzkQ26t1mjYuAwn1fDO0oi4ttAP6idRRYm+/e+AlK7
	6ckQQxzTOmrevV9eDa3Z9s
X-Google-Smtp-Source: AGHT+IGEOdXK6nlXaJPlfETARFJdt3pDVaKhZ6TxRiRhy5mnC53tRrfODBoFyBY5NkPpQ5ObeNky9iLOeXSeVxCvn9M=
X-Received: by 2002:a05:622a:5409:b0:4ed:a7ba:69c with SMTP id
 d75a77b69052e-4f4abdc8ea1mr645867221cf.83.1767387723440; Fri, 02 Jan 2026
 13:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
 <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
 <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com>
 <20251231194112.aapst4mb6pwgsarz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com>
In-Reply-To: <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 2 Jan 2026 15:01:52 -0600
X-Gm-Features: AQt7F2q17PnzPAOPKNo0aRD40aVXNRZbaTkJCwxAiqzEWqMBFseWo4WRWJFbWMk
Message-ID: <CAH2r5msQjhPMFX4-0SiqxHT+ur+XQqZdRyyNiJm3DgosEhve-Q@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With uutils test generic/452 also now fails (works when I force remove uuti=
ls)

generic/452  0s ... - output mismatch (see
/home/smfrench/xfstests-dev/results//samba/generic/452.out.bad)
    --- tests/generic/452.out   2025-08-22 09:54:32.316786174 -0500
    +++ /home/smfrench/xfstests-dev/results//samba/generic/452.out.bad
 2025-12-29 16:23:28.515219667 -0600
    @@ -1,3 +1,3 @@
     QA output created by 452
    -SCRATCH_MNT/ls_on_scratch
    -SCRATCH_MNT/ls_on_scratch
    +SCRATCH_MNT/ls_on_scratch: function/utility not found
    +SCRATCH_MNT/ls_on_scratch: function/utility not found

On Fri, Jan 2, 2026 at 2:43=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> I could repro the problem by running od command the same way that
> _hexdump() in fstests calls, and I did confirm that on current Ubuntu
> you can workaround it by doing:
>
> "sudo apt-get remove coreutils-from-uutils --allow-remove-essential"
> (which auto-installs gnu utils after uutils are deleted)
>
> On Wed, Dec 31, 2025 at 1:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> wro=
te:
> >
> > On Wed, Dec 31, 2025 at 01:10:15PM -0600, Steve French wrote:
> > > But it does show gnu coreutils installed ... "gnu-coreutils is alread=
y
> > > the newest version (9.5-1ubuntu4)."
> > >
> > > On Wed, Dec 31, 2025 at 1:09=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> > > >
> > > > but I guess they are different packages that include 'od' now.   Wa=
s
> > > > "GNU coreutils" now is in 'uutils coreutils' package
> >
> > Anyway, I think you'd better to make sure if it's an expected behavior =
(output
> > format) change of latest gnu od command at first. If it's, we need a fi=
lter.
> > If not, this might be a bug (default behavior change).
> >
> > Thanks,
> > Zorro
> >
> > > >
> > > > On Wed, Dec 31, 2025 at 1:05=E2=80=AFPM Steve French <smfrench@gmai=
l.com> wrote:
> > > > >
> > > > > Very strange - it shows version 0.2.2 (while the working one show=
s version 9.4)
> > > > >
> > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > > > > od (uutils coreutils) 0.2.2
> > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > > > > DISTRIB_ID=3DUbuntu
> > > > > DISTRIB_RELEASE=3D25.10
> > > > > DISTRIB_CODENAME=3Dquesting
> > > > > DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
> > > > > PRETTY_NAME=3D"Ubuntu 25.10"
> > > > > NAME=3D"Ubuntu"
> > > > > VERSION_ID=3D"25.10"
> > > > > VERSION=3D"25.10 (Questing Quokka)"
> > > > >
> > > > > On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redhat=
.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > > > > I noticed that tests generic/029 and generic/030 and generic/=
031 now
> > > > > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lowe=
r case
> > > > > > > issue in dumping test output (hexdump/od). This is testing wi=
th
> > > > > > > 6.19-rc2 but it looks like a change to hexdump or od that lik=
ely broke
> > > > > > > this.  Any ideas?
> > > > > > >
> > > > > > > See e.g.
> > > > > > >
> > > > > > > generic/029  0s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.ba=
d)
> > > > > > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004=
 -0500
> > > > > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/02=
9.out.bad
> > > > > > >  2025-12-19 18:25:13.562003626 -0600
> > > > > > >     @@ -42,10 +42,10 @@
> > > > > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  =
>WWXXXXXXXXXXXXXX<
> > > > > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  =
>XXXXXXXXXXXXXXXX<
> > > > > > >      *
> > > > > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  =
>XXXXXXXXXXXXXXXY<
> > > > > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  =
>XXXXXXXXXXXXXXXY<
> > > > > >
> > > > > > Hi Steve,
> > > > > >
> > > > > > Sorry for this late reply, I just backed from holiday.
> > > > > >
> > > > > > What's the version of your "od" command in Ubuntu 25.10 ? e.g.
> > > > > >   # od --version
> > > > > >   od (GNU coreutils) 9.9
> > > > > >
> > > > > >
> > > > > > The hexdump output is from the common/rc:_hexdump() helper, it =
actually runs
> > > > > > "od -Ax -t x1z ..." command. If the output format of latest "od=
" command is
> > > > > > changed, we used to use a *filter* to help the output to be com=
patible.
> > > > > > For example:
> > > > > >
> > > > > >   _hexdump()
> > > > > >   {
> > > > > >         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
> > > > > >   }
> > > > > >
> > > > > > If you have a better idea to do that with a simple 'sed' comman=
d line, that
> > > > > > would be better.
> > > > > >
> > > > > > Thanks,
> > > > > > Zorro
> > > > > >
> > > > > >
> > > > > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  =
>YYYYYYYYYYYYYYYY<
> > > > > > >
> > > > > > > and
> > > > > > >
> > > > > > >      80 generic/030  0s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.ba=
d)
> > > > > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.2=
57748640 -0500
> > > > > > >      82     +++
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.ba=
d
> > > > > > > 2025-12-19 18:25:14.073196575 -0600
> > > > > > >      83     @@ -4,50 +4,50 @@
> > > > > > >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58=
 58 58
> > > > > > > >XXXXXXXXXXXXXXXX<
> > > > > > >      86      *
> > > > > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59=
 59 59
> > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59=
 59 59
> > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > >      89      *
> > > > > > >      90     -4e7000
> > > > > > >      91     ...
> > > > > > >      92     (Run 'diff -u
> > > > > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.ba=
d'  to
> > > > > > > see the entire diff)
> > > > > > >      93 generic/031  1s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.ba=
d)
> > > > > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.2=
57748640 -0500
> > > > > > >      95     +++
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.ba=
d
> > > > > > > 2025-12-19 18:25:14.411496471 -0600
> > > > > > >      96     @@ -6,14 +6,14 @@
> > > > > > >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00=
 00 00
> > > > > > > >................<
> > > > > > >      99      *
> > > > > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd=
 cd cd
> > > > > > > >................<
> > > > > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd=
 cd cd
> > > > > > > >................<
> > > > > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd=
 cd cd
> > > > > > > >................<
> > > > > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd=
 cd cd
> > > > > > > >................<
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Steve
> > > > > > >
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> > >
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
