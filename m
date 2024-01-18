Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B4220F2
	for <fstests@vger.kernel.org>; Thu, 18 Jan 2024 01:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543149; cv=none; b=DCxx2oPHCb2UaCAw5vDawgOna0hkmy8lDJkL6We/Qrf+RR50lzUePCjp8Qh9+0r99D+kBrNJM8JtwSuDYV65klAKdczUoQxHOUPsL1XQfWFIVglAMU8Oc1ZQSjUiA5hS+8z8FfKxsEy4dNL2hQNW8GprJBkTOm9dmZj+O8+cNqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543149; c=relaxed/simple;
	bh=iLQE0Nn25ZdOD8abgwN4oZdLPNufKn5YiCltKVp7eag=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=KM7jv9m7aR+Gm/o1ROtSWcEmQBWIM3eyLg9UF4PItwDCYACNPpUQO66MhHKGnfp/nMS+WAxQXUop1hoHIh35Mg0rdjl39n4sRRv4IrT0pFSAF0kqareiMrGJo448ApT5ZftalHBe9lMs7YgZUYOTNBQ+ih5hVRalzTokE64cBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0+PvrQDe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0+PvrQDe"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cf6d5117f9so2688074a12.2
        for <fstests@vger.kernel.org>; Wed, 17 Jan 2024 17:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705543146; x=1706147946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mokiIIftc61Fe5xy+tupKxR7hScn5bDl/MNxkEufu4=;
        b=0+PvrQDeQHPNh1AjTMb/QUsvkL4p6yUcVjINiqyCO/ZIYXUKQ9pZLcmbsm0ss8p9yu
         SdViSkmmWFXAo4Ujrlap9U2qahopKqm4T1I00TRUY9peV+qEIYjT8st9jUDKU4dpXNXi
         nVe+EZz56LEGutq4GbSrL5vmdFct3GAYLvV2G7eGFFyCFA4aKe0LS6AKvIeW7NrARfmK
         Aph7wOMDNiyBkgXmiPWD/WfnNvAAg+M4pthdaQl/4fX2dnjgujfr+yRcKcWQP3Xu1KGT
         L/9A/vyMlueHosuog9CKiS87XL0JBtj4z5WrKHKMAxYcfkQ5hnKJzOqpbU6UIHGVdDus
         0D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705543146; x=1706147946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mokiIIftc61Fe5xy+tupKxR7hScn5bDl/MNxkEufu4=;
        b=fTi1+eBysfKGDZS8KFIn7IFez8alIXCN/Ppm4TEnr0+UksMby8/Nva39Jhp1emeDkM
         xmcrAos/6/G23rD/WlA0ThOVnVwT8yYzpRQ93VZHtbbNHVoJJzzoUG/2RSb6Vue65M2I
         mzloLaoHItwU2enXPFO3ggiAttLkMw0NlBIdC4qUG5zuK0Ck+AI+wRMstWfeh+lwiRix
         YPjUmF8pfhQo+LNGhG54yciABpYeoMpSzQkb/lhjXl+C0Szzl6qALtzLw6rr9axsyn/A
         kx3Hy3069i9b5dXClm3SXZx6iA5inlQUDu5L7+9Xt2+M3COLsEXMHgZRMzhXNL/+wo/D
         fSFA==
X-Gm-Message-State: AOJu0YxTR/CI0i5Z7SX/7FQSqanJD6FpXdOYUkOrzXnfBvlO8mvZLQct
	0UiZKZJbOJ1a+LeO3R33PoUqlGnAqd9HQfT7W/e2pUk9REsRYPKXNy63aPiAfgA=
X-Google-Smtp-Source: AGHT+IGX5mmEhVD89vQOBjLKFEMMnMTqmbJovTI8Llh13zrA5fxFMyb8nJk619l7SgAQjoHhaC8WvA==
X-Received: by 2002:a17:90a:db4b:b0:28e:eb9a:477d with SMTP id u11-20020a17090adb4b00b0028eeb9a477dmr111276pjx.79.1705543146290;
        Wed, 17 Jan 2024 17:59:06 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id nc7-20020a17090b37c700b0028d0c8c9d37sm374941pjb.22.2024.01.17.17.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:59:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rQHgN-00BpFO-0c;
	Thu, 18 Jan 2024 12:59:03 +1100
Date: Thu, 18 Jan 2024 12:59:03 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [xfstests generic/648] 64k directory block size (-n size=65536)
 crash on _xfs_buf_ioapply
Message-ID: <ZaiF5+yMC8FfXYS7@dread.disaster.area>
References: <20231218140134.gql6oecpezvj2e66@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231218174836.GQ361584@frogsfrogsfrogs>
 <20231219063420.qssutqqhr3hreevw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231225133854.zfnywywxa6x5re4q@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240104043552.GU361584@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104043552.GU361584@frogsfrogsfrogs>

[ FYI, I missed this because I got the fstests list copy first, not
linux-xfs list copy and so it got filtered into fstests, not XFS.
please just send test failures like this to the linux-xfs list -
there is no value in sending them to fstests as well but it can
cause bug reports to "go missing". ]

On Wed, Jan 03, 2024 at 08:35:52PM -0800, Darrick J. Wong wrote:
> On Mon, Dec 25, 2023 at 09:38:54PM +0800, Zorro Lang wrote:
> > On Tue, Dec 19, 2023 at 02:34:20PM +0800, Zorro Lang wrote:
> > > > Also, does "xfs: update dir3 leaf block metadata after swap" fix it?
> > > 
> > > OK, I'll merge and give it a try.
> > 
> > It's still reproducible on xfs-linux for-next branch xfs-6.8-merge-2, which
> > contains the 5759aa4f9560 ("xfs: update dir3 leaf block metadata after swap")
> 
> DOH.  Got a metadump?  I wonder if s390x is more fubar than we used to
> think it was...

I'm betting that the directory corruption is being reported because
the directory block change was not replayed by recovery due to the
bad magic number error. The kernel was configured with
XFS_ASSERT_FATAL=n, so it continued on after the recovery failure
and things went bad when that unrecovered metadata was accessed.

Two things: a magic number mismatch between the buffer and the log
item should cause recovery to fail on production kernels, and what
we need to work out is how the buffer being recovered had a magic
number mismatch with the buf log item.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
