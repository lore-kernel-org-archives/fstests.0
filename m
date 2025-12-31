Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF12DC32B
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767207927; cv=none; b=t9gmTGnHaiWwyCJ7j6ZIkgS5xI7Vx6vpUd4wCVKvMIiqxfVh28JQMx8uSu1HDOCOEmvq12OoJ//gn2lkbcE4VgkhW9Y1sNYU3kS+RMBDbJDphmvXXnaEy9DTjk4chHfvClv1qRZVtFmSXE06Sao1+BTVQbCh1n4B7RmDlVy6HO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767207927; c=relaxed/simple;
	bh=UYdmS9eCFkpAQR9juRSEZ+40Jgu4NoLebZfMnB0VrLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/4Zo4ibsyz3aIKfa0QZ1o3OyNmGveXncelAZ0m4AhNhuGYtC0KqaSqi+CkXz/ZvMOJqQ2HZCMgoVhSv3RifzTRkELRzbmJBQ2LZnYfEkw8Qlhhsdjh5Ldvb5krkyPCkZ2juX8EIpcODPwZOs84fz193bIDN0retvjiQvsvf8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW/xWRwP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW/xWRwP"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a288811a4so124718396d6.3
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 11:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767207924; x=1767812724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYKOTawQn8cDMG3hBQJkVoTtrFYpcgRSYftBZa3EaWI=;
        b=LW/xWRwPVugQELpNCXbpyZ32C1uH2POAEpT8S5fHJtyAz0tHs/ueM+Mai4fbXoevql
         3wx7AMP+Vpy8+7+97vD9Zv/YOPswuQzhO67AEMqB+sL4HzBv4LWzIBbW562/hmbbFgrr
         cLHmpALZUOZyN4OwDZaQPg39+BXchDMchcHJ3HO5zvZvIW2qBgW5nZPOrVq2Bpqapvjz
         DaREEvaUd90TD5+7tPNQCBD/29JQdJ/QVS9Z17OEbSWNgcgIHzjDKJ1j+th+P6cx2ypr
         9qweStFM9PB9Sl9N78ELKmi+NRpGCaQWp+tjogN0acAglASEaCx5Vgdjs6XSTKgpSDkx
         tqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767207924; x=1767812724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYKOTawQn8cDMG3hBQJkVoTtrFYpcgRSYftBZa3EaWI=;
        b=hpvt5QLuvS9DAeejsanFQuhL0G2/AY1cXIbcTKbJFp3yIiU7mNdkehAFvPIinGu8m6
         qfUMRrMpVLD8/8YuSpkW6W0ksa433nuMo0/RLI16q0DE0acLaHCOefNRmH7ZlzM34wBK
         q7TeEvVbD+LYoY9vPz+FJgAL5PgCRlQqg2gthik54CxCkAxdApc0m+T4dmy0iaTxIKYD
         YJxNIFt4X99oOlprTROeqKdFimrRzc8+be63mPA/RA2qKMTByG6ZzmU7hOQ33TRhH+v7
         pRd1BO4v65ZEQFk9S/ziXdEKJCyzodAB0tHqWgAHClRV7U0Ae9BA2NV0ISMRTYRBuaJ/
         Uuxg==
X-Forwarded-Encrypted: i=1; AJvYcCWhy5uW1DZYEsAMc4cQEN4c6W2NOA0/CbsBjMGkKeyjVIU9Onb/sHVxo5FGuRVH1wmbSWo7qU41@vger.kernel.org
X-Gm-Message-State: AOJu0YynWHCV53l2HMsBc5knKpfrfK8r6x+ydpIGPquJFuYOpY+cc52P
	xIu/zgpFwOXSW2R000x3RwrGH3QLgfRuXsZF4a/PJEY2nCJrfp+TitsEsFKCQCtGfNFHH8lSvNR
	xdrLAtTTKKhzbyg6heoGTI9fiS7oWppUIKbmC
X-Gm-Gg: AY/fxX5ywnTP7CgCMR/6ljah2LbTn+YvIuQ4S94GtmSkZJtqkMmH/Mo+oHXAP+FbF/W
	6dFc+4NVZsZASGsbALLNNtgYq8SKioB/Tqx+cu12wPLmhVgUvwD8ZWSxXAP9fBcgIgl1xvdNiTX
	aT7r5w6UIPYstGiN2s43hGb8I/fY3klyiGkbpD4N3gx/lLXHuaMaliMnhaltGMpur8ekrZ7RIde
	oYOTr9PWSVKWnzjWlGQzT2g9TmIsSuoJsS9ddvvY2rMT4h9XhvfrWFHzLH27/n8/PppAjldWrW+
	DWyH7+502cT0DRFc1DpDBpt5L+5IOlJ2uKIWLR65sIuRs7UVGnnGW0IQNJuh75NwGqWA52+6tvc
	2AXGjqhnW6Ik2B4W0r6sW/9og57BiH10zMv+Bg/ImlXjEtF3WACk=
X-Google-Smtp-Source: AGHT+IGBk7XzW3cXEoCNzFtlwUoYBPErYJnt3FPDMgLqR6HNjwNL4jW4JSu4iNz2tybS2vM3VQZuDenBpV8CMkqlXw8=
X-Received: by 2002:a05:6214:19cd:b0:880:48c6:ad02 with SMTP id
 6a1803df08f44-88d83d653fdmr530611446d6.52.1767207924279; Wed, 31 Dec 2025
 11:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 31 Dec 2025 13:05:12 -0600
X-Gm-Features: AQt7F2o14vIVc9lYqaaIqfRk2SFaHhr9_FQKssMq70xN0ggFmAlpCfV_BYPicTI
Message-ID: <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Very strange - it shows version 0.2.2 (while the working one shows version =
9.4)

smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
od (uutils coreutils) 0.2.2
smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D25.10
DISTRIB_CODENAME=3Dquesting
DISTRIB_DESCRIPTION=3D"Ubuntu 25.10"
PRETTY_NAME=3D"Ubuntu 25.10"
NAME=3D"Ubuntu"
VERSION_ID=3D"25.10"
VERSION=3D"25.10 (Questing Quokka)"

On Wed, Dec 31, 2025 at 12:41=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrot=
e:
>
> On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > I noticed that tests generic/029 and generic/030 and generic/031 now
> > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> > issue in dumping test output (hexdump/od). This is testing with
> > 6.19-rc2 but it looks like a change to hexdump or od that likely broke
> > this.  Any ideas?
> >
> > See e.g.
> >
> > generic/029  0s ... - output mismatch (see
> > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
> >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
> >  2025-12-19 18:25:13.562003626 -0600
> >     @@ -42,10 +42,10 @@
> >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXX=
XXXXXXX<
> >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXX=
XXXXXXX<
> >      *
> >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXX=
XXXXXXY<
> >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXX=
XXXXXXY<
>
> Hi Steve,
>
> Sorry for this late reply, I just backed from holiday.
>
> What's the version of your "od" command in Ubuntu 25.10 ? e.g.
>   # od --version
>   od (GNU coreutils) 9.9
>
>
> The hexdump output is from the common/rc:_hexdump() helper, it actually r=
uns
> "od -Ax -t x1z ..." command. If the output format of latest "od" command =
is
> changed, we used to use a *filter* to help the output to be compatible.
> For example:
>
>   _hexdump()
>   {
>         od -Ax -t x1z ... | awk '{$1=3Dtolower($1);print}'
>   }
>
> If you have a better idea to do that with a simple 'sed' command line, th=
at
> would be better.
>
> Thanks,
> Zorro
>
>
> >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYY=
YYYYYYY<
> >
> > and
> >
> >      80 generic/030  0s ... - output mismatch (see
> > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> >      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -=
0500
> >      82     +++
> > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > 2025-12-19 18:25:14.073196575 -0600
> >      83     @@ -4,50 +4,50 @@
> >      84      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > >XXXXXXXXXXXXXXXX<
> >      86      *
> >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > >YYYYYYYYYYYYYYYY<
> >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > >YYYYYYYYYYYYYYYY<
> >      89      *
> >      90     -4e7000
> >      91     ...
> >      92     (Run 'diff -u
> > /home/smfrench/xfstests-dev/tests/generic/030.out
> > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> > see the entire diff)
> >      93 generic/031  1s ... - output mismatch (see
> > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> >      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -=
0500
> >      95     +++
> > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > 2025-12-19 18:25:14.411496471 -0600
> >      96     @@ -6,14 +6,14 @@
> >      97      =3D=3D=3D=3D Pre-Remount =3D=3D=3D
> >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >................<
> >      99      *
> >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > >................<
> >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > >................<
> >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > >................<
> >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > >................<
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
