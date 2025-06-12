Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855D8F5C
	for <fstests@vger.kernel.org>; Thu, 12 Jun 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740120; cv=none; b=cX+9zUqte2zCNNJ4Uq17IqllMh55RRHWHlXAZerkBlArCAVls40P+YmWdheKvNdTosadpgdkajatHVij9fHsfOWkWJ2CVQp3h0ADWmNzpAU+N5ckVTFEt7n9XcLlObQGf666qDo3qPSKdPVXFLHYoeRGPz5qdMysWx/0r/Uevv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740120; c=relaxed/simple;
	bh=h9XIfDyNCX6G913On//2nPPyBsVyporV20HGL7Ut/gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5s5FFX/rEJWihhZ1QCAUYi5aeXrDOlQ0KJHRzV8Ajp+q9fP0NiaBri+gWKuveHh5BjP9njzBWdjTJhlAzkH5Mvp6m545zYuA6QrLCfabefPU5b1ZdGhkZcJFf4DU5iWETtTN5s0FQTkmd+QPbBMf2x6reyAnRu8PP7Wd57vDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efoqCETv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efoqCETv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A006FC4CEEA;
	Thu, 12 Jun 2025 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740120;
	bh=h9XIfDyNCX6G913On//2nPPyBsVyporV20HGL7Ut/gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efoqCETvrtf4lH4es1R/FIDQ+0CRFZ1Ks9GxghJvot07ZGwyIYYPlP+oWWfu4ZbVX
	 gT61T2PJxx3IlxRJFECxBYW2lQ+Znrd0kTLGlQuarmjTt/nXGatANfFQ4dO2imTiu/
	 TR0ANoX+hKfWIO2XITS0kNkx+ZLyrPvFTRe4oSuB5OLVeZh4t/KrjH0pzaopG2S8xa
	 bX2DbuZHsH96mCvj2E9wc2etJvYhpDz6C9GdEIYBj33eDaxJyB08C1uw+xt3fkXiGz
	 oIV/hgZrvyay3elHJDq0meslNPlUXR4i79srr3+VZ1FEFQtLUt7ZJQwFDA96uS1LRw
	 A7O2B7Q0NbdFw==
Date: Thu, 12 Jun 2025 07:55:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 04/12] generic/767: Add atomic write test using fio crc
 check verifier
Message-ID: <20250612145520.GS6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
 <20250611144225.GI6143@frogsfrogsfrogs>
 <aEpyOHL-K-ErQOrV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEpyOHL-K-ErQOrV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Thu, Jun 12, 2025 at 11:52:48AM +0530, Ojaswin Mujoo wrote:
> On Wed, Jun 11, 2025 at 07:42:25AM -0700, Darrick J. Wong wrote:
> > On Wed, Jun 11, 2025 at 03:04:47PM +0530, Ojaswin Mujoo wrote:
> > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > 
> > > This adds atomic write test using fio based on it's crc check verifier.
> > > fio adds a crc for each data block. If the underlying device supports atomic
> > > write then it is guaranteed that we will never have a mix data from two
> > > threads writing on the same physical block.
> > > 
> > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/767.out |  2 ++
> > >  2 files changed, 86 insertions(+)
> > >  create mode 100755 tests/generic/767
> > >  create mode 100644 tests/generic/767.out
> > > 
> > > diff --git a/tests/generic/767 b/tests/generic/767
> > > new file mode 100755
> > > index 00000000..4f80e7b6
> > > --- /dev/null
> > > +++ b/tests/generic/767
> > > @@ -0,0 +1,84 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > > +#
> > > +# FS QA Test 767
> > > +#
> > > +# Validate FS atomic write using fio crc check verifier.
> > > +#
> > > +. ./common/preamble
> > > +. ./common/atomicwrites
> > > +
> > > +_begin_fstest auto aio rw atomicwrites
> > > +
> > > +_require_scratch_write_atomic
> > > +_require_odirect
> > > +_require_aio
> > > +
> > > +function max()
> > > +{
> > > +	if (( $1 > $2 )); then
> > > +		echo "$1"
> > > +	else
> > > +		echo "$2"
> > > +	fi
> > > +}
> > > +
> > > +function min()
> > > +{
> > > +	if (( $1 > $2 )); then
> > > +		echo "$2"
> > > +	else
> > > +		echo "$1"
> > > +	fi
> > > +}
> > 
> > Should these be common/rc helpers?
> > 
> > Or, since bash is ... uh fun with arguments...
> > 
> > _min() {
> > 	local ret
> > 
> > 	for arg in "$@"; do
> > 		if [ -z "$ret" ] || (( $arg < $ret )); then
> > 			ret="$arg"
> > 		fi
> > 	done
> > 	echo $ret
> > }
> > 
> > and then you can pass as many arguments as you like.  The only downside
> > is that you can pass stringly typed crap "_min cow frog" and it still
> > returns "cow".  As if.
> 
> Yes this makes sense (sans the cow vs frog part :p) . I'll make the change in v2.
> 
> > 
> > > +_scratch_mkfs >> $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +touch "$SCRATCH_MNT/f1"
> > > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > > +blocksize=$(max "$awu_min_write" "$((awu_max_write/2))")
> > > +
> > > +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> > > +blocksize=$(min "$blocksize" "65536")
> > > +
> > > +fio_config=$tmp.fio
> > > +fio_out=$tmp.fio.out
> > > +
> > > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> > 
> > What program is nproc?
> 
> It returns the number of CPUs so we can scale the load based on CPUs we
> have. It comes from coreutils so I think the distros should have it.

Ah, another variant on getconf _NPROCESSORS_ONLN.  Though looking at the
strace I guess its benefit is that it looks at the cpu affinity mask to
compute the number of processors that can actually be used.  Hrm, maybe
that would be a good cleanup for another day...

--D

> 
> Thanks,
> ojaswin
> > 
> > --D
> > 
> > > +SIZE=$((100 * 1024 * 1024))
> > > +
> > > +cat >$fio_config <<EOF
> > > +[aio-dio-aw-verify]
> > > +direct=1
> > > +ioengine=libaio
> > > +rw=randwrite
> > > +bs=$blocksize
> > > +fallocate=native
> > > +filename=$SCRATCH_MNT/test-file
> > > +size=$SIZE
> > > +iodepth=$FIO_LOAD
> > > +numjobs=$FIO_LOAD
> > > +group_reporting=1
> > > +verify_state_save=0
> > > +verify=crc32c
> > > +verify_fatal=1
> > > +verify_dump=0
> > > +verify_backlog=1024
> > > +verify_async=4
> > > +verify_write_sequence=0
> > > +atomic=1
> > > +EOF
> > > +
> > > +_require_fio $fio_config
> > > +
> > > +cat $fio_config >> $seqres.full
> > > +$FIO_PROG $fio_config --output=$fio_out
> > > +cat $fio_out >> $seqres.full
> > > +
> > > +# success, all done
> > > +echo Silence is golden
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/767.out b/tests/generic/767.out
> > > new file mode 100644
> > > index 00000000..2bf7f989
> > > --- /dev/null
> > > +++ b/tests/generic/767.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 767
> > > +Silence is golden
> > > -- 
> > > 2.49.0
> > > 
> > > 
> 
