Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94321805E
	for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641374; cv=none; b=iW7MOdTPTdVODTzybwVqW7ei7Y/qSvZA4xdTr7RTSBrcBArW+IH98V1EpRFLJRA76j8yTKbNsHR39UUY2BaFJEHHqPp3TL5BD+cdZEcMIbJnN7BKdA9g4AhBGut8QO2vriSo+LNhqoCyiR2O0Xy7mysRMNyNLMMt6zj2GDtGX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641374; c=relaxed/simple;
	bh=Y9ti6rE9vqkWle3Jgl2BRrPt5+QGGg4w1cRQsv1G6g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaXUbgc8jrZaQtkK0HqOjogJfvwf8wD+bTrg3+fWyujiCR/ZGqzIfaJzVAYbmgTZevPNff7n/LnUYXA3d5h0nuEReg6TPRdlQvrDlGNXkNNlvQSoxvPZukhlfCt7+2U8W21/UiX4HhHHO2ZI77CKYxO9Dh9thfV+pda7EwnPbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=MnrH9ABt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="MnrH9ABt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215770613dbso8594215ad.2
        for <fstests@vger.kernel.org>; Thu, 19 Dec 2024 12:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1734641372; x=1735246172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bIiYB80VxQ7ZUsSp1nMFrFeVOGrRcj3/Y/P4Z+ht9k=;
        b=MnrH9ABtvKiYxJL76hx4DVIZuEB9apxDKUiKNBIwsa0XflIyIRuR8DuiYi8YOIRUKc
         KAnmGJIeHlwAuz0Er3E5BZPFPoeypq3Kfxs4cdESNFcvnHV5ToBaPSWsesJnjKGP/ESU
         gHS9I9N2wptu3D2Q0nbEFcEgoDU05ZSAZspOVbhmU1HgvQ0jdMiBG3+4/+6VrFcnArJa
         LjtizP0UouM0f4XYX+StOkUxC+0QlWlZbhFO2t62FbEKeYJHbw5fxOJKFxEnQ1qg/Z/g
         zVsOtXwK0z3Y2ABilB7KM3s+Rvcm4PLLnOIIQpiCYIh+rqNQMDm7SMKw9hNYZfF420ad
         VaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641372; x=1735246172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bIiYB80VxQ7ZUsSp1nMFrFeVOGrRcj3/Y/P4Z+ht9k=;
        b=VBDbTQsmLqWh/oh6dd+N7YkSylP6uhdvfi/Nd23A72MVBWqsliJvIadONSQ9C40uDl
         tGVgV5rCMNp84Z39TKOO3iDjSkOzPlN3rP2gGEnys59Uq8YOlr7OOo9DF8v+KM5e+xOl
         wbbhc9Hg0/HGfjNwS9N1OnmMuCzMHf4MI9ZYefZydOHvciqPfOtgPbNXXfThBWAj3qUS
         C5xgDabYbtLFNWUe67AazN7p9xieqpC42qJR8PgR4ZZbzr7Hqybf3p5+MEPt1Nz4fkS8
         oU5062O5G6mWB+hOleuQZjmUIE/ZakSlVOApYJz+bYlRCsG8ajnHQdht6nUGvF/7mV26
         CUgw==
X-Forwarded-Encrypted: i=1; AJvYcCWrMP9eEW0i74vv14UTX2Vfh9BWUI+vBpHp0vMWg3jOt6YlF+3rgT+gjc2ovENWNQpfBv1Mq3vc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7uf6ORWglMMKS0vKiNhK/u411skBIf/ryP2Ve2PHZHmM3ssB
	tskBDfHKXmTVw/GYD+0CydchTcXD8aWyrC+1C0nC1nPwavXghQvl1xvR7wOvELE=
X-Gm-Gg: ASbGncsRkuwdqIxbUq8wHl2gO5yyjy2d3Hmf8bBiLi6SzbQLvL0q6ROgdzWRhP/Z2d2
	EU93N/G6KRcl0KvQv4vFQIDJ37pEARlSyeqo0kTIs0EEYJBSxtkrweMXyuFeMq5RVtXOlSPQuoL
	ss5zhdOKjpuLwhhUHoVIVs7lwpXNH1FIxzoI1o0OHNFfBXYTi8kGyQQU0ke6OGORJ5SS14M1M3Y
	VuXjkq6WmEmb8NDG9fz+8ufNKXnAj2kNnHSpXWfnuNqTJHwfY/nf6ELA87tOkG+34BXoNiwTV4g
	MkWHORq683ZjASFQjGs+1yq9Dwp8XA==
X-Google-Smtp-Source: AGHT+IERECpk8p3y3r6hCY9P9NXZgy88FmQ6ZrqpSxT+Hs1Rv4yI/FPjLrAF1RRdZdXmxrJMGv9XCA==
X-Received: by 2002:a17:902:dac6:b0:216:59d4:40e7 with SMTP id d9443c01a7336-219e6f25e08mr1442245ad.55.1734641372133;
        Thu, 19 Dec 2024 12:49:32 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm16245375ad.123.2024.12.19.12.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:49:31 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tONSa-0000000CoV4-3Z95;
	Fri, 20 Dec 2024 07:49:28 +1100
Date: Fri, 20 Dec 2024 07:49:28 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
Message-ID: <Z2SG2HsqgA46kuAz@dread.disaster.area>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu>
 <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area>
 <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241219163206.GD6160@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219163206.GD6160@frogsfrogsfrogs>

On Thu, Dec 19, 2024 at 08:32:06AM -0800, Darrick J. Wong wrote:
> On Thu, Dec 19, 2024 at 06:16:26PM +0800, Zorro Lang wrote:
> > On Wed, Dec 18, 2024 at 09:37:53PM -0800, Christoph Hellwig wrote:
> > > On Thu, Dec 19, 2024 at 09:26:06AM +1100, Dave Chinner wrote:
> > > > On Tue, Dec 17, 2024 at 12:11:07AM -0800, Christoph Hellwig wrote:
> > > > > On Sun, Dec 15, 2024 at 12:12:42AM -0500, Theodore Ts'o wrote:
> > > > > > +if [ $FSTYP = "xfs" ]; then
> > > > > > +    _scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
> > > > > > +else
> > > > > > +    _scratch_mkfs >> $seqres.full 2>&1
> > > > > > +fi
> > > > > 
> > > > > We really need to document why generic tests have file system specific
> > > > > hacks.  And yes, that's a request for Dave who originally added it
> > > > > without any explanation and not Ted.
> > > > 
> > > > Creating and then unlinking 50000 files is journal space bound
> > > > when using default 64MB logs on small test filesystems. Increasing
> > > > the journal size to 256MB halved the runtime of this test.
> > > 
> > > Please explain this in thet test.  And you probably also want to
> > > ensure that you don't force the log smaller than 256 either, otherwise
> > > people in 10 or 20 years will wonder why this test forces logs to
> > > be so small.
> > 
> > I'll help to add this comment when I merge this patch, if Dave hope to
> > keep "-l size=256m" for xfs.
> 
> What happens if someone runs fstests with a 128M external log device?

It fails, then drops MKFS_OPTIONS.  The simple solution for this is
to simply to use a larger external log device....

> Is this one of those cases where _scratch_mkfs notices the mkfs failure
> and formats without MKFS_OPTIONS? 

More than likely.

> And if that's true, what about my
> test configs that set MKFS_OPTIONS to test new non-default features?

Changing existing infrastructure behaviour to better suit *your*
test environments is *your* responsibility to address, not mine.
I don't care if MKFS_OPTIONS get dropped in occasional tests, it's
more important to me that the tests run fast so I can iterate
my modify-build-test development cycle faster.

It should be trivial for you to address, though. Add a function
like:

_scratch_mkfs_try_option "-l size=256M" 

which has the opposite fallback behaviour of dropping the test
supplied option and using MKFS_OPTIONS instead, and I'll use it for
all these "test go faster" modifications that we badly need to
address...

FWIW, this would also get rid of the need for the FSTYP checks in
the test, too, because passing "-l size=256M" will fail on btrfs,
ext4, etc and then they fall back to the specific test config...

So, provide me with the infrastructure that makes stuff like this
work properly in *your test environment*, and I'll use it
appropriately.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
