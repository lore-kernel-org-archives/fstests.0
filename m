Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C42225A59
	for <fstests@vger.kernel.org>; Tue, 12 Aug 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987325; cv=none; b=hCogke6bZ2y8hlBxNyDLDDm91IToqZZYAkjODZ8EMukr8UWK0her7NI2lablBtHwS2r6I8j6c6eV2806mZ/JWhnRmI92MANz/a8v/Lvt4TurcFBYVqW7QP5eVEEvBGWbSpRp4Nrggo9ZnSrdlMDR8SOpB0FDg8mgkvNix92mtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987325; c=relaxed/simple;
	bh=y9ANBD0GlAZDEZXdoqhazIsTPRQvGJpLNTCiGq6kCDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2k8zLpbyOQ6gEnN0GPc2mFj/MZtV9Q4escs5+WSSQcgD9rbsN+vXj0NeXbOjGA2ON6VI9VUlJrQTSVuqz78IbkIz/i8OGLobzs6c+H+nw6I2MtABx1EqpuPpoHTciHnZfRbMN6SDdwgQFXB3FySGwo959Ekg/JWzI7FqUZB6iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2izlEq/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2izlEq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754987322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b33Mt+ahkHKcI0mp391l8bT5odu6lhBKIaGz4Dml3AY=;
	b=Z2izlEq/ZqPS3u2QBegUK1VRZfO4vjV1fJrlN6rrIIAc6cPqpBoCTxpUcQ78NzQinQOOs9
	5iO41Rf9ImlE+XoC+N22MIhHJQ4X51BsDA8LgYAAVTlUBo4UunfA2qqt7EuW+1kF8bUS+R
	aH5i0UcW20OD1y15+vdSJWzEYCLU3TY=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-LbKGQuN0O0i_ubmGFNgrfA-1; Tue, 12 Aug 2025 04:28:41 -0400
X-MC-Unique: LbKGQuN0O0i_ubmGFNgrfA-1
X-Mimecast-MFC-AGG-ID: LbKGQuN0O0i_ubmGFNgrfA_1754987320
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so5127714b3a.2
        for <fstests@vger.kernel.org>; Tue, 12 Aug 2025 01:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987320; x=1755592120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b33Mt+ahkHKcI0mp391l8bT5odu6lhBKIaGz4Dml3AY=;
        b=F8mFQqMKFYmjzZzpP/m87F3T+Zu88eU49cH2xP9VLiBF8GkeOonSpv2f7dKBTxJEKe
         tkkwUiBQM162x+W5BwSTWC929GOxGzb3m5OEu+ebtsgNm4s9ydvb7kBz+zEqIsQVaiDy
         kKzYC9m8y3Od1HnKEjUjcAVrmK9FraShCuYSqCs5Od6wdHJqvFX/p2vhmZDGXRMQ5Jyd
         Kv0BNkDK6OIIMjZqhPk9SfUXhS/0yPR8xSzqkmgJnCr6hwY31dq1h+yC/uy5gkXxou+S
         X4PHJbwGWexmnTWyTKtwNBdiLU4xh2831NfjCI+q9xI1hewxapfwMa+HNQbSkve1gUMR
         ZhRA==
X-Gm-Message-State: AOJu0YwOmTkNPZA74nJxngYBxTFgG4bqv3mQeUUfh814Rn6roVd+8NvW
	5t7IHZxIAt7X1S01XtbGS4Rz7c54Ea2FMhExcNI1+ihoWyfouV86KiONnOQjmsrMja8lm5uUySc
	MvcI1j0cki0FgaOvJ/G8LMhWOlaFJ+FGF/vA+mh5Ls3UJ564DzOtss8XucYwONTOhlsU=
X-Gm-Gg: ASbGncsyPAVPMKKxBRJcnfPJDvOa+/u9joCTRRNbvWNIzxG7RcV6lW8MTltU3jC5fvp
	8DwUFTNo1WBurTG0LY2fpSHa7RLDozQxZWCtT/pgL6Xkm2iPkVmfvan/c/GxEJmWRVcAhSrRHou
	dqDCGAtMW6y3HA1l8UxJnmIV8rx7rkX23xXCPJpOGtMX1ZEwzuZlE7dvAT/Z164PYiBBal2K7/b
	6qIoshBj7VyFj5xZ3EVIUf6Jbi79jKXix8IYba4HC7CahlpIcByAqQV36BKeFzF5FOtlMjHlvmO
	ZGDi+wxKKbGEGSAUjT4wdE664CA/3IvBwBqa9cIUd3aqA/KsCGnYgv97Q3PowfviT0Ot/gU5LaH
	MQKQc
X-Received: by 2002:a05:6a00:b46:b0:76b:f01c:ff08 with SMTP id d2e1a72fcca58-76e0de2de8emr3330927b3a.2.1754987319756;
        Tue, 12 Aug 2025 01:28:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8gVQTICViLXNw1QYG44wZtLxxcp+rbiPwodVrIUjocGCpA+tNgEwxsvDFYEV22ohP6vh0uw==
X-Received: by 2002:a05:6a00:b46:b0:76b:f01c:ff08 with SMTP id d2e1a72fcca58-76e0de2de8emr3330899b3a.2.1754987319285;
        Tue, 12 Aug 2025 01:28:39 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf77210aesm22735184b3a.113.2025.08.12.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:28:38 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:28:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/131: test iomap zero range via fsx and error tag
Message-ID: <20250812082835.m5kavpacurvezj4w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250807145626.564764-1-bfoster@redhat.com>
 <20250811181908.xmzp5wpqg5w3tgyb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aJpCTGS3bdYkVP2n@bfoster>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJpCTGS3bdYkVP2n@bfoster>

On Mon, Aug 11, 2025 at 03:19:40PM -0400, Brian Foster wrote:
> On Tue, Aug 12, 2025 at 02:19:08AM +0800, Zorro Lang wrote:
> > On Thu, Aug 07, 2025 at 10:56:26AM -0400, Brian Foster wrote:
> > > iomap supports a zero range operation based on buffered writes. This
> > > mechanism is used in limited spots, such as partial block zeroing,
> > > etc., because usually for larger zeroing ops it is more efficient to
> > > punch a hole and allocate unwritten extents.
> > > 
> > > This means iomap zero range has limited production test coverage
> > > even though it has some particular corner cases that warrant test
> > > coverage. XFS supports an error injection knob to force use of iomap
> > > zero range on fallocate zero range operations. Add a test to run fsx
> > > with this knob enabled to provide more zeroing test coverage.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > > 
> > > FYI, this test is intended to go along with this patch[1] that
> > > introduces the errortag.
> > > 
> > > [1] https://lore.kernel.org/linux-fsdevel/20250807144711.564137-8-bfoster@redhat.com/
> > > 
> > >  tests/xfs/131     | 26 ++++++++++++++++++++++++++
> > >  tests/xfs/131.out |  2 ++
> > >  2 files changed, 28 insertions(+)
> > >  create mode 100755 tests/xfs/131
> > >  create mode 100644 tests/xfs/131.out
> > > 
> > > diff --git a/tests/xfs/131 b/tests/xfs/131
> > > new file mode 100755
> > > index 00000000..eb8882a3
> > > --- /dev/null
> > > +++ b/tests/xfs/131
> > > @@ -0,0 +1,26 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 Red Hat, Inc..  All Rights Reserved.
> > > +#
> > > +# FS QA Test 131
> > > +#
> > > +# Run fsx with XFS force_zero_range error injection enabled. This is a proxy
> > > +# test for iomap zero range. Zero range is used in limited cases by default,
> > > +# such as EOF zeroing on file extension, etc. This error tag forces use of iomap
> > > +# zero range for fallocate zero range operations.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick zero
> > > +
> > > +# Import common functions.
> > > +. ./common/inject
> > > +
> > > +# Modify as appropriate.
> > > +_require_test
> > > +_require_xfs_io_error_injection "force_zero_range"
> > > +
> > > +_test_inject_error "force_zero_range"
> > > +run_fsx "-q -S 0 -N 100000"
> > 
> > Just check with you, if you hope to have a $TIME_FACTOR with -N at here.
> > 
> 
> So do you just mean to make it 100000 * $TIME_FACTOR so the runtime can
> be increased via configuration, if desired? If so, that sounds
> reasonable to me (same for your tweak in the other email as well).

Sure, only $TIME_FACTOR. As this is an error injection test, so I think
we don't need to add this test to soak group and use $SOAK_DURATION (except
you intend that). I'll merge this patch with the $TIME_FACTOR.

Thanks,
Zorro

> 
> > This test case looks good to me with this patch:
> > https://lore.kernel.org/linux-xfs/20250807144711.564137-8-bfoster@redhat.com/
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> 
> Thanks!
> 
> Brian
> 
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/xfs/131.out b/tests/xfs/131.out
> > > new file mode 100644
> > > index 00000000..2ca0d932
> > > --- /dev/null
> > > +++ b/tests/xfs/131.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 131
> > > +fsx -q -S 0 -N 100000
> > > -- 
> > > 2.50.1
> > > 
> > > 
> > 
> 

