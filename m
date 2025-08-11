Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E02E174D
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936311; cv=none; b=b8X5QqyBUOI3QJgM4p+BaQagh2lWlgWIfs2hXG+SOIVSRRrDZuZZGFoTAwEe47jbnuU3c4m3zhuptmGp57i8Novlr2flD/lmzUkFTNKb9xUoYNswj/UzQoejGxVQo5BHK4k2yNvosElbrmnvLDE5qcbE21qhsPDAhOxQolR3vpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936311; c=relaxed/simple;
	bh=278LB+F/JpYWyp3Scr9ING3NFA9Kzch6L8LJO3c2y5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fc0g1gWLBDPR06gB31UbXbreGfa29BMEuBY0Bncb385PpRtrJACBOGzGTRrwbvUNLRtI0wydCH1zT2oKQkRJCJRAgifloEaiks5n/jDQLbq7QRI59dHbgMLfUfLxJNIHQcfRibuL0fFzUKi79GqzDAQ5G6L5sxK/ZvDY1ankyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBBoVssR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBBoVssR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lAD+rf/CTMK9ZczcWk4uX22kkA50cFqnLejY2P0NP4k=;
	b=EBBoVssRgs3PeV9HtZIBaUVlM8syNaeRd+ETtXA90XSkrFYMO50W90ewzcZjSPoXpku3LG
	ylp0dxskOnJmCMhkcRyi5i6/3WJ9QsBbQ/oI4rlb1NKu8dYbl0gpmaXefbq3K5aiCz8JQB
	lrGvBH3ey53iqbR0pXveKdmZEBGJolQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-LCk9rsi3PbyEPaba0-5FAw-1; Mon, 11 Aug 2025 14:18:27 -0400
X-MC-Unique: LCk9rsi3PbyEPaba0-5FAw-1
X-Mimecast-MFC-AGG-ID: LCk9rsi3PbyEPaba0-5FAw_1754936306
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459d8020b7bso23758145e9.3
        for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 11:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936306; x=1755541106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAD+rf/CTMK9ZczcWk4uX22kkA50cFqnLejY2P0NP4k=;
        b=m1mTXZa729Prar5Hu5uIUhx196LP+lq6FLjtDZVR1hSTe9TKoxlxjb3awySmXeUa2X
         bIys+NGAXvafnaCLbZrsHYI0kwLssSB/KsrwxbOOYC0740+TBF7oLDCW9fUIBTIOyAdO
         JcmrKtVbvZXRu0QJl7R7h2R7X1i0/V8YTSREhhz6GNQ1ToQE9rn8a7hKZvhDVDITRERd
         ttUg4tyPRyYg8BjBiIXwvS4eydQC+PjK88SaA5r0ujSlkAYWN4j9vlqG/ZHyjWkQZLBM
         QuIhqtukE7kb+jKumFBu1nhVenOiBZi8VBP7sPsTNztSPrAASrUu3wbZOoC/OL0CcF0e
         QcRg==
X-Gm-Message-State: AOJu0YyMdqzebXjxLxmLCJ5IQWvvFtJUnm6PHGyOk18GtNyfoLpvqv5D
	Gr9P+uPd5EgvOGgPmRe4Pf+Y2ffCRJD11fNaDKRJoi4gUuew/d5NP9yJEXAzTvKdUxMFgHWR8vY
	Y1/id9Jz9UicnGkXgBz4s1alH4U1iPP8vN0AiKTx4bLTg/2BgMWpDV0v82A==
X-Gm-Gg: ASbGncumH+dZCQOKjkRNTBwVz62dxVp84LhETdiG709HtO7N3CyNp+R+rohcQereTTz
	/SmGGYZkv0lKj9zi5w0dSNatbsfJO5oYPdynk8L3Tk+4ekcfmPFMRC/BvkyP9BWSSwpsBy0hne5
	13sOE6frCJ2edtCU2Y93DgQeYzVlINOtZU6P26iTRW6vXiTQYzoAeUmDoHizBJWg8F3EueZePJ4
	kkgvZXDQjlHGJqwRdD8PMnSq+k5XkHOdwOzu3wHti3yCEkalQwYCLan+qDJwBvj+o3NOFI1agDV
	OCL8Xz4Zx+d2VdyF00gjtmBq2oL0WnOBH5yGQuwzYN/1zpqtemKrmv4XBMw=
X-Received: by 2002:a05:600c:1c90:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a10b941ddmr7145975e9.4.1754936306152;
        Mon, 11 Aug 2025 11:18:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6y7tsIn2G/sy6tsYCOF6OgvujdY/Mg5JcoMXvxNskFgP3OG39fmK1x2ARU5f0kEII7yPZbg==
X-Received: by 2002:a05:600c:1c90:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45a10b941ddmr7145785e9.4.1754936305759;
        Mon, 11 Aug 2025 11:18:25 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm43024090f8f.40.2025.08.11.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:18:25 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:18:24 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 2/3] generic: introduce test to test
 file_getattr/file_setattr syscalls
Message-ID: <ydu5kha77suh2sn4jmyh4xxj2eiw3g72qvf3b7hy2k5xoh33eu@2vconk3marrs>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-2-6a09c4f37f10@kernel.org>
 <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811175541.nbvwyy76zulslgnq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-08-12 01:55:41, Zorro Lang wrote:
> On Fri, Aug 08, 2025 at 09:31:57PM +0200, Andrey Albershteyn wrote:
> > Add a test to test basic functionality of file_getattr() and
> > file_setattr() syscalls. Most of the work is done in file_attr
> > utility.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  tests/generic/2000     | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/2000.out |  37 ++++++++++++++++
> >  2 files changed, 150 insertions(+)
> > 
> > diff --git a/tests/generic/2000 b/tests/generic/2000
> > new file mode 100755
> > index 000000000000..b4410628c241
> > --- /dev/null
> > +++ b/tests/generic/2000
> > @@ -0,0 +1,113 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 2000
> > +#
> > +# Test file_getattr/file_setattr syscalls
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# Import common functions.
> > +# . ./common/filter
> > +
> > +_wants_kernel_commit xxxxxxxxxxx \
> > +	"fs: introduce file_getattr and file_setattr syscalls"
> 
> As this's a new feature test, I'm wondering if we should use a _require_
> function to check if current kernel and FSTYP supports file_set/getattr
> syscalls, and _notrun if it's not supported, rather than fail the test.

hmm, I don't see where _require_function is defined

Anyway, the _notrun makes more sense, I will look into what to check
for to skip this one if it's not supported

-- 
- Andrey

