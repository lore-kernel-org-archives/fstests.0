Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316752D0637
	for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144259; cv=none; b=aIeB2RWJIsmk8hrYtglWLekoU4vmZSPm8NUsQrFziQPL60WjT3h9Hpwc53uodJ3JVBadGLr8Qsw9SnAK0S0sYH1iOMtT4qgKe4zA15+6sLDfUyyTLUNbNi0sWRhA4PHr8zkcgihQy6Xv7nNO4i8Ke6Ew5wU/NTF8VrkO4b89wvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144259; c=relaxed/simple;
	bh=xhtb1KDxXyh6qSIXD3yaf4mkBfalj+bfIv3bOiHrTBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+OKsSAw8MF6TycqH+wv//5Olv1SH1BaKE7FxIWDh7lojMIhiVhAqxF95DslT+JR9ZJaxLLpOaoQapaqse4Xx0f8pk+q0pQe4hfh4W1gyUypdtqhGoUEI0dLV9uqQXFpEBXl8T0IuvbZGc4Bye85lmTML0kM3HRwRZlr6CKadk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRLmO3xG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjnARHzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRLmO3xG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjnARHzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763144255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzz2UQttAdlWuixFQvQcB5l7gTdqlw/lLPJ2vqXTeKA=;
	b=PRLmO3xGNL/T2WytFEx7SQb+HVH8mdTtWhXbC5Vzjc3HhKYJhNbVnkuc8PIc/QKsPBzqFM
	PADgApJHFtIrdcjM9WnI/dG2/4ttB/4DtKjLPNdLqt3jNumS+iRFHIiVv/Che40WpGPCpA
	vITPhSL7DcDEGEEvxBA+qacb1vRW1rA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-LYSRe6eoPz2isD71vdabIw-1; Fri, 14 Nov 2025 13:17:34 -0500
X-MC-Unique: LYSRe6eoPz2isD71vdabIw-1
X-Mimecast-MFC-AGG-ID: LYSRe6eoPz2isD71vdabIw_1763144253
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343daf0f488so3184417a91.1
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 10:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763144252; x=1763749052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pzz2UQttAdlWuixFQvQcB5l7gTdqlw/lLPJ2vqXTeKA=;
        b=XjnARHzvvQ/eFLkGmnHs41EVamWGMKxy1fhzcA9PJ5dvS16+35cFgCrdS+NFw6ScWD
         3hAq3qDhVgn3cu5HMIsSxa2qjTKfVPrEfR+8morkt0Caul5+PSoGbVpJUK5PbuudIfzB
         rRGGKpoYheQxKdjyHHrRxtqlIhU46BD9mSAs1huITU/tzNomt7ZAFcpjEALBjF2nTTha
         b/1hR9WMReBaXauYs/9eqwHxAeqdc3bevkNXhOct4XcvFBtVZJix2j1cv0tkk+jZCLot
         1dU+NPrZemJm0iXeNrPurBNIZE7hhShDHj8JMV0b1Z1nRctMwwls8gguwgwzevuLfomG
         Rv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144252; x=1763749052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzz2UQttAdlWuixFQvQcB5l7gTdqlw/lLPJ2vqXTeKA=;
        b=oaAl/FCwUOj2XRF4xWHTmugg3aK7tzFrXO0gubu4OCpawEjrM7p8Wy3GEOhCA1g7ds
         5TN3X78c69bGaclFTkovxM+YpiNkOPaU33GtAANpWA9ZTPOsbjenkqHT+4b6RWnTCYvl
         pt8/tbyNaAHZaU+amvGI5+vbqvz1jMCXzQZ+gbEKvWIbaE915GLc34RpGgb7WjdE0ZJF
         hOBgUiROkm+zNJzLpWXk9pg7hAe/ry14uRb6Z38YW0WNfXhhyYLp6GE87sGEpDBojo3u
         nkXn/EEXEFqFmVfuXGAonIOCRSbsQecbkYGus2ckwGrEEqapK4M5knX69K0xL5CEHyxr
         xSJg==
X-Forwarded-Encrypted: i=1; AJvYcCXUoTPKxxJsWx41hp6NHJEoW5ONBJ1OP9WM/68r11PVOnAmCOZuEEIBsv6CfpaFWT5/b2/Xa1Ae@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM+ZlNYyYev4PLa/Nmzy1nrU+dna3F0DhUNrs/bZqNH1Foob5
	aiFL9bdPsCQnxdzL9+pSgfS1uO4BKEXHIcN2CHLWroglviIpUUzYQBG2wIZXqnPkVVBBkMmzHiw
	HNOqVNcbNyCIYfgXwEGxDp3CF2cnrE7Jo8X2opJFQybz/I8JqWRMGfIcx3QaFLf+VG40=
X-Gm-Gg: ASbGncuN+1jHGZVToXYRPpnI9Ph+k77CpLSRxo3i9YtZnfbMrEo792PBjUBv/MuQRIt
	7HGBbqN3Tv7OfM++tGK/y8SqJkMu8afYpOm0dLNkIoXq/ZYwsdMp0GtJIFHKgyVaR1JJKqRKG5n
	P+M0X2Ie2jg4fErrigKlIbqXyYMOjXX5x6tMG5sgBDk5+csrKQ/n1e9gXl55SJNAKdeLqBJOnSQ
	EywBx2mhDVXu3FJLLpf+/CojpxVtdne4wkrmi2zvHhy2RoLgJgtNtYljgbTkee78+wgsg4z/9f3
	3ZONhlDW0RTdwkBmCClhf/1P/Sa20lNIArOPiuHasWGP9XQtEhpTyZH4EFRvmDqy3YIE7Fgrsfg
	bUKvAJgnkk0JIYDxeWS9o9pCWaJNi8XVnYfTpqLthcxmcbkChsA==
X-Received: by 2002:a17:90b:2552:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-343f9ea40c1mr5387254a91.12.1763144252187;
        Fri, 14 Nov 2025 10:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjbz5/Tk+V/W5EZCxxK9X5glUMc6FVN7yj5MlVQPxg1aNXDu8bfP+hR9vNCYaHWNpSrvJ45g==
X-Received: by 2002:a17:90b:2552:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-343f9ea40c1mr5387220a91.12.1763144251605;
        Fri, 14 Nov 2025 10:17:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456518a1a7sm1160636a91.15.2025.11.14.10.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:17:30 -0800 (PST)
Date: Sat, 15 Nov 2025 02:17:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] overlay: add tests for casefolded layers
Message-ID: <20251114181726.lbk67ksagcpzt5lk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251017170649.2092386-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017170649.2092386-1-amir73il@gmail.com>

On Fri, Oct 17, 2025 at 07:06:49PM +0200, Amir Goldstein wrote:
> Overalyfs did not allow mounting layers with casefold capable fs
> until kernel v6.17-rc1 and did not allow casefold enabled layers
> until kernel v6.18-rc1.
> 
> Since kernel v6.18-rc1, overalyfs allows this kind of setups,
> as long as the layers have consistent encoding and all the directories
> in the subtree have consistent casefolding.
> 
> Create test cases for the following scenarios:
> - Mounting overlayfs with casefold disabled
> - Mounting overlayfs with casefold enabled
> - Lookup subdir in overlayfs with mismatch casefold to parent dir
> - Change casefold of underlying subdir while overalyfs is mounted
> - Mounting overlayfs with strict enconding, but casefold disabled
> - Mounting overlayfs with strict enconding casefold enabled
> - Mounting overlayfs with layers with inconsistent UTF8 version
> 
> Co-developed-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Zorro,
> 
> This test covers the overlayfs casefold feature that was introduced in
> two steps - casefold disabled layers in 6.17-rc1 and casefold enabled
> layers in 6.18-rc1.
> 
> I think there is less interest in testing the v6.17 changes on their own
> so this test requires support for casefold enabled layers from 6.18-rc1
> and will notrun on kernel < 6.18-rc1:
> 
> generic/999 5s ...  [12:43:16] [12:43:18] [not run]
> 	generic/999 -- overlayfs does not support casefold enabled layers
> 
> If there is a demand, we could split a test for the v6.17 support.
> 
> Note that this test is written as a generic and not an overlay test,
> because we do not have the infrastructure to format and mount a base fs
> with casefold support, so this test can run with e.g. ext4 FSTYP, but it
> will notrun with e.g. xfs FSTYPE:
> 
> generic/999 6s ...  [12:30:03] [12:30:05] [not run]
> 	generic/999 -- xfs does not support casefold feature
> 
> I left the test number 999 for you to re-number.
> If you prefer that I post with another test number assignment in the
> future please let me know.

Hi Amir,

Sorry for this late reviewing, most of this case looks good to me :)

I tried ext4 and f2fs on linux v6.16, v6.17 and v6.18-rc4+, the test
works on them. But when I test on tmpfs (due to _require_scratch_casefold
says tmpfs supports casefold feature), it fails:

FSTYP         -- tmpfs
PLATFORM      -- Linux/x86_64 dell-per750-41 6.18.0-0.rc4.251106gdc77806cf3b47.40.fc44.x86_64+debug #1 SMP PREEMPT_DYNAMIC Thu Nov  6 17:22:41 UTC 2025
MKFS_OPTIONS  -- tmpfs_scratch
MOUNT_OPTIONS -- -o size=1G -o context=system_u:object_r:root_t:s0 tmpfs_scratch /mnt/scratch

generic/999 15s ... - output mismatch (see /root/git/xfstests/results//generic/999.out.bad)
    --- tests/generic/999.out   2025-11-11 09:54:58.168783859 +0800
    +++ /root/git/xfstests/results//generic/999.out.bad 2025-11-15 01:55:37.137507467 +0800
    @@ -11,3 +11,4 @@
     ls: cannot access 'SCRATCH_MNT/ovl-merge/dir/': Stale file handle
     Casefold disabled on subdir after mount
     ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
    +Overlayfs mount with strict casefold enabled should have failed
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/999.out /root/git/xfstests/results//generic/999.out.bad'  to see the entire diff)
Ran: generic/999
Failures: generic/999
Failed 1 of 1 tests

# cat local.config
export FSTYP=tmpfs
export TEST_DEV=tmpfs_test
export TEST_DIR=/mnt/test
export SCRATCH_DEV=tmpfs_scratch
export SCRATCH_MNT=/mnt/scratch

> 
> Thanks,
> Amir.
> 
> 
>  tests/generic/999     | 243 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  13 +++
>  2 files changed, 256 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 

[snip]

> +# Create lowerdir, upperdir and workdir without casefold enabled
> +lowerdir="$SCRATCH_MNT/ovl-lower"
> +upperdir="$SCRATCH_MNT/ovl-upper"
> +workdir="$SCRATCH_MNT/ovl-work"
> +merge="$SCRATCH_MNT/ovl-merge"
> +
> +mount_casefold_version()
> +{
> +	option="casefold=$1"
> +	mount -t tmpfs -o $option tmpfs $2
> +}
> +
> +mount_overlay()
> +{
> +	local lowerdirs=$1
> +
> +	_mount -t overlay overlay $merge \
> +		-o lowerdir=$lowerdirs,upperdir=$upperdir,workdir=$workdir
> +}
> +
> +unmount_overlay()
> +{
> +	_unmount $SCRATCH_MNT/ovl-merge 2>/dev/null
                 ^^^^^^^^^^^^^^^^^^^^^^
                 $merge ?

> +}
> +
> +# Try to mount an overlay with casefold enabled layers.
> +# On kernels older than v6.18 expect failure and skip the test
> +mkdir -p $merge $upperdir $workdir $lowerdir
> +_casefold_set_attr $upperdir >>$seqres.full
> +_casefold_set_attr $workdir >>$seqres.full
> +_casefold_set_attr $lowerdir >>$seqres.full
> +mount_overlay $lowerdir >>$seqres.full 2>&1 || \
> +	_notrun "overlayfs does not support casefold enabled layers"
> +unmount_overlay

[snip]

> +MNT1="$testdir/mnt1"
> +MNT2="$testdir/mnt2"
> +
> +mkdir $MNT1 $MNT2 "$testdir/merge"
> +
> +mount_casefold_version "utf8-12.1.0" $MNT1
> +mount_casefold_version "utf8-11.0.0" $MNT2
> +
> +mkdir "$MNT1/dir" "$MNT2/dir"
> +
> +_casefold_set_attr "$MNT1/dir"
> +_casefold_set_attr "$MNT2/dir"
> +
> +mkdir "$MNT1/dir/lower" "$MNT2/dir/upper" "$MNT2/dir/work"
> +
> +upperdir="$MNT2/dir/upper"
> +workdir="$MNT2/dir/work"
> +lowerdir="$MNT1/dir/lower"
> +
> +mount_overlay $lowerdir >>$seqres.full 2>&1  && \
> +	echo "Overlayfs mount different unicode versions should have failed" && \
> +	unmount_overlay
> +
> +umount $MNT1
> +umount $MNT2

I think we can make sure $MNT1 and $MNT2 are unmounted in _cleanup phase,
as what you did for $merge in _cleanup.

Thanks,
Zorro

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..ce383d94
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,13 @@
> +QA output created by 999
> +Casefold disabled
> +Casefold enabled after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/subdir': Stale file handle
> +Casefold enabled lower dir
> +Casefold enabled lower subdir
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
> +Casefold enabled upper dir
> +Casefold enabled
> +Casefold disabled on lower after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/dir/': Stale file handle
> +Casefold disabled on subdir after mount
> +ls: cannot access 'SCRATCH_MNT/ovl-merge/casefold/subdir': Object is remote
> -- 
> 2.50.1
> 

