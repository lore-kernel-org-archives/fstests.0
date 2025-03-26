Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0262A1B2
	for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990734; cv=none; b=JlVacNO14Em52wY3VVHJdoW+o/jsq+2JPZZDmMTF1lTKgJ2B8nvuTLkVrK9FDGIllxElysAedUaN7qQRRbzARgx4exGL+VhTLDFYauxlmz3BncWSp5CfZFDYgC6Wax+Ma7ua0sejj0/PDvnwD8Ibo5MfY93KW3djCegBA2AsHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990734; c=relaxed/simple;
	bh=PfhfPkkjoPkyRt3ydh6MeWgP/k7XjaNWiRrCYeWgXpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQUvTd62y8/9bAtOoKD72fBxWfPRZyo05kxJ77ZhyEbPy9N2O4FiM7k4+arR2J9EoqksN4f/uqv7MGh4i6iGy0MZD3Wf4Tr5qQAtp+ot4PYwBbyskYlySLDXhZC91SGszNmDEqzjhk4u+pCLn+oegsG8mY8se7PNupRi4VRpaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCdS4Feb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCdS4Feb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742990730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5705i4IMdIYl7RREK9RAzszYsX2FKNdvOH1MiONcLqU=;
	b=TCdS4FebsUarCaaHUHLFIrgpbHq1dqGd8q8eyNyIdKtNvJbAZxIa+f2BTiNcxd1S0im2ea
	ZZ2UEWTkI7MHz/j8nNxcedcqjSPzJKbHuzt5I3n0uVhX14JgLwKvlFHLe4UOaTOHUsl+u7
	hjeu73GK98xG5uUECxPyTe/n0oLByrw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-y-ZxKm6iPoWwssM_rGRoUg-1; Wed, 26 Mar 2025 08:05:27 -0400
X-MC-Unique: y-ZxKm6iPoWwssM_rGRoUg-1
X-Mimecast-MFC-AGG-ID: y-ZxKm6iPoWwssM_rGRoUg_1742990726
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso16179204a91.1
        for <fstests@vger.kernel.org>; Wed, 26 Mar 2025 05:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990726; x=1743595526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5705i4IMdIYl7RREK9RAzszYsX2FKNdvOH1MiONcLqU=;
        b=YTAyhxlxoZ8PapleVF5tahL686PR1rL2UF7+NTjPjE4/SGyhfkBhQeSLMy5x5IFlTI
         YKMmI4I73HXPb3a5NSJad88j2eXnuI5Xw62don+ha8VndHsYDYUzeOTWAuuVV5Z4HDCy
         5O7Cfb0RJO5PF5hfbY9Umj+3rwfPWR0ghN+akY3WNW+seWhPn0FUhRcu9Dk4VmR9+zgX
         aCrXIjrmFp/b/3r/Bq0V61wLBL2R9vlbzyWJ8vBESJ0S3WP+rIZlRfUpcBhEoJuWIAqm
         E9SRZB/QVliz53fi4wA5jIG/eq/bzkFkNBgHnuDz7UTfA5fSXyFfvsLAnekv4XmMEXOJ
         3jag==
X-Gm-Message-State: AOJu0YybfM+6O6EdjbrlKbxw2iTdlpcEohA4kZ6yffTzJHCT+kvB+g7m
	AaScPlsgSRJKABD573s81QS6gD7KEVdVfcrtLgpcNgZlDUFAqI6uIAZ7jvVCuBb1U0zdZF2mQz+
	8iXINfqchVpby4OhMxE9c1N1Uz1zxk72kMkB1Uy9jolUOjzLQ0G87a50=
X-Gm-Gg: ASbGncvvfoLeNwhK9aQ9fwBjoSt6QsR9eZxpu5TNnrVpEnaoB9cIUpsvNe/gmbx+kUB
	mY3v/+EHI433AxL6deqAp6fwEl3HQu3uhwuHXzbUJG99Ki0LeZ+r7i7cuxrDk+hNW8Sp+D2fUQG
	vxwjj2Ia/QdFi7XaH9p1ltkCTaNDl9CAaMYEGYX1mjGgd7+fFtRNFxvY6umqwOMAjxLgqK2c6+r
	DNqM/Ktn+/dKJyAjqf+KoZ5lsd+E23eVMinPVoDjpPAbhVVZwwjYAD4an/EIe0WyX08bxdCccMw
	RFJzdAcgKximDLTgoWLRqEEHFlwOwYMWn2w3o10Eu0r7+G+0gJJsj0pB
X-Received: by 2002:a17:90b:38c7:b0:2ff:5c4e:5acd with SMTP id 98e67ed59e1d1-3030ff08ddcmr28681842a91.35.1742990726370;
        Wed, 26 Mar 2025 05:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhneHesdbOtXw4gniFcK86cM2C0IYwALL+FtTJ9JYKmF2/lxfNv147QapG1PkzO8dAtrpX8Q==
X-Received: by 2002:a17:90b:38c7:b0:2ff:5c4e:5acd with SMTP id 98e67ed59e1d1-3030ff08ddcmr28681808a91.35.1742990725843;
        Wed, 26 Mar 2025 05:05:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f60b919sm12175624a91.27.2025.03.26.05.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:05:25 -0700 (PDT)
Date: Wed, 26 Mar 2025 20:05:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test fsync of file with no more hard links
Message-ID: <20250326120522.5uzi3otqe4lhozvv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <9a9c54e662293fb01591c256dd32243b1a149fe2.1742905343.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9c54e662293fb01591c256dd32243b1a149fe2.1742905343.git.fdmanana@suse.com>

On Tue, Mar 25, 2025 at 12:24:40PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a file that has no more hard links, power fail and
> then mount the filesystem, after the journal/log is replayed, the file
> doesn't exists anymore.
> 
> This exercises a bug recently found and fixed by the following patch for
> the linux kernel:
> 
>    btrfs: fix fsync of files with no hard links not persisting deletion
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use the src/multi_open_unlink.c program with added options to sync
>     filesystem after creating files and fsync files after the unlink.

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

If no more review points this week, I'll merge it this week.

Thanks,
Zorro

> 
>  src/multi_open_unlink.c | 24 ++++++++++++++++++--
>  tests/generic/764       | 50 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/764.out   |  2 ++
>  3 files changed, 74 insertions(+), 2 deletions(-)
>  create mode 100755 tests/generic/764
>  create mode 100644 tests/generic/764.out
> 
> diff --git a/src/multi_open_unlink.c b/src/multi_open_unlink.c
> index c221d39e..fb054e87 100644
> --- a/src/multi_open_unlink.c
> +++ b/src/multi_open_unlink.c
> @@ -28,7 +28,7 @@
>  void
>  usage(char *prog)
>  {
> -	fprintf(stderr, "Usage: %s [-e num-eas] [-f path_prefix] [-n num_files] [-s sleep_time] [-v ea-valuesize] \n", prog);
> +	fprintf(stderr, "Usage: %s [-e num-eas] [-f path_prefix] [-F] [-n num_files] [-s sleep_time] [-S] [-v ea-valuesize] \n", prog);
>  	exit(1);
>  }
>  
> @@ -44,8 +44,10 @@ main(int argc, char *argv[])
>  	int value_size = MAX_VALUELEN;
>  	int fd = -1;
>  	int i,j,c;
> +	int fsync_files = 0;
> +	int sync_fs = 0;
>  
> -	while ((c = getopt(argc, argv, "e:f:n:s:v:")) != EOF) {
> +	while ((c = getopt(argc, argv, "e:f:Fn:s:Sv:")) != EOF) {
>  		switch (c) {
>  			case 'e':   /* create eas */
>  				num_eas = atoi(optarg);
> @@ -53,12 +55,18 @@ main(int argc, char *argv[])
>  			case 'f':   /* file prefix */
>  				given_path = optarg;
>  				break;
> +			case 'F':   /* fsync files after unlink */
> +				fsync_files = 1;
> +				break;
>  			case 'n':   /* number of files */
>  				num_files = atoi(optarg);
>  				break;
>  			case 's':   /* sleep time */
>  				sleep_time = atoi(optarg);
>  				break;
> +			case 'S':   /* sync fs after creating files */
> +				sync_fs = 1;
> +				break;
>  			case 'v':  /* value size on eas */
>  				value_size = atoi(optarg);
>  				break;
> @@ -83,6 +91,12 @@ main(int argc, char *argv[])
>  			return 1;
>  		}
>  
> +		if (sync_fs && syncfs(fd) == -1) {
> +			fprintf(stderr, "%s: failed to sync filesystem: %s\n",
> +				prog, strerror(errno));
> +			return 1;
> +		}
> +
>  		/* set the EAs */
>  		for (j = 0; j < num_eas; j++) {
>  			int sts;
> @@ -111,6 +125,12 @@ main(int argc, char *argv[])
>  				prog, path, strerror(errno));
>  			return 1;
>  		}
> +
> +		if (fsync_files && fsync(fd) == -1) {
> +			fprintf(stderr, "%s: failed to fsync \"%s\": %s\n",
> +				prog, path, strerror(errno));
> +			return 1;
> +		}
>  	}
>  
>  	sleep(sleep_time);
> diff --git a/tests/generic/764 b/tests/generic/764
> new file mode 100755
> index 00000000..1b21bc02
> --- /dev/null
> +++ b/tests/generic/764
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 764
> +#
> +# Test that if we fsync a file that has no more hard links, power fail and then
> +# mount the filesystem, after the journal/log is replayed, the file doesn't
> +# exists anymore.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix fsync of files with no hard links not persisting deletion"
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_test_program "multi_open_unlink"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +mkdir $SCRATCH_MNT/testdir
> +$here/src/multi_open_unlink -f $SCRATCH_MNT/testdir/foo -F -S -n 1 -s 0
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# We don't expect the file to exist anymore, since it was fsynced when it had no
> +# more hard links.
> +ls $SCRATCH_MNT/testdir
> +
> +_unmount_flakey
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/764.out b/tests/generic/764.out
> new file mode 100644
> index 00000000..bb58e5b8
> --- /dev/null
> +++ b/tests/generic/764.out
> @@ -0,0 +1,2 @@
> +QA output created by 764
> +Silence is golden
> -- 
> 2.45.2
> 
> 

