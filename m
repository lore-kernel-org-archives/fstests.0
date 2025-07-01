Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C2241CB7
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411986; cv=none; b=AXzZUmQmFTPTE0O8AbV+TvkNeFPcKdRZ9Uq2UsMMcMZ6Ci8t8s3EFDdpjKq1Q3y/EJJk5jeKaBjEo52PNx7rMXQEE6BFTUNF0+KvxSyKdAqiOcbSvSvcabXBIECtg/6tIpBxrNjc1blWiRtfgtyURxKcQoDVS1XFFIncdRWnPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411986; c=relaxed/simple;
	bh=L4jnORSIn9OGJAUIAFa+ocd3bjyL8SlZBhk71Re5zO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=As3zS0EosbRktc6r7GnzmMwhZ08WEwbvrClBYuBNDm/5bOII4vfJXR6N3m/1Z8S2oz0FTzPbvzh8R4WikFQ9iezTgx3KIgdYyziuXhLS1jZ7ZqQUlg42uAPR7KjOXLIcHHUmFXqPPQGkl8TGKNHGz1hw/Usr03LFdKc8ECE6RoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAAbD3JT; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAAbD3JT"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fad3400ea3so56588586d6.0
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751411984; x=1752016784; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjBVDWpuvSEy3/dtjwop0nID6wOC7zTXvrLlXFYZZGk=;
        b=RAAbD3JTYKbfcjASgEEP++nYIjAiEfE77JZssooU7NN8a5vNnLvbAynxKI4J+P298d
         2OoKJA7Ux1uPm6oviYM7UgCHl+3P3apS/qbFdAfItaVjKlKCG4XUDpjOK9ew3uu6eTeA
         vHdVwF5mVK6vQAnCwIYscFXuB0VQuF8ZbUW7K5hRrwaY3G2+I1cVrUrd4k1DPL0FX9hP
         AWlcsGBNoznflOt/ca1ZBYeiyAr5J6Da481y6KQPvK2DygoBj6fE2XKoZ8pJxYGh3Yog
         AD3rZ7sezczGRnZqSL1yyq2o8wIfbkTmTpP2+yNF/ZYVOLtSHodCMqv8W1o4KdnZmsGX
         yi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751411984; x=1752016784;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjBVDWpuvSEy3/dtjwop0nID6wOC7zTXvrLlXFYZZGk=;
        b=L3HzjnhhcoRZR18t/qM9Mgh/zuho2+rF6VHCaL3SdKfaNQHV9fJlR79/PayXEUyyAJ
         xy7JDTDSNhnf02Er20MQsyA0hU3PkpwloelUamq4OBZrPu+vy7wcd8dA7SIoshqig7EZ
         dY1NkTWXG2LUe/Vx8w2vFo2LVyUWQh3Q5K/hUR9JnIchwKO47WlsJ41vdGrWUwefbwHZ
         tu1EbNKu4FX2mg6msRz86qGAW29sLNIdgXONBgcdtCLrD1fX8iP5fiPLpBPEBeuZb4V7
         J8m+V2GDoD8os6OFOE8n2OsTkEzu3M9wdkjeDw604626spQ1nIgoeZWW34w3Yo3qKSxB
         bm/g==
X-Gm-Message-State: AOJu0Yy7n0x2SF4S6kg9UAYjSLFwclfDPNcHBJk4qpdnw6EbCOpY7S0E
	/HhUTHPCuqcTDQ6olfuOsO2g3x1CP/v4yAZ2ChEVSVYwN65kUWaLxO2l0vQc9+T/7n0B3+ZEJIO
	fI4UAAhOeh9Wwx36GhrBEyBOX2IAjYWfM0w==
X-Gm-Gg: ASbGnctRUUNlQe2oFBZjHWMJdjBBZQvQQ1hXgk9xcSAruBjutKekuFZte2W8hUO+p3Y
	GwrUh85DqRsAFeWPwLIbzQbqR49P+X6XtuL3muR9W4jVnPjQQdWLb7Zqy0ZzBDDKLpbNfkq2xzL
	6aRXk0ZQI3eAHJzn/RfkGBnQV1ksEqVH33cu0HqA9/YMXcApyE+4CSD3QVMmHp+Se6kdkM/RiaF
	XiR
X-Google-Smtp-Source: AGHT+IFx+VrEdfp1vNG3+qrSpyywEVUjc6lcd0ltxvGkNuzO2keqMTIK4xFLsTgzs7xeSZhWX18rV9+LCQZVzBtiNsE=
X-Received: by 2002:ad4:5968:0:b0:6e6:5bd5:f3a8 with SMTP id
 6a1803df08f44-702b1beaeb6mr6323396d6.29.1751411983885; Tue, 01 Jul 2025
 16:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msYMeEaaKKT1mEG7bCjFYExFCRUdL6ShimoK0g1AEdERQ@mail.gmail.com>
 <CAH2r5mtrM0_+x2jzxoRoNq6c3e5rS_7s7QT-=S5fDA06XoFNvw@mail.gmail.com> <CAH2r5mvE0R_npJgiA2+OuDHwa60EGxeC=LU7Z8FDA0X_AFYeNQ@mail.gmail.com>
In-Reply-To: <CAH2r5mvE0R_npJgiA2+OuDHwa60EGxeC=LU7Z8FDA0X_AFYeNQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 1 Jul 2025 18:19:32 -0500
X-Gm-Features: Ac12FXwU-W8aUoqXdTqOF9MvfB5aehyzX2twr8g1OPsBhGz5IGvxHzKlbV2-Cs4
Message-ID: <CAH2r5mu2Y41qW14CiRde_hqeVvy=-mSnOR8XWvQF5ChN1M+BYA@mail.gmail.com>
Subject: Re: Build errors with current xfstests
To: fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Must be a problem with debris left over when updating the master
branch.   Works now

I deleted the repo from the local system, git cloned again (identical
master branch head) and it now built.

upgrading the branch must have had problems from old files left around

On Tue, Jul 1, 2025 at 2:40=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> nevermind - was on the wrong branch.   Now on updated master branch I
> get a different error, will retry on current for-next branch
>
> Building shared
> gmake[3]: *** No targets specified and no makefile found.  Stop.
> gmake[3]: *** No targets specified and no makefile found.  Stop.
> gmake[2]: *** [../include/buildrules:31: shared] Error 2
> gmake[1]: *** [include/buildrules:31: tests] Error 2
> make: *** [Makefile:65: default] Error 2
>
> On Tue, Jul 1, 2025 at 2:23=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
> >
> > I haven't had a problem building it before on Ubuntu, but perhaps due
> > to upgrade to Ubuntu 24.04 this line in acinclude.m4 breaks (which is
> > supposed to set HAVE_FALLOCATE but won't if this line fails).  Any
> > thoughts?
> >
> > #include <fcntl.h>
> > #include <linux/falloc.h> ]], [[ fallocate(0, 0, 0, 0); ]])],[
> > have_fallocate=3Dtrue; AC_MSG_RESULT(yes) ],[ have_fallocate=3Dfalse;
> > AC_MSG_RESULT(no) ])
> >
> > On Tue, Jul 1, 2025 at 2:15=E2=80=AFPM Steve French <smfrench@gmail.com=
> wrote:
> > >
> > > I am getting the following build error with current xfstests on
> > > Ubuntu.  Any thoughts?
> > >
> > > Building src
> > >     [CC]    iogen
> > > iogen.c: In function 'create_file':
> > > iogen.c:996:3: error: #error Dont know how to (pre)allocate space!
> > >   996 | # error Dont know how to (pre)allocate space!
> > >       |   ^~~~~
> > > iogen.c: In function 'main':
> > > iogen.c:280:9: warning: ignoring return value of 'write' declared wit=
h
> > > attribute 'warn_unused_result' [-Wunused-result]
> > >   280 |         write(outfd, (char *)&req, sizeof(req));
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > iogen.c: In function 'parse_cmdline':
> > > iogen.c:1535:17: warning: ignoring return value of 'getcwd' declared
> > > with attribute 'warn_unused_result' [-Wunused-result]
> > >  1535 |                 getcwd(fptr->f_path,
> > >       |                 ^~~~~~~~~~~~~~~~~~~~
> > >  1536 |                        sizeof(fptr->f_path)-1);
> > >       |                        ~~~~~~~~~~~~~~~~~~~~~~~
> > > gmake[2]: *** [Makefile:51: iogen] Error 1
> > > gmake[1]: *** [include/buildrules:31: ltp] Error 2
> > > make: *** [Makefile:51: default] Error 2
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
