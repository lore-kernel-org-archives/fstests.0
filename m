Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A93E42981E
	for <fstests@vger.kernel.org>; Mon, 27 Jul 2026 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785174626; cv=none; b=KiIN4gpujfvhbX+X9AUw+wzSjYWgSwM+/yUU9hkiLTrKORQwZ3sderpmlwPHvvKPHgO10dSvThpPl5GUf3bP5Vd3+TUsNvCoyS1Qp24mdmDkCGjEEfygXMYPCvEbS+W+pSEUc9ej5KgcXzfX4yhyZfI37nOxjUGJj2rMBIVcrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785174626; c=relaxed/simple;
	bh=EYTSjSCybomjYbHL8NJXVM3a24GdpeR2IFHGCX5snUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifqPCVjeCad2lwIm0/Gu5cGDW1iR767YgPKcDKstipF6glq1Paq8A0wzTGyFwpLSLK9YEZijsgLCaj5ZALJAwSqUKdQ982Ab6a9AQBdVuvqeOg16DMbm/z3u49kEx5Z9SscW37rRwFf4Vl1vD2hg6Aesfxvu+pIGHNOggCoxqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tzgz0+/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tzgz0+/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A9F1F00A3D;
	Mon, 27 Jul 2026 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785174615;
	bh=n0puckbhg1NjigGkaWkGscbP69VVSG+CBvumzu87bZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tzgz0+/dOF5dRi7APJ3Ao6lVXpvZyRCUxlgBGpz5uTTSkC5Dnrw7I4eBUJ+jzI2Jl
	 0TMN51snWt8y8mSgJRJ/brM6LC5yyh0NKwQOO+Oym5iKDsGTroa3ekbReOkFwBCs3X
	 IEQ11qxhcGYo2Koea04RlstiYtdernJ6Q2y6hMklOPyNglFqfSZo5nBx4+IKBajmo/
	 muxdPA4LcrF5Qw439kRrCmYL7BouJD2thdnsaslt5mjYdgkfuP6uHIT2ZW+iqJKyQq
	 8TSiduA2dt7L3QBBpHDdiYPo2xnK5upDD1L54YqBnjpRppyPXlZhFWmjb+W1UaTN7I
	 4nUVi2BrxfouQ==
Date: Tue, 28 Jul 2026 01:50:08 +0800
From: Zorro Lang <zlang@kernel.org>
To: Anand Suveer Jain <asj@kernel.org>
Cc: Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
Message-ID: <ameWjhJLY41-hWQ4@zlang-mailbox>
Mail-Followup-To: Anand Suveer Jain <asj@kernel.org>, 
	Chao Yu <chao@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
 <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d872ecc-6e76-43b6-8b43-adb979cacf79@kernel.org>

On Wed, Jul 22, 2026 at 07:56:33AM +0800, Anand Suveer Jain wrote:
> 
> > Hi Chao and Anand,
> > 
> > The *_fs_sysfs related helpers were brought in by me in:
> >   commit 2a7b77abcd1dde735186b363da24540706c43b73
> >   Author: Zorro Lang <zlang@redhat.com>
> >   Date:   Tue Jul 5 17:30:24 2016 +0800
> > 
> >     xfs: configurable behavior on errors at unmount time
> > 
> > At that time, I didn't think about the "features/" directory.
> > 
> > Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> > family of functions shouldn't be restricted to the $dev directory,
> > we should remove this restriction.
> > 
> > Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> > helpers which call *_fs_sysfs(). Also change the test cases who call these
> > functions.
> > 
> > Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> > *_fs_sysfs directly).
> > 
> > Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> > them is somewhat confusing and easy to mix up.
> > 
> > I need to write a series of patches to clean up these logic. For this current
> > patch, we can start with a small-scale change first. What do you think?
> > 
> I noticed some duplicate code that needs cleanup.
> Essentially, I think we can maintain two sysfs check helpers:
> one that involves mounting the device, and
> another for module-level feature checks.

How about:

- *_fs_sysfs()
|
+--> *_fs_sysfs_device()
|
`--> *_fs_sysfs_feature()

I also need to clean up and unify _fs_sysfs() and _fs_sysfs_attr() .

Thanks,
Zorro

> 
> Thanks for the help, Zorro.
> 
> Anand
