Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BA220F2D
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605901; cv=none; b=lpzVwA3tCXcnyrOHlGnQoum7an+6T5sE+N/CxUAVYkiPqU1t5I1mzAp/ZAXU2KA4YM8thY1s1/W/eCWRK++Ekd/IeD273PZmeUBCQOr7zyXc7EEOmAUcgywP+LgPxpJjoxTo0r54hi7Sf8XWdimhYQZj8GcE65aWdBIdFbcXVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605901; c=relaxed/simple;
	bh=jr2C7l/VJ2Iz6nnLWbmQDWgG6kXE6pdm1AFRG8mqPh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=dcmnx9cWUXLqs+yQU4lpSlcmDGzFGxLj3umKaD5+RoF+71T1QxjeVxH9ONX4OA2XE582Zxb2xfq3/0Q0fSwotk2rHZiFXK+OrO3kGIo16c88pnQFd9nr5dmGzX9XQ134hMH2jcqzJWu8NnfHF1E1nh5gHw/6gL+Y8AqKyJm/vro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/3JVy9d; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/3JVy9d"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-477282401b3so73453541cf.1
        for <fstests@vger.kernel.org>; Wed, 07 May 2025 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746605898; x=1747210698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDcaM8FslLfate/DGrIiIGczG2bgUPcnEShXjwrRNSw=;
        b=O/3JVy9dp97FTHKAHzVKh9KG4wJUF0U/p9mjtvfuchXaLDFk5KgunYJ6RYX0fvLPH4
         TgOTgnZzOc/b6F8/Hn0lLAnzV8AOuA2m1xOMgf8GkqpP9KRcUh8OZCeikNWFwsfDfDYy
         I39PS/7sskTl9zcTtflUHSgM+qGwYnRG24bPXrhFEQLfMsNHt/q2/RZmIucoUyDs6w15
         i8xLp8FWtClYVjiVUKo6HpOigPIo6QIUVo08TvMMEmmIfubK0D+Y4X4lTZ+N6nbSWn7f
         2hsR72s79veBD8TptjcdiF6L5k/SfKWBSlAzCBU+CUMWs5Os2T5KW+oOL2RXcZBWP7GF
         9o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746605898; x=1747210698;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDcaM8FslLfate/DGrIiIGczG2bgUPcnEShXjwrRNSw=;
        b=khpcLwuwtAbmDv1ikwtGqCZ+KAFEyXHsMKOkeJ23qUE3wUBMM+sxN7O1NAjLy+NaGb
         sCfjd92fUrs8o9vcmcAK0N//cQ2FzGZ1rimARFQqN6EIJTNZYHDU89x1Ye2PJ9pxbA5N
         Op9PsXQRH/ELtlGgTKUc8uyqydmob8kDE9AxXif+haH4c2XYPilrbH4p0QUqzwcWIVpk
         l388kte0+gjXlm8QoGSL8BDUcqmmi75ghfnRQpo55vkpSBtpM4uKXzixiKyMuIp7p3Gr
         e3qXydpko7pKQwcmPHGj23b7H6622xSMAJsPTXV76kmyUYlDi21p+wjQshYa8wu54AMh
         s0rg==
X-Forwarded-Encrypted: i=1; AJvYcCXMmaSNM3+qXadsAxcT8z5xIFwQfTYuHIyvQAHUx81AGujZO8QU7Oj67bZc5rAu1fu2lVs9e9Eq@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJq3y5w163YpJOe8hvBtFIdFrOFMp1kYjpqkC3GFLm+SywBHY
	I+lySvINbf0CB9OmWzkG4JNOJZDg54Y/ALXdxCw/wXEbfDdie9XmxTzaYw==
X-Gm-Gg: ASbGncuc2TE+irJLv6LPBH/O4hg+Van/SnIyYx5d8elyA1yleAHF/yixa+QB2HMr3Eg
	88Sj6f3NF01JcMDVu7agNiAtoaV0v0OoVTeCiS17K6i1R+Wzq4kzf4fqaHCVLTNrOGGREIfV+M7
	Y6Mkc0CHUN641G+VQ+4tscFh390NQvSR3cTe5VpxuDy9L/2kyoIoWI/mKFhE0BPg+CiWpMS3RqS
	XLr/BZoAU9CW/iD/GrjJzFeIuAz2uwJ2/Tbf41AjYBjy3gEa4SO/tjmkjCraVgfuuIGPLe5Jqdv
	RovLcP7Uqx0c2R8JCy/AzEj3EevNGhkvjbtvdGXLGuQ/n+a0FH2bVRF/161jXm12xiADWHXr6Ub
	hsiEX7YqsPyEL4uOn+g==
X-Google-Smtp-Source: AGHT+IE/X1HJcAtBxdrgZoQlDn3ZwFDWKePOj+MsExd/41jXNWGCFnqIAysB34AIF5QKn+V+sl7jrA==
X-Received: by 2002:a17:903:990:b0:22e:53a2:5551 with SMTP id d9443c01a7336-22e5ece4678mr38634965ad.43.1746605888079;
        Wed, 07 May 2025 01:18:08 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e95c3sm88825665ad.68.2025.05.07.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:18:07 -0700 (PDT)
Message-ID: <3c71d313d13fab780425304c118bd86f534fefe6.camel@gmail.com>
Subject: Re: [PATCH 08/28] check-parallel: add logwrite device support
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 07 May 2025 13:48:03 +0530
In-Reply-To: <20250417031208.1852171-9-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-9-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Every logwrite test will use the same /dev/mapper/<dev>
> name for the logwrites device, so we also need to convert
> common/dmlogwrite to use per-test device names as we have done for
> other dm devices.
> 
> Then add a per-test-runner LOGWRITES_DEV so that all tests using
> dm-logwrites now get run by check-parallel.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  check-parallel     | 4 ++++
>  common/dmlogwrites | 5 +++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/check-parallel b/check-parallel
> index 0649a417f..5fee62f37 100755
> --- a/check-parallel
> +++ b/check-parallel
> @@ -216,12 +216,14 @@ runner_go()
>  	local me=$basedir/runner-$id
>  	local _test=$me/test.img
>  	local _scratch=$me/scratch.img
> +	local _logwrites=$me/logwrites.img
>  	local _results=$me/results-$2
>  
>  	mkdir -p $me
>  
>  	xfs_io -f -c 'truncate 2g' $_test
>  	xfs_io -f -c 'truncate 8g' $_scratch
> +	xfs_io -f -c 'truncate 1g' $_logwrites
>  
>  	mkfs.xfs -f $_test > /dev/null 2>&1
>  
> @@ -229,6 +231,7 @@ runner_go()
>  	export TEST_DIR=$me/test
>  	export SCRATCH_DEV=$(_create_loop_device $_scratch)
>  	export SCRATCH_MNT=$me/scratch
> +	export LOGWRITES_DEV=$(_create_loop_device $_logwrites)
>  	export FSTYP=xfs
>  	export RESULT_BASE=$_results
>  
> @@ -249,6 +252,7 @@ runner_go()
>  	umount -R $SCRATCH_MNT 2> /dev/null
>  	_destroy_loop_device $TEST_DEV
>  	_destroy_loop_device $SCRATCH_DEV
> +	_destroy_loop_device $LOGWRITES_DEV
>  
>  	grep -q Failures: $me/log
>  	if [ $? -eq 0 ]; then
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index a27e1966a..7c3ad95c9 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -4,6 +4,9 @@
>  #
>  # common functions for setting up and tearing down a dm log-writes device
>  
> +LOGWRITES_NAME=logwrites-$seq
if 2 different runners are running tests with the same $seq, won't
there be a conflict? For example runner-0 is running xfs/xyz and
runner-1 is running generic/xyz ? 
The rest looks fine to me. 
--NR
> +LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
> +
>  _require_log_writes()
>  {
>  	[ -z "$LOGWRITES_DEV" -o ! -b "$LOGWRITES_DEV" ] && \
> @@ -81,8 +84,6 @@ _log_writes_init()
>  		BLK_DEV_SIZE=$((length / blksz))
>  	fi
>  
> -	LOGWRITES_NAME=logwrites-test
> -	LOGWRITES_DMDEV=/dev/mapper/$LOGWRITES_NAME
>  	LOGWRITES_TABLE="0 $BLK_DEV_SIZE log-writes $blkdev $LOGWRITES_DEV"
>  	_dmsetup_create $LOGWRITES_NAME --table "$LOGWRITES_TABLE" || \
>  		_fail "failed to create log-writes device"

