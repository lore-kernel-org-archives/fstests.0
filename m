Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86338DDCD
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747794771; cv=none; b=cpiZ+yTyr/lquNtkJSffxahjOZVd/khm/t4YiI/TmiZbm/qwiMp58jqu/i5LHYLiWiRi7gZXUW4UBJaXVxLHSj87FkKHC60ghEORPSOwftxn5ARM0+CfxjW8sKwzu1qTM2KFPw3q2lCcqWRzGr9pIsh+NmVOXzv4ZCSyvOoUxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747794771; c=relaxed/simple;
	bh=2QOp7AgGznEUgsqt4F5LwEuS8JtoHpU2wfH5dnd98OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNqnws1x5Jz5L1UaLQLaRvEfZ8pfEb2Ky3eAuZZDfAmQYBGDDiv+9Q9l7/r3/p3a5Jr3K3mTyKxcO3pGCAvp/cRjF6eGz6ENK60NBkC5H1DZ1z1mA+4qd4hFrc8kgBcbF6SW1mFxhZeS2IVywCU6TZrtrjGgfNB9YVRiI3iHA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eK+MoxJO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eK+MoxJO"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e7bfef364so4754543a91.1
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 19:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747794769; x=1748399569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ANSidj25I2Oup5Tv8VrXxpbmPeV228ChN5jpItUf2c=;
        b=eK+MoxJOZDzc6UMOi7kKYicEKtOe6N1WHsWq8q6QQeuEoH1ToVbrPJt6xCW04QJxwX
         aM3wd6Hl9UL8d9GPtvCS8psGr26/sI3s2oqUDKiIg5KgJix+Hgj9Va2QV6eS33cMm977
         Kvf83QcEiMrZCo+4SAXnFGR8gJJDl3Su0edzjqIMVkq52htaEZXHwzQwJDzDtXbidA9F
         RB5Nk2moxl+drL0O/kpNcP5F6/cxMwMWBuLlavGqEG2jhqSALDGw6onL3MInDGABT3F/
         YtFTxHmB0CHY4Qfjtf4aWYE84NKMiMH5mElkERoNwrZNba6Je1EwvO04IvbriPqUvKyj
         BSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747794769; x=1748399569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ANSidj25I2Oup5Tv8VrXxpbmPeV228ChN5jpItUf2c=;
        b=Tmzux8W559zyeuDC+luZ5jystLWNx6zkdGg6A5HXGk40i2KJWWBmp/I75ONuellNw1
         jZfj/z1I30S3D76xmp3ecLszzQxKTANUuNgOpTkIVPY/gRuTtw/9SAO7Qo3q5nWfedqB
         d2WBuaRkp8jHO5nGVGoKohii3yz3hU0DmCkEW9++01VqMDl13TPu4c8se0bVMY2y4XR4
         +vUu5jJgt/kVXP0gJIGh1u8NUN8EToipup24ZW5JJgZAYK/Ceo+a3qOQF5+4zq6f0Kwi
         V0Y/CXUlfY5VbBmgZVNrT1qgC5mgLFhPgBNkvMHTepSJWdjqfHooxisQrIHSjDJ72Xij
         g4SA==
X-Gm-Message-State: AOJu0YwGmrTOgifphegXtEhFmeryPZO0zXtXF/PbnloWf2WtJSirmOTo
	Zt+DcRF/PtM+7ojLWFQu5Eb1++N+/oawYv6gU77xi83JEpRO9Vn+a9O3tPeeUVhlYex17ePa8hR
	QXLzm
X-Gm-Gg: ASbGnctk0HE16sxPLg6OxTMu1SCxJTPtkjGvXumuV5lKvUKizOIDae5yDL+RrENmQ2O
	Rwis4qvzgFMzwNyP64qz8WaxuNpirz5XSJ0EFxJ42TyveevUbfFucXYS7SrVp2CR4qUROZg/H83
	l+rqaT4Ekl5dRL9R0Q6aDrVZzqxZF+/gCLjxJbpdUpNT/7Re5FSz7mBOZT+/XopY1HVBS2Sqivv
	MDJ2ylN0/zsA3Q9+BSb5AJ55bVKnWqRUFGizOWE2BCi1QJFJHGexdoEMEdC2mOZiG1uvREJi8nN
	Dp6Vjxm+b/m2Ik19vz31YFtOdhsKD8c0nVv42Og4xN/uRoiEea2zDyVBmSDXZeLbOVCg0hyGkGg
	J09TPrNXHFuecGV9c
X-Google-Smtp-Source: AGHT+IFJdW19MLvxmzSiVnj88WWtnqVYk2ckR2Wg+jPOcJJ8ehsAngsHMIwZV78ZsOHUvE/tYXKgyA==
X-Received: by 2002:a17:90b:1dc9:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-30e7d5635a4mr28403437a91.20.1747794768548;
        Tue, 20 May 2025 19:32:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36513bb7sm2501993a91.46.2025.05.20.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:32:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHZG9-000000068WW-2UKq;
	Wed, 21 May 2025 12:32:45 +1000
Date: Wed, 21 May 2025 12:32:45 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 23/28] open-by-handle.c: use syncfs() rather than sync()
Message-ID: <aC07TfBnIPnDNrQN@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-24-david@fromorbit.com>
 <15e09df3ecf75b4b7da58fd2e00d5f72aab2d493.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e09df3ecf75b4b7da58fd2e00d5f72aab2d493.camel@gmail.com>

On Wed, Apr 30, 2025 at 02:32:33PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > generic/467 runs open_by_handle at least 15 times. Each
> > execution runs sync() at least once, sometimes three times.
> > 
> > When running check-parallel, sync() can take a -long- time to
> > run as there can be dozens of filesystems that need to be synced,
> > not to mention sync getting hung up behind all the mount and
> > unmounts that are also being run. This results in:
> > 
> > Ten slowest tests - runtime in seconds:
> > generic/467 442
> > .....
> > 
> > This test running for a really long time.
> > 
> > Convert the sync() calls to syncfs() so that they only try to sync
> > the filesystem under test and not the entire system. This avoids
> > interactions and delays with other tests and mount/unmount
> > operations, hence allowing both the test and the overall
> > check-parallel operation to run faster:
> > 
> > generic/467        6s
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  src/open_by_handle.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> > index a99cce4b3..816bb5d12 100644
> > --- a/src/open_by_handle.c
> > +++ b/src/open_by_handle.c
> > @@ -430,7 +430,7 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	/* sync to get the new inodes to hit the disk */
> > -	sync();
> > +	syncfs(mount_fd);
> >  
> >  	/*
> >  	 * encode the file handles or read them from file (-i) and
> > maybe store
> > @@ -563,10 +563,10 @@ int main(int argc, char **argv)
> >  	}
> >  
> >  	/* sync to get log forced for unlink transactions to hit the
> > disk */
> > -	sync();
> > +	syncfs(mount_fd);
> >  
> >  	/* sync once more FTW */
> > -	sync();
> > +	syncfs(mount_fd);
> I don't see mount_fd being closed at the end. Maybe all the file
> descriptors are closed after the program finishes execution?

Yes, they are closed on exit. Again, simple test code that isn't
running out of open files, so there's not a lot of reason for this
patch series to care about such existing issues in the code right
now.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
