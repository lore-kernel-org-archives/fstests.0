Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF32609F7
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825924; cv=none; b=ET0iUq7gFNxECuF7AG7LYvGFUSA1Gmz1b2FWstnrvuDMhKT/qJo4EiuO1VDU9jlZmkEv9O8RpPH7flf9jKFaBIblhHCrxrTGw1ub49r2FygcBynR2KQf7IgqJzH2L7Pi4hbLoyYV3MtUrZ1HIFyge7ZEIVA4vPMIuYRNhWVU0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825924; c=relaxed/simple;
	bh=IKse9UHVRnYETfk3Og3Gu4YAgLm8PQfT8lF88hYyozE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeY+2RmLoabQ/G3pAeZ0ExFp2zoi8j+PedxjaRJcpzEnoc/SjoOhCxWs2fNYrTzazbofDWpaSS3J6aukka1A2Q3Iu9Oa0X0Lahu3THY53BGxPdi+3QVL2tgCmSjCCDgrbDgid47wp1qoGnykL+ioNeunX+o916kaDPyhPVxkbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XyxbQRKD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XyxbQRKD"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2322bace4ceso31773395ad.2
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 04:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747825922; x=1748430722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pyYtUG/KhjOFhf1N47v6k8076JDeWJpJa2SG/bQ1OQQ=;
        b=XyxbQRKDwNWui5z4kcn8VWBS+yBdHyUUqxb7hzNkDPhF6887Lq4ai8ezNkIMIH0uFk
         uBSnC7PGUpgTmr8D88et9TI4MblrYP3wIubZbykRFg02qTGJ94ZLu3JwFlmyaAiAmjdd
         hTWec6UD6fEhaJBRzv8vSXJ9HIzqC3RZ9krQlE9urw/kdfIonPnrl64tzatONlVivV5z
         fvZt6+pFbrligQ7YvQwTG/2MO23vImqqlIyNpwTjL4eO5SOj6LSRfYSQ+VX5uTEnk8nY
         LnW8lu/zMHVT40v1/8QvxYYZG/ADSznk/Ac1tL1lVsSHqGLPkMHCtWF+TY/mt3nKwcnR
         zWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747825922; x=1748430722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyYtUG/KhjOFhf1N47v6k8076JDeWJpJa2SG/bQ1OQQ=;
        b=K1YuumM3y9mW9Wme2ILLv2j2pso0ur/gdIXrTXm9Fa/C4e58d8ZA19ZIQD82CqjBQY
         60WqKX7JNjmL2cysEuup+49JQrGBH94YAizGZXQVjC5P7kqAleeDKMMRkh2iKlOI2ZPQ
         j4ljPXOnrK6kthE4XeFIvhR3lEmFH6j+l0gxapJUCg1RJwhVzccr58i96lNVF2pC4cNz
         rZ/Yo28MbiJEH5ww3EGTmhZ3nvqGlwBvBa06RUB2+2CRZRg/fglVmGCVn2xJweIXY9g4
         g63OsosRor/oOhiXVRfgsLA9zLsv5b3lGMeGUOFMDMZwKwhjzH2+/tHkbOrb6+H5ihag
         V8xQ==
X-Gm-Message-State: AOJu0YyT80GieyH70w7Xh4Pbc0iqgT8Xy/p4RRbVm2u5R0FTJug2y3To
	opzC26nB8A359qQ2UpyWLdZxlplAPhH1en+/WxOJ/uMMS/8GeGc4TeHoGF6oml4ZrCM=
X-Gm-Gg: ASbGnctafLWjQImlxV+y2UWRiLUThEhAwuz5/hZ+dFWpqbixcKLuVTkcqQ1XVnT4z8o
	UGgLAH9E2I3/3QnVxl4EjOs79v8dTEUC6WrOFoYFtFl7M0m9/hWS/gUh4k+1mW/ElWfGVbkinRI
	BZxE2OQBzzgiEZI7b+KcdN/dnPDq9M8jALeIagbbwBwkNMHNei/Yu3+h+3hccNTZpJka604CIaj
	/o5yqM7/OJo38zIkoLhmGAjCydp1owCtn7DzIElnegZa5lP9s2X2B39thUuQc0dJssfIK1fESOE
	wcSLgsSSReYohqE58dXDBTjV0nHUe2HywcBgBtEOtfK14kEvA7w44tNLLe54wYu8338/uwgeMTd
	gJJZgdYH6pVnTdwUlSAhb6bAdCwY=
X-Google-Smtp-Source: AGHT+IENoSIraQV2MUuaiHPAFPZCJmIlgR5GxiNMGVm33sZ/YAzsVbHs7G76SIXTnPRovj8+yWkxYQ==
X-Received: by 2002:a17:903:442:b0:22e:6d46:a5d7 with SMTP id d9443c01a7336-231d452db0dmr264286175ad.35.1747825921611;
        Wed, 21 May 2025 04:12:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba49esm91065235ad.163.2025.05.21.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 04:12:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHhMc-00000006Het-2eYB;
	Wed, 21 May 2025 21:11:58 +1000
Date: Wed, 21 May 2025 21:11:58 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 11/28] check-parallel: initial support for specifying
 device sizes
Message-ID: <aC20_r_xBjIjH6LV@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-12-david@fromorbit.com>
 <c63cadb8922f591e6bc3a528db35e96ebc6e9949.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c63cadb8922f591e6bc3a528db35e96ebc6e9949.camel@gmail.com>

On Wed, May 07, 2025 at 03:35:29PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Rather than hard coding loop device sizes, abstract them out into
> > environment variables with defined default values. This allows
> > a check-parallel wrapper to specify sizes or, in future, for them
> > to be read from a config file. Sizes are specified in human readable
> > values using M/G/T suffixes to indicate the units being specified
> > 
> > Whilst doing this also add support for creating all the external
> > devices that XFS uses during fstests execution. A typical setup
> > will be something like:
> > 
> > TEST_DEV_SIZE=10G
> > TEST_RTDEV_SIZE=10G
> > TEST_LOGDEV_SIZE=128M
> > SCRATCH_DEV_SIZE=20G
> > SCRATCH_RTDEV_SIZE=20G
> > SCRATCH_LOGDEV_SIZE=512M
> > LOGWRITES_DEV_SIZE=2G
> Should we document these new variables in README?

Not at this point in time. This patch is just introducing
the code to create all the necessary devices for a runner, the sizes
of which need to be specified somewhere for it to work.

....
> > @@ -243,22 +251,35 @@ runner_go()
> >  	local id=$1
> >  	local me=$basedir/runner-$id
> >  	local _test=$me/test.img
> > +	local _test_rt=$me/test-rt.img
> > +	local _test_log=$me/test-log.img
> >  	local _scratch=$me/scratch.img
> > +	local _scratch_rt=$me/scratch-rt.img
> > +	local _scratch_log=$me/scratch-log.img
> >  	local _logwrites=$me/logwrites.img
> >  	local _results=$me/results-$2
> >  
> >  	mkdir -p $me
> >  
> > -	xfs_io -f -c 'truncate 2g' $_test
> > -	xfs_io -f -c 'truncate 8g' $_scratch
> > -	xfs_io -f -c 'truncate 1g' $_logwrites
> > +	xfs_io -f -c "truncate $TEST_DEV_SIZE" $_test
> > +	xfs_io -f -c "truncate $TEST_RTDEV_SIZE" $_test_rt
> > +	xfs_io -f -c "truncate $TEST_LOGDEV_SIZE" $_test_log
> > +	xfs_io -f -c "truncate $SCRATCH_DEV_SIZE" $_scratch
> > +	xfs_io -f -c "truncate $SCRATCH_RTDEV_SIZE" $_scratch_rt
> > +	xfs_io -f -c "truncate $SCRATCH_LOGDEV_SIZE" $_scratch_log
> > +	xfs_io -f -c "truncate $LOGWRITES_DEV_SIZE" $_logwrites
> Do you like the following refactoring:
> 
> 
> declare -a devices_map=(
> 	"$TEST_DEV_SIZE:$_test:TEST_DEV"
> 	"$TEST_RTDEV_SIZE:$_test_rt:TEST_RTDEV"
> 	"$TEST_LOGDEV_SIZE:$_test_log:TEST_LOGDEV"
> 	"$SCRATCH_DEV_SIZE:$_scratch:SCRATCH_DEV"
> 	"$SCRATCH_RTDEV_SIZE:$_scratch_rt:SCRATCH_RTDEV"
> 	"$SCRATCH_LOGDEV_SIZE:$_scratch_log:SCRATCH_LOGDEV"
> 	"$LOGWRITES_DEV_SIZE:$_logwrites:LOGWRITES_DEV"
> )
> create_dev_images devices_map
> 
> create_dev_images() {
>     # this executes commands like 
>     # xfs_io -f -c "truncate 10G  <test-file.img>"
>     # for all the devices
>     local  -n dev_list="$1"  
>     for entry in "${dev_list[@]}"; do
>         IFS=':' read -r -a tuple <<< "$entry"
>         xfs_io -f -c "truncate ${tuple[0]}  ${tuple[1]}"
>     done
> }

My brain hurts just looking at that. That's way too clever and
complex for a dumb engineer like myself - it took me several minutes
to sorta work out what it does and how it works.

However, I'm still not sure how it works, because the image file
variables have different values for every runner context. i.e. we'd
need a map per runner, not a single global map. I don't know if that
variable is evaluated at declaration time, when it is read into the
array, when the array variable is evaluated, how that interacts with
background execution, etc. I'm not sure I can work that out without
help of the bash man page and watching the output when 'set -x'
has been issued.

Compared to reading a bunch of truncate commands in a couple of
seconds and being certain the code is doing what it should be doing,
adding a device map like this is adding a lot of extra cognitive
load and analysis every time I look at this code.

IMO, there's a good reason for writing code that is dumb as a
hammer: everyone knows how to use a hammer. The KISS principle is
everyone's friend...

> > @@ -285,7 +306,11 @@ runner_go()
> >  	umount -R $TEST_DIR 2> /dev/null
> >  	umount -R $SCRATCH_MNT 2> /dev/null
> >  	_destroy_loop_device $TEST_DEV
> > +	_destroy_loop_device $TEST_RTDEV
> > +	_destroy_loop_device $TEST_LOGDEV
> >  	_destroy_loop_device $SCRATCH_DEV
> > +	_destroy_loop_device $SCRATCH_RTDEV
> > +	_destroy_loop_device $SCRATCH_LOGDEV
> >  	_destroy_loop_device $LOGWRITES_DEV
> destroy_devices()
> {
>     # This destroys all the loop devices that were created. 
> 
>     local -n dev_list="$1"
>     IFS=':' read -r -a tuple <<< "$entry"
>     eval "_destroy_loop_device \$${tuple[2]}"
> }
> and then call
> destroy_devices devices_map. 

Once everything has settled, I'll be replacing the loop destroy code
with a single call to 'losetup -D' from the check-parallel cleanup
trap.  This will detatch all the image files from all the loop
devices in a single command, rather than doing them one at a time in
every runner context.

> IMO, this reduces the number of lines of code and adding an entry to
> devices_map automatically does the devices creation, removal and
> setting of environment variables without having to manually add them.
> This is just a suggestion - please let me know what do you think about
> this.

I can't tell if it works or not without spending a lot more time
trying to understand it. I've already spent way too much time trying
to understand it well enough to write a coherent response.

I think that about sums it up....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
