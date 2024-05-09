Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9734C8B
	for <fstests@vger.kernel.org>; Thu,  9 May 2024 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277006; cv=none; b=ILndBUSPb2POQcHJH8Yep8ELQeosjhs27Ri3p+r++HNVTjxBRnMEbA9nkVtB6iQ0r7HeUBOFPrsvDBjhnBC0F/ddnYRPEk+XZ0Gr/+jHQniTiZn4Y8aJsS5D5ZOAWiPKBhkSdBIGKyVFQa4zmKmAzwgEDj+cFLzUwatK9uQu+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277006; c=relaxed/simple;
	bh=wGvYko9mrjKp7qwIXMYfpSX+/bd6yuj2Id+rovX9JQI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=dQH5QcfLgC7gbSC8MbZx2JVFAcnSHLyBCP2+BSWY3zwX6wy0Dk3LQUTpynP2CnjAe5h5clH/TTYVecB3y2ImhRqdzu2Pgz91ZCqIUlumJQby/7eSlZb9bpkqr9fbw6BzSzIDpfrotoAb2L7Wqp2+AwkzSwgk+YWvzk/WCQ2XKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evwDa5M6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evwDa5M6"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee38966529so16370445ad.1
        for <fstests@vger.kernel.org>; Thu, 09 May 2024 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715277004; x=1715881804; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CM9TM2Fc4373HXKk7BNn2KtcUSgLT/GhDivpRLbK3xo=;
        b=evwDa5M6s/OmPnHLFo3hsgMySIjWO2l2dH0Nv+fQfQpl2OqbuCd3nKDgOTOfOUDUUa
         78Os+X1m0eoYhMqNLYyXiymqRJXGfnH72/EMgITF0143j+9eKKTDQ91Nla40sfkjDJzi
         5VVOuum5JDPQ8S4Ej1QZ5ZJpvV4atF73mOG9aMhDjZSelRJSe88FbhKwBPq/9tQWeQou
         AgWFZbdQG+6XPtDT4OdIyZSZnp099MkuC+7iI+gXMaAqrtiEzotC9vYBqqyAt4UN9p/h
         2I2paMZbMJ7dHf9Sv0UZt7yaeJVpEYPCG8KDpXEHur5IlgY5Kqh1vy4UWyAF5JWGe1K8
         QEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277004; x=1715881804;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM9TM2Fc4373HXKk7BNn2KtcUSgLT/GhDivpRLbK3xo=;
        b=XE95laZOjw81Q3BA+UvuoFST0DraZmNQBf+AUty1UJEtdFit8JxdyzE7JU2+Q62sNF
         KNv8tfIJEvvI5wyVWeuKab0sSSIzhcSkN/7ac0/jZdVovk2C62Uwt4Sk3MOW6Mta/q8h
         IEOUMHGK2lsHBH+W98iVcTuGyIDXGdOJBk4DN4XN/Ly6S0KfB1OtxbcaQFS5L1BwDxk4
         B3Jd0xSrFInvgDWEF8TJr1PAh701E7cTFl3kmBrDWMpWjkVusJvAZfsBhucpIGHKJkOz
         08gwDljqkMO+bfpYXPNG9TGva+sL2c28o16a2e6HysLIt9DEUVLeeADNvPPZVC38zO8h
         CoOw==
X-Gm-Message-State: AOJu0YyjvSo59kwLbsS34fucIIoqfem9uD28UIV8N7l6zblz0U4GQQHM
	kurq1eJTUj/k9D9v12FlrMXbL2w7G+5j7X8VZh3LzyffboagEtsX
X-Google-Smtp-Source: AGHT+IGvWPtJOgiKV0V2IppVKjasN2Qi9OkWtxIZwt3dQ4vXTorsuJykks/SwYW3XCYwtyb+ssMwwA==
X-Received: by 2002:a17:902:e806:b0:1e2:58f:7ed4 with SMTP id d9443c01a7336-1ef42d69b6amr6119005ad.5.1715277003989;
        Thu, 09 May 2024 10:50:03 -0700 (PDT)
Received: from dw-tp ([171.76.81.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d4733sm17110725ad.54.2024.05.09.10.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:50:03 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org, zlang@redhat.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
In-Reply-To: <20240508105852.nfjtlp53v24xb3tw@quentin>
Date: Thu, 09 May 2024 23:03:08 +0530
Message-ID: <87ttj6gaaz.fsf@gmail.com>
References: <20240506150119.184097-1-kernel@pankajraghav.com> <20240506150119.184097-2-kernel@pankajraghav.com> <20240507222323.GC2049409@frogsfrogsfrogs> <20240508105852.nfjtlp53v24xb3tw@quentin>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> On Tue, May 07, 2024 at 03:23:23PM -0700, Darrick J. Wong wrote:
>> On Mon, May 06, 2024 at 05:01:17PM +0200, Pankaj Raghav (Samsung) wrote:
>> > From: Pankaj Raghav <p.raghav@samsung.com>
>> > 
>> > This test fails when xfs is formatted with 64k filesystem block size*.
>> > It fails because the soft quota is not exceeded with the hardcoded 64k
>> > pwrite, thereby, the grace time is not set. Even though soft quota is
>> > set to 12k for uid1, it is rounded up to the nearest blocksize.
>> > 
>> > *** Report for user quotas on device /dev/sdb3
>> > Block grace time: 7days; Inode grace time: 7days
>> >                         Block limits                File limits
>> > User            used    soft    hard  grace    used  soft  hard  grace
>> > ----------------------------------------------------------------------
>> > 0        --       0       0       0      0       3     0     0      0
>> > 1        --      64      64    1024      0       1     0     0      0
>> > 2        --      64       0       0      0       1     0     0      0
>> > 
>> > Adapt the pwrite to do more than 64k write when the FS blocksize is 64k.
>> > 
>> > Cap the blksz to be at least 64k to retain the same behaviour as before
>> > for smaller filesystem blocksizes.
>> > 
>> > * This happens even on a 64k pagesize system and it is not related to
>> >   LBS effort.
>> > 
>> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> > ---
>> >  tests/xfs/161 | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/tests/xfs/161 b/tests/xfs/161
>> > index 486fa6ca..94290f18 100755
>> > --- a/tests/xfs/161
>> > +++ b/tests/xfs/161
>> > @@ -38,9 +38,15 @@ _qmount_option "usrquota"
>> >  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>> >  _scratch_mount >> $seqres.full
>> >  
>> > +min_blksz=65536
>> > +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
>> > +# Write more than one block to exceed the soft block quota limit.
>> > +blksz=$(( 2 * $file_blksz))
>> > +
>> > +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))
>> 
>> If we don't set $min_blksize and always write (2 * $file_blksz) does the
>> test still work?
>
> I think something like this is more clean where we don't have anymore
> hardcoded variables:
>

Yes, why not.

> Author: Pankaj Raghav <p.raghav@samsung.com>
> Date:   Thu Jan 18 18:40:39 2024 +0100
>
>     xfs/161: adapt the test case for 64k FS blocksize
>     
>     This test fails when xfs is formatted with 64k filesystem block size*.
>     It fails because the soft quota is not exceeded with the hardcoded 64k
>     pwrite, thereby, the grace time is not set. Even though soft quota is
>     set to 12k for uid1, it is rounded up to the nearest blocksize.
>     
>     *** Report for user quotas on device /dev/sdb3
>     Block grace time: 7days; Inode grace time: 7days
>                             Block limits                File limits
>     User            used    soft    hard  grace    used  soft  hard  grace
>     ----------------------------------------------------------------------
>     0        --       0       0       0      0       3     0     0      0
>     1        --      64      64    1024      0       1     0     0      0
>     2        --      64       0       0      0       1     0     0      0
>     
>     Adapt the pwrite to do twice the FS block size and set the soft limit
>     to be 1 FS block.
>     
>     * This happens even on a 64k pagesize system and it is not related to
>       LBS effort.
>     
>     Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index 486fa6ca..074acddc 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -38,15 +38,21 @@ _qmount_option "usrquota"
>  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
> +
> +pgsize=`$here/src/feature -s`
> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")

small bit: maybe just $blksz is fine.

> +# Write more than one block to exceed the soft block quota limit.
> +blksz=$(( 2 * $file_blksz))

small nit: Instead of blksz here maybe writesz or filesz then?

Then let's make:
lim_bsoft=$blksz, lim_bhard=$(( 10 * blksz )) and writesz=$(( 2 * blksz ))


> +
>  # Force the block counters for uid 1 and 2 above zero
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
>  sync
>  chown 1 $SCRATCH_MNT/a
>  chown 2 $SCRATCH_MNT/b
>  
>  # Set quota limits on uid 1 before upgrading
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=12k bhard=1m 1' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=1m 1' $SCRATCH_MNT

Then we can use $lim_bsoft and $lim_bhard here.

>  
>  # Make sure the grace period is at /some/ point in the future.  We have to
>  # use bc because not all bashes can handle integer comparisons with 64-bit
> @@ -71,7 +77,7 @@ _scratch_mount
>  
>  # Set a very generous grace period and quota limits on uid 2 after upgrading
>  $XFS_QUOTA_PROG -x -c 'timer -u -b -d 2147483647' $SCRATCH_MNT
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=10000 bhard=150000 2' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=150000 2' $SCRATCH_MNT
>  
>  # Query the grace periods to see if they got set properly after the upgrade.
>  repquota -upn $SCRATCH_MNT > $tmp.repquota
>


-ritesh
