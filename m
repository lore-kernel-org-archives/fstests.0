Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032781FDA7B
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075744; cv=none; b=YCX4IiSgaxo7dw5E4gNfcw3aaqejBYRcCFnuM4QFIxkgoBgney1loVZoXYE7C6GNTadzhLfOiPtSFIrDtmZa3tGyGCR6N6idavCCCHK4xPXMTPpZDY5zSoyLGLCtv+gceESTz1iLo6PAQYmjDtGLkFeTJQVjYFLXEotvAOe3EzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075744; c=relaxed/simple;
	bh=h2V2nYKf/+TSic+kt418c8VX513RmVCyVTA4ZzINrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvzQFOB3LtNNGu7ES0szuKomQVvsNBNwCUwzCANN45/MPWWfSQxjUieN+eTKsEMETjt30EEcUVluzZmq8myfBly35OwVXgOZY5iBYk+trr2tHE1ZDacKTV1gvDHajaiMR/Lshpl1aQmndqHLt5uIbfdywodLBtQ/sSk4xCNcI/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-12.bstnma.fios.verizon.net [173.48.114.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51KIMBYL005431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 13:22:11 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 34CFC2E011A; Thu, 20 Feb 2025 13:22:11 -0500 (EST)
Date: Thu, 20 Feb 2025 13:22:11 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Boyang Xue <bxue@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v1] ext4: add test case 061 for ext3 to ext4 conversion
Message-ID: <20250220182211.GD2150479@mit.edu>
References: <20250220072226.175071-1-bxue@redhat.com>
 <20250220151528.GC2150479@mit.edu>
 <CAHLe9YYjX-78hHCb9ftBc3=OsBJBpPmV+5_C=72BRbhOVH8qTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLe9YYjX-78hHCb9ftBc3=OsBJBpPmV+5_C=72BRbhOVH8qTg@mail.gmail.com>

On Fri, Feb 21, 2025 at 01:06:04AM +0800, Boyang Xue wrote:
> > This isn't actually a very exhaustive test of doing a "conversion".
> > If you really want to do a "coversion" test, what I'd recommend is to
> > fill the TEST_DEV to be about 50% full, and then make the changes to
> > the file system features, and then running the xfstests using the ext4
> > file system type without SCRATCH_DEV being set up.  This would do a
> > much better job of testing this case, without needing to add a new
> > test to xfstest that to be honest, isn't really all that effective at
> > testing this case.
> 
> I'm curious why the TEST_DEV is about 50% full is more effective at
> testing this case?

The reason why this is useful is because we are starting with a file
system that 50% of the space filled with files using indirect files,
and when you run the tests, you are created and deleting files using
extents.  That's actualy not perfect.  What we would want to do is to
create ext2/ext3-style files using indirect block maps, that would
then be mutated using fstress and fsx in parallel with files being
created, mutated, and deleted using extent-mapped files.

The basic idea is that you want to actually exercise *using* the file
system after it is converted -- reading and writing files, allocating
and dealocating blocks and inodes, after converting the file sytem --
and then making sure that the kernel doesn't crash or result in a
corrupted file system.

Your proposed test just fills the file system, unmounts it, uses
tune2fs to add the extents feature flag, and then runs e2fsck on the
file system, and then tries mounting the file system.  That's pretty
much guaranteed to work, since running fsck.ext4 on a file system that
was originally created as ext3, with lots of indirect mapped files,
and then adding the extent flag, essentially exercises *zero*
new or different code paths.

Cheers,

					- Ted
