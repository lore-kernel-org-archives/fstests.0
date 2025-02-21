Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2401E9905
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156472; cv=none; b=SIstqD0lxPexTiViu6fSKVUm0ouchhPR85yvRTPEv1kX2LV0FxUrB/Oeg3JGzwPK56zruHHtwyutUiIVouZhS/p4rB3NjmaFw2QvX2X5Ga0V+dPZIHcziDxhUPZn8AVkA5+fi3y0ix8YhcJJql1MGAfI7XQPIV4H0fzkK9ol15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156472; c=relaxed/simple;
	bh=UEhBBl4R2UtHUakkote54lSON4a70yR6Rdc63v0ovF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRS+WpmQltdnKOuJgTVGBWwbEFfLXxSs9EVYJXxGll1VQ5nOPE6p9eOrHlxe9Q//+B1JykMRBLLool3ElFPo0tAKeTGQK9HkupzVfO2jg+Tp+Dn3rsyxRLaDa70B8IdM30OHFFQ2YUwcuaVYzyli+6gXhFV7/439yM1ZmjOVNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyJ34jUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyJ34jUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0671EC4CED6;
	Fri, 21 Feb 2025 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156472;
	bh=UEhBBl4R2UtHUakkote54lSON4a70yR6Rdc63v0ovF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyJ34jUbdBIASd8zX6IZ+qYP6bv4/uGmvpAD2X8C26YV6apGeGxZihyV4cyzdf+mX
	 Iqz14NzcKXI351GNuy4A+guCUJLtOzbjLPAi5/++tJjagIis3+p09N10t8Xat3wsK6
	 i213jD3oPJsKZ1U8/JGU8W2bup++RiVegDjxCC6BJZjVwj1Jx70meFUkTLW6Rn6YfM
	 1uX46MFD+c/CVq43D1T6wDpC56NdPIKuwvUbL6AYjMF5XQPi5H9VeyCElVOR5yLSzh
	 FNJS2IDqvuiB+c21JKgwGDMLCHGLi/KCk0cOmCxD0/3Rw+SYYnijkbe8//7IsG9WLo
	 ol1HtulAwP5aw==
Date: Fri, 21 Feb 2025 08:47:51 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Eric Sandeen <sandeen@redhat.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
Message-ID: <20250221164751.GY21799@frogsfrogsfrogs>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>

On Fri, Feb 21, 2025 at 10:44:09AM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-02-13 at 12:06 -0600, Eric Sandeen wrote:
> > A bug was recently fixed in exfat where attempting to do a zero-byte
> > write would yield -EFAULT; test for that here.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > diff --git a/tests/generic/761 b/tests/generic/761
> > new file mode 100755
> > index 00000000..e933eb83
> > --- /dev/null
> > +++ b/tests/generic/761
> > @@ -0,0 +1,28 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 761
> > +#
> > +# test zero-byte writes
> > +#
> > +# exfat had a regression where a zero-byte write to a file would
> > +# yield -EfAULT. Should work on all filesystems - write should
> > +# succeed and the zero-byte file should be created.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> > +	"exfat: short-circuit zero-byte writes in
> > exfat_file_write_iter"
> > +
> > +# Modify as appropriate.
> > +_require_test
> > +
> > +rm -f $TEST_DIR/testfile.$seq
> > +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> > +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> Minor: Maybe just remove the test file that is created above (since we
> are using the TEST_DIR)and not leave any test artifacts? Or, maybe use
> the scratch device? 

Agreed, the _cleanup should remove the testfile.

Using the scratch device (== additional runtime for mkfs) is overkill
since this test creates a single file but writes nothing to it.

--D

> --NR
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/761.out b/tests/generic/761.out
> > new file mode 100644
> > index 00000000..72ebba4c
> > --- /dev/null
> > +++ b/tests/generic/761.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 761
> > +Silence is golden
> > 
> 
> 
