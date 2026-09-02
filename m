Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B614A0F0E
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358444; cv=none; b=NoyAWqLqUUU2cT5F4CWv1QvFKJQlvVLjQrbsB9RcLI6Ae2hlf1Z/u4YUMnU74zZgjGCzNDYe4IWtAUkA9mPWhT6mWMok73e0imFqP/hz7XdcjtnWVqkenVqgX7lW6v179+tR11xZ1V33LKvRyWwjeAj7muHQL21pJwlRDLLrQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358444; c=relaxed/simple;
	bh=1FfSBZPQZtbW7koHD2xRJrlHPhzTiEGIlEqllv169f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1Lsif/kFZAAGpqNdUiIT5K2XLk4EFzQrHHNgLytIqdTbYuhJbh4e/XQS6UWISHlzGiSZ5XJHaoboEeVZMAOGF1LA1d9FnxJf49bHYD7Hpt0XpExAbr0d4n6lMXcBirJyECQBiRtNmVQ85sLN1ASbZmbxgWpL1wRMxbztJivNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5gwgr7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5gwgr7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E051F00A3F;
	Wed,  2 Sep 2026 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358442;
	bh=jGWXYKbYvfrmNeoEiMb4eJUo9HkrH6ZYdGtAKazV/zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5gwgr7XKNgxgUTcn0kSF7OfbKm6Y5fTqzEaGsIwXEnYa5IEcoEM+yXlqenTfXxyb
	 G7E4bFMqA9ZLpwVCNu8fKZQP68E2WVlvsx53GA9kP65ANWp9TYoNVk9wgVFPFNewX5
	 yo/CA3QKM4jlKEBdkNlhsJySBNnea3bt8kHz4jdhJZZiJCuaR60R8ksQ5cFazun7kG
	 SZxCYhAnGHQp4r7vGQch+v1UuoY4rxbUrLDJ4pVE83aJvKrxsbW5B+m4nj48y3HAOj
	 u92IAmwO0T+GQWZbScetdF+qm4FKyk3KA4P682V7Ws/uagya/ofDSo1HtiH0XYDIl+
	 jrmL65+AbfDcg==
Date: Wed, 2 Sep 2026 22:13:56 +0800
From: Zorro Lang <zlang@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] overlay/081: add missing _require_scratch check
Message-ID: <apgtCCVNFzb9giBh@zlang-mailbox>
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>, 
	Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
References: <20260901132438.759-1-prabhakar.pujeri@dell.com>
 <ape4hyfwsv5LrYxB@zlang-mailbox>
 <20260902073507.5074-1-prabhakar.pujeri@dell.com>
 <CAOQ4uxjBc5CfCpjrq8Ut4xHHaenKicTxBCbNuQkBFuu-Mz9=EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjBc5CfCpjrq8Ut4xHHaenKicTxBCbNuQkBFuu-Mz9=EQ@mail.gmail.com>

On Wed, Sep 02, 2026 at 10:25:57AM +0200, Amir Goldstein wrote:
> On Wed, Sep 2, 2026 at 9:35 AM Prabhakar Pujeri
> <prabhakar.pujeri@dell.com> wrote:
> >
> > On Wed, Sep 02, 2026 at 01:51:08PM +0800, Zorro Lang wrote:
> > > As you're fixing this patch, I'm wondering if we need a _require_* helper to
> > > make sure the mount options *uuid=null/auto/on* is supported by current system?
> > > Due to the comment says "mount options uuid=null/auto/on introduced in kernel
> > > v6.6" :)
> >
> > Thanks for looking.  That case is already covered a few lines below the
> > change, at the first use of the uuid= option (line 40):
> >
> >         _overlay_scratch_mount_dirs $lowerdir $upperdir $workdir -o uuid=null \
> >                 2>/dev/null || \
> >                 _notrun "Overlayfs does not support unique fsid feature"
> >
> > overlayfs rejects unknown mount options with EINVAL, so on kernels older
> > than v6.6 that probe mount fails and the test skips with the _notrun
> > reason instead of failing.  The uuid= options are also exercised only by
> > this test (it is the sole user of uuid=null/on/auto in the tree), so a
> > dedicated _require_* helper would have exactly one call site.  Happy to
> > factor it out anyway if you would rather have an explicit requirement.
> >
> 
> *IF* we would want this, I would not recommend a dedicated require_
> for uuid feature.
> 
> I would recommend teaching _require_scratch_overlay_features/
> _check_overlay_feature to deal with mount options (e.g. uuid=on)
> which do not have a module parameter to tune the default.
> 
> So if /sys/module/overlay/parameters/uuid does not exist, instead of
> assuming it is not supported, assume that it defaults to off.
> 
> I am not saying this is worth the trouble, which is probably why I took the
> easy lane and added the local _notrun condition adhoc in the test.
> 
> Overlayfs enum mount options that can be tested with the generic
> features helper: redirect_dir, index, nfs_export, metacopy
> 
> Overlayfs enum mount options that cannot be tested with the
> generic features helper because they do not have a corresponding
> module param of same name:
> uuid, xino, verity, fsync
> 
> verity - has a dedicated helper because it has special conditions.
> fsync - test 087 has _require_scratch_shutdown_and_syncfs
>             which is technically enough to test support for -o volatile
> uuid - can benefit from generalization of features helper
> xino - all these tests 041, 043, 044, 067, 070, 071 practically open
>           code the suggested improvement of the generic helper
> 
> So for the uuid test alone it might not be worth it, but unless I am mistaken
> for all the xino tests, this would be a nice cleanup/improvement.
> 
> But of course, this should not block this trivial and correct fix patch.


Thanks Amir! Sure, I've already applied this patch locally. I just wanted
to use this opportunity to bring it up for discussion, as overlayfs is quite
a unique filesystem and its features have indeed been growing steadily.

I completely agree that having a unified feature check/require helper makes
sense. It would definitely make writing future test cases much cleaner and
simpler. Any patches in this direction are definitely more than welcome :)

Thanks,
Zorro

> 
> Thanks,
> Amir.
