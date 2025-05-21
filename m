Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA522D7A7
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747794258; cv=none; b=VV3GqdMZ0hR/sRD7QeT0oEkqn0c8fkvAceCV2rD2cTP0JfLG5oqormg03XagH+z1F+iGbJmBYeejxXKPpbiPwJT3odZOiJbwWAZ+WOt2GjWNIfKL60C41OQ2ga1SKR4QeaJ+0aOfB8B9u7mLJ8OApY7CFRjaU4tCNb+PLJa5vS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747794258; c=relaxed/simple;
	bh=sxgqluEIN1mI/idtu2u2O/x0v7CNdNkgoCsr0F6a2C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG5Tus9ZiGtiEEGd3HFGKGtAAG5JQ0vfPCOIgMa007Nx0bUTCZ8Dl7UibaLDI2BY3j5zuLRYZpS6JOPahEwAphLPLEk07Mph0rqRuMPDTbOrLernh7Y3AJb6Dk4YOokpF26QfVZu5jMM2BaVdRDB69Rv12dkiOMJ206XCq/S9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Bu+BbWn0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Bu+BbWn0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e8feb1886so4818594a91.0
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747794255; x=1748399055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ts4XjfqgCtSx6PcwuBwWTiYriuk5L4Ep7FJGTw1KMs=;
        b=Bu+BbWn0GKHGX4ksiMdveoQodG7aNPmgObmbHktyurBWjfMDoPY+5harHWycnoVe6T
         NWwQknh9F5l7ISrPowwKEYzpceFD+F4lSENhNJ1Qy1Qzt2XlG+Omrc/GmbVTmJ0eIgBH
         KcRpPzN/okY3dJL6VilEFdKp6T7sr3CcN6lI4/E4yJbIGCt3Xbr7U0zUK0AKgHw0qCj3
         ALjFaBgPR86e8O8YCUyc8Oh6fSaSxbDzUMKRCy2mwE41heObd028imAyibhSvX4UsM0F
         UNe7jEhHNr18CZCV4/+wpmxLuGHWW1oxWyNyQvvEIKXa0SrN9IW67yclgjvQDcdeTfHV
         7uDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747794255; x=1748399055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ts4XjfqgCtSx6PcwuBwWTiYriuk5L4Ep7FJGTw1KMs=;
        b=EdisUhx3wt51fSzfZpk+XEFbbWCSd6dmSwdwH6nyP58usl1b0MotAF5NHxTE3RX/Zu
         S1ubvstbuMAWiFRD4EmWAKdfZNiOjCTbuJIGfZ/7DQXITsvtMebRIXgEg6Lo5T2vINS4
         8dcgZznY6luLNOGIvzycE4kBmAPkhPJUAKI6UuQRP9C850eEiMwXyZbND4+hDTPL+rOy
         4pYY2Gov3rmcEA3p4S83NSE+Eafn5NxiVIcM4XAP9Bh2NwvU1hixhO3/zuuy+3+9nwyY
         kehSvgCp61o2yb1VKDO+CAopT+l8IvWwuz38RXyth3XvA0cxUhyqloMN2Bn0DDjWFsL7
         NV/w==
X-Gm-Message-State: AOJu0Yxz09WGh5BPFMiXPXamNkgDEaowffoNOIhPE/aZwq8IetiN9FIU
	4ZeZR5i3fKRZc8RoADkEN3FY/2RUqeRvJlPiTmXi4toAd9+GIoYElcrP76l81Fds59Q=
X-Gm-Gg: ASbGncsOJ55PgCGn03C1lELnwnbHFs0qeGU7n0T+VKD6XM6vp06SdoZ1T9g7Q02gJ/2
	ZCgOMh5hZe4zDrqwpR83P1X08iAlSOLX81zFYqhqmM2z5K436m+VPkFYUSov9yp+C/Rfh6mD4MH
	pb6WhT6JAffePoq8zjtkBqAobO1F0KAA1OynfD2BwaPgHdFQRtpWDZ4Kn9nEZY1PZqdCYFnUS+n
	d4gKZYKmNcTo7c8qpBMLqiGlqHkInEPlvTxn+oIEe9GeVnZY24KYQsQ59OsJJwds/XE8EXrTT32
	fNEm7cGzY/065bUZX3XeZlC6al6ZEK2AFvjdlJxhX8IKpOVeWMYVFqT9qsNT5FUtP6vi7qvj7w3
	38d2EhpN1ZARAFeq3h80anthFg3g555y83Kf6lA==
X-Google-Smtp-Source: AGHT+IHdLqn9utfh79CMLlETwliB2Ur/nmutH2cbSVOWOaMA9oFF9ce960ibfoGEkf+YDjxAjjJ1AA==
X-Received: by 2002:a17:90b:2c8c:b0:30e:823f:ef31 with SMTP id 98e67ed59e1d1-30e823ff071mr27456579a91.29.1747794254931;
        Tue, 20 May 2025 19:24:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365b159fsm2485103a91.3.2025.05.20.19.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:24:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHZ7r-000000068DK-2RkX;
	Wed, 21 May 2025 12:24:11 +1000
Date: Wed, 21 May 2025 12:24:11 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 26/28] stale-handle.c: use syncfs() rather than sync()
Message-ID: <aC05S9FqdlGCyrVx@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-27-david@fromorbit.com>
 <2cf4c78230559c62ca1be758ec9a069cbcbf8a9f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cf4c78230559c62ca1be758ec9a069cbcbf8a9f.camel@gmail.com>

On Wed, Apr 30, 2025 at 02:04:08PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> > xfs/238 runs stale_handle to create 1000 inodes, grab their file
> > handles, unlink them and then try to open them from the stored file
> > handles.  It takes a ridiculously long time to run under
> > check-parallel because it runs sync() multiple times:
> > 
> > xfs/238        144s
> > 
> > When running check-parallel, sync() can take a -long- time to
> > run as there can be dozens of filesystems that need to be synced,
> > not to mention sync getting hung up behind all the mount and
> > unmounts that are also being run.
> > 
> > Convert the sync() calls to syncfs() so that they only try to sync
> > the filesystem under test and not the entire system. This avoids
> > interactions and delays with other tests and mount/unmount
> > operations, hence allowing both the test and the overall
> > check-parallel operation to run faster:
> Yes, filesystem wise sync is makes more sense. I remember similar
> changes with your previous check-parralel patch series as well.
> > 
> > xfs/238        5s
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  src/stale_handle.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/src/stale_handle.c b/src/stale_handle.c
> > index 2acd4968c..fd8b3ec61 100644
> > --- a/src/stale_handle.c
> > +++ b/src/stale_handle.c
> > @@ -21,7 +21,7 @@
> >  int main(int argc, char **argv)
> >  {
> >  	int	i;
> > -	int	fd;
> > +	int	fd, test_dir_fd;
> >  	int	ret;
> >  	int	failed = 0;
> >  	char	fname[MAXPATHLEN];
> Not related to this change: 
> A lot of local variables are being used in this test:
> char	fname[MAXPATHLEN];
> void	*handle[NUMFILES];
> size_t	hlen[NUMFILES];
> char fshandle[256];
> Is this fine? Shouldn't we limit the usage of so much local stack?

It's userspace and it's not a big/complex program. Using stack like
this instead of allocating memory is simple, fast, and easy to
maintain. There's no reason to complicate the code unnecessarily.

> > @@ -44,6 +44,12 @@ int main(int argc, char **argv)
> >  		return EXIT_FAILURE;
> >  	}
> >  
> > +	test_dir_fd = open(test_dir, O_RDONLY|O_DIRECTORY);
> > +	if (test_dir_fd < 0) {
> > +		perror(test_dir);
> > +		return EXIT_FAILURE;
> > +	}
> > +
> Now that we are already opening the test_dir to get an fd of the
> filessytem being tested, should we remove the stat call(line 42) just
> before this open call and instead use this open call to check the
> presence/absence of test_dir?

We can, it doesn't matter either way...

> Other than this, the rest of the changes look good to me (some minor
> comments below but not related to this change).
> 
> Feel free to add 
> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
