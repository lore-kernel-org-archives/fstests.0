Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3A33CB2C8
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430100; cv=none; b=O+H4UbYyJq8Xvz+MvQYP+lSnsdblmKYKP9DktRgUS/93ORZeF41sOvCfdI1w6OLc0mc1WMaUjJqwQiIohwpxzD1ddKFu3/oxa7K6OuPQ6cUAgqaEpAMddjfBj6jMFFu5HY8VSuZbCvAWNlwAIFcOWgV+LZNzOjIDbC6Yk+6ZVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430100; c=relaxed/simple;
	bh=eFg5Ud/pXw9BgN+ZKi4E7gdnqHZnxs7PcavZ3SnTYmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDLlkOx01ddGqshg6meVQQtNuE4TPgpUUS/sp0pUerzPM46lZY95dy3UHg+DD2XAex9jq7a7K6zvcbZ2wW4xu9TSTg62lh4mYOTtZv/fAFB53jqCfPszYOIsAVtwIxJhmTOxBKpojcgZ6v06e5y5Ps3wk8HJ7VmT+zYRvcEZQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXUxPtED; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnN9yml6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXUxPtED";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnN9yml6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773430098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SU195nWeFaO4HZwLZPKAG3hBwqIIai7MC9ln7TpUlOk=;
	b=fXUxPtEDrdwbx4ShhXclrmd7nCD8jpw1zjRKvv5kKq9JxxEns6CmvGLcrqPqCQGoU6SiSj
	BHzUKYWwCAl2TxJwOnA2M+Hq1PvMUDVRYFATOILFp2UyyGcdSYxkbM2I0Ia528MN0ymDCv
	Lf62CP/Mka/JohNqwOpiKm2AD0f451U=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-CITpRd2LMpqfCvjfqbbwTA-1; Fri, 13 Mar 2026 15:28:16 -0400
X-MC-Unique: CITpRd2LMpqfCvjfqbbwTA-1
X-Mimecast-MFC-AGG-ID: CITpRd2LMpqfCvjfqbbwTA_1773430096
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aec6c572fbso134498135ad.1
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773430095; x=1774034895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SU195nWeFaO4HZwLZPKAG3hBwqIIai7MC9ln7TpUlOk=;
        b=AnN9yml66O45BaZ56vwGhwfHxcPFJNYWpRKy5uRacPj/Kep8KfpEAFHzogfYRV2Pga
         CJw8oewYQL3SoRIlvKIhwSu3RYOg/wlYcvyQPRHWHSGi5k3S8CiPrBpj7z2Yms9HNSpE
         JJWPoY6zHBzk4cjQXNZKCMqF2M2HroYuddIqw7xGLEiPwvDbD3hQMnzpJb/42//adjHv
         M41wb3jLp1O0JG2NYtATqPMK7I0jwZ1OhNi4CNEaWtFS5L8dm9nd1fXFWJ9UQq4ND83A
         0wt5IjmxbWAFMRcwxg+8NHVFO7HXaT+ntDpi6l0l2QbZPeEx20Fke9OlkFg1ENXVyAt5
         p6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430095; x=1774034895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU195nWeFaO4HZwLZPKAG3hBwqIIai7MC9ln7TpUlOk=;
        b=dX2hgm3frHf4md/+cp8quuB2ISOjwGks5HcaHsvAvxqtgRsyFZmQRqz03ZLvVaJ0Uc
         GODkDttkKoHhmWJhxsXEBy+BkLkRi1gCkbXFeLo4BMGiHp2pPCm6pixRz6oEnKjFoXQQ
         caiTlre7QjccZhjW0hc60P8fiITDt+bRfrkaQKER3hsA4gyu9xDnZ4IPBTakz3adkP9F
         /vruUvOhrAjIshNwgdS4wY6e2c/RU3m9ZksP16Op94DfQ1STpCPFcBlfDt+wy1+eLHk8
         vcilc/oH+Pzg2Tm2MuD5Wky2OTJqsXr8GScRtSnYf6DiLkukbCu3TnRZlwK20jhowdhr
         cHvg==
X-Gm-Message-State: AOJu0YwDaBelpaciVoa5XS9Xz6l1r8BZ+TDL72tXriyo8Xued888B6M9
	G6NryFeYSzv9XcLJRpYKK+FS06uz0CUTeHFNU/1jKyrfFUK1+Vrdv8RBpE9BIUbLBUNIPyPo96D
	6mJL7lHvItkbkdqFgSCcUsca0Vrto0SHer/aEbLnuVEBjnLZwVJN7GBhafKVwQbshFKs=
X-Gm-Gg: ATEYQzwepzl2KJoEp2Xbz4SedOBhbVDFfnwUKWCI38HNuM+KXGgufMBCbTX34T7bFOY
	MmtvV2z/5/GuM7E2BBHSwEsfWYtALOHXGxQpja6PGXB3lVul83+iSYN7JUnFiFIb0/2w6b6erAD
	bJ6F/CjjXPp0LxUkDg6ac0uKnFRw010Uk05d/6jBaKFwsmLftPJKzXcSo4WUethvXOhO0KacR0K
	csZs9ENvbDjSvPK8vMEL3aN693VRgGZk6ASY/UrGvmS64v5p5ywsoQoYSL8+1gTuU2ymP10PKt7
	JSVy07+2vsBVt3iHXXHF/vBjU6S3apBxvXhnu7dE0Bte6ifl+QTUfPtelz69nJ6oFScVUE6Sb9v
	vmL3JlugkRdFtMPEnVTp5jhsMmUhWk5hZiOV+C4E4Ae39IE/wu+OVBcj16qQEVQ==
X-Received: by 2002:a05:6a21:700d:b0:398:71f2:59d8 with SMTP id adf61e73a8af0-398ecda24a4mr4203660637.56.1773430095383;
        Fri, 13 Mar 2026 12:28:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:700d:b0:398:71f2:59d8 with SMTP id adf61e73a8af0-398ecda24a4mr4203646637.56.1773430094920;
        Fri, 13 Mar 2026 12:28:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07382e6csm6608292b3a.54.2026.03.13.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:28:14 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:28:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/14] xfs: test xfs_healer can fix a filesystem
Message-ID: <20260313192810.2mwyyslm65kng3x5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403886.1186408.6888396407274716678.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403886.1186408.6888396407274716678.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:51:41PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that xfs_healer can actually fix an injected metadata corruption.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1884     |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1884.out |    2 +
>  2 files changed, 91 insertions(+)
>  create mode 100755 tests/xfs/1884
>  create mode 100644 tests/xfs/1884.out
> 
> 
> diff --git a/tests/xfs/1884 b/tests/xfs/1884
> new file mode 100755
> index 00000000000000..1fa6457ad25203
> --- /dev/null
> +++ b/tests/xfs/1884
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1884
> +#
> +# Ensure that autonomous self healing fixes the filesystem correctly.
> +#
> +. ./common/preamble
> +_begin_fstest auto selfhealing
> +
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/systemd
> +
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
> +# Access the broken directory to trigger a repair, then poll the directory
> +# for 5 seconds to see if it gets fixed without us needing to intervene.
> +ls $SCRATCH_MNT/some/victimdir > /dev/null 2> $tmp.err
> +_filter_scratch < $tmp.err
> +try=0
> +while [ $try -lt 50 ] && grep -q 'Structure needs cleaning' $tmp.err; do
> +	echo "try $try saw corruption" >> $seqres.full
> +	sleep 0.1
> +	ls $SCRATCH_MNT/some/victimdir > /dev/null 2> $tmp.err
> +	try=$((try + 1))
> +done
> +echo "try $try no longer saw corruption or gave up" >> $seqres.full
> +_filter_scratch < $tmp.err
> +
> +# List the dirents of /victimdir to see if it stops reporting corruption
> +ls $SCRATCH_MNT/some/victimdir > /dev/null 2> $tmp.err
> +try=0
> +while [ $try -lt 50 ] && grep -q 'Structure needs cleaning' $tmp.err; do
> +	echo "retry $try still saw corruption" >> $seqres.full
> +	sleep 0.1
> +	ls $SCRATCH_MNT/some/victimdir > /dev/null 2> $tmp.err
> +	try=$((try + 1))
> +done
> +echo "retry $try no longer saw corruption or gave up" >> $seqres.full
> +
> +# Unmount to kill the healer
> +_scratch_kill_xfs_healer
> +cat $tmp.healer >> $seqres.full
> +
> +status=0
> +exit
> diff --git a/tests/xfs/1884.out b/tests/xfs/1884.out
> new file mode 100644
> index 00000000000000..929e33da01f92c
> --- /dev/null
> +++ b/tests/xfs/1884.out
> @@ -0,0 +1,2 @@
> +QA output created by 1884
> +ls: reading directory 'SCRATCH_MNT/some/victimdir': Structure needs cleaning
> 

