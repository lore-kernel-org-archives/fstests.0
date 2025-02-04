Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314110E4
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628299; cv=none; b=pSygwKlwmm3bMlOO+uWGRP2jrm5QVuTcNd7BehS2qKn1pO7+xSD0ZB0p8ppTvfhHYL+Sxis0vl4wy2HFYGxWAdNfZEC1j7w5N5TjtsyBWD808hKSSsWTaOLFmavcIQRSC+5ywZ+uNHc/rhfM6+VXgxTPldephmZyl+s7onsq5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628299; c=relaxed/simple;
	bh=uf/l+xMJ9YRbL1jdaCfVKdtXOcxwr3B6I1EgNNU9Xgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSg3yFMN8t7V/i0jCirk92LlK/0IkrbP0l1AY9lkdvXofPnOGJyQE82mW84g9Kj0W1qQK4axUGaG6c5ANvCNRxDfR2WmhCVpRc3KpvpaJv1HHLNYZbfHJvDNOpH6vnE4WON9WhYpnpseHtzE/Mw5ZqNcx02asntIhgbMrVOa6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NWFHMimZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NWFHMimZ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so8646466a91.3
        for <fstests@vger.kernel.org>; Mon, 03 Feb 2025 16:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738628297; x=1739233097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6X9atRSkJkKWBJM8CFyQZwoAER5Co5yAjBOTSx/RzFw=;
        b=NWFHMimZTDdLmLoCgqitl0M5P5teAktOddavv2hEfRABPDRcSgppDDr3zVaDqu8JjU
         xIcj9dEY3BHZIlDWrOYo4qWzJoq+HxhVyFLt0AoYDgPeGtT52wifuEELGkFqtSsudq6B
         ChM3b6tzkksnJVet/7JG6iSZJXtMQR/44TfcFRbKxHF2XS2F9eK2WRTLRKGI1N8rzjkt
         1BBewrx+1m+DfxOPxGVnYoCDqDecxoiWnALC9uE3hQFRuaW+Chynr+tkiAoDczc0UrA5
         3fj4jo7YrnX5O6FtMvxS55V8HBSiLSjtl702JN2kXbqP4oFEbUq6cFNme8PfaJxDQx/Y
         JoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738628297; x=1739233097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6X9atRSkJkKWBJM8CFyQZwoAER5Co5yAjBOTSx/RzFw=;
        b=GCm+c5/09b8GKUGaH8woiPnynkUuEYYlKyBzzqbiIUKHOzW9oW6wqaoMHwUqAI1rL8
         yHzZ81JU2c9qbE4WKOCJaGcUJ6JR+W13yjAPBym4Z5N5X0wGmt6sOXd/KvFGwf9EManR
         i0ikrWODza03TvsoUKnmz1a/G9xEiK+nizx/YFP3pmC6h+Sq3ScQuUqQQYR4AJ44gw05
         3cmE7RDIQAfsDFbkdNh8NyEOhrDqP6VD0NmqE9CUCSdKAta9e2ZwLiRbLAyiep42CTnI
         JTX9CLvtSyHTD9lnXwSSv6CCJYGO9eIJ6GeDeP7lO3sRS8ZZR/6kKrp8PSxvPeyVnoHY
         sdgw==
X-Gm-Message-State: AOJu0YwQ/LF2vENPGoFCKF1nYQBP93M1wgoP5lTE+Lj3wWPy0LYWrN2f
	C/kwSbjiG89hfy+l/1I4BPsMMC8uIDYjPR/seUKQrAV/MxnLiYY8Q4+p4qWH07k=
X-Gm-Gg: ASbGncvJWjcgAfkXoonbqpWJQ9XHQbWnKvf+X2ZT+qM+n4x//lgTF1JmvdzYmnN0vGv
	ZSnp+O2J3D7qrNn63i576AwphIArGcfzN+ZvcRaS0WCuqNzS52T5g3KDhe/Gvh4fbzyhKAN/4RJ
	ehWxhrH/+xj4IvVtdEpF0B1U/B0Z5g5qHpVJE6zd+ZaIJx7PvIz8GEqcOXTQjNsFITDGuZLvn5C
	u3Qz7zY77DYjCbjLY0Aw6+C1ZmyUeJJBK6sOHOtLVZZ6A81wsp6XVTrZG4q7bfh5L54udSEfruM
	ikv2rWSJNnWiAdMDbvuTD+/EbRrDp0xDJ4OfKehMHB6KrAJ0/UzNwZJh
X-Google-Smtp-Source: AGHT+IEEalDio6MM16W2X5IjA5CbTEYUFgEE2csx1/WknusP+dBXoM+rieXb1+m6juuDR24cVkCWMg==
X-Received: by 2002:a17:90b:5688:b0:2ea:5054:6c49 with SMTP id 98e67ed59e1d1-2f83aa8279dmr43885832a91.0.1738628297065;
        Mon, 03 Feb 2025 16:18:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f7890sm82797835ad.90.2025.02.03.16.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:18:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tf6dp-0000000EIf0-39Pk;
	Tue, 04 Feb 2025 11:18:13 +1100
Date: Tue, 4 Feb 2025 11:18:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <Z6FcxffA-v4-01lI@dread.disaster.area>
References: <cover.1738161075.git.anand.jain@oracle.com>
 <3aecf19197d07ff18ed1c0dda9e63fcaa49b69d1.1738161075.git.anand.jain@oracle.com>
 <Z5vmAzAEtzK_EuXO@dread.disaster.area>
 <fa76f7ed-06e3-4f16-a762-fa444226bcdf@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa76f7ed-06e3-4f16-a762-fa444226bcdf@oracle.com>

On Fri, Jan 31, 2025 at 02:43:03PM +0800, Anand Jain wrote:
> 
> > > +set_sysfs_policy_must_fail()
> > > +{
> > > +	local attr=$1
> > > +	shift
> > > +	local policy=$@
> > > +
> > > +	_set_fs_sysfs_attr $SCRATCH_DEV $attr ${policy} | _filter_sysfs_error \
> > > +			| _expect_error_invalid_argument | tee -a $seqres.full
> > 
> > This "catch an exact error or output a different error then use
> > golden image match failure on secondary error to mark the test as
> > failed" semantic is .... overly complex.
> > 
> > The output on failure of _filter_sysfs_error will be "Invalid
> > input". If there's some other failure or it succeeds, the output
> > will indicate the failure that occurred (i.e. missing line means no
> > error, different error will output directly by the filter). The
> > golden image matching will still fail the test.
> > 
> > IOWs, _expect_error_invalid_argument and the output to seqres.full
> > can go away if the test.out file has a matching error for each
> > call to set_sysfs_policy_must_fail(). i.e it looks like:
> > 
> > QA output created by 329
> > Invalid input
> > Invalid input
> > Invalid input
> > Invalid input
> > Invalid input
> > Invalid input
> > .....
> > Invalid input
> 
> Thanks for the review.
> 
> This test case verifies the sysfs interface syntax in general.
> Relying on golden output can cause false negatives on older
> kernels lacking support for newer sysfs policies.
> Creating individual test cases for each sysfs interface is
> unnecessary overhead.
> 
> With this approach, when needed, we use:
> 
> if _has_fs_sysfs_attr $dev <sysfs-interface>; then
>     verify_sysfs_syntax <sysfs-interface> <value>
> fi

One test instance per sysfs attribute, please.

i.e. move verify_sysfs_syntax() gets moved to common/ somewhere,
then the test for any given sysfs attr is a simple 10 liner with a
fixed golden output.

We can then do the same sort of input testing for sysfs attrs that
belong to other filesystems, too, not just a handful of btrfs
specific ones this test touches. I'd much prefer such tests are
largely generic like so:

....
_require_fs_sysfs_attr $TEST_DEV <sysfs-attr>
_verify_sysfs_syntax $TEST_DEV <sysfs-attr>
exit

If the sysfs-attr doesn't exist, then the test is _not_run and
this emits a log file note that can be captured. If it does exist
and doesn't behave correctly, the test then fails.

Note that things like "test not run because sysfs attr does not
exist" notes in the log files can be important for QE
people trying to track whether backports for older/stable kernels
work correctly. The proposed test is completely silent on whether
any specific sysfs attr was tested or not, and that's not really
helpful in identifying whether something works correctly or not...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
