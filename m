Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E4261583
	for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605871; cv=none; b=SLx4Ch9bfnbB23iK91FHP51/xTm5KtJRR8/eMFq/C9YabdBZ2zdu3nnL/NVxW/XiHPrUn6fqJtZYxeksJvtR7OmX0JMrFRv/ZRGxB9DkOcVvguKVFKfsz5TugNrzvnCe3T+eB0xpezpDKm0UEm4nRTI9HDZg3EyGgpD/6sA1zx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605871; c=relaxed/simple;
	bh=V5RHRNqTw4lI5IbZCuyA3x7FDKEYN2piwqVBrAEGwds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp2vpQSdQFdDhBT1/CeHZVNShvO+AFXhb5L/wJSwqrx1MVkgmgK+30LsGAbNN3/0gCSqg2cBpWY1QfUlZwqLECVy2MYdG6VaYWxSLxxLkVV3Be5HtO0CrpPBep78q/JnmZ003KAU6Qnp/9oZg0NabmveLWulK3Im8CSUGlQyCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1U/sbtIk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1U/sbtIk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22101839807so3682625ad.3
        for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740605869; x=1741210669; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MCUcEwmj1Jh7k+9CxWzzM/Zd6boDO4ys9mXEZIczeCM=;
        b=1U/sbtIkP5VJ0FGtf2ilFnh4zraIcwAbPbGodSh++OG9fN18+cMVt2fwsLBsSuvbtv
         VYqEWPl3i+RBpkdbGCWwjINf7nO2HzOdn5rGLDeZmIDfUspdFgt4QiRajLKEs0WDigMO
         IXdpiO5eWXcNMFJIDEOUdg82PDQV7ggyarGDD9246JuiuvGjjqk0XeNSCzShA84AH3DP
         urkmSan5xNkrdTs91Bo+Vurz/5C2UqLQPE+aL9mN5h+3TYwDWaes/CxmtJ2WfB2G/tdi
         T5FY5ETUQNNg3hNZbz0K+ojJjxx74kBxOKVP1sbme6RZGSUOob2STwKX7mk9YGyuZrSu
         Df/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605869; x=1741210669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCUcEwmj1Jh7k+9CxWzzM/Zd6boDO4ys9mXEZIczeCM=;
        b=rfZ2bLHa04K4JepRYME/Bs8xCRanj5tki8JgKmSp9j5rLSVPW4vTVPmJ7MLnd5roa6
         TIKNBkpY6PcPFLNoeZ7QsJLrOPn5j3FVngPHfLYePd5Qt09oryfkOEw/5X8FwwUqQkF1
         OWFigVaDM+kz1QRdRg9ff0VIp36fINVU4RBd+8PYsmuESbgsSt4XNu3y5a5b9oSHNte/
         CxJ7fByeEySQRdpEQXnKCyhQceGRj0jEcu2g7+n+qP0VPenmHFRt/g/O/8bf/Lz9qZiW
         wMDBB2QrsLl4f1FM9WZL5g84p6icfPMR8tQN1ST43cfAC6r1s1b+xX3B/OOFrDXmR1Zq
         9jzg==
X-Forwarded-Encrypted: i=1; AJvYcCW73OoszlNwq9DgghEG5BF82yZAUkFO9yVsInOlL2pvGxyF3XN6MPwa4nsGM9cF0CfgiX2ugUBj@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeZ3q5eMPGbO8aISLL4yAFeAPgF79qAsIsi5qmfVSxKDJqVsJ
	CJcpAnlBfknpqxFf2+BHwdqQtz9KNERIqx9AbwurX85ebCb/s0fm0rpUm4XZWdw=
X-Gm-Gg: ASbGncuk+K8MafdK3X758oRIaUagK1+rATZfsbfVZZCJMC1ARMT3IKAAO3NU6Eao5wk
	2UfPCOFK1aBc4ltb8cpZVM6cVIxuR8bUXV/RbLYLGrB0zY/5RuNKl59SuH9ePKLVOGgeYhOWPyW
	FzY0U+vhX0eiMXGZ8PpIXSV65QHmY7jmYTXEu+UfrDEi7JGI8TkIFyd8IezYNeg3d/G2HLFU23H
	92ePfZltUk1NPs3EitReQK5iG5wklyMQNa45wSYnREf6wJ+QRACoTZNESS+NX5zm0/qczg6Y5/0
	e7Bkd5OPZ8Z5u1KHiG7cyVbPw5PxJqokzqJPmChWLN9EQd9mO47FIrx5G4jSMjmSKmlKnMDqAQW
	v1g==
X-Google-Smtp-Source: AGHT+IHNqRpXCuSGBS+Xg8ISiTxFsZCpyrUty1AnGDojZW1XuESCjdL+Ctc0rMGpJj7o3PpbI9dUdA==
X-Received: by 2002:a05:6a00:21cb:b0:730:7771:39c6 with SMTP id d2e1a72fcca58-7348bdb3e0bmr8947565b3a.8.1740605869526;
        Wed, 26 Feb 2025 13:37:49 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2ad91sm24930b3a.13.2025.02.26.13.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 13:37:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tnP6A-00000006MMg-1KKF;
	Thu, 27 Feb 2025 08:37:46 +1100
Date: Thu, 27 Feb 2025 08:37:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
	Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: finish UMOUNT_PROG to _unmount conversion
Message-ID: <Z7-JqucPHv2E6ncE@dread.disaster.area>
References: <cover.1739989076.git.fdmanana@suse.com>
 <9aa6c8318d11b2fd1c2e208d85b2f83ea81ff88d.1739989076.git.fdmanana@suse.com>
 <d2d72753-5bf2-48cf-b2f0-cfe184ec75a7@oracle.com>
 <20250220170333.GV21799@frogsfrogsfrogs>
 <CAL3q7H6cH26jarU+YEogd5O5FuHi+YNtaWgmsV72NuXacPQU6w@mail.gmail.com>
 <20250221041819.GX21799@frogsfrogsfrogs>
 <Z75B38rmY9TPsftf@dread.disaster.area>
 <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H41a=gzDtQDX8L4ep5PhD4ZpuSCUiNGzx5eK2h_N6bQXQ@mail.gmail.com>

On Wed, Feb 26, 2025 at 10:37:20AM +0000, Filipe Manana wrote:
> On Tue, Feb 25, 2025 at 10:19 PM Dave Chinner <david@fromorbit.com> wrote:
> > diff --git a/tests/btrfs/029 b/tests/btrfs/029
> > index c37ad63fb..1f8201af3 100755
> > --- a/tests/btrfs/029
> > +++ b/tests/btrfs/029
> > @@ -74,7 +74,7 @@ cp --reflink=always $orig_file $copy_file >> $seqres.full 2>&1 || echo "cp refli
> >  md5sum $orig_file | _filter_testdir_and_scratch
> >  md5sum $copy_file | _filter_testdir_and_scratch
> >
> > -$UMOUNT_PROG $reflink_test_dir
> > +_unmount $reflink_test_dir
> 
> This isn't equivalent to directly calling UMOUNT_PROG since the
> _unmount helper always redirects stdout and stderr to $seqres.full.

Please update your tree to the latest for-next. _unmount does,
indeed, return stdout/stderr to the caller, and so as the commit
message says, it is a drop-in replacement for UMOUNT_PROG.

I wouldn't have sent the patch in this form if that hadn't been
fixed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
