Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603C9463
	for <fstests@vger.kernel.org>; Sun,  8 Dec 2024 00:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733616135; cv=none; b=gyUc0f5y1Om5/qiDIeSecnlhTiPh6C8q4Gb9N1hUonM1QP1i17JZl3GiQypOXIGYMig2HABduXJkF51rYKJr8tAGF1yaq41lCjURoYHEysAjMl8mElWD3JTd3MDr/5AzsRiffQRGYd1m0bskQiQiujFwvWaeQBzvV+C+YndBpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733616135; c=relaxed/simple;
	bh=xzPha+URmp5/qitpr9IgmqHOujDHMm78T0QygdQ1hfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IavnZ+ywEV69/FlCBBHCV4G1pjvHz9kPV5PHzdRfCy6l3znf0TfBbglshBYkagwhp5TrVkyMoVGcwtst3K+t2YwyGwHm8qXV1rPvCGU79bDd+vYiJoIxeKM8BAuUjBMoF0KSv3TcN7g2Nq6gYyoD/ldnXFPg62zIKSjL6FqBT3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KnE8uoOZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KnE8uoOZ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7250c199602so3455046b3a.1
        for <fstests@vger.kernel.org>; Sat, 07 Dec 2024 16:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733616133; x=1734220933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pEJxfLF4197obbcmjNJQzP030tEsqzeqCBaOq8cJHBM=;
        b=KnE8uoOZVeIYk75mm4htUaacopjqVZKcBhqZwxkMc4dG8NeC2nrPIVj0RnJHnFQQ1l
         rz5FCTWIec0fUc7K2VkZ9FtF5hgaxamc6M/V/NqM/vzpyN8fGM+LSp1T6bJDxaJVN5m8
         Gb8du2EgkvdINgu/BARfO6OJ3XAat85jPttfokxaNA4y7AWhsLhFeUBErKLtDoj0XHs/
         70lyVg5+Dh9KvH59Lpc4rWJcbxoXZHSJIIz3k/4uHQPLrQqSasCjZmIoIJ0k1DmtNyTC
         pBf8a3iNVYSgrSz5ImD8BbcHdx9FYUQUWTPPNzn30MDMJhK/+dAkheLPhjWXkau+pkmh
         GyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733616133; x=1734220933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEJxfLF4197obbcmjNJQzP030tEsqzeqCBaOq8cJHBM=;
        b=Df9B/pXn7OWEfM9ZeMgeK+dg/PEdh2fq04jqW8nrsAy2YOO+ecPmgxALFaO6G1Gj/g
         2mfV4uBA2z492KrHWvYkIbTAV15hLug5ZoRnAh7nsdgPzD7w+CtJBUEis9zKSvLLZDUv
         KyNf51EVy+DoMZ7XmO6+SHH813/Lkv1ThYyuxRY0qHuFJR6MTuNCT6jrWgYgnmckyoSo
         b9cI3JRYqv1gr3eekQbfMF7nYOvBTpdyElD2SxgFMitr70YAHajr9zYmODU6hU606j6M
         86Wh08TGMkXhh4JaoX9eh/32Nso9lRDxy4+UpsIZaqeFTL1gE4mUI2qSbaY1TW2BrQG1
         s0og==
X-Forwarded-Encrypted: i=1; AJvYcCUg8NmV0JoY2GZCCKqBXDXWcxCbL2c32m2qrsfohM97HO9Sn/+iqIlz4cZ6UIFVHCAzDBRSmzfB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2JYtjKPrdmC1YPljnca2GKCTKYRV5kUI501i7bj5LFiFC6q0l
	itb6iPnog7rdjbYODdcYMvq1VsnWTWypwjW1fTSVuM+VhfY5J5g0OvO8R4gAPM0tV3Q63/WZnYw
	G
X-Gm-Gg: ASbGnctGF9ezGRDThQrI7+bvwbRU1Wrj5Dvb9SmIfcQmo9NMTM26w9fWrKIZmLNA/16
	+TDab+h6gI26dJsRCrvgchRrGXQ7k2VpvjPfCCcBOUmssEXQUoo/hUynYKCtKBc3W8pQGmfKUW8
	CXpyTjXy3TBgLbUufw72Oc+tHo4WIzqCT0GfJ0PR1J2yQ5xsTIvUjs2DmHQJAGkkVAg3PqafEfc
	nNadRz67KQ3adbWbJdat+wExP4L8f7gCT1BHK6/kPxiMoZhR09l5LWGzkfr2rLSaJPV0YFQqxPn
	CughGmKKFpetQ+sUPxzfzas=
X-Google-Smtp-Source: AGHT+IHiiOKhRhYWURwoZL1hjUJi6l+Jfjl3bkrGkwFy6eu4u6McIj3aTCdFb49cEYQCshQvHvgLRw==
X-Received: by 2002:a05:6a00:4004:b0:725:c778:a0ee with SMTP id d2e1a72fcca58-725c778a1e6mr6671620b3a.9.1733616133305;
        Sat, 07 Dec 2024 16:02:13 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29caa6dsm4991352b3a.5.2024.12.07.16.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 16:02:12 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tK4kT-00000007xju-0JjX;
	Sun, 08 Dec 2024 11:02:09 +1100
Date: Sun, 8 Dec 2024 11:02:09 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH 00/40] fstests: concurrent test execution
Message-ID: <Z1TiAdDQSrebz3Y8@dread.disaster.area>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241129042216.u2f2sl5pc553gxqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241207000917.GA7824@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207000917.GA7824@frogsfrogsfrogs>

On Fri, Dec 06, 2024 at 04:09:17PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 29, 2024 at 12:22:16PM +0800, Zorro Lang wrote:
> > On Wed, Nov 27, 2024 at 03:51:30PM +1100, Dave Chinner wrote:
> > > Hi folks,
> > > 
> > > This patchset introduces the ability to run fstests concurrently
> > > instead of serially as the current check script does. A git branch
> > > containing this patchset can be pulled from here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dgc/xfstests-dev.git check-parallel
> > 
> > Hi Dave,
> > 
> > I've merged your "check-parallel" branch, and rebase on fstests'
> > patches-in-queue branch (which is nearly the next release). I just
> > pushed a new branch "for-dave-check-parallel" which fixed all
> > conflicts. It'll be "next next" release, feel free to update base
> > on that. I'll test that branch too :)
> 
> I ran this through my test infrastructure at zorro's request.  I saw a
> bunch of loop dev errors trickle out:
> 
> --- xfs/129.out
> +++ xfs/129.out.bad
> @@ -2,3 +2,6 @@
>  Create the original file blocks
>  Reflink every other block
>  Create metadump file, restore it and check restored fs
> +losetup: /dev/loop0: detach failed: No such device or address
> +Cannot destroy loop device /dev/loop0
> +(see /var/tmp/fstests/xfs/129.full for details)

Almost certainly I missed the conversion of names in
_xfs_verify_metadump_v1() from "data_loop" to "md_data_loop_dev"
and such. common/metadump is liley missing "unset md_data_loop_dev"
after destroying the loop devices, too.

Not sure why that isn't triggering on my setup, trivial to fix. I'll
sort it out and fold it back into the original loopdev cleanup
patch in the set.

> and I noticed the runtimes for running serially went way up.

Not seeing that here; I don't think any of the changes I've made
should affect the runtime of a normal check test pass; the tests
should take the same time to run or run faster after this patchset,
even serially...

> Not sure
> if that was because my dev tree has a bunch of metadir fixes in it or
> not; will run that again over the weekend with upstream tot to see if it
> that brings the total runtime back down.

OK.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
