Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59414A8E
	for <fstests@vger.kernel.org>; Fri,  2 Jan 2026 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767390357; cv=none; b=hLVMcS/ng4N2+P1FUz4fJXBEaWiSUSOHTyi7oGifL9+46rZlVxuSlCq2apefeYq/U7nxSvisGD5IwWXVfixzybfh7OdKWigqvn79IPWWoAptm+X87wRvl7N4RBibPh9Bd4xPuEwuoTK/85KdofCv5wg/m9Jzva4mrkPPG/KKdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767390357; c=relaxed/simple;
	bh=ay0+VCfIGiV6VAnJzeZiajX6h3KStSZOWSVQfx3fB+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqCEjk4MVHzek6Vp4NcYvDF6MoOzb8teLxRBeZjKkSi+v5hgv0Z5x46gvxp1stp/gRw6dv+h5lG9Z4VqIL2iq+bPWZZBHPUdQAanRr5sQPVQ9+/t09WO9bOIUgazXrDqK5xlkTITzdeJWO75kVxiffj3nIBPFPjPqiOpmBf2u7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioC+Hj33; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+OG+Um+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioC+Hj33";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+OG+Um+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767390353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihscdTREmVcqCJdlta1n4XcJxQANmHjnRKDRYJhqkWc=;
	b=ioC+Hj337R82uR2IRo10QX4Zr4UpfbzFCwskK8y+LQwMcFgTgUCVjfdHL6s3nzZHd6ugfc
	Kvr1Z6xLBjlRIUkVkT5x7e28G2qwoFV0NEP4ZxgInlUUhcta1jHF/2T7RheAsbgfy/Ow6v
	s83dTbWqSUn06Amez5HnfoNk4v7qXjk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-l0zPD7uSM-is_9zyIyPCwg-1; Fri, 02 Jan 2026 16:45:52 -0500
X-MC-Unique: l0zPD7uSM-is_9zyIyPCwg-1
X-Mimecast-MFC-AGG-ID: l0zPD7uSM-is_9zyIyPCwg_1767390351
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1f69eec6so155226555ad.1
        for <fstests@vger.kernel.org>; Fri, 02 Jan 2026 13:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767390351; x=1767995151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ihscdTREmVcqCJdlta1n4XcJxQANmHjnRKDRYJhqkWc=;
        b=C+OG+Um+3mF3BmaIgExJ5YMIbqZZAflhtpgx0wRyn50rC93qJAv5t0a3JZcVSJFn8O
         OFS+zg9SALpdolxC+jotEg1VSy7bvQQM99Cf2fkOzK6/jQuATFXU/oGEFT/cSB63yh99
         VuTnsRXmad3luftCGSa9LiKDWmgso8rn29c4zUckcvjXRCDEti2esqSZns38xHVJmife
         en/3ljoy5ubJeHA3ZC1AlV6JTpqhTlTudSj1rNBtqNgmYdamdQH+M7EagDsNfFL2nhoc
         3k+glURUS4XZllV6HicunFTbKP67uzdxEw7Eox8iTB+yPy2z0KWz6O+MX2Hi6htZ57yQ
         7/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767390351; x=1767995151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihscdTREmVcqCJdlta1n4XcJxQANmHjnRKDRYJhqkWc=;
        b=JiAc4rIwhBOFjgH8/kX/dpjffQeEN7UHqMBqP/Q6DlWYv1b78SuhEJQ7VOf0aQlZz2
         as86kpkJ36HjO+rDj1Wf68BayYYaTRRv6AfsZAaWvFrbjragCofD8S1DPsN7bHn8EoIN
         f+J7Pgs73jlp95TctsXBrLSb05yVADRTiZ/rItUo9u4cHTVQbPeCz1R/EkrDcFk4VaT9
         aEFoVTjQGwy5BiyYLDxXMzGPCeiK/V9o30AJ81Yxm+a0Nb+Z3A0W8M8/Lmu3c3H763eZ
         1WMIM6CXeRH/6l7BtYd+3rzjijd3mehbRCE4u+OooLTWeP4U0n43btvG6k32Oc726W9d
         yBBw==
X-Forwarded-Encrypted: i=1; AJvYcCVwzIoYO7SGLv+bvF88vaVEeiX6kLCGjxbsXlHaahFyfHzV4oDX0H5azG5TPrbqtYy4lh9QYAsb@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSHOqCrgpJwEChYtWOy6O0o/6TJ2DaoHZ0kdQsT5YWLeThgNB
	0NYM2dOnUnXVh7lZaVmz0dBGSDHZQ3wPVvZcShPI5EKaJu0zG0+QFz7TAlEJLHYLiNbOl1aDA5h
	g7Zacfy+46i5jiir0McyEzCHtFVeoPvmZ7TSY1zr4GW0rVgzNXW1jHQuLDu0=
X-Gm-Gg: AY/fxX5I3o4bT3IFCerZj5fzqMFqHfYjHTsVF1p+5eZmNOU/+f1/bMwGeeTOZrWpvlQ
	NXlBvWecf3RpTTKQNNlP4zskxBWNv8lVlF1tYoqmXb0YmHR1AFxXzWGbGv7YsZTzgVPsGmMT/JQ
	2Xd4PduQge8YQ0WZD4PoA+/dYjJ8EZhTFLe7l02+z2qkfTlDM9rQ7m8w1t2uar82+OXj7mNo9Ck
	fwyHlJtUZ9spinVsbnJ8Lqdq32j+dyd0raMy9drUVxoHvH9xdRG842E9HlVkVuxDgU+cWAG68uw
	0b7kbaWCZuVbnUJd2I1nR60p3ecPoheJe0A2WzkGceifRLFeOaiXr5dChOPiK6TfDhXKpqWl4iB
	ajx3sDv4/ODxneKYrPg6CkQ0DlEhFgOKnsQ3m/rmEk9LfF8BDVg==
X-Received: by 2002:a17:902:c950:b0:298:33c9:eda1 with SMTP id d9443c01a7336-2a2f2a34f5fmr419880865ad.43.1767390351172;
        Fri, 02 Jan 2026 13:45:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH03jw6wFaW4TxodrA6yHdNkpavCPl+XiRpdeQUdr8fNXFrO77i9Hqyypb0nUXMU7AJunLIcQ==
X-Received: by 2002:a17:902:c950:b0:298:33c9:eda1 with SMTP id d9443c01a7336-2a2f2a34f5fmr419880705ad.43.1767390350606;
        Fri, 02 Jan 2026 13:45:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm384057835ad.100.2026.01.02.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 13:45:49 -0800 (PST)
Date: Sat, 3 Jan 2026 05:45:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
Message-ID: <20260102214545.calxkyk6rec76thg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
 <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
 <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com>
 <20251231194112.aapst4mb6pwgsarz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5muXzz70Bq=20gby=U8w4+cX0n6O5TaBEina=wAbGWN3HA@mail.gmail.com>

On Fri, Jan 02, 2026 at 02:43:58PM -0600, Steve French wrote:
> I could repro the problem by running od command the same way that
> _hexdump() in fstests calls, and I did confirm that on current Ubuntu
> you can workaround it by doing:
> 
> "sudo apt-get remove coreutils-from-uutils --allow-remove-essential"
> (which auto-installs gnu utils after uutils are deleted)

OK, so that's the root cause. You didn't run fstests with GNU coreutils,
you used another utils. I'm glad to learn about a new project named
"uutils" [1], and looks like ubuntu would like to use it.

But currently for fstests, I (personally) think fstests depends on GNU's
coreutils by default. I don't think other fstests developers would like
to make fstests to support other coreutils replacements. Except the
uutils project replaces GNU coreutils totally in one day. So you'd
better to make sure the running dependences are installed properly before
running fstests.

And the uutils project says it trys to "retain full compatibility with the
existing utilities", isn't this output format difference counted as
a compatibility bug :-D

Thanks,
Zorro

[1]
https://uutils.github.io/

> 
> On Wed, Dec 31, 2025 at 1:41 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 01:10:15PM -0600, Steve French wrote:
> > > But it does show gnu coreutils installed ... "gnu-coreutils is already
> > > the newest version (9.5-1ubuntu4)."
> > >
> > > On Wed, Dec 31, 2025 at 1:09 PM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > but I guess they are different packages that include 'od' now.   Was
> > > > "GNU coreutils" now is in 'uutils coreutils' package
> >
> > Anyway, I think you'd better to make sure if it's an expected behavior (output
> > format) change of latest gnu od command at first. If it's, we need a filter.
> > If not, this might be a bug (default behavior change).
> >
> > Thanks,
> > Zorro
> >
> > > >
> > > > On Wed, Dec 31, 2025 at 1:05 PM Steve French <smfrench@gmail.com> wrote:
> > > > >
> > > > > Very strange - it shows version 0.2.2 (while the working one shows version 9.4)
> > > > >
> > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > > > > od (uutils coreutils) 0.2.2
> > > > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > > > > DISTRIB_ID=Ubuntu
> > > > > DISTRIB_RELEASE=25.10
> > > > > DISTRIB_CODENAME=questing
> > > > > DISTRIB_DESCRIPTION="Ubuntu 25.10"
> > > > > PRETTY_NAME="Ubuntu 25.10"
> > > > > NAME="Ubuntu"
> > > > > VERSION_ID="25.10"
> > > > > VERSION="25.10 (Questing Quokka)"
> > > > >
> > > > > On Wed, Dec 31, 2025 at 12:41 PM Zorro Lang <zlang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > > > > I noticed that tests generic/029 and generic/030 and generic/031 now
> > > > > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> > > > > > > issue in dumping test output (hexdump/od). This is testing with
> > > > > > > 6.19-rc2 but it looks like a change to hexdump or od that likely broke
> > > > > > > this.  Any ideas?
> > > > > > >
> > > > > > > See e.g.
> > > > > > >
> > > > > > > generic/029  0s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> > > > > > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
> > > > > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
> > > > > > >  2025-12-19 18:25:13.562003626 -0600
> > > > > > >     @@ -42,10 +42,10 @@
> > > > > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
> > > > > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> > > > > > >      *
> > > > > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
> > > > > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
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
> > > > > > The hexdump output is from the common/rc:_hexdump() helper, it actually runs
> > > > > > "od -Ax -t x1z ..." command. If the output format of latest "od" command is
> > > > > > changed, we used to use a *filter* to help the output to be compatible.
> > > > > > For example:
> > > > > >
> > > > > >   _hexdump()
> > > > > >   {
> > > > > >         od -Ax -t x1z ... | awk '{$1=tolower($1);print}'
> > > > > >   }
> > > > > >
> > > > > > If you have a better idea to do that with a simple 'sed' command line, that
> > > > > > would be better.
> > > > > >
> > > > > > Thanks,
> > > > > > Zorro
> > > > > >
> > > > > >
> > > > > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> > > > > > >
> > > > > > > and
> > > > > > >
> > > > > > >      80 generic/030  0s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> > > > > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -0500
> > > > > > >      82     +++
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > > > > > > 2025-12-19 18:25:14.073196575 -0600
> > > > > > >      83     @@ -4,50 +4,50 @@
> > > > > > >      84      ==== Pre-Remount ===
> > > > > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > > > > > > >XXXXXXXXXXXXXXXX<
> > > > > > >      86      *
> > > > > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > > > > >YYYYYYYYYYYYYYYY<
> > > > > > >      89      *
> > > > > > >      90     -4e7000
> > > > > > >      91     ...
> > > > > > >      92     (Run 'diff -u
> > > > > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> > > > > > > see the entire diff)
> > > > > > >      93 generic/031  1s ... - output mismatch (see
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> > > > > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -0500
> > > > > > >      95     +++
> > > > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > > > > > > 2025-12-19 18:25:14.411496471 -0600
> > > > > > >      96     @@ -6,14 +6,14 @@
> > > > > > >      97      ==== Pre-Remount ===
> > > > > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > > > >................<
> > > > > > >      99      *
> > > > > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > > > > >................<
> > > > > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > > > > > >................<
> > > > > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > > > > >................<
> > > > > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
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
> 

