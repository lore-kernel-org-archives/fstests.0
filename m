Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA619E7EF
	for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753961; cv=none; b=Vo1fEa+gvXSW7U73D53ilg+Z+zLl6xK0WwoWT4R6vF8Xw+Vc5dzsqdDsPlkrhtZn+HcrKIWbSElJQKGgRlF2PF4UTq6x+lzqTaDrdm6Z4kAVZ8h/0DgsKaH4+BBXS0pWEpE29HMjRlTFY1RfK4okqOLFhEQWRMxf6zJW71PDAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753961; c=relaxed/simple;
	bh=NDFfE9ulhCGoU48psNfOIGkfCOEchsyqgdoNaoXi/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lh90WA+QcS89WrHc9bRyNzfHBQ6xdsNcI7k3YsZnTkzsPQislu2DF5JdBck12zOLsGbfUPEXgBge67W1JGUVt+lM9NLCCFaO7qqv+0Fk3tdKa+UbzhG7tQjftMJCCk4eLa0yZZPtVymnXX4lI/AYpGd46S3dXxriPzAc1IYSS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUM3cJyZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUM3cJyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726753958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3unzzAJvSmtnztsBLm5ryefNZMfxFcR0XbUnhOSCxHc=;
	b=gUM3cJyZTWnrL6XpMMEehnF5/d/WN5pzTxYnf66YrV8U30fBeDB2OJWcDMkFyKCVdfCHGR
	VqkQz33XtBJFaXvvI4Oa7iit6xsDzfYmFNBO7hHqzqYfC8r5uw6hPLWHCxvHtI884kMSxb
	12a4rMoEoB2ztOZvysixPnLeHkB98cg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-tVwOT2LpNP2csueTpAxepw-1; Thu, 19 Sep 2024 09:52:37 -0400
X-MC-Unique: tVwOT2LpNP2csueTpAxepw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7d65a13582dso1105960a12.3
        for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 06:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726753956; x=1727358756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3unzzAJvSmtnztsBLm5ryefNZMfxFcR0XbUnhOSCxHc=;
        b=gdYCtWw/dEG2LpYhyNQ54TLTMAtITh00UTjYBBiMShW3FDyKDcxIBZCYZKjUCXb6j4
         Z8I2BxcrjoZWpsyZXvYIYWkBR5DTj6xAikiovjxXO7FADLY4SxhsG3/4ERKJ5tgREjPE
         cH2QYbhxiUc1eH62xXNG007u0XYaVaYyW90BFIXNuHlgrN8FnDjDxPDwifSx+0CRU2dQ
         Q7ZRqG5/xfwZ2svyjcp+OlzNf2qnKPhhJoiDKP8d14oSTNcME5oA5jozMNIwGFBJG7ME
         WjgYPrbn2yFq+I+Oeqcc2bzd7ki2eZua6C9Vu019O2JET+aB+qp/yLJM2PO0u2giZrIl
         7XxA==
X-Gm-Message-State: AOJu0YxTI9qO3cFmUvaensGtBgg4YLYhEYKDCH8o9m3ZjpNezM0GJizR
	Fg0ONy4+JzSHcSvk2giULDAMm0lqk9eSF6QG7fX3LghsXXxHO82RKKrPpI4OUA9Q3zc1UQAB0WS
	GqmFwxtmKBBkw200ZcnLpF4KsDsZ4H1r1gJEHUaix5BNe0mBJfmd+W7w=
X-Received: by 2002:a17:902:fc4c:b0:208:b468:db21 with SMTP id d9443c01a7336-208b468de27mr162851195ad.30.1726753955978;
        Thu, 19 Sep 2024 06:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeVGpauaCxXxAFA/JHs3lAViaZBXOOJBg14DyeczN2LDhPf8YDEDUO5qkH3OU1lcocGRvBdg==
X-Received: by 2002:a17:902:fc4c:b0:208:b468:db21 with SMTP id d9443c01a7336-208b468de27mr162850795ad.30.1726753955460;
        Thu, 19 Sep 2024 06:52:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079460254dsm80193725ad.114.2024.09.19.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:52:35 -0700 (PDT)
Date: Thu, 19 Sep 2024 21:52:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: fstests@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com
Subject: Re: [PATCH v2] ext4: Regression test for corruption during on-line
 resize
Message-ID: <20240919135231.fye7b6sip47s4col@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240917135813.1375520-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917135813.1375520-1-srivathsa.d.dara@oracle.com>

On Tue, Sep 17, 2024 at 01:58:13PM +0000, Srivathsa Dara wrote:
> Regression test for:
> 	a6b3bfe176e8 ext4: fix corruption during on-line resize
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> ---
> 
> v1->v2:
> - Remove default $MKFS_OPTIONS
> - Unmount the device before running e2fsck

This version is good to me, I'll merge it if no more review points
from ext4 list.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/ext4/060     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/060.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/ext4/060
>  create mode 100644 tests/ext4/060.out
> 
> diff --git a/tests/ext4/060 b/tests/ext4/060
> new file mode 100755
> index 00000000..38d1c8f7
> --- /dev/null
> +++ b/tests/ext4/060
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 060
> +#
> +# This test ensures that kernel avoids FS corruption while online
> +# resizing an ext4 filesystem with disabled resize_inode feature.
> +#
> +# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line resize")
> +# stops the corruption.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto resize quick
> +
> +_supported_fs ext4
> +_fixed_by_kernel_commit a6b3bfe176e8 \
> +	"ext4: fix corruption during on-line resize"
> +
> +_require_command "$RESIZE2FS_PROG" resize2fs
> +_require_command "$E2FSCK_PROG" e2fsck
> +_require_scratch_size_nocheck $((9* 1024 * 1024))
> +
> +# Initialize an EXT4 filesystem with the resize_inode feature disabled,
> +# and a size of 128MiB less than 8GiB, i.e., short of 1 block group in
> +# an 8GiB filesystem.
> +
> +dev_size=$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024))
> +MKFS_OPTIONS="-O ^resize_inode" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1
> +
> +_scratch_mount
> +
> +# Perform online-resize
> +$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
> +
> +_scratch_unmount
> +
> +$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Filesystem corrupted"
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/ext4/060.out b/tests/ext4/060.out
> new file mode 100644
> index 00000000..8ffce4de
> --- /dev/null
> +++ b/tests/ext4/060.out
> @@ -0,0 +1,2 @@
> +QA output created by 060
> +Silence is golden
> -- 
> 2.39.3
> 

