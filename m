Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CB23A9B3
	for <fstests@vger.kernel.org>; Sun,  8 Feb 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770573292; cv=none; b=ISj4EV1ikppDd19E8Q1G52lVOsIzUcIR3LejLuF64kwo505i/t/yqlmxUvePCQ6Vm0K69t3mRHQaBACruorGn9QmxYgIt/atGuWRKYWy5lpLRnxT7W4ZbHqr2+/YMV+qMqGAFxJ9JeD11dSNBCkezi4tZ3mkvYbhhas1bB8WSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770573292; c=relaxed/simple;
	bh=kXZRlQ8KeH8CU4gaK6SQU5UHRqLeG5WC8cBf1nTaqOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1uBtEcQpSiv8DiyGA7ZVT1LTeO1jZ7BJYUqucbcJKO/n+6+g99FaNJKYvo/j8RQ3b65Mcc2WCT3EoBMvOwdUGHal17g4l3Q98SzMOpsEWBlxMXehiEheNSndDfQb+xMiGePDbUSkWWpRT2HiiS13jQlRgOsCud6yUFcinAkOmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNNV7W4a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2VMfHAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNNV7W4a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2VMfHAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770573291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc4JahNdkOdItF/J1j4gKrcyg78llUsUJ7bbKDWY1aw=;
	b=VNNV7W4avolEDS92zCqqmNkOaRlSKwqCB0nqi+8NydEN8IDf41/vuw+u+liwMdoGZWBze4
	DjgNBd6cPcU7Eve53lGFHLmrgDTPdmEhcPPQuHI/a9ude5dAA65XWWU5izs2DEeY2plGPF
	duq111siJAMrpnlnhRGIgW+55iOsfCw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-GQOLWK_8Ohant7H3-WpijA-1; Sun, 08 Feb 2026 12:54:50 -0500
X-MC-Unique: GQOLWK_8Ohant7H3-WpijA-1
X-Mimecast-MFC-AGG-ID: GQOLWK_8Ohant7H3-WpijA_1770573289
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c7a38429so966154a91.0
        for <fstests@vger.kernel.org>; Sun, 08 Feb 2026 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770573288; x=1771178088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc4JahNdkOdItF/J1j4gKrcyg78llUsUJ7bbKDWY1aw=;
        b=B2VMfHAtO+xqCkWqBDLYl5Xp5PpHWso2TPm0TAM1f4CbU9l/CR4EugzMLQ9hmijy6S
         lZOabeenfczwQ9+uy6xcM+4kcYh4DzXIVxhnh7F19Lb1nJ2mi5lIAApVp23CEF3KIqPa
         G2bOwdJAg6nR8h06cPJAFTFpyBAa7rHlQX/GKka/H5UAujrdTdXXYWy8bZ+ElnUaaI2A
         3KQZo1THJEnqTskKt9DQR/PFR/S+cPjyKCUrTYEt4Ve66ShvGazlY2z/SXPyaGMarAtt
         75Kk7znlM0dZrZRVuPluBoCxTDGOzZPP9spNny7xrM+Db1wARhUwA2tkbZvqqzDSvAjR
         rjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770573288; x=1771178088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc4JahNdkOdItF/J1j4gKrcyg78llUsUJ7bbKDWY1aw=;
        b=fxO8uvjIRQhdirZ8INdZHzWxsmPLwigM80qAZGsIcrrVRXm3r9FA82mnbELNV6xVdq
         vkU1z89E/Sway3rC4BTLgrwVX+PmhRTPFk1joOwqDFyW1HLT8SonredGcFwQbWPi1fVY
         mqWI4UPiOOm7WcJDCCHcpLmwPgeHKWYxbsjcbjCFWWLIgsmy7KOycm6OiItKeT9XP8F0
         G9JcY2FymVJgxbLJ4ZRkvb+zcuGphhBS8PBXKh6BcGEFudr0i1FWukU6TY1aSPULfO1d
         +InPzuBzxOFtR1XXEcBV9C+fFsg/PZ5s47AyT/rqn8H+w4f12g5r/ImDtZd7JV+CW3I6
         atGQ==
X-Gm-Message-State: AOJu0YzEr2tz6c1VlCax1KjBcxpmdMdsjWQ6Aii6jUlkotAJe4HJPAka
	RKSUqltUqnH2M+O5PVp/GMJ4LeZgBfBwLf03T5Me/QDC4GSPZ1sRKQbc9p4e5Flfa7alirw6rNg
	i3uWAuq+suYnV4RzcZpAKpvQzH5hif/fxfDoXB8ZcfLLDlG07c++t/jPyyYZ4wINHCy4=
X-Gm-Gg: AZuq6aKWsQ4ih6MdJ/yEh2BymZ8nsigmg8dciXTcpEVC0OgQKqngm1lWcOk9tuhilGe
	YsgiUP8CvJXA8UPgCknGyvWrHH5dSPLv+6Z9Qnq2XGPSG3fMyRAdGEwnMNDXfMDcWwBP8WVzYce
	357vlQy0KHWBWosCqnwC3QlU3AwKCKoF7G2iBdEbOkn6BYMHKkmObHMC4blti37Pmmdxjejczg2
	Ra4jeF8fOQ8/EC6HusW1XpLLS0wBIjtQHdqW6hioVI+FCHXaHpEPb8UUcx1Ll/dy+dIR2sDfvYx
	xvvTJ9CkTIxYHbBUricmOXqLETifcNZd+jIy32M576Y8hVvEro9GGl/BN5xAGfC0hZQAtVIsXYJ
	7qaGVCgGp8UbrTe4w4zYPLuQrA9K/V3uMtrzPPwfXo2XTDbXTDA==
X-Received: by 2002:a17:90b:510a:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-3549bc3bcd2mr11389222a91.17.1770573288594;
        Sun, 08 Feb 2026 09:54:48 -0800 (PST)
X-Received: by 2002:a17:90b:510a:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-3549bc3bcd2mr11389211a91.17.1770573288089;
        Sun, 08 Feb 2026 09:54:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b64a8a9esm5293567a91.1.2026.02.08.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:54:47 -0800 (PST)
Date: Mon, 9 Feb 2026 01:54:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] ext4/307: Calculate donor size to avoid failures for 64k
 bs
Message-ID: <20260208175443.5h5uy65figlq2y6f@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260202132730.589621-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202132730.589621-1-ojaswin@linux.ibm.com>

On Mon, Feb 02, 2026 at 06:57:30PM +0530, Ojaswin Mujoo wrote:
> Hard coding donor size to 250M causes the following failure in e4compat
> 
> e4compact.c:68: do_defrag_range: Assertion `donor->length >= len' failed.
> ./common/rc: line 4616: 1583182 Aborted                 (core dumped)
> 
> The issue is that e4compat asserts that the stat.st_size of all files
> combined shouldn't be more than that of the donor file. In case of 64k
> blocksize, fsstress often creates sparse files which have >3G size even
> though their disk utilization is <100M. Since donor file is not big
> enough, this trips e4compat causing the failure.
> 
> Fix this by dynamically calculating the donor file size based on the
> size of all files. Also, make some changes to avoid future ENOSPC like
> reducing the -n passed to fsstress to keep the size around 2G and making
> sure we use the whole SCRATCH disk instead of 500M.
> 
> While we are at it, add some new lines to make the code bit more
> readable.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

Hi,

Thanks for your patch, but this patch is conflict with v2026.01.27 :
	42c2ccaf ("ext4/307: allocate donor file size dynamically")

both of you were trying to fix the donor file size issue. Please confirm if
that commit helps you. If you still need further change, please rebase your
patch on v2026.01.27.

Thanks,
Zorro

>  tests/ext4/307 | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index 1f0e42ca..7e7fb9c8 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -12,24 +12,57 @@ _begin_fstest auto ioctl rw defrag prealloc
>  # Import common functions.
>  . ./common/filter
>  . ./common/defrag
> +
> +# Get the total of stat.st_size of each file to determine the
> +# size of donor file. We use st_size here instead of blocks used
> +# because thats what e4compat.c checks against.
> +get_bytes_used() {
> +	local filelist="$1"
> +	local total=0
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +	while IFS= read -r f; do
> +		echo -n "File: $f: " >> $seqres.full
> +		[[ -z "$f" ]] && continue
> +
> +		if [[ -f "$f" ]]; then
> +			local bytes
> +			bytes=$(stat -c %s "$f")
> +			total=$((total + bytes))
> +			echo $bytes >> $seqres.full
> +		fi
> +	done < "$filelist"
> +
> +	echo "Total bytes: $total" >> $seqres.full
> +	echo $total
> +}
> +
>  # Disable all sync operations to get higher load
>  FSSTRESS_AVOID="$FSSTRESS_AVOID -ffsync=0 -fsync=0 -ffdatasync=0"
>  _workout()
>  {
> +	local blksz=$(_get_block_size $SCRATCH_MNT)
> +
>  	echo ""
>  	echo "Run fsstress"
>  	out=$SCRATCH_MNT/fsstress.$$
> -	args=`_scale_fsstress_args -p4 -n999 -f setattr=1 -d $out`
> +	args=`_scale_fsstress_args -p4 -n500 -f setattr=1 -d $out`
>  	echo "fsstress $args" >> $seqres.full
>  	_run_fsstress $args
> +
>  	find $out -type f > $out.list
>  	cat $out.list | xargs  md5sum > $out.md5sum
> -	usage=`du -sch $out | tail -n1 | gawk '{ print $1 }'`
> +
> +	bytes=`get_bytes_used $out.list`
> +	echo "Total bytes used: $bytes" >> $seqres.full
> +
>  	echo "Allocate donor file"
> -	$XFS_IO_PROG -c "falloc 0 250M" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +	$XFS_IO_PROG -c "falloc 0 $bytes" -f $SCRATCH_MNT/donor | _filter_xfs_io
> +
>  	echo "Perform compacting"
>  	cat $out.list | run_check $here/src/e4compact \
>  		-i -v -f $SCRATCH_MNT/donor  >> $seqres.full 2>&1
> +
>  	echo "Check data"
>  	run_check md5sum -c $out.md5sum
>  }
> @@ -41,7 +74,7 @@ _require_scratch
>  _require_defrag
>  _require_xfs_io_command "falloc"
>  
> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mkfs >> $seqres.full 2>&1
>  _scratch_mount
>  
>  _workout
> -- 
> 2.52.0
> 

