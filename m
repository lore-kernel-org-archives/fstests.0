Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8525C80A
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822644; cv=none; b=chTNRq0SirqQB0ycLeboKRgIjOHky62DY3QTDkK8nbKFNFgRvwbEcquyGwpiO9CZGpmQ877aEqyuQCN2ilrDhz3/mYzFAYR5UHPVvRMEAzg3LVCW5lSj2zl/L455sA0M3VZL7dVVrze4jD5q9BbxZORLiNuZ+EeHAbsT6KXhMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822644; c=relaxed/simple;
	bh=y8lKonV/JfYNNJxb/tLVGpy85TJU4tHSQqnKdGwXK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj+SJZ6hjQPXmbFAO20BxswsXNiqnC13CG0Uvkqj+I7+BoWFR2HXZk030uNtZa/0n8L2cGAPC7SG10vNk4kth5fcfUIBlheqECd7OXAvYkL8amxFSK+5ZNGStbJg9ZejUIClfe0rLzlKKXepejmOlMVczTA15Bfq6BZ/EIRoCzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cD30AUwU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cD30AUwU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e16234307so59882385ad.0
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747822642; x=1748427442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfnuPbNiIhfZ/9//yZv2WC+t3EB1iwzehsEu/wOJpsM=;
        b=cD30AUwU/K2sEdSz5AmAHGVKCaFknzpUhS/NONDwZ6eocql6EsX3McL+0AthbvoGcR
         PNZUk8f7/j7b1j443OQFf3kR0fXi5H6FGUy0uqCqwsBg295NwS/G1+Gdb83D5hhVn+u3
         4GYQ+cvCzK/AcmlGxSFqz9JHVeAbNAO9yY8QQnNRp85RtccCsTenHXACe8f+p4G52zn/
         Ru9mybGlyRG78jyDT6U8T5tMEyIXrxWixQ/LqqXcP2kpI1x/2lXNN/y9LCIyJijRbK9u
         4T1qof4v1S6EfabcmGZwCXq4ErpjSyXoDp7wvZWNOTsnf34SWkeYtNSgAjAgUEqVM2kg
         JLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822642; x=1748427442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfnuPbNiIhfZ/9//yZv2WC+t3EB1iwzehsEu/wOJpsM=;
        b=eaiAYs9vU6AWo57YQYZhRO6cdKyM0yfYChBZJmsL0nlRdX0b7TLoru96iOhPoVV/aA
         lumEvFJHTYFWXdrkDoPoTSWOoBTDzOCqo/utzbgqdut4SrwwlDXJz/fPWwxqETXmkQnm
         XoXRVNFBME80xyBBDUn6t2j0cbnqUW+2tey9MUxVl/Uavp0TZMoglLajQSHz1kcK7H8/
         F9JvO6AWVI+zjN4VaN3HGKVZQ5qVI56/JQZrIQsK0C7cY/+7SOyIcbyYPnWkTV1mnKai
         SCOu6WjHg6sJ9K9PXQN7p0y2ulY1IstokvTMndLjPgpyEbOyAnld1QSEEDQEcaa+ugNz
         3aOg==
X-Gm-Message-State: AOJu0YzByA7xspIINpPNbs8ovC7Xp5GUJS0lNKSlqVJirp54TYKOpFhO
	rKyKFtSzOMy7vbDBp6J8gJCtmvg0mx9jJTnrH4ww8S6CNDP+7ZVkGd2LtrLdNqGWyt2idlsIv8N
	9w5L6
X-Gm-Gg: ASbGnctUR3ruFma9P3ja5sZ0LyjDyd7pULXIoegA1EK30rIjaH46WneSeaXSza1bY0E
	E1vNeT4N5TYivbKvbFTiL3Ix0gyVWUXrXV6xFxLM7or20O/fp1leG4tZ2Md3zT5sayLzvGt6IM9
	llmL17hck64nFXitcBDCuybwBTwisoq9sdTEz5Hx4Y/2FR3HPg3pOvvXCSFZ4fY7Jiy27euA52q
	dT+U13zP0+3OdqAYM1VSDAoNY8F8H1VI3A3wvvZ7K/l8iJBDqgUVWpo7VkraDQud6dDU1koXBjx
	W00Yf/9wI9+qUg6TRxcVcx33rVrRcvGjrFBtPcllMCrhjivWcOUd5gL/7JPFrmKD/kKzyOzcD1i
	45HD4bh6fIWDl5k2Cc07wEVR9YkI=
X-Google-Smtp-Source: AGHT+IHJ6ZYhmWGuD+du6uc8kxas/d/0TohKSzAnW2SY+thvyOZdzlIT1R6ZndI7v8o7qCKfScoxsw==
X-Received: by 2002:a17:902:d4c6:b0:231:eb7f:107e with SMTP id d9443c01a7336-231eb7f1265mr263075775ad.22.1747822642513;
        Wed, 21 May 2025 03:17:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac959esm90437925ad.33.2025.05.21.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:17:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHgVj-00000006GeN-2DwJ;
	Wed, 21 May 2025 20:17:19 +1000
Date: Wed, 21 May 2025 20:17:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 09/28] check-parallel: allow FSTYP selection from the CLI
Message-ID: <aC2oLzBppRVtLwV7@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-10-david@fromorbit.com>
 <ed42bdd1d43dd856978e8dea5b6bbc736e182d8a.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed42bdd1d43dd856978e8dea5b6bbc736e182d8a.camel@gmail.com>

On Wed, May 07, 2025 at 02:19:31PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Add a CLI option to specify the initial FSTYP to test. If this is
> > not specified the the default of "xfs" will be used. This option is
> > different to the way check has FSTYP specified as check-parallel
> > has no infrastructure to support non block device based filesystems
> > and hence we have to reject virtual or network based filesysetms
> > are this point in time.
> > 
> > Note: This patch only implements default mkfs parameter support for
> > the test device. Config sections can be used to override this as
> > check will then format the test device when the section that defines
> > non-default test device mkfs options is selected.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  check-parallel | 44 +++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 37 insertions(+), 7 deletions(-)
> > 
> > diff --git a/check-parallel b/check-parallel
> > index 5fee62f37..19f2d2b0c 100755
> > --- a/check-parallel
> > +++ b/check-parallel
> > @@ -18,7 +18,7 @@ run_section=""
> >  
> >  tmp=/tmp/check-parallel.$$
> >  
> > -export FSTYP=xfs
> > +FSTYP=
> >  
> >  . ./common/exit
> >  . ./common/test_names
> > @@ -35,6 +35,7 @@ check options
> >      -r			randomize test order
> >      --exact-order	run tests in the exact order specified
> >      -s section		run only specified section from config file
> > +    -f <FSTYPE>		specify the filesystem type to test
> >  
> >  testlist options
> >      -g group[,group...]	include tests from these groups
> > @@ -66,16 +67,39 @@ external_file argument is a path to a single file containing a list of tests
> >  to exclude in the form of <test dir>/<test name>.
> >  
> >  examples:
> > - check-parallel -D /mnt xfs/001
> > - check-parallel -D /mnt -g quick
> > + check-parallel -f xfs -D /mnt xfs/001
> > + check-parallel -f ext4 -D /mnt -g quick
> >   check-parallel -D /mnt -g xfs/quick
> >   check-parallel -D /mnt -x stress xfs/*
> > - check-parallel -D /mnt -X .exclude -g auto
> > - check-parallel -D /mnt -E ~/.xfstests.exclude
> > + check-parallel -f btrfs -D /mnt -X .exclude -g auto
> > + check-parallel -f udf -D /mnt -E ~/.xfstests.exclude
> >  '
> >  	    exit 1
> >  }
> >  
> > +# Only support block device based filesystems with generic mkfs support
> > +# at the moment.
> > +is_supported_fstype()
> > +{
> > +	local fstype=$1
> > +
> > +	case $fstype in
> > +	xfs)		;;
> > +	ext2|ext3|ext4)	;;
> > +	udf)		;;
> > +	jfs)		;;
> > +	f2fs)		;;
> > +	btrfs)		;;
> > +	bcachefs)	;;
> > +	gfs2)		;;
> > +	ocfs2)		;;
> Extremely minor: Maybe list the test in alphabetical order?

I copied the list from a case statement somewhere in common/rc that
was already in that order. I don't it's worth the time and brain
cells to order it, let alone require anyone to maintain that order
over the long term. It's just a simple string check....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
