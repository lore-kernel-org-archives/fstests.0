Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5330ACEE
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767210084; cv=none; b=Z8Z98VBaT22rB73SpmR18sJH8DnDm01Adj3QBPTIaDXIOourHaeLl+h2nsB7jVtN0inBztVBqKlyyw96TZ6SIAe+r6f39p3LCFmUfUW94CqnvhQAWpKY+BPgvyviN2MI3+wMcDP3Inj5Rb8OBM+NebJa9WLiuzAehpbt8asY+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767210084; c=relaxed/simple;
	bh=TEBhP9XLU7n3NPDKKIWdO/XDIpn6y9ETv43UPJPGheg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJECEsY61BkRJ7bFkaZwoUlvWeJtKXZkv8c12Dcd1ePqRSxgIqFokTM9MlBpgpqXJfc5cBhK5FV2OVhXSl3tp6DomGh7yrjXsoplJKpcxg86YGWVhNcoWM88p9q2Fg/FfhK11y4JaqAieWAcwh2r6ECyaIHQiR8+TAYlIkRfKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egxSDwQa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiWEx2ML; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egxSDwQa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiWEx2ML"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767210081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kTTQUprv40Ka7f9HokDfXggwQhCjK4qMCI69xsNxCM=;
	b=egxSDwQa4NHOWO0UQzINhWasOxXVveYFvAgTQBLWAbuJvqI18C6ISpG8fxmy5V4wzn5C0x
	R78K4PgMR8p+NOsoU1/qnahPv5jbvMbjUyS0h8jiCi5CjmVSdsmy74dY5H/9UWRkv+t0mR
	+NzI6m2ADzNzxlXmsOGtiMUfH+Lb5qs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-tTt6btOnOTSDiPykWLgJZQ-1; Wed, 31 Dec 2025 14:41:19 -0500
X-MC-Unique: tTt6btOnOTSDiPykWLgJZQ-1
X-Mimecast-MFC-AGG-ID: tTt6btOnOTSDiPykWLgJZQ_1767210078
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0e952f153so363000125ad.0
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767210078; x=1767814878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kTTQUprv40Ka7f9HokDfXggwQhCjK4qMCI69xsNxCM=;
        b=SiWEx2MLRggENGPcIspb/TKuxc3mWVl8OOrAQ4NNQE0D7GClO1ngkSCUQqZoPJg2Qx
         aAhIIVCPz4tZ14Rk45NolW5CV/K2UzE4AKlO/9bwn2iuoyDOBRMBcfQI1/6Bea1M26ec
         Fbn6vKxrRxWwYzOWRYYrTkd5U2FI+fNCbF9CGequlzJc2BDk2viLU1uPILXNeBJ28vbE
         GHG8UGPJauQgj9vVpsgY/zWeTkp8RMpE82BQbl1EokBb2Z74AD5gNblj11CqM75Qzesf
         Ygfxye9nVbLAwtnHOKYaR7qJkvriB9oECct5pgzzGBGHPVn6JEl59R0TXgBRkCi9v8Yl
         zlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767210078; x=1767814878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kTTQUprv40Ka7f9HokDfXggwQhCjK4qMCI69xsNxCM=;
        b=Dii7omjU4acDcgLdBVaRGq0eaN52rzGmTLgsHIXXWPY43zw8T09FKB2K3FonJ8yXpv
         BrSuKGgJ0xzQpG6QlzLauwJpPfcC+a5LgufMAG9W2i49ZIVdf6nJrgFDUfqgHlgspW8J
         aDi9Jp/AllFZ+Kp7+XA6xgKKZZ0mXluGxZxf1ZNo1AVQPQt/HP8C8QTMw8K0bemLevdB
         xuF+plLhExCLk7oGyGqbjITZRol6iUgFnA4g28/VrSFjXfCbCER2lDdk0y/2fuOBD5jK
         rPx1aRBvFNKHqCxAeD0LDVtzJ4zyOVhvacrQJUQzSvBNdJNGUf/z61Ef2+CBXCI5Xq4f
         1ftg==
X-Forwarded-Encrypted: i=1; AJvYcCVA9ThbhN3pit5q7kyUek4llAXnEmbT6f/v1WYtRuo+Cb1SuTWrYjMe5nUHFC7skN6LKMDyZ0of@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMnG+rjhhsvdUd+rgEC6fcmfglhoOmuMkI8MeBICeNIZzqFQy
	BEWs40keay9G0cfFKLlESnpHnY/gEsbvuwT60U3UucqVisPwBAfQ97FvgLPYJLqZL9tKF5oxCGX
	xoTOEsxEyBmoUR/HjXeyad4yp14g7NsxqIDtJZ1NJjsBh+TYx3cpgFJqN7EotuAg2W6U=
X-Gm-Gg: AY/fxX6HDpXdGvji+34+u7Viff22JPOjJKFOhcFGrzCuIn5w5sLK5DzgTD+fZPlOFRZ
	rTKatByxwIFnH60O+OnDTyLlmrXdOop+vhlIkWutcJrTVA0Vmk06sRNX6tT6HvSCEGQgcwnRWr1
	HASByG/HMt+y1T6v6RpBlAgTJpLSaGboVArIRb7PrUYyEZ6HGz7j322VCcbVLSNyE5nwSyzr9Lo
	qG7hy76vDSEFsgNb7iil01EeDkJq8pljRxJTClq+q2yVG60yPNwX3JlEsWbwbalzx+qz25RTBwH
	N08hvZFAD43uyJiDSz48d8Byi8Z5vy6bkuReAZ8WSQJImaD9gRJdvG3iVs/rY1lDRcafA71QNzB
	UNgsl6D8uhR47ikNduLaP8qGza9fZREhH5tQyCmm0FARX61BUAA==
X-Received: by 2002:a17:903:943:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a2f2a40096mr357223425ad.54.1767210077912;
        Wed, 31 Dec 2025 11:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSM4HgYYJK9EK7xMwR3JNRsLl7HRlOdLCOtFTMzym3oXvzmp3I701juihf8FhtWHopqYj8bw==
X-Received: by 2002:a17:903:943:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a2f2a40096mr357223275ad.54.1767210077366;
        Wed, 31 Dec 2025 11:41:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66bd3sm331259735ad.1.2025.12.31.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:41:16 -0800 (PST)
Date: Thu, 1 Jan 2026 03:41:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: upper vs. lower case hexdump vs od on current Ubuntu causes
 generic/029, 030 and 031 to fail
Message-ID: <20251231194112.aapst4mb6pwgsarz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <CAH2r5muo2jWVkqAwnT-NNPpYeA9P6WHq6Jic-g6r3NM3-+eq2Q@mail.gmail.com>
 <20251231184053.taidcweyhrwxleeu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAH2r5mvoeCj8h5nQQm82TSy9MA6yJ1UYVPCRPPFV+BJBYaY_oA@mail.gmail.com>
 <CAH2r5mtr=q3H2hDj5mrOjM5jM5zvSHN0OEQ3MYEt5a3J8wkYHg@mail.gmail.com>
 <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mvq4hKkyRx37gb21QmHBuGjDB5YcUd=YW5jTkk6+X5YMA@mail.gmail.com>

On Wed, Dec 31, 2025 at 01:10:15PM -0600, Steve French wrote:
> But it does show gnu coreutils installed ... "gnu-coreutils is already
> the newest version (9.5-1ubuntu4)."
> 
> On Wed, Dec 31, 2025 at 1:09 PM Steve French <smfrench@gmail.com> wrote:
> >
> > but I guess they are different packages that include 'od' now.   Was
> > "GNU coreutils" now is in 'uutils coreutils' package

Anyway, I think you'd better to make sure if it's an expected behavior (output
format) change of latest gnu od command at first. If it's, we need a filter.
If not, this might be a bug (default behavior change).

Thanks,
Zorro

> >
> > On Wed, Dec 31, 2025 at 1:05 PM Steve French <smfrench@gmail.com> wrote:
> > >
> > > Very strange - it shows version 0.2.2 (while the working one shows version 9.4)
> > >
> > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ od --version
> > > od (uutils coreutils) 0.2.2
> > > smfrench@smfrench-ThinkPad-P16s-Gen-2:~$ cat /etc/*release*
> > > DISTRIB_ID=Ubuntu
> > > DISTRIB_RELEASE=25.10
> > > DISTRIB_CODENAME=questing
> > > DISTRIB_DESCRIPTION="Ubuntu 25.10"
> > > PRETTY_NAME="Ubuntu 25.10"
> > > NAME="Ubuntu"
> > > VERSION_ID="25.10"
> > > VERSION="25.10 (Questing Quokka)"
> > >
> > > On Wed, Dec 31, 2025 at 12:41 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 22, 2025 at 06:33:41PM -0600, Steve French wrote:
> > > > > I noticed that tests generic/029 and generic/030 and generic/031 now
> > > > > fail on current Ubuntu (Ubuntu 25.10) due to a upper vs. lower case
> > > > > issue in dumping test output (hexdump/od). This is testing with
> > > > > 6.19-rc2 but it looks like a change to hexdump or od that likely broke
> > > > > this.  Any ideas?
> > > > >
> > > > > See e.g.
> > > > >
> > > > > generic/029  0s ... - output mismatch (see
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad)
> > > > >     --- tests/generic/029.out   2025-08-22 09:54:32.256748004 -0500
> > > > >     +++ /home/smfrench/xfstests-dev/results//samba/generic/029.out.bad
> > > > >  2025-12-19 18:25:13.562003626 -0600
> > > > >     @@ -42,10 +42,10 @@
> > > > >      000600 57 57 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >WWXXXXXXXXXXXXXX<
> > > > >      000610 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58  >XXXXXXXXXXXXXXXX<
> > > > >      *
> > > > >     -0007f0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
> > > > >     +0007F0 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 59  >XXXXXXXXXXXXXXXY<
> > > >
> > > > Hi Steve,
> > > >
> > > > Sorry for this late reply, I just backed from holiday.
> > > >
> > > > What's the version of your "od" command in Ubuntu 25.10 ? e.g.
> > > >   # od --version
> > > >   od (GNU coreutils) 9.9
> > > >
> > > >
> > > > The hexdump output is from the common/rc:_hexdump() helper, it actually runs
> > > > "od -Ax -t x1z ..." command. If the output format of latest "od" command is
> > > > changed, we used to use a *filter* to help the output to be compatible.
> > > > For example:
> > > >
> > > >   _hexdump()
> > > >   {
> > > >         od -Ax -t x1z ... | awk '{$1=tolower($1);print}'
> > > >   }
> > > >
> > > > If you have a better idea to do that with a simple 'sed' command line, that
> > > > would be better.
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > >
> > > > >      000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59  >YYYYYYYYYYYYYYYY<
> > > > >
> > > > > and
> > > > >
> > > > >      80 generic/030  0s ... - output mismatch (see
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad)
> > > > >      81     --- tests/generic/030.out   2025-08-22 09:54:32.257748640 -0500
> > > > >      82     +++
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad
> > > > > 2025-12-19 18:25:14.073196575 -0600
> > > > >      83     @@ -4,50 +4,50 @@
> > > > >      84      ==== Pre-Remount ===
> > > > >      85      000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
> > > > > >XXXXXXXXXXXXXXXX<
> > > > >      86      *
> > > > >      87     -4e6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > > >YYYYYYYYYYYYYYYY<
> > > > >      88     +4E6400 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
> > > > > >YYYYYYYYYYYYYYYY<
> > > > >      89      *
> > > > >      90     -4e7000
> > > > >      91     ...
> > > > >      92     (Run 'diff -u
> > > > > /home/smfrench/xfstests-dev/tests/generic/030.out
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/030.out.bad'  to
> > > > > see the entire diff)
> > > > >      93 generic/031  1s ... - output mismatch (see
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad)
> > > > >      94     --- tests/generic/031.out   2025-08-22 09:54:32.257748640 -0500
> > > > >      95     +++
> > > > > /home/smfrench/xfstests-dev/results//samba/generic/031.out.bad
> > > > > 2025-12-19 18:25:14.411496471 -0600
> > > > >      96     @@ -6,14 +6,14 @@
> > > > >      97      ==== Pre-Remount ===
> > > > >      98      000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > > >................<
> > > > >      99      *
> > > > >     100     -01f860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > > >................<
> > > > >     101     -01f870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > > > >................<
> > > > >     102     +01F860 00 00 00 00 00 00 00 00 00 00 00 00 cd cd cd cd
> > > > > >................<
> > > > >     103     +01F870 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > > > > >................<
> > > > >
> > > > >
> > > > > --
> > > > > Thanks,
> > > > >
> > > > > Steve
> > > > >
> > > >
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
> 

