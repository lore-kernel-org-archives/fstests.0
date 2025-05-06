Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B91EB182
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560165; cv=none; b=CheQNJ7YdBz/nMI1rs8n1gCaWlnELQtw+M0/ePJEkh5rUu99i3UM4kI7OZBpJUslPWJGviNAfcNzK35NeWu4kBUlBYFvysYy5bfftizQ5PcND6V86nlVP3VgnKGE58KkaWh4KN9cCzsSKWv6dL8YDq80Pq2UGnQgSOmkl4iX+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560165; c=relaxed/simple;
	bh=0eIysUF5njc4VkshtwO4iAeDnr7fqlNJmozempjgDg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJd7HLM3CPPxNOQ1Vycb/n6LCsHkr49W770VrrAMAo8xLZyViOSb/B4JReJylQWOzadnvoaTgGxE3lF/BgSyy5b5PrVJ+3yWgTdbHOh+OgtcW561qGl5M1DGvY2SGaCzyO1NoEiTUXFdLRv1XOsPjDDHzrtjd3IiyWeHuOF8Aqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TGKrp4Oj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGKrp4Oj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746560162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlccjetcOiFoNBMq1PHkU/DMSj79dwUFrKyd+ujZry8=;
	b=TGKrp4OjEK46fnoLYr2T1zN6Fzg0G7gg74loNAIQZ/puTpVfVOoFnulmEzCyogO/rlReMm
	fDs6g4ezS10k40qaRxwJTikeKoMBfYvy0gem6ODEm4+atmb1Hy+kcyuxBFzaxbJiKz04Rx
	7so2w3AbX+j9Dv666jmHWsafN4G0WAg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-h3u9LZmOOOS5iltFuZ9-Wg-1; Tue, 06 May 2025 15:35:59 -0400
X-MC-Unique: h3u9LZmOOOS5iltFuZ9-Wg-1
X-Mimecast-MFC-AGG-ID: h3u9LZmOOOS5iltFuZ9-Wg_1746560158
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22e40e747a3so8365865ad.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560158; x=1747164958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlccjetcOiFoNBMq1PHkU/DMSj79dwUFrKyd+ujZry8=;
        b=bTCv7sMLMx65xZC0JM4nq6k/jsi82b3V3eXOZkcPKK9UsBxIvakxcmv5yFwWx/IeCz
         fJJBz5jx/XcTOCgrhs+z1IU9lQfKJoWebUMD1mNq2aCsW3cQ6LoMk8MO1v7x2J3X8bpy
         KakCXE0iqHgV+xbn+Xf92xg8X2C5jvD/O8Enb8KpOqXGl7hE8jSToLIjEleJfFVBgqED
         IsjRN+FwMMe7ituxRv5ZNbcS576YbLxYfzuTxnqza2AKfaJ5n8wAsPZK7uYBltowl1VP
         B7RQtwreJ8OwzwJDHsLpXj1rFVikA5zawZcH1BuIugSyvkx2awha27Nd2wlFR5++nH78
         iSDg==
X-Forwarded-Encrypted: i=1; AJvYcCVSE1mB17zX7Pkz60Jkg9OJPR1TshCA+DmZBl+jxi6wJBWAwNsytcAWSiSsVF+nKuziow69Jc5H@vger.kernel.org
X-Gm-Message-State: AOJu0YyEc7tkibmVkOnS9lGuxjwRfJCX98sxMjWlPE2wglTvjGAZfbFj
	LBoXPg0LFCJO/inf2Nv++bG2Spdk0EhSlNhQK1Homd+T1mF4MdokAO1DOuBubGNDhH5ib/vKWUM
	Yp/oA1OYbW0715iPwPQDrOvyiC+LkZWhGfO3Dat4OkjUEqHo3f9fPfxw=
X-Gm-Gg: ASbGnctnAsn0O3F2V6lLg4mH3wMbhQ54louMg/lyDAupWPzkZmPAOXGtdO5vU2nfCIn
	JSmrDmx0tA0xa+4x1SsHwIFRHOgTGgcQ4Z8qDaPqoDUoVg+ex4gJBzwe43mLcTsv3TQCI+NtMY/
	0ANh5pYfqjqB6D8dHBVTYeIK0DH4+1Jgk3nVPqDbeYtw3Y0lGxQGKvAOB79aspnZLXM5gIclHp+
	sCELWC0HSLx6QfUXjQQypdVejpG7QfRntZkzY4RFEnrdE0fF8jm5I5OLZwWxL7BYuZgsSVZ6bvd
	q5x6LLLC+u3725maehFxaE7+6bcbBUwWFAI3Gd7RHDFO58H4tE6q
X-Received: by 2002:a17:903:22cd:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22e5ee1d5a3mr6443005ad.48.1746560158229;
        Tue, 06 May 2025 12:35:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXaUkmzIX6ISVVuvM3v2socpRCWj+mgNkNuzGiAMiabk68CslL2FyQ383GcQbS1Rc8G8xVKQ==
X-Received: by 2002:a17:903:22cd:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22e5ee1d5a3mr6442695ad.48.1746560157815;
        Tue, 06 May 2025 12:35:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9dc9sm78239945ad.87.2025.05.06.12.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:35:57 -0700 (PDT)
Date: Wed, 7 May 2025 03:35:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/15] xfs: add a test to check that data growfs fails
 with internal rt device
Message-ID: <20250506193553.fxwtsheijvvwdh5f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-5-hch@lst.de>

On Thu, May 01, 2025 at 08:42:41AM -0500, Christoph Hellwig wrote:
> The internal RT device directly follows the data device on the same
> block device.  This implies the data device can't be grown, and growfs
> should handle this gracefully.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4204     | 33 +++++++++++++++++++++++++++++++++
>  tests/xfs/4204.out |  3 +++
>  2 files changed, 36 insertions(+)
>  create mode 100755 tests/xfs/4204
>  create mode 100644 tests/xfs/4204.out
> 
> diff --git a/tests/xfs/4204 b/tests/xfs/4204
> new file mode 100755
> index 000000000000..0b73cee23ba5
> --- /dev/null
> +++ b/tests/xfs/4204
> @@ -0,0 +1,33 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4204
> +#
> +# Check that trying to grow a data device followed by the internal RT device
> +# fails gracefully with EINVAL.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto growfs ioctl zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount

Won't $SCRATCH_DEV be unmounted after each test case done. Is there any reason
we must do this in a specific _cleanup?

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +_require_zoned_device $SCRATCH_DEV
> +
> +echo "Creating file system"
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +echo "Trying to grow file system (should fail)"
> +$XFS_GROWFS_PROG -d $SCRATCH_MNT >>$seqres.full 2>&1
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4204.out b/tests/xfs/4204.out
> new file mode 100644
> index 000000000000..b3593cf60d16
> --- /dev/null
> +++ b/tests/xfs/4204.out
> @@ -0,0 +1,3 @@
> +QA output created by 4204
> +Creating file system
> +Trying to grow file system (should fail)
> -- 
> 2.47.2
> 

