Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B23DF012
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430773; cv=none; b=nof+Wwp4AHEbc9O8tDO7V5Xu2iQfacU0n3zmJYQ4uj41vSDnagMgLWuM5fhC4TYkYt+sv9Xzjir6dD0yeW1GzfVACGR6UDsRpmf+4+csUySJU61PG6Qb7IJgKY5wyFWNIQlFC1azylmNcVRjiTB6ir/WWJfE5FsfeEZUZJSVAZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430773; c=relaxed/simple;
	bh=HZsmWq7jMAGXxfnCq9onwHaNVoF3tcEBKezAUjF1cJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bynNlsLK2AB5ciuy6TYsHlJ9LcqRlX8rMfSyZ3BOmD7biFcFVEo40ssrE+6/HlN9pOx0h7R+Eo4kO+dEmlclVOv3Y1V8oQFl5c6E5xh3oONAY6czB3HZlYjivBXGQ+Hrwzs6x5hkA2dZmeqcqo8E7e02A4S3kzC/fvFNUdwkDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6ZMu1zL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lTxyYDoT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ZMu1zL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lTxyYDoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773430765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/SL+ahEzEcUlQ2vyQjl+JZmgLbTncbrhlf/1P3iY6qc=;
	b=Y6ZMu1zLQ5HHWM0XTe2wbeVeF7qSBsd6FwmgodiCxOH+N7dr6/vuyDWKzmgejBvpDDo9aC
	Qkw7i6CrmcRyzMBYN+FiMih6VaEMZ4ZuJcdtdbLluaAMdT9XEnt6suRTgFnhUTIV602i/u
	FFT7u6P7HXcxBPr66EhXxT5ffkV7VCw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-ac7I7yX_PHe35wsJRgo1Tw-1; Fri, 13 Mar 2026 15:39:24 -0400
X-MC-Unique: ac7I7yX_PHe35wsJRgo1Tw-1
X-Mimecast-MFC-AGG-ID: ac7I7yX_PHe35wsJRgo1Tw_1773430763
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c738f71723aso1433319a12.2
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773430763; x=1774035563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/SL+ahEzEcUlQ2vyQjl+JZmgLbTncbrhlf/1P3iY6qc=;
        b=lTxyYDoTx4LoaA/ADQZn7nos9mYNFmq+XabQkX7JJiJXZCZuDa6CwMzA+S6j/61Ytb
         GxQErsYWwfjKfa3j6v18TvOLF52rRPnlI6POVHz6CFTzRKE5x+ffSUA1eGUuYcD9r0B5
         1Zf40tfvjFTV7YIj6RorXMkZu13y6yhi8x35vRkLGaw431kUKZyhH+7BtyLIlr7RS6a1
         veBBYEoipAmvhyxBEIaKHiChU6Z/AAiBqfyeS+yWfhBktYCbdUOHJD+yHyezJU7obQ7Y
         NEQkmLlOLbt1wjc/Tv2eY7cRxKvatQUVKVbYf0I0fmS/tTM0v/xeQbXwTMff0y2FexzF
         mLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430763; x=1774035563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SL+ahEzEcUlQ2vyQjl+JZmgLbTncbrhlf/1P3iY6qc=;
        b=hNAeTRtvJ61sV/OWL0S6fNv7viOYCuOXQJ+xsW4GueWcVToIvOTr0NtIs8Bt8GvVAr
         h+MceFJ3zUPirnZGzjhCZVO4+6sW13vJ4fpAHvPrpetowyjezDN/MC6y5n03x9fDRTZ2
         bKuyEOy9JE3w1V/VOkfY7zQfQOUE6/0yjnBzj0xwUGlXKHcbi4MIgSwmr0CmAR7vINe0
         FM369jb3XitFvfUJxgIQ74WxpDMagxuHDl9G04uEJ1uKTw+ldzoF51aJYCZCm692aUCn
         rlo3ChDiA2tVG1Xc6gd8MQX8IigDrf7E9sgTxkGAeTDpGruCU2iqFuptLoHa30KqIUdg
         baEg==
X-Gm-Message-State: AOJu0YxY+TAgdwtz39l3Wz9l3JMVKmDROdUOLwzcxWmod7LWGK59vDmK
	amiVxNWjK2ucHzPD9evmUKcLRkl8WR19I6zC8wrZZ8hQu1xFTM7Q5LKC4shgGvw1Twq/+T5Mq7y
	E2IVVEX4cnFqr6Rjx0gYSqwalFBH5qwawk4Wu9MMtVw9wUf/X3fjzjvNWluo=
X-Gm-Gg: ATEYQzwKVrEXBW9NUBkM8Y9m3KBvnDIvvPYNLiNeIDR3kfntuKAYzZCzJRhz33NOoM1
	fXH0Xc4LcSKadsLBXPLSAiq0JTA0jXtfN191Eg0spKnj/oppdnYJD6OPx333NqO+P7vV+69KUng
	hB0mCHOyb1yfZqa+n1JElNkk4w1cmNWsibHBFcqp2vuk6iThzJ8kyW9RV/41q7SInwAmw/d4JSR
	5h2YV0s4ulPCyCc+1aD6s37aOIrjdESKYoP4m3fC3HS+DXX+OzM4jGuWH4G7d7mcMeK7XjC/FYD
	1AmlOxMKdEYEv5pFH64oTF8Xdgx0YHECoonsNKMQuJerTNwIB/DhofQMwDYOif7w74A12pTIk5v
	kD5obxPFrdgiRY0NRueRVBDIgWIm7k4bwkHIHgGN47gSbDtKnyecpVOs3UBuBCw==
X-Received: by 2002:a05:6a00:244b:b0:82a:1499:263b with SMTP id d2e1a72fcca58-82a1991be08mr3851397b3a.52.1773430763416;
        Fri, 13 Mar 2026 12:39:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:244b:b0:82a:1499:263b with SMTP id d2e1a72fcca58-82a1991be08mr3851373b3a.52.1773430762775;
        Fri, 13 Mar 2026 12:39:22 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a06fe211csm6793094b3a.0.2026.03.13.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:39:22 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:39:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/14] xfs: test xfs_healer can follow mount moves
Message-ID: <20260313193918.inapmgb6tgdizodi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403978.1186408.10548791378400332968.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403978.1186408.10548791378400332968.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:52:59PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that when xfs_healer needs to reopen a filesystem to repair it,
> it can still find the filesystem even if it has been mount --move'd.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1900     |  115 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1900.out |    2 +
>  2 files changed, 117 insertions(+)
>  create mode 100755 tests/xfs/1900
>  create mode 100755 tests/xfs/1900.out
> 
> 
> diff --git a/tests/xfs/1900 b/tests/xfs/1900
> new file mode 100755
> index 00000000000000..9a8f9fabd124ad
> --- /dev/null
> +++ b/tests/xfs/1900
> @@ -0,0 +1,115 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1900
> +#
> +# Ensure that autonomous self healing fixes the filesystem correctly even if
> +# the original mount has moved somewhere else.
> +#
> +. ./common/preamble
> +_begin_fstest auto selfhealing
> +
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/systemd
> +
> +_cleanup()
> +{
> +	command -v _kill_fsstress &>/dev/null && _kill_fsstress
> +	cd /
> +	rm -r -f $tmp.*
> +	if [ -n "$new_dir" ]; then
> +		_unmount "$new_dir" &>/dev/null
> +		rm -rf "$new_dir"
> +	fi
> +}
> +
> +_require_test
> +_require_scrub
> +_require_xfs_io_command "repair"	# online repair support
> +_require_xfs_db_command "blocktrash"
> +_require_command "$XFS_HEALER_PROG" "xfs_healer"
> +_require_command "$XFS_PROPERTY_PROG" "xfs_property"
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +_xfs_has_feature $SCRATCH_MNT rmapbt || \
> +	_notrun "reverse mapping required to test directory auto-repair"
> +_xfs_has_feature $SCRATCH_MNT parent || \
> +	_notrun "parent pointers required to test directory auto-repair"
> +_require_xfs_healer $SCRATCH_MNT --repair
> +
> +# Configure the filesystem for automatic repair of the filesystem.
> +$XFS_PROPERTY_PROG $SCRATCH_MNT set autofsck=repair >> $seqres.full
> +
> +# Create a largeish directory
> +dblksz=$(_xfs_get_dir_blocksize "$SCRATCH_MNT")
> +echo testdata > $SCRATCH_MNT/a
> +mkdir -p "$SCRATCH_MNT/some/victimdir"
> +for ((i = 0; i < (dblksz / 255); i++)); do
> +	fname="$(printf "%0255d" "$i")"
> +	ln $SCRATCH_MNT/a $SCRATCH_MNT/some/victimdir/$fname
> +done
> +
> +# Did we get at least two dir blocks?
> +dirsize=$(stat -c '%s' $SCRATCH_MNT/some/victimdir)
> +test "$dirsize" -gt "$dblksz" || echo "failed to create two-block directory"
> +
> +# Break the directory, remount filesystem
> +_scratch_unmount
> +_scratch_xfs_db -x \
> +	-c 'path /some/victimdir' \
> +	-c 'bmap' \
> +	-c 'dblock 1' \
> +	-c 'blocktrash -z -0 -o 0 -x 2048 -y 2048 -n 2048' >> $seqres.full
> +_scratch_mount
> +
> +_scratch_invoke_xfs_healer "$tmp.healer" --repair
> +
> +# Move the scratch filesystem to a completely different mountpoint so that
> +# we can test if the healer can find it again.
> +new_dir=$TEST_DIR/moocow
> +mkdir -p $new_dir
> +_mount --bind $SCRATCH_MNT $new_dir
> +_unmount $SCRATCH_MNT
> +
> +df -t xfs >> $seqres.full
> +
> +# Access the broken directory to trigger a repair, then poll the directory
> +# for 5 seconds to see if it gets fixed without us needing to intervene.
> +ls $new_dir/some/victimdir > /dev/null 2> $tmp.err
> +_filter_scratch < $tmp.err | _filter_test_dir
> +try=0
> +while [ $try -lt 50 ] && grep -q 'Structure needs cleaning' $tmp.err; do
> +	echo "try $try saw corruption" >> $seqres.full
> +	sleep 0.1
> +	ls $new_dir/some/victimdir > /dev/null 2> $tmp.err
> +	try=$((try + 1))
> +done
> +echo "try $try no longer saw corruption or gave up" >> $seqres.full
> +_filter_scratch < $tmp.err | _filter_test_dir
> +
> +# List the dirents of /victimdir to see if it stops reporting corruption
> +ls $new_dir/some/victimdir > /dev/null 2> $tmp.err
> +try=0
> +while [ $try -lt 50 ] && grep -q 'Structure needs cleaning' $tmp.err; do
> +	echo "retry $try still saw corruption" >> $seqres.full
> +	sleep 0.1
> +	ls $SCRATCH_MNT/some/victimdir > /dev/null 2> $tmp.err
> +	try=$((try + 1))
> +done
> +echo "retry $try no longer saw corruption or gave up" >> $seqres.full
> +
> +new_dir_unmount() {
> +	_unmount $new_dir
> +}
> +
> +# Unmount to kill the healer
> +_scratch_kill_xfs_healer new_dir_unmount
> +cat $tmp.healer >> $seqres.full
> +
> +status=0
> +exit
> diff --git a/tests/xfs/1900.out b/tests/xfs/1900.out
> new file mode 100755
> index 00000000000000..604c9eb5eb10f4
> --- /dev/null
> +++ b/tests/xfs/1900.out
> @@ -0,0 +1,2 @@
> +QA output created by 1900
> +ls: reading directory 'TEST_DIR/moocow/some/victimdir': Structure needs cleaning
> 

