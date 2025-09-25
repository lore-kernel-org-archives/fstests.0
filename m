Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23329B777
	for <fstests@vger.kernel.org>; Thu, 25 Sep 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819049; cv=none; b=uxpVvMxKYyDOJc4p0Gi5Oh70VlBBgIUy300Ab8vtCfAw5C9VdCoYzP1elnZ5a4zY9cfxAgzQtLPtRWuqei+EP9EGKUUBojwN+wRN5sd2IBaPo3SvaOOsEM/LkB4olJsd2ImLfl/Mzz9b6K4dBCKM4qf6HF6BxqJrLiWKK1Ge8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819049; c=relaxed/simple;
	bh=VKwsXaIBCX9vrwHP5cv/Z/sFqNIDQ0ImhER6MIkNAGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPJgXW1sD7bTJQG35cunwOPPP5rrkFkEB1Tk6dAj0yTkoDmXbO8k579l0/ItrUNWDcz+yoQWm6Y5q86KHoZ+5tOmF/3QtPxESxtSs9j1oZ7Si6/kEFIMtxsPVZ5HUDSEZjUKHVQGGPV6jQPjCBDMBz1248yU185yqPgMNSFNhRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4r/Mcb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4r/Mcb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD71CC4CEF0;
	Thu, 25 Sep 2025 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758819046;
	bh=VKwsXaIBCX9vrwHP5cv/Z/sFqNIDQ0ImhER6MIkNAGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o4r/Mcb1m7KNx62fXBCb0RDArDs+K598eTYLJW82cu6wwbuF+1N0bKM7oP6T09o4A
	 zcFxfV7PDbR1L6JoZ9Uf32ndcSduHQ7WJcoBBaclVwnQDFeb3xAG7ETc1SnxU1h4Y5
	 /oEh9FeXo9G+YHAGL9LaOInhW8oJ3kucYwhDY5ewfJD1/dvXp5eDzvBRrXMFtPOp+i
	 3lnNUunCvqDYzrVNen/wiG3ikvD2nLad4MMAElECV/HcxAawfEz/TfHBZS1WQleHhh
	 2jbz19UGR++iFb8PLsEBXfzceDt8p5Iou170Xc5Dfm8Rd6Rqcfu36mYOEl4ytPSRJ1
	 4hK1fhR9DcH8g==
Date: Thu, 25 Sep 2025 09:50:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: destroy loop dev before fallback recreation
Message-ID: <20250925165046.GG8092@frogsfrogsfrogs>
References: <20250924181235.152502-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924181235.152502-1-bfoster@redhat.com>

On Wed, Sep 24, 2025 at 02:12:35PM -0400, Brian Foster wrote:
> When running fstests on an s390x box I observed failure to unmount
> filesystem errors due to stale loop devices being left around. This
> root caused down to generic/361 leaving around an attached loop0
> device. On further inspection, the test actually created two loop
> devices (loop0 and loop1), and executed on and cleaned up the
> latter.
> 
> The origin of the former appears to be that the initial losetup
> command in _create_loop_device() fails due to $dio_args in this
> environment, but still creates the loop device. For example:
> 
>  # losetup --direct-io=on -f --show /mnt/scratch/fs.img
>  /dev/loop0
>  losetup: /dev/loop0: set direct io failed: Invalid argument

Egad following the argument parsing in losetup is awful.  I had thought
that the -f would set act == ACT_FIND_FREE which would then set up the
loop device with one configure call, but the error message clearly
indicates that we're failing here:

	case A_SET_DIRECT_IO:
		res = loopcxt_ioctl_dio(&lc, use_dio);
		if (res)
			warn(_("%s: set direct io failed"),
			        loopcxt_get_device(&lc));
		break;

In this case, we clearly don't tear down the loop device after this
failure, so yes, you've found a bug.  losetup can totally create a loop
device, fail to configure it, and return EXIT_FAILURE without tearing
down that loop device.

>  # losetup -a
>  /dev/loop0: [64771]:131 (/mnt/scratch/fs.img)
> 
> The helper then goes on to create loop1, but it or the test never
> deals with loop0. To avoid this problem, detach any old loop device
> if one was set up before the fallback losetup command.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> This appears to be fallout from recent commit aa14b84a8d1a2 ("xfs/259:
> try to force loop device block size"). I'm not really sure why losetup
> creates the device with bad dio settings but not with block size. Maybe
> it's more of a dynamic setting or whatever and that's why this was
> previously a separate losetup command..? Anyways, this seems to work for
> me..

It probably has to do with the underlying fs not supporting directio or
something.  What fstype is /mnt/scratch, and which kernel version?

> Brian
> 
>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index 81587dad..891f6b7e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4596,6 +4596,7 @@ _create_loop_device()
>  	# size to the directio alignment of the underlying fs, so if we want to
>  	# use our own sector size, we need to specify that at creation time.
>  	if ! dev="$(losetup $dio_args $args -f --show $file 2>/dev/null)"; then
> +		test -n "$dev" && losetup -d "$dev" > /dev/null 2>&1

The logic looks sound, but I think there ought to be a comment
explicitly documenting this behavior of losetup:

		# losetup can create a loop device, fail to configure
		# it, and return EXIT_FAILURE without tearing down that
		# loop device.
		test -n "$dev" && losetup -d "$dev" &>/dev/null

Because I won't remember this subtlety 3 months from now. :(

--D

>  		dev="$(losetup $args -f --show $file)" || \
>  			_fail "Cannot assign $file to a loop device ($args)"
>  	fi
> -- 
> 2.51.0
> 
> 
