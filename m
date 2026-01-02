Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9C1E1A3D
	for <fstests@vger.kernel.org>; Fri,  2 Jan 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767390613; cv=none; b=b6ZCQuSCm7a+93yY5vXdVfl4EcxxYuB0XT44XmB6QQ7so4U9btgfYB6ccmWjEdjVo/gotXswMrMkXe9K6TGuvTPECeftIKuRhEZi/7NKgtl0hz2rHe7fIG/zk9ByQFKfkHjyg9pYjbRoch5VuLIQE74Ld4ncVbSuHo5IjvRfSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767390613; c=relaxed/simple;
	bh=gQY0g5ZfErfVlaJx+FvG/o8R11PbfQINXw9TqVc8+hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcYbTLt96K6eNP/Fcdv0kpehXuPaAAhbIA3PT6m1PnB0rMu1wrTDvkOM4AFR+19lKeXoVaU9QjRyRpPjeI1gKS2TKxlnWfNY+rW301tQtsDEEvI8U9sPKmRwq2kRxwdVQTl4hXAmqTkgc8aT520qnUHZWZeC/CQNBPQFj3ipCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fphmfh3a; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fphmfh3a"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8887ac841e2so113282956d6.2
        for <fstests@vger.kernel.org>; Fri, 02 Jan 2026 13:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767390611; x=1767995411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cl6U7WQmNwSspuT3b84Jqy+Cufs83JbX9LItMJm4hw=;
        b=fphmfh3a8rm4RJ7+APz+AMF6f8CW6RTyfldIsJkRprEhNm/U/Kvb77xsihUt3CVhKx
         IaxwfHwuHDvp9pv+4u3DxFfH8VxQ5/xd0lrJre+W78thnBohMi3wBO9njuHKv/pkB3nB
         nmP3eW3OwCuWcgy883jWrWaD70xDIjtW5pNUjRpKbxE2HpNKNtlDI/W7lpxM49RN8RlH
         9uaajTU2cY19tqFttP8JwnEPgjNDqI+vbbR36Ato2wwYXEiqyXol6001UWgdEz8MIiYr
         MnhsJidxOXqndGo3y+qLBvy80pwzHw28QK8v1gaJOE5JcMIHVLXd1psVqP2ENJlB8OMP
         Vmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767390611; x=1767995411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Cl6U7WQmNwSspuT3b84Jqy+Cufs83JbX9LItMJm4hw=;
        b=eR/IEDO76XBKAbyKHZQBheMLH6Ct56a7oab4KbekDqPogNVhC8X0JpxxMVm2dXrnDq
         TRDOtOPaJjzpaG489pMlu3C+Jzs43HfZm5JGeeu1Wq+nAcYgZZkZ5OmxCmHMjNpxM4IW
         w6LrvssaU7sc2lI9SXDrcEt4MjiBUA+L37qzpcojzNR4uIcAsNcRXPtmXtWb2svIMV66
         a8Q6akFnMPdVFNcmDAdlaXUVVgcYMxFA0WcewRCXxS2LCtWv98iaUjWEAM0ZOpmZCwVi
         StmnaxM5QxDqpV0wFesxcNp3SGVWxj8SPJqErRsziRCnC6k9HWcVKXorlR+Pmnm6k7p+
         ZfLA==
X-Forwarded-Encrypted: i=1; AJvYcCX3rCGL1A8+V3JJhsQ5RumHiLACdBxfbc2qatZIbmH6CSGkSLSpbHvmPxs3rQq9WKSeoW3Ol7r8@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuIkgBi8vrnTWTllKMJ3W4dBh7tuUzgstsgQeQp4f5XjiXVps
	q8d5fayZtyo4BTFFuKEnIk3QAhOaIvd8KwpnRrugHdG0p4cSzqTFVQBRSYpu1R5TFJZnPykWqM8
	96yL6sOnTKZONsooCr8aWPZlgchGxb+E=
X-Gm-Gg: AY/fxX4mdbzk+sj5nY1vpY40EpxlHlISlDywh+1BYrCRkF4GeU8d97Z+om+b2gMAtOH
	DhJL15p2YxZS6ZiNxzDibY5YtyZvH+5h66YfzkGpsKb/aHLe0H+Trt/rMMPMT+q+4gpXSGeiXsn
	QCgM1G9PcoJasvzJxUG7qUuOB+r1ZwXusZzuNXZnCssscEUQ0/Igg4kLph7u5cZoxGZFWDKeozU
	GGWNOWyOGwpr+FvnTgSAwIYPPTZecefOVKsKRoHS6HIblHTa0oYeUMgwSFg+kQDD3o+TW6XZv7X
	lqHrOSRtGLWWbPcbsA/HRWdPsKhapLbE+1zHYVoS/YPAKtZ3mucO+6BHsNBim+N88f1wpmwFvpy
	8fW+X9yjQvIebuOChdj6IwosVd3EMIUGZZByc1czBDJ27x8ELyxjQTbGhoCcek94tZSg5y95jbF
	vRSrDYLi+7L2IkdbxRE8uv
X-Google-Smtp-Source: AGHT+IEZFvvFvnQ4qU1yuRVIuQFGCmbzi86zGORc87NT3sWaocIPydk/6hokpd2FGjAuXMUBDPk+0odUlweI5pip6jU=
X-Received: by 2002:a05:6214:3f92:b0:88f:e333:4a9c with SMTP id
 6a1803df08f44-88fe3334c18mr397435266d6.51.1767390610867; Fri, 02 Jan 2026
 13:50:10 -0800 (PST)
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
 <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com> <20260102214545.calxkyk6rec76thg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20260102214545.calxkyk6rec76thg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 2 Jan 2026 15:49:59 -0600
X-Gm-Features: AQt7F2r5p3zliPXYXE1SNz6w1NUErnVjXAC43aALPOwBUe_AGQeCor4vYwC7Lo0
Message-ID: <CAH2r5muYt7SMzWRqXz8kG1JZUBSj-3SwTMTkOqQFFvPpJmfe-g@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ubuntu 25.10 has already switched to it (uutils) but in a few months
presumably we should know whether they switch back in Ubuntu 26 to gnu
utils

On Fri, Jan 2, 2026 at 3:45=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote:
>
> On Fri, Jan 02, 2026 at 02:43:58PM -0600, Steve French wrote:
> > I could repro the problem by running od command the same way that
> > _hexdump() in fstests calls, and I did confirm that on current Ubuntu
> > you can workaround it by doing:
> >
> > "sudo apt-get remove coreutils-from-uutils --allow-remove-essential"
> > (which auto-installs gnu utils after uutils are deleted)
>
> OK, so that's the root cause. You didn't run fstests with GNU coreutils,
> you used another utils. I'm glad to learn about a new project named
> "uutils" [1], and looks like ubuntu would like to use it.
>
> But currently for fstests, I (personally) think fstests depends on GNU's
> coreutils by default. I don't think other fstests developers would like
> to make fstests to support other coreutils replacements. Except the
> uutils project replaces GNU coreutils totally in one day. So you'd
> better to make sure the running dependences are installed properly before
> running fstests.
>
> And the uutils project says it trys to "retain full compatibility with th=
e
> existing utilities", isn't this output format difference counted as
> a compatibility bug :-D
>
> Thanks,
> Zorro
>
> [1]
> https://uutils.github.io/
>
> >
> > On Wed, Dec 31, 2025 at 1:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Wed, Dec 31, 2025 at 01:10:15PM -0600, Steve French wrote:
> > > > But it does show gnu coreutils installed ... "gnu-coreutils is alre=
ady
> > > > the newest version (9.5-1ubuntu4)."
> > > >
> > > > On Wed, Dec 31, 2025 at 1:09=E2=80=AFPM Steve French <smfrench@gmai=
l.com> wrote:
> > > > >
> > > > > but I guess they are different packages that include 'od' now.   =
Was
> > > > > "GNU coreutils" now is in 'uutils coreutils' package
> > >
> > > Anyway, I think you'd better to make sure if it's an expected behavio=
r (output
> > > format) change of latest gnu od command at first. If it's, we need a =
filter.
> > > If not, this might be a bug (default behavior change).
> > >
> > > Thanks,
> > > Zorro
> > >
> > > > >
> > > > > On Wed, Dec 31, 2025 at 1:05=E2=80=AFPM Steve French <smfrench@gm=
ail.com> wrote:
> > > > > >
> > > > > > Very strange - it shows version 0.2.2 (while the working one sh=
ows version 9.4)
> > > > > >
> > > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > > > > > od (uutils coreutils) 0.2.2
> > > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > > > > > DISTRIB_ID=3DUbuntu
> > > > > > DISTRIB_RELEASE=3D25.10
> > > > > > DISTRIB_CODENAME=3Dquesting
> > > > > > DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
> > > > > > PRETTY_NAME=3D"Ubuntu 25.10"
> > > > > > NAME=3D"Ubuntu"
> > > > > > VERSION_ID=3D"25.10"
> > > > > > VERSION=3D"25.10 (Questing Quokka)"
> > > > > >
> > > > > > On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redh=
at.com> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > > > > > I noticed that tests generic/029 and generic/030 and generi=
c/031 now
> > > > > > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lo=
wer case
> > > > > > > > issue in dumping test output (hexdump/od). This is testing =
with
> > > > > > > > 6.19-rc2 but it looks like a change to hexdump or od that l=
ikely broke
> > > > > > > > this.  Any ideas?
> > > > > > > >
> > > > > > > > See e.g.
> > > > > > > >
> > > > > > > > generic/029  0s ... - output mismatch (see
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.=
bad)
> > > > > > > >     --- tests/generic/029.out   2025-08-22 09:54:32.2567480=
04 -0500
> > > > > > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/=
029.out.bad
> > > > > > > >  2025-12-19 18:25:13.562003626 -0600
> > > > > > > >     @@ -42,10 +42,10 @@
> > > > > > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58=
  >WWXXXXXXXXXXXXXX<
> > > > > > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58=
  >XXXXXXXXXXXXXXXX<
> > > > > > > >      *
> > > > > > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59=
  >XXXXXXXXXXXXXXXY<
> > > > > > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59=
  >XXXXXXXXXXXXXXXY<
> > > > > > >
> > > > > > > Hi Steve,
> > > > > > >
> > > > > > > Sorry for this late reply, I just backed from holiday.
> > > > > > >
> > > > > > > What's the version of your "od" command in Ubuntu 25.10 ? e.g=
.
> > > > > > >   # od --version
> > > > > > >   od (GNU coreutils) 9.9
> > > > > > >
> > > > > > >
> > > > > > > The hexdump output is from the common/rc:_hexdump() helper, i=
t actually runs
> > > > > > > "od -Ax -t x1z ..." command. If the output format of latest "=
od" command is
> > > > > > > changed, we used to use a *filter* to help the output to be c=
ompatible.
> > > > > > > For example:
> > > > > > >
> > > > > > >   _hexdump()
> > > > > > >   {
> > > > > > >         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
> > > > > > >   }
> > > > > > >
> > > > > > > If you have a better idea to do that with a simple 'sed' comm=
and line, that
> > > > > > > would be better.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Zorro
> > > > > > >
> > > > > > >
> > > > > > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59=
  >YYYYYYYYYYYYYYYY<
> > > > > > > >
> > > > > > > > and
> > > > > > > >
> > > > > > > >      80 generic/030  0s ... - output mismatch (see
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.=
bad)
> > > > > > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32=
.257748640 -0500
> > > > > > > >      82     +++
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.=
bad
> > > > > > > > 2025-12-19 18:25:14.073196575 -0600
> > > > > > > >      83     @@ -4,50 +4,50 @@
> > > > > > > >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 =
58 58 58
> > > > > > > > >XXXXXXXXXXXXXXXX<
> > > > > > > >      86      *
> > > > > > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 =
59 59 59
> > > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 =
59 59 59
> > > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > > >      89      *
> > > > > > > >      90     -4e7000
> > > > > > > >      91     ...
> > > > > > > >      92     (Run 'diff -u
> > > > > > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.=
bad'  to
> > > > > > > > see the entire diff)
> > > > > > > >      93 generic/031  1s ... - output mismatch (see
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.=
bad)
> > > > > > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32=
.257748640 -0500
> > > > > > > >      95     +++
> > > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.=
bad
> > > > > > > > 2025-12-19 18:25:14.411496471 -0600
> > > > > > > >      96     @@ -6,14 +6,14 @@
> > > > > > > >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00
> > > > > > > > >................<
> > > > > > > >      99      *
> > > > > > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd =
cd cd cd
> > > > > > > > >................<
> > > > > > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd =
cd cd cd
> > > > > > > > >................<
> > > > > > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd =
cd cd cd
> > > > > > > > >................<
> > > > > > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd =
cd cd cd
> > > > > > > > >................<
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Steve
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > > > >
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
> > > >
> > >
> >
> >
> > --
> > Thanks,
> >
> > Steve
> >
>


--=20
Thanks,

Steve
