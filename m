Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6923B63C
	for <fstests@vger.kernel.org>; Fri,  2 Jan 2026 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767386656; cv=none; b=brYu+7H4WtMBQNhxa4XnsdkLAmVcpeS9cWmXxvmla1sLGHVRbJTnbsejW6PBivP2ET36MOw6L9a+cx1QIYWvOqu8xOW7ZwOibBAtulwaAvLbA34oWDXEoZtkKuif/QMqFLo8vsjiHYWSkfvQv0nqzNBmAr8q04ZktoAs0mgkn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767386656; c=relaxed/simple;
	bh=DN8IjB586EVNXNlTGeznxFJKVLvMAjfgJru+Q/lYq58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erkTiFqY/px5eBbzj5wZOxjT3JnpIs3tXsSPkzhkUw4wyG4AcHPuOhpgNWG8RNkaRpTZAhaSTK2cyVYeqdqDzebtdO+PJzNoQkC8k8cP7475/ABZhNIeZhOGvpqveVyCgEyUvWZ+1LNUsTCoK+m5cR2AhDWrN2XGSNo5a4R5v3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8zzPz6M; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8zzPz6M"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-890228ed342so50860086d6.2
        for <fstests@vger.kernel.org>; Fri, 02 Jan 2026 12:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767386654; x=1767991454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqIcSVd+xoY8ASEy3GsyEpFUXlpbXJ2Up2WLEeLSjok=;
        b=a8zzPz6MZ12FCIL7aj7UwPHRDy2nRUhdXIeIeegh/C4GQtbSny/YFd66rM+/kI/KNq
         e9IbFkZNGll6Bbxy7F+SjmMLKuperWbkkb5FLiALQAAuQf+K7Kx/a7oMeCFtvxmhTxR3
         Z8/HP3ldvXKiOGJkf0LvIIQiTH6VeyqDLsOlDap4KBxFZ2qmjqIIUV0Yu6aJjYupoFFj
         n7+OnRcg6IHchN4WzIKcAYdoWk01g9kznEvGbc0iyXlpTq6oPe2/C9prO3fGmjtzFN9P
         SiWFtHszdzoWc+6dZfft0X2iRHfgORtf4ByGskDYv6bJTHzj5Y/HcLmZT61w9Ndc8wU3
         2G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767386654; x=1767991454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqIcSVd+xoY8ASEy3GsyEpFUXlpbXJ2Up2WLEeLSjok=;
        b=mFi0pDINYM8S7o4I1X8SugdIpEdRwV+soCZNAa+Av6yGJnzKbxLo/u9r3eqLAGWcaA
         5Rwldg83hulEGw5Lzom7DEAv2W8GGZiFqabXgTWm8y2s7Ka8Kqq0DBS8YSIFVdj/QNIa
         hHHjOhrv7em+uRsehyLW17EtaK5DGXxD3pBpESrTbU5OviRwtoxmD1GqG3HEs6KdXqvb
         iS0wLtGn9J3FJur4tUUC43PqfRne7J/hGWUo5BNmUAVscaZue9HiNwtWL85D0fs31nPR
         hC3sLuLRM5M/7xVmzTZL95spAq551fV2Vi35kmXHYgruAi5NgcXdN2AqFqYWadP6NhMq
         ST1g==
X-Forwarded-Encrypted: i=1; AJvYcCVqqeAPEV0qBK8Qs+rGtIZz3wwZry/o2JNrjX7WyC3+Vhasj6cJP7h+5YI/LPpdnDm6xOObpIKD@vger.kernel.org
X-Gm-Message-State: AOJu0YyCsr60uIjbcpsnsZFfkJIFKPBNaKBIXp2v4AMOx1/oIKsqfq4B
	8Hlzvh9RrqHxxg23dvg6UYt5vEjkr8m/RNJ0FiG425kxauDU3j7AOI20Weaipysrj3Nx4uOKO8Q
	0kLl4Vhib5eVSoPVihuprIpEpnQOP8ns=
X-Gm-Gg: AY/fxX5AArzSvlaQxptU+SQP4tSSwE9Swh44PmW+aMeHzGLVngvxmzsoAvVTSAOW/C7
	FpY8QgF58Jt5E918kPKgXXlJaoQLlAsCNnS4EobJ61Qdn8YG1lqSdQEX3gKNcB0+EWgGh28TQ4e
	90dZWJKUjdWS8YAJLNeEUncw5mpjNK1a7FPZm8Qx7eBNmylJJ2IHZXUmRcWwvuWTaVY9edBv+k0
	0XqtosTg/p+eVbXRRI9HzrAz6nUu3opZqadh28NkTq5HBiwu75uyP8uAxj7ZObwITF1TkVXOFok
	XCNGrKo5WquyqG4U0mvZbO/pNcNtemNxaQZeduwNh5axgcxrFzejLAXPDE21JBzYiDe9Mdu5F4N
	+MmS1uIdFZTKqhZay8ErAqbCkvi7A6psMfuE3/vqh9vcy8yCEHNw7l/LnTHonwS7RXTh/i4vGIG
	n8xUdeuv4AeD0n2dVqL2dv
X-Google-Smtp-Source: AGHT+IFcCyp7/KVwj6mTT5eQu26PGAZ4uUXIseM49f/qqY0nDily3Xo3tbaEku9n9QdLnQtc/h8QOlnvxzmWAM6GepM=
X-Received: by 2002:ad4:530b:0:b0:882:4a63:63a7 with SMTP id
 6a1803df08f44-88d8442ff3bmr465632166d6.60.1767386653810; Fri, 02 Jan 2026
 12:44:13 -0800 (PST)
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
 <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com> <20251231194112.aapst4mb6pwgsarz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20251231194112.aapst4mb6pwgsarz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 2 Jan 2026 14:43:58 -0600
X-Gm-Features: AQt7F2ofJLebUnhPiQhwucCKJxt6h-5ABI5lnHiaKEgQ8nWHlpgZdY7yXEzi_Fk
Message-ID: <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I could repro the problem by running od command the same way that
_hexdump() in fstests calls, and I did confirm that on current Ubuntu
you can workaround it by doing:

"sudo apt-get remove coreutils-from-uutils --allow-remove-essential"
(which auto-installs gnu utils after uutils are deleted)

On Wed, Dec 31, 2025 at 1:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Wed, Dec 31, 2025 at 01:10:15PM -0600, Steve French wrote:
> > But it does show gnu coreutils installed ... "gnu-coreutils is already
> > the newest version (9.5-1ubuntu4)."
> >
> > On Wed, Dec 31, 2025 at 1:09=E2=80=AFPM Steve French <smfrench@gmail.co=
m> wrote:
> > >
> > > but I guess they are different packages that include 'od' now.   Was
> > > "GNU coreutils" now is in 'uutils coreutils' package
>
> Anyway, I think you'd better to make sure if it's an expected behavior (o=
utput
> format) change of latest gnu od command at first. If it's, we need a filt=
er.
> If not, this might be a bug (default behavior change).
>
> Thanks,
> Zorro
>
> > >
> > > On Wed, Dec 31, 2025 at 1:05=E2=80=AFPM Steve French <smfrench@gmail.=
com> wrote:
> > > >
> > > > Very strange - it shows version 0.2.2 (while the working one shows =
version 9.4)
> > > >
> > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > > > od (uutils coreutils) 0.2.2
> > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > > > DISTRIB_ID=3DUbuntu
> > > > DISTRIB_RELEASE=3D25.10
> > > > DISTRIB_CODENAME=3Dquesting
> > > > DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
> > > > PRETTY_NAME=3D"Ubuntu 25.10"
> > > > NAME=3D"Ubuntu"
> > > > VERSION_ID=3D"25.10"
> > > > VERSION=3D"25.10 (Questing Quokka)"
> > > >
> > > > On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redhat.c=
om> wrote:
> > > > >
> > > > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > > > I noticed that tests generic/029 and generic/030 and generic/03=
1 now
> > > > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower =
case
> > > > > > issue in dumping test output (hexdump/od). This is testing with
> > > > > > 6.19-rc2 but it looks like a change to hexdump or od that likel=
y broke
> > > > > > this.  Any ideas?
> > > > > >
> > > > > > See e.g.
> > > > > >
> > > > > > generic/029  0s ... - output mismatch (see
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> > > > > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -=
0500
> > > > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.=
out.bad
> > > > > >  2025-12-19 18:25:13.562003626 -0600
> > > > > >     @@ -42,10 +42,10 @@
> > > > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >W=
WXXXXXXXXXXXXXX<
> > > > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >X=
XXXXXXXXXXXXXXX<
> > > > > >      *
> > > > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >X=
XXXXXXXXXXXXXXY<
> > > > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >X=
XXXXXXXXXXXXXXY<
> > > > >
> > > > > Hi Steve,
> > > > >
> > > > > Sorry for this late reply, I just backed from holiday.
> > > > >
> > > > > What's the version of your "od" command in Ubuntu 25.10 ? e.g.
> > > > >   # od --version
> > > > >   od (GNU coreutils) 9.9
> > > > >
> > > > >
> > > > > The hexdump output is from the common/rc:_hexdump() helper, it ac=
tually runs
> > > > > "od -Ax -t x1z ..." command. If the output format of latest "od" =
command is
> > > > > changed, we used to use a *filter* to help the output to be compa=
tible.
> > > > > For example:
> > > > >
> > > > >   _hexdump()
> > > > >   {
> > > > >         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
> > > > >   }
> > > > >
> > > > > If you have a better idea to do that with a simple 'sed' command =
line, that
> > > > > would be better.
> > > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > >
> > > > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >Y=
YYYYYYYYYYYYYYY<
> > > > > >
> > > > > > and
> > > > > >
> > > > > >      80 generic/030  0s ... - output mismatch (see
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> > > > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.257=
748640 -0500
> > > > > >      82     +++
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > > > > > 2025-12-19 18:25:14.073196575 -0600
> > > > > >      83     @@ -4,50 +4,50 @@
> > > > > >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 5=
8 58
> > > > > > >XXXXXXXXXXXXXXXX<
> > > > > >      86      *
> > > > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 5=
9 59
> > > > > > >YYYYYYYYYYYYYYYY<
> > > > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 5=
9 59
> > > > > > >YYYYYYYYYYYYYYYY<
> > > > > >      89      *
> > > > > >      90     -4e7000
> > > > > >      91     ...
> > > > > >      92     (Run 'diff -u
> > > > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'=
  to
> > > > > > see the entire diff)
> > > > > >      93 generic/031  1s ... - output mismatch (see
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> > > > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.257=
748640 -0500
> > > > > >      95     +++
> > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > > > > > 2025-12-19 18:25:14.411496471 -0600
> > > > > >      96     @@ -6,14 +6,14 @@
> > > > > >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> > > > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00
> > > > > > >................<
> > > > > >      99      *
> > > > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd c=
d cd
> > > > > > >................<
> > > > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd c=
d cd
> > > > > > >................<
> > > > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd c=
d cd
> > > > > > >................<
> > > > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd c=
d cd
> > > > > > >................<
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > > > > >
> > > > >
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
> >
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
