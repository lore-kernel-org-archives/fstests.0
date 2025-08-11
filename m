Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351D71FDA
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939751; cv=none; b=leN7tZ5XOXyFKTE5HM1Y58W4WJt36ll/KH7C/tneQrebEYArVr6f+C59MZ4mw5zphKCAbHTk5TgLSSQYgkK8FF07w3I4QjCH1ismccwtMzSLdSuaV71/NQIH29qC1dka0g9RQ3/JRDdBWm7opquM6uCUIdAyliw/xTrZa0sRGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939751; c=relaxed/simple;
	bh=/a4lRrxxaMx5+NSNtiBA4lZ0j+y0OhTRw4rNb3zfqnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZfGJD5WXVQnyf5oO+ejMksBlxH4rk58zeWGmA5B1W/FCF0bswRvxrXhK07VEn7UolgwjJJMwx7NRqQ3DyeQB5eamVp/bYBfIrFBMEH5MbkN/hwAlzqWc7hrHeiCkTIyaH3VIJmJrka33SC/j031zOzPs5XZgOx7bGiYyCVaHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsMjhVo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsMjhVo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754939749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvm1ldWUx7kJ56vM8s68ygTxFiJPAQHw34i423yl0wY=;
	b=YsMjhVo7B88PqK7XMo6jiA5n3hXpD4yFdg0G/0j8TiynNl96zxN3cKSuDPo3wNx8zFqYOg
	OHDj/vAl0om1QtsPLzod+AtXLBrB5CoLIrAo8Fsr9398/9Wr7NFIJORH5IbGz0faCWiUtB
	DNN0k2q7ATPCCL11hxuF4W+6sngjtGc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-2-p0uzAMM3G0-w91slJ7sA-1; Mon,
 11 Aug 2025 15:15:47 -0400
X-MC-Unique: 2-p0uzAMM3G0-w91slJ7sA-1
X-Mimecast-MFC-AGG-ID: 2-p0uzAMM3G0-w91slJ7sA_1754939747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE4F319560BD
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 19:15:46 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.68])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56407300145D;
	Mon, 11 Aug 2025 19:15:46 +0000 (UTC)
Date: Mon, 11 Aug 2025 15:19:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/131: test iomap zero range via fsx and error tag
Message-ID: <aJpCTGS3bdYkVP2n@bfoster>
References: <20250807145626.564764-1-bfoster@redhat.com>
 <20250811181908.xmzp5wpqg5w3tgyb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811181908.xmzp5wpqg5w3tgyb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Aug 12, 2025 at 02:19:08AM +0800, Zorro Lang wrote:
> On Thu, Aug 07, 2025 at 10:56:26AM -0400, Brian Foster wrote:
> > iomap supports a zero range operation based on buffered writes. This
> > mechanism is used in limited spots, such as partial block zeroing,
> > etc., because usually for larger zeroing ops it is more efficient to
> > punch a hole and allocate unwritten extents.
> > 
> > This means iomap zero range has limited production test coverage
> > even though it has some particular corner cases that warrant test
> > coverage. XFS supports an error injection knob to force use of iomap
> > zero range on fallocate zero range operations. Add a test to run fsx
> > with this knob enabled to provide more zeroing test coverage.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> > 
> > FYI, this test is intended to go along with this patch[1] that
> > introduces the errortag.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20250807144711.564137-8-bfoster@redhat.com/
> > 
> >  tests/xfs/131     | 26 ++++++++++++++++++++++++++
> >  tests/xfs/131.out |  2 ++
> >  2 files changed, 28 insertions(+)
> >  create mode 100755 tests/xfs/131
> >  create mode 100644 tests/xfs/131.out
> > 
> > diff --git a/tests/xfs/131 b/tests/xfs/131
> > new file mode 100755
> > index 00000000..eb8882a3
> > --- /dev/null
> > +++ b/tests/xfs/131
> > @@ -0,0 +1,26 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Red Hat, Inc..  All Rights Reserved.
> > +#
> > +# FS QA Test 131
> > +#
> > +# Run fsx with XFS force_zero_range error injection enabled. This is a proxy
> > +# test for iomap zero range. Zero range is used in limited cases by default,
> > +# such as EOF zeroing on file extension, etc. This error tag forces use of iomap
> > +# zero range for fallocate zero range operations.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick zero
> > +
> > +# Import common functions.
> > +. ./common/inject
> > +
> > +# Modify as appropriate.
> > +_require_test
> > +_require_xfs_io_error_injection "force_zero_range"
> > +
> > +_test_inject_error "force_zero_range"
> > +run_fsx "-q -S 0 -N 100000"
> 
> Just check with you, if you hope to have a $TIME_FACTOR with -N at here.
> 

So do you just mean to make it 100000 * $TIME_FACTOR so the runtime can
be increased via configuration, if desired? If so, that sounds
reasonable to me (same for your tweak in the other email as well).

> This test case looks good to me with this patch:
> https://lore.kernel.org/linux-xfs/20250807144711.564137-8-bfoster@redhat.com/
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 

Thanks!

Brian

> > +
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/xfs/131.out b/tests/xfs/131.out
> > new file mode 100644
> > index 00000000..2ca0d932
> > --- /dev/null
> > +++ b/tests/xfs/131.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 131
> > +fsx -q -S 0 -N 100000
> > -- 
> > 2.50.1
> > 
> > 
> 

