Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A031F9F62
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740064536; cv=none; b=Nw/AKg7t5ZMUxaFQS8fTNEc601NORrNoOJv9P5F0VAbqvvCfryLaGc3cAD1M6jVqAHQoZ8b3jiJJosq7eSJ+hfADgb/lLQvGkMyLmwAZxDFcLyskbjTT26ruWvTsYmGSc+SGGZ6VKkOCn3wdql1N5eBWY+1oA9mL0yUdUc9CGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740064536; c=relaxed/simple;
	bh=MnfC3MpJaNTEsfbCZChlF8QLt/RNAgHn/WMwYjetiAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnJWGJvC1BmrgrAhmIHdPQonVPl+322+neM6WSQYKhWr6Dg+qe41yHRoTeJy2jdpsFsvOOOfXvBov75QBK1YJBIxi/ugNgruxUB94R72En9r7pmPxwgR8p3S8JLeHwadaFYi+YmdnSxQd2RTRcN6cc5o1JGxSGwT5/+SDCY97E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51KFFSJw011446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 10:15:29 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id AF41D2E011A; Thu, 20 Feb 2025 10:15:28 -0500 (EST)
Date: Thu, 20 Feb 2025 10:15:28 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Boyang Xue <bxue@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v1] ext4: add test case 061 for ext3 to ext4 conversion
Message-ID: <20250220151528.GC2150479@mit.edu>
References: <20250220072226.175071-1-bxue@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220072226.175071-1-bxue@redhat.com>

I'm curious why this is something that you care about this particular
case?  Historically, Red Hat (nor any other enterprise distribution)
has supported changing or adding ext4 feature flags.  What users were
told to do was to create a new ext4 file system, and then copy the
files (or do a backup/restore) to the new file system.

Over a decade ago, when I was at Google, we did do a transition of
file sytems from ext2 to ext4 (in no-journal mode) for all files
stored in our cluster file systems.  Our experience for our partcular
workload is that the performance delta between an existing file system
that was formatted w/o extents, and uninit_bg, and then converted to
"ext4" using tune2fs, was roughly half the performance improvement of
a file system that was freshly formatted to use ext4 once the file
system was filled to roughly the same level, so that file system aging
wastaken into account.

So users who do the conversion won't get the full benefits of ext4.
Also, the exact set of file system features that we changed was
different from from what you are testing.  I'd also note that this
test is just filling a 1G file system, then changing the file system
features, and then running fsck on the file system, and then trying to
mount the file system.

This isn't actually a very exhaustive test of doing a "conversion".
If you really want to do a "coversion" test, what I'd recommend is to
fill the TEST_DEV to be about 50% full, and then make the changes to
the file system features, and then running the xfstests using the ext4
file system type without SCRATCH_DEV being set up.  This would do a
much better job of testing this case, without needing to add a new
test to xfstest that to be honest, isn't really all that effective at
testing this case.

What did we do, 10+ year ago?  Well, we ran xfstests using the a file
system config[1] that didn't have flex_bg set, since that's one of the
primary differences when using a "converted" file system.  We then
using tune2fs to convert 1% of the file systems in a single failure
domain of the cluster file system, and watched looking for potential
problems, and measuring for any performances gains (or losses).  We
then gradually increased the percentage of file systems converted to
2%, 5%, etc which is considered best practice[2] when doing this kind
of feature rollout.

[1] https://github.com/tytso/xfstests-bld/blob/master/test-appliance/files/root/fs/ext4/cfg/ext3conv
[2] https://books.google.com/books?id=81UrjwEACAAJ

Cheers,

						- Ted
