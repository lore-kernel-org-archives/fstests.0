Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971C27511A
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741277; cv=none; b=pYL6wTupF8tRrGhiu/umW5UbVSt89wJ2DWc7YDgYqLV+kmKjy+2skfoS3CeGPEofrAD5IBIaDU+LC4sM6hGRsaDAA6xxkGSqSVx9jk4bCN9DL9anaHW5Y+ajKXWRy3Wkwma7mvHv5w0g9/5dPcO5ETZezIAsBaAPDQeXy26IAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741277; c=relaxed/simple;
	bh=aFPffuXeIlWTFok7DUQOkl0grOvv4v5SdRY9SVRBYwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXZkrKdcs7ftmfSgY9g41/GZiScnHVWKghXs3kTIZBqbOMbrLf/EUW07Rqu5EpfKSu6c6gjPUt/J4x/71IEWM1YO0GalBl8w/LWpEgO9aoozB8UNIahiWqMFxKzSdUzwyCAOmlbe3EaHTz4tU/886tAOUdzD7UWvg1R2gL5epcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFtYFth+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFtYFth+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DEFC4CEEA;
	Thu, 12 Jun 2025 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749741276;
	bh=aFPffuXeIlWTFok7DUQOkl0grOvv4v5SdRY9SVRBYwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TFtYFth+Nc+Z/3WG1ucy5Oa8gOHUz+YgwbKWO6u1suywsmHpQjSD3vADYf8D8YNQ8
	 AEysIrc/t3H2d4zxSA5IBYmsYEKhOF/rwYoegd4Xzy5o4lJ0D1Ne2p6tPRt+ug7ef6
	 LVrgfWjpudLWMxekE6essaD4a1ilHtgcj1pzdic5NV5CTLu4Nr5pNlGx06Dys0DUh8
	 vQousKWJ3avVEygRHEYgFXGJbgr/H9BrLduImTmMplNgtfhquX97b7XBzit7JWoNQE
	 u22x2ei6LxJnhESyFtW94bVSjWhx7aaraeQnxGt91Kb5BVN02SlHTlfXI0d2lnsshO
	 uWqBHVjEOUzTA==
Date: Thu, 12 Jun 2025 08:14:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <20250612151435.GT6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
 <20250611144558.GJ6143@frogsfrogsfrogs>
 <aEpzYbXmPf1X4-MI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEpzYbXmPf1X4-MI@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Jun 12, 2025 at 11:57:45AM +0530, Ojaswin Mujoo wrote:
> On Wed, Jun 11, 2025 at 07:45:58AM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 11, 2025 at 03:04:50PM +0530, Ojaswin Mujoo wrote:
> > > Stress file with atomic writes to ensure we excercise codepaths
> > > where we are mixing different FS operations with atomic writes
> > > 
> > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/771     | 49 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/771.out |  2 ++
> > >  2 files changed, 51 insertions(+)
> > >  create mode 100755 tests/generic/771
> > >  create mode 100644 tests/generic/771.out
> > > 
> > > diff --git a/tests/generic/771 b/tests/generic/771
> > > new file mode 100755
> > > index 00000000..690dfa0a
> > > --- /dev/null
> > > +++ b/tests/generic/771
> > > @@ -0,0 +1,49 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > > +#
> > > +# FS QA Test 771
> > > +#
> > > +# fuzz fsx with atomic writes
> > > +#
> > > +. ./common/preamble
> > > +. ./common/atomicwrites
> > > +_begin_fstest rw auto quick atomicwrites
> > > +
> > > +# Import common functions.
> > > +. ./common/filter
> > > +
> > > +_require_test
> > > +_require_odirect
> > > +_require_scratch_write_atomic
> > > +
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount  >> $seqres.full 2>&1
> > > +
> > > +testfile=$SCRATCH_MNT/testfile
> > > +touch $testfile
> > > +
> > > +awu_max=$(_get_atomic_write_unit_max $testfile)
> > > +blksz=$(_get_block_size $SCRATCH_MNT)
> > > +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> > > +
> > > +# fsx usage:
> > > +#
> > > +# -N numops: total # operations to do
> > > +# -l flen: the upper bound on file size
> > > +# -o oplen: the upper bound on operation size (64k default)
> > > +# -w writebdy: $psize would make writes page aligned (on i386)
> > > +# -Z: O_DIRECT (use -R, -W, -r and -w too)
> > > +# -W: mapped write operations DISabled
> > > +
> > > +_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full
> > 
> > Don't we already get fsx stress testing RWF_ATOMIC through generic/521
> > and generic/522?
> 
> So for RWF_ATOMIC we need to pass the -a flag to fsx which the other tests
> don't do. This test specifically passes -a to make sure we stress the
> RWF_ATOMIC code path intermixed with other operations. Further, other
> tests run FSX on test device whereas for our atomic write tests we
> generally assume the scratch dev is the one with atomic capabilities.

Oh, I overlooked the part where it's not enabled by default if its
presence can be detected by fsx.  Can we flip the polarity of -a, that
way RWF_ATOMIC will get tested with all the other fsx soak tests?

> > Also why is mmap write disabled?
> 
> I thought it'd be better to not mix mmap writes with direct writes but I
> can add it back if that's preferred.

It's not unreasonable that some dumb program is going to try that some
day, even though we all scream for ice crea^W^W^Wnot to mix the two IO
paths.

--D

> Regards,
> ojaswin
> > 
> > --D
> > 
> > > +status=$?
> > > +
> > > +if [[ "$status" != "0" ]]
> > > +then
> > > +	echo "Somthing went wrong, check $seqres.full"
> > > +fi
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/771.out b/tests/generic/771.out
> > > new file mode 100644
> > > index 00000000..c2345c7b
> > > --- /dev/null
> > > +++ b/tests/generic/771.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 771
> > > +Silence is golden
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 
