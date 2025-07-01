Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C027FB3F
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398823; cv=none; b=JZchJSdqPnV6FG65Dy2XaQYlXCjxRHo6Ex1W1TLEaJGOVXR5DwV7vF7q/bn8XjnInar9Ggkkzc6LljaSyUle4zarcgVyW7D9uCOKjNO+7+oU+FDtdURIemF5PARJf9zuVpsR8NYkzrF6hj+xmYySrnUXBZwPV40I4T3Qg3A8JgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398823; c=relaxed/simple;
	bh=dQ8jQAf0kE7kv2FshMY3Nl4lF2MAct+2k4xqG5y0i0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q16slPjkHulVbsNvSBKrAl0Q3GyStACvkMFPluKBL4LaKQXHgCHM39ttuNWYFhWP+uiHLubeZxRgVnScSu3VJkKey04JWqR8c5/KNjG0CS9rGzZAOBH8zUg2SmbBjRX95PZfmKSz7AbJgqlxcfvShDpok9ax41cjkIl69huuiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHI22fQn; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHI22fQn"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso65154046d6.1
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751398821; x=1752003621; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9ioh2f/wyI3yLgEJ+usj4O5CK1//J0uRQF+hWsnhDg=;
        b=MHI22fQnfcE4G9jhGEM7dEP8/KePg/a+GJafFqSxrYPt4OPuvETyGMsCilImGP8Dp5
         +LPcVXeHGp3JJw0+pT11EHduZa5mlyl3/Q4ZTF+wGDAzMpSfr7/D9GeSw3CbCHYFv69s
         DtP5sVyJR9xvMF+fsJENAQSMMzyaIZ7hfXURrJOHzLlWMuf9P15+E/Oo1r50JWS/AttU
         AoG3Mx+M+LSP9fKDf71z9ddE6rDu+WCDehhnD5MDUA2W7yo8AS1mGdGEX7OkOrsXbhg6
         pVwsZMFN539+kVVoRIGH+fqk9CBzPIzOhpH0HL8tLRdBYkb6bwQa6te9HLy5M1Eux3Vv
         KrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751398821; x=1752003621;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9ioh2f/wyI3yLgEJ+usj4O5CK1//J0uRQF+hWsnhDg=;
        b=AAfvJwBlH/itL6CT7GKPzlfAfQKcuzvFI91fKhmqZf98eym1xDFUfeK2KBqpiU7AVH
         LKFPEwQ+rS86oJO3svHbdyd0s5HozLSHnfGFdLclw5DJ9fz2EDaKceoKKoPJ++RISyDd
         FXugBMQMoFLSsVe49BY/aS5RXqsZoUpPulR14z8c2vBcWlDcPmYLu1M2T+R2FSnLFlL6
         orK9kkDNg81aSVKulFVKHx9phE7ddN5JNlW4xu1mk+S9qR63zAhQER6hhbRr/bUwtXWW
         fevlJVIam5yPnx6ERew9sXmQIXrw503XA15hl15wxJazmApfJLqhw/LwHHekJ2IEg0ZY
         vMQQ==
X-Gm-Message-State: AOJu0YzOFRM+zXA3A9BwZ8DJoucOxL1wYel4tlfc66xbSV3Y3zrmONwo
	dSAPUWizOlGM73H0hvvdPTfJKV06tlgBUBtB/N0mz/7rIKrZwpa42IbctUrOnnp8hv1Xkr4qICx
	eVcgqKiBsel+7x9gjwOtrUSvearANDivW5ScU
X-Gm-Gg: ASbGncsyHam56/yDzwPVXOBv2xgxi1PFNXanskLwXXGgr0q65xnVYJcf99S0eeD2SNv
	4AX5XIBTlpgnTIm1U9eGd4blHMmo0DJn8WUNgBE6Ybbrq7KjFkp5qnO1MWCMJ7YGLgliqOOCjs5
	YMvfr3ObcB0ATRpOGQlw8rHxIuQ0+CddY0avyZPZpzDw==
X-Google-Smtp-Source: AGHT+IHQQuq4x/AytU1PnWZENpr/iVtoLIMOMJNM8wepPySK6y7aAat5CBpaqwQdg1p+ZyH1NZhVamhl7LPifmuyPEI=
X-Received: by 2002:a05:6214:4c47:b0:6fa:fdf5:a604 with SMTP id
 6a1803df08f44-7010a9a8738mr74942156d6.12.1751398820603; Tue, 01 Jul 2025
 12:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msYMeEaaKKT1mEG7bCjFYExFCRUdL6ShimoK0g1AEdERQ@mail.gmail.com>
 <CAH2r5mtrM0_+x2jzxoRoNq6c3e5rS_7s7QT-=S5fDA06XoFNvw@mail.gmail.com>
In-Reply-To: <CAH2r5mtrM0_+x2jzxoRoNq6c3e5rS_7s7QT-=S5fDA06XoFNvw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Jul 2025 14:40:08 -0500
X-Gm-Features: Ac12FXyIHg8kuAf4_g15b-m5jUn7dGWeRzk0875nBy1jL4ebMyt5Uel3CyNSd_U
Message-ID: <CAH2r5mvE0R_npJgiA2+OuDHwa60EGxeC=LU7Z8FDA0X_AFYeNQ@mail.gmail.com>
Subject: Re: Build errors with current xfstests
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

nevermind - was on the wrong branch.   Now on updated master branch I
get a different error, will retry on current for-next branch

Building shared
gmake[3]: *** No targets specified and no makefile found.  Stop.
gmake[3]: *** No targets specified and no makefile found.  Stop.
gmake[2]: *** [../include/buildrules:31: shared] Error 2
gmake[1]: *** [include/buildrules:31: tests] Error 2
make: *** [Makefile:65: default] Error 2

On Tue, Jul 1, 2025 at 2:23=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> I haven't had a problem building it before on Ubuntu, but perhaps due
> to upgrade to Ubuntu 24.04 this line in acinclude.m4 breaks (which is
> supposed to set HAVE_FALLOCATE but won't if this line fails).  Any
> thoughts?
>
> #include <fcntl.h>
> #include <linux/falloc.h> ]], [[ fallocate(0, 0, 0, 0); ]])],[
> have_fallocate=3Dtrue; AC_MSG_RESULT(yes) ],[ have_fallocate=3Dfalse;
> AC_MSG_RESULT(no) ])
>
> On Tue, Jul 1, 2025 at 2:15=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
> >
> > I am getting the following build error with current xfstests on
> > Ubuntu.  Any thoughts?
> >
> > Building src
> >     [CC]    iogen
> > iogen.c: In function 'create_file':
> > iogen.c:996:3: error: #error Dont know how to (pre)allocate space!
> >   996 | # error Dont know how to (pre)allocate space!
> >       |   ^~~~~
> > iogen.c: In function 'main':
> > iogen.c:280:9: warning: ignoring return value of 'write' declared with
> > attribute 'warn_unused_result' [-Wunused-result]
> >   280 |         write(outfd, (char *)&req, sizeof(req));
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > iogen.c: In function 'parse_cmdline':
> > iogen.c:1535:17: warning: ignoring return value of 'getcwd' declared
> > with attribute 'warn_unused_result' [-Wunused-result]
> >  1535 |                 getcwd(fptr->f_path,
> >       |                 ^~~~~~~~~~~~~~~~~~~~
> >  1536 |                        sizeof(fptr->f_path)-1);
> >       |                        ~~~~~~~~~~~~~~~~~~~~~~~
> > gmake[2]: *** [Makefile:51: iogen] Error 1
> > gmake[1]: *** [include/buildrules:31: ltp] Error 2
> > make: *** [Makefile:51: default] Error 2
> >
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
