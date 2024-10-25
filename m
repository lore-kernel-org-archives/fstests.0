Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DB171E43
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729829716; cv=none; b=AMLBfYKkt+d84a1IN6B+nTx679G024KrggO+Cvz+DvUeaUFyaKIHVU53eLvTnxl948ie3erFyKW8OhBtC4PvAOorQfi8srAX8Ne/59RBM1yLAz8FkD87g6Pb8MXxzS0Mdr2jC5wlAMSzxDDrQl6dkRVdOH8kOBeyd2nnmMMX/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729829716; c=relaxed/simple;
	bh=L4+h0L1CvCYWIw5G7Qhyt334dwBamj7EEw94vE22jH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f53sChHw8C3+xabd/db8Of+x4t2bDe1+nfLii4IfY9FNJocmUGKEjhjYI1hXRRl+1RASMXI5NLZEQ+JH4gqbvR5AqZNvuylZYUN363SvZFqHvwt9NAwHsEkJj5Z7X6vgKnZLejO73PcRoJL8vDIUXPO+Zk0ZTo7b7FJRDinDs68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHxRiFpd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHxRiFpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729829712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uQZuyv5nB6OogUunIX1YoyHSut6KP4K8BhXzcxr7hwA=;
	b=dHxRiFpdpv3X7VEy/W72DyWIkOUGYQlWJFy5bpp9iIiudD/oAVv00Q31/JQQzPt0CR4/Ds
	FQBoYuuXxdU9weo/f5AzcRtlot8AHzNPjIdnduDEhj/Me6X50Ig2I2C7HENXYpZMXvaw9N
	quHuhg7Z2Jf/JsYlJ1Otjc/I8c8CLfM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-8xhUxAZYOl27RP6AtrC_CA-1; Fri, 25 Oct 2024 00:15:09 -0400
X-MC-Unique: 8xhUxAZYOl27RP6AtrC_CA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2e8a71e3aso2172142a91.3
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 21:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729829708; x=1730434508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQZuyv5nB6OogUunIX1YoyHSut6KP4K8BhXzcxr7hwA=;
        b=f6C8/FcXJ6JBj6M0mCo8PnaHPs3uXnrSX8eGCKuQT38qr56wd7y9QyfKGnTnxQZGeR
         IR4rRYWiJVv27G0bSwSCAqU2soGiUQJMljkWl7jpfsSTlQfXmWBUW0QcBbX50wwwi6Qp
         VK9RNIrtY1IIl8LHHa7Jfg2xLcxUIXuyIb9ldm8YZ+/EEn3ViSk94nfkrn//0WTqd9wj
         PFlHu6cw94EX5U34qq5qVEhCapHhkvfWw3EO2BaTCtMDJvR+DnZPHeOMHcsXRQ1DQUaI
         rpNf+MrB45wLxKLMZhZgRzEiGsCtoxD7a8TmeMIgzb7B0UdegWfIOhKY53/LhvlkYkDU
         kAEw==
X-Forwarded-Encrypted: i=1; AJvYcCXwth+fQq44cq1fuRIFNXORIDIwmOVXUyzdehfBe98J3Ub+S9fSZSSvEl9PvcBr7KbwJzCq3BT2@vger.kernel.org
X-Gm-Message-State: AOJu0YwILaFYDm8M/mGid/BLpRVEJCjkQblyoqCXJsQK9QqqCvAu69Ww
	wI1gz4iegadWtMOFU84c61iBQVg7lwvzHnViZxVwtHYw7nam8RvxV/Qzqyv6KcUXlQCp5YU5w2D
	vFqOLbzsE32CmxOf5OvnSeJnLhbLiZmqvC7tiI5qFQLnNTioQLBLn1JM=
X-Received: by 2002:a17:90b:2ec8:b0:2e2:bfb0:c06 with SMTP id 98e67ed59e1d1-2e76b5dde50mr8533969a91.12.1729829707882;
        Thu, 24 Oct 2024 21:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuLeO5xufOlVUDrPsPkwWmkEsKaCz9qNYx/kQdYxGRmls+bgEy4/45lY9Ah6aHNypwf6mZNg==
X-Received: by 2002:a17:90b:2ec8:b0:2e2:bfb0:c06 with SMTP id 98e67ed59e1d1-2e76b5dde50mr8533957a91.12.1729829707462;
        Thu, 24 Oct 2024 21:15:07 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bdfesm2372937a91.10.2024.10.24.21.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 21:15:06 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:15:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Nirjhar Roy <nirjhar@linux.ibm.com>, fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, ojaswin@linux.ibm.com, zlang@kernel.org
Subject: Re: [PATCH 1/2] common/xfs,xfs/207: Adding a common helper function
 to check xflag bits on a given file
Message-ID: <20241025041501.jzj7b2ensn6lvpep@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
 <6ba7f682af7e0bc99a8baeccc0d7aa4e5062a433.1729624806.git.nirjhar@linux.ibm.com>
 <20241025025651.okneano7d324nl4e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241025040703.GQ2578692@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025040703.GQ2578692@frogsfrogsfrogs>

On Thu, Oct 24, 2024 at 09:07:03PM -0700, Darrick J. Wong wrote:
> On Fri, Oct 25, 2024 at 10:56:51AM +0800, Zorro Lang wrote:
> > On Wed, Oct 23, 2024 at 12:56:19AM +0530, Nirjhar Roy wrote:
> > > This patch defines a common helper function to test whether any of
> > > fsxattr xflags field is set or not. We will use this helper in the next
> > > patch for checking extsize (e) flag.
> > > 
> > > Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
> > > ---
> > >  common/xfs    |  9 +++++++++
> > >  tests/xfs/207 | 14 +++-----------
> > >  2 files changed, 12 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/common/xfs b/common/xfs
> > > index 62e3100e..7340ccbf 100644
> > > --- a/common/xfs
> > > +++ b/common/xfs
> > > @@ -13,6 +13,15 @@ __generate_xfs_report_vars() {
> > >  	REPORT_ENV_LIST_OPT+=("TEST_XFS_REPAIR_REBUILD" "TEST_XFS_SCRUB_REBUILD")
> > >  }
> > >  
> > > +# Check whether a fsxattr xflags character field is set on a given file.
> > 
> > Better to explain the arguments, e.g.
> > 
> > # Check whether a fsxattr xflags character ($2) field is set on a given file ($1).
> > 
> > > +# e.g. fsxattr.xflags = 0x0 [--------------C-]
> > > +# Returns 0 if passed flag character is set, otherwise returns 1
> > > +_test_xfs_xflags_field()
> > > +{
> > > +    $XFS_IO_PROG -c "stat" "$1" | grep "fsxattr.xflags" | grep -q "\[.*$2.*\]" \
> > > +        && return 0 || return 1
> > 
> > That's too complex. Those "return" aren't needed as Darrick metioned. About
> > that two "grep", how about combine them, e.g.
> > 
> > _test_xfs_xflags_field()
> > {
> > 	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat" "$1")
> > }
> > 
> > 
> > 
> > > +}
> > > +
> > >  _setup_large_xfs_fs()
> > >  {
> > >  	fs_size=$1
> > > diff --git a/tests/xfs/207 b/tests/xfs/207
> > > index bbe21307..adb925df 100755
> > > --- a/tests/xfs/207
> > > +++ b/tests/xfs/207
> > > @@ -15,21 +15,13 @@ _begin_fstest auto quick clone fiemap
> > >  # Import common functions.
> > >  . ./common/filter
> > >  . ./common/reflink
> > > +. ./common/xfs
> > 
> > Is this really necessary? Will this test fail without this line?
> > The common/$FSTYP file is imported automatically, if it's not, that a bug.
> 
> If the generic helper goes in common/rc instead then it's not necessary
> at all.

Won't the "_source_specific_fs $FSTYP" in common/rc helps to import common/xfs?

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > >  
> > >  _require_scratch_reflink
> > >  _require_cp_reflink
> > >  _require_xfs_io_command "fiemap"
> > >  _require_xfs_io_command "cowextsize"
> > >  
> > > -# Takes the fsxattr.xflags line,
> > > -# i.e. fsxattr.xflags = 0x0 [--------------C-]
> > > -# and tests whether a flag character is set
> > > -test_xflag()
> > > -{
> > > -    local flg=$1
> > > -    grep -q "\[.*${flg}.*\]" && echo "$flg flag set" || echo "$flg flag unset"
> > > -}
> > > -
> > >  echo "Format and mount"
> > >  _scratch_mkfs > $seqres.full 2>&1
> > >  _scratch_mount >> $seqres.full 2>&1
> > > @@ -65,14 +57,14 @@ echo "Set cowextsize and check flag"
> > >  $XFS_IO_PROG -c "cowextsize 1048576" $testdir/file3 | _filter_scratch
> > >  _scratch_cycle_mount
> > >  
> > > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> > >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> > >  
> > >  echo "Unset cowextsize and check flag"
> > >  $XFS_IO_PROG -c "cowextsize 0" $testdir/file3 | _filter_scratch
> > >  _scratch_cycle_mount
> > >  
> > > -$XFS_IO_PROG -c "stat" $testdir/file3 | grep 'fsxattr.xflags' | test_xflag "C"
> > > +_test_xfs_xflags_field "$testdir/file3" "C" && echo "C flag set" || echo "C flag unset"
> > >  $XFS_IO_PROG -c "cowextsize" $testdir/file3 | _filter_scratch
> > >  
> > >  status=0
> > > -- 
> > > 2.43.5
> > > 
> > > 
> > 
> 

