Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C185947
	for <fstests@vger.kernel.org>; Tue,  3 Sep 2024 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725337300; cv=none; b=hPSu1N4U5AMF6+tItfAi6wTCsDWHsHJXU0SK3Q1X8RlYH3hmoQDI71G1clDqw0b7H9UN7/I+dZcVYRU5r8BORPVvXqT5qxy/Ohg+xNZEBFqrtLDd59iNuGvQht8XRLkZlVooOdnyRDZOh1ypUyaqjVUFr4nYRFUhAEphHaNQv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725337300; c=relaxed/simple;
	bh=I2zd2i4W5VyJTYDUS1DRCWhBEGG9EmETI+dftElULCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8TtXj4+MxXnxzdKBRYTIujPKXZyrJHEbxe/eU5QjNs4o1kgdRsOGPjGpkG195O8NoZ5/OKzt8/SWjtN72gfMEbDLOXHGr78SxKSU0LjJV72vMB1Y+2/Eas3IVi39NjMt5ZEm8QF+/cIl+3jVZDD6SHLdaTTgyAzxlkWZkgzqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaSKRo8I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaSKRo8I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725337297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eiwZQLgviRV/Umg3q5g8rwP8Cx0AwF218F1g4QAmMD8=;
	b=NaSKRo8Ib5qTCN2q64aXGKsqhXrVsxVuqcivN1GY0IO5NgemMoNfdJlr6E7Y0qjFx91Koy
	VbKkA77GqIZ2tNsCjGa3C6EZ2i3VLOev5bsRF/ufPLY02lLS6mF0DHjmaiIOSJjB0n2Gp/
	dvq5XeXCDZZ8lFSRhQbxI2tFZHEsV48=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-CLF2Gh5TMU-GQKtQE6GU1g-1; Tue, 03 Sep 2024 00:21:34 -0400
X-MC-Unique: CLF2Gh5TMU-GQKtQE6GU1g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-714356dfaa4so3969252b3a.3
        for <fstests@vger.kernel.org>; Mon, 02 Sep 2024 21:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725337293; x=1725942093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiwZQLgviRV/Umg3q5g8rwP8Cx0AwF218F1g4QAmMD8=;
        b=MrNfnnD0BKL+Lbl3aEgnWyiihcU09ckGDDbPYViXGnyBGYsItbTJa1Uj8faAT9077A
         3sMoZMR74Q9KhqAjKf7NI5I4gepfVXnOnHtDTsSo3DirUjgtKBx6MLlLQj6unEGdDKi2
         TTMFGSeyPP20eT+JotB2cTYBRYESfzjpO5HAnFEnmQr3AFffkyJx/B6NwQJ4VbGIYCel
         nD+N9hSV4nxPS0Ngb64MCoU1tzgHYU4vZDx7AV1u6O6NjfJYKjqdzcbfSVzMzTIsK1UM
         3JIGtRPNVtUuoeoG02NXHjOmlm6QiWazkwwZClaJqPFnmIg+w7t+ciXvz0R2QEk8kbVM
         x21g==
X-Forwarded-Encrypted: i=1; AJvYcCWOiXF4vCFeo8ObUie4pThQcLQ5yd+GPfxE+mrxvIt5Wg0dO7r1Qdva6sqq1GQtpOhNUeztjmc7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43g9XztZxL/5wzcqgUi+0UvaJZwYoOkfE60ajNNSvdiZ0r/BG
	kx6albC+PsAKfkrUIsxJhlsTVPeeI2Y2b7NPMuUL7OBSYRF654likdWWbYPoxfrczsmr5vto6jL
	0oFdiL1G4o8x+Ka4/nKqOVqrrN+y5PV4vyVorXJ3/ehApPbaUmrCRdWI=
X-Received: by 2002:a05:6a21:6e41:b0:1ce:e114:7143 with SMTP id adf61e73a8af0-1cee114746emr6510626637.54.1725337292980;
        Mon, 02 Sep 2024 21:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/GPkTqUfHnhO3kucdSgcD0xt8fEZFKuqPMxonwxkz7pK2WFID6VnyVkgj1y9uROsm1Au/vw==
X-Received: by 2002:a05:6a21:6e41:b0:1ce:e114:7143 with SMTP id adf61e73a8af0-1cee114746emr6510611637.54.1725337292402;
        Mon, 02 Sep 2024 21:21:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d9dd5a6c72sm1565953a91.1.2024.09.02.21.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:21:31 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:21:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] overlay: create a variant to syncfs error test xfs/546
Message-ID: <20240903042128.ksqua6ha47iayolq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240830180844.857283-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830180844.857283-1-amir73il@gmail.com>

On Fri, Aug 30, 2024 at 08:08:44PM +0200, Amir Goldstein wrote:
> Test overlayfs over xfs with and without "volatile" mount option.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> I was going to make a generic test from xfs/546, so that overlayfs could
> also run it, but then I realized that ext4 does not behave as xfs in
> that case (it returns success on syncfs post shutdown).
> 
> Unless and until this behavior is made a standard, I made an overlayfs
> specialized test instead, which checks for underlying fs xfs.
> While at it, I also added test coverage for the "volatile" mount options
> that is expected to return succuss in that case regardles of the
> behavior of the underlying fs.
> 
> Thanks,
> Amir.
> 
>  tests/overlay/087     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/087.out |  4 +++
>  2 files changed, 66 insertions(+)
>  create mode 100755 tests/overlay/087
>  create mode 100644 tests/overlay/087.out
> 
> diff --git a/tests/overlay/087 b/tests/overlay/087
> new file mode 100755
> index 00000000..a5afb0d5
> --- /dev/null
> +++ b/tests/overlay/087
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> +# Copyright (c) 2024 CTERA Networks.  All Rights Reserved.
> +#
> +# FS QA Test No. 087
> +#
> +# This is a variant of test xfs/546 for overlayfs
> +# with and without the "volatile" mount option.
> +# It only works over xfs underlying fs.
> +#
> +# Regression test for kernel commits:
> +#
> +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> +#
> +# During a code inspection, I noticed that sync_filesystem ignores the return
> +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> +# that syncfs(2) does not capture internal filesystem errors that are neither
> +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> +# so that had to be corrected as well.
> +#
> +# The kernel commits above fix this problem, so this test tries to trigger the
> +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> +# hope that the EIO generated as a result of the filesystem being shut down is
> +# only visible via ->sync_fs.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount shutdown
> +
> +
> +# Modify as appropriate.
> +_require_xfs_io_command syncfs
> +_require_scratch_nocheck
> +_require_scratch_shutdown
> +
> +[ "$OVL_BASE_FSTYP" == "xfs" ] || \
> +	_notrun "base fs $OVL_BASE_FSTYP has unknown behavior with syncfs after shutdown"
> +
> +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> +# bother checking the filesystem afterwards since we never wrote anything.
> +echo "=== syncfs after shutdown"
> +_scratch_mount
> +# This command is complicated a bit because in the case of overlayfs the
> +# syncfs fd needs to be opened before shutdown and it is different from the
> +# shutdown fd, so we cannot use the _scratch_shutdown() helper.
> +# Filter out xfs_io output of active fds.
> +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> +	grep -vF '[00'
> +
> +# Now repeat the same test with a volatile overlayfs mount and expect no error
> +_scratch_unmount
> +echo "=== syncfs after shutdown (volatile)"
> +_scratch_mount -o volatile
> +$XFS_IO_PROG -x -c "open $(_scratch_shutdown_handle)" -c 'shutdown -f ' -c close -c syncfs $SCRATCH_MNT | \
> +	grep -vF '[00'

Oh, the test steps are much different from xfs/546. If we move x/546 to generic/,
can overlay reproduce this bug by that? If not, I think we can have this overlay
specific test case at first, and "move x/546 to generic" can be another job.

Thanks,
Zorro

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/overlay/087.out b/tests/overlay/087.out
> new file mode 100644
> index 00000000..44b538d8
> --- /dev/null
> +++ b/tests/overlay/087.out
> @@ -0,0 +1,4 @@
> +QA output created by 087
> +=== syncfs after shutdown
> +syncfs: Input/output error
> +=== syncfs after shutdown (volatile)
> -- 
> 2.34.1
> 

