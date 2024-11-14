Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16CA139CFA
	for <fstests@vger.kernel.org>; Thu, 14 Nov 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731561818; cv=none; b=KlBu6KjxlqfjO7H3V7gI1euBr6jtpsdE0arZRzn0RxlL1I22AP0iixceqFjsAa6/nwul0ESpXBqSsYYhMXB+Tq5JeGxHuf4rPWjOqdJamXnHsPKZkoKv1EP3TJ9ADsplTwTm/cR1WBAN1PrKKy9Zsxz1e7MOR4OrQ+oqzu/Ec2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731561818; c=relaxed/simple;
	bh=ijTvODv7PtM+LCi7w5uD9tochVReUbQ2+4iRVBr9yRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbGR8iSIAiNPxNXa6habzmaLrMa5sq+fxjo1OrrgsZMpFAo8j2OsGwvvuFF4z5pM7T3eHs0MjUhQFXCxurDP7hwmaqTqsq085U35BAuBmjfvldZqe8g9tT1h13xwsh4M9n3LckZ99qer3FTFPgcl1NquLDR2pbIfOTw0WaQ4C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=THxMaDdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THxMaDdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731561815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eO7pYgqJfcrAGGemNxwACOe0c+cs5OIE/cc/+Dkpg+w=;
	b=THxMaDdXSwwpxLCzkwo+iQ+Fa0zSQClocZg9/Ckmly79cXha0jEK29c4fc9TTNnmiQiqn3
	qokfrVuNaV9p9zX7U5iZDBywIjw2wbolzr83tATVl0WZ5dPJAm76HMjDG8XwkoDvWS9y1c
	4fBBCfXr13PefgA9POzCeOL9yQYb5f4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-ThM5tHahP1aSqHnhOUGYfA-1; Thu, 14 Nov 2024 00:23:33 -0500
X-MC-Unique: ThM5tHahP1aSqHnhOUGYfA-1
X-Mimecast-MFC-AGG-ID: ThM5tHahP1aSqHnhOUGYfA
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-72459f94af7so248291b3a.2
        for <fstests@vger.kernel.org>; Wed, 13 Nov 2024 21:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731561812; x=1732166612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO7pYgqJfcrAGGemNxwACOe0c+cs5OIE/cc/+Dkpg+w=;
        b=LG4fUrbU1opJvbbjCrP2z7kKe6NS2OkgxkVKYeh4MLG8YmBD0snaepv8i+FlWoO8Z/
         ZD7ToJRsT/Hl/LsXkWrK+TJAb/qj1TsXo7wuJEGjZQKXpDeDnngXSxKyTFuraRI35xIA
         Gx7id+BxwdmJuPUP4rz9S19ckOy82JCpFgPngMdWwDx66afYvhq28bxjNSVkbdsEnZMI
         fCyKWnSw8zogieVYIsaAhVIbW5KJNL4udBOPuycFCBOxHh3B2KAKQc2oVveV4vmA0Ezc
         hPeOrnxSU95o7QmXMwDOVZ5xRhidvwlOCwkjzxfZIgnxQWLrWUMToAIwnF2t19SBNKJ7
         a6cA==
X-Gm-Message-State: AOJu0YxgV4Z3tTzNttasee+bZIrumwqap32IUvYohbFcNVChPqf4VYYK
	qV0ay81t493RKC0mrJqTN904wqop30ZEf3gQLAPWAmWTDV+zezGHGd4aXqPTtBMTN5tzAynirCz
	1JZH5cZxYOw6XcqjL09DXCphmBzTVE9NpEtgt67g523nbWJTMfK3bL1B97enn1b0/F2lX
X-Received: by 2002:a05:6a00:22cf:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-72469e26084mr1140934b3a.21.1731561812070;
        Wed, 13 Nov 2024 21:23:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4TTOzWQ1o1ps43cbIcP2E0A839wv9/z/aWR+Lo7hD9bAoRSd1yMEChiQQ0zxV+JxZC9Sn3Q==
X-Received: by 2002:a05:6a00:22cf:b0:71d:e93e:f542 with SMTP id d2e1a72fcca58-72469e26084mr1140918b3a.21.1731561811611;
        Wed, 13 Nov 2024 21:23:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a6e46a6sm355958b3a.41.2024.11.13.21.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 21:23:31 -0800 (PST)
Date: Thu, 14 Nov 2024 13:23:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] generic/757: fix various bugs in this test
Message-ID: <20241114052328.rnm54xeqxnvkaluc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <173146178810.156441.10482148782980062018.stgit@frogsfrogsfrogs>
 <173146178859.156441.16666438727834100554.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173146178859.156441.16666438727834100554.stgit@frogsfrogsfrogs>

On Tue, Nov 12, 2024 at 05:37:29PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Fix this test so the check doesn't fail on XFS, and restrict runtime to
> 100 loops because otherwise this test takes many hours.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/generic/757 |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/generic/757 b/tests/generic/757
> index 0ff5a8ac00182b..9d41975bde07bb 100755
> --- a/tests/generic/757
> +++ b/tests/generic/757
> @@ -63,9 +63,14 @@ prev=$(_log_writes_mark_to_entry_number mkfs)
>  cur=$(_log_writes_find_next_fua $prev)
>  [ -z "$cur" ] && _fail "failed to locate next FUA write"
>  
> -while [ ! -z "$cur" ]; do
> +for ((i = 0; i < 100; i++)); do
>  	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
>  
> +	# xfs_repair won't run if the log is dirty
> +	if [ $FSTYP = "xfs" ]; then
> +		_scratch_mount

Hi Darrick, can you mount at here? I always get mount error as below:

SECTION       -- default
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 dell-per750-41 6.12.0-0.rc5.44.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Oct 28 14:12:55 UTC 2024
MKFS_OPTIONS  -- -f /dev/sda6
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch

generic/757 2185s ... [failed, exit status 1]- output mismatch (see /root/git/xfstests/results//default/generic/757.out.bad)
    --- tests/generic/757.out   2024-10-27 03:09:48.740518275 +0800
    +++ /root/git/xfstests/results//default/generic/757.out.bad 2024-11-14 13:18:56.965210155 +0800
    @@ -1,2 +1,5 @@
     QA output created by 757
    -Silence is golden
    +mount: /mnt/scratch: cannot mount; probably corrupted filesystem on /dev/sda6.
    +       dmesg(1) may have more information after failed mount system call.
    +mount -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch failed
    +(see /root/git/xfstests/results//default/generic/757.full for details)
    ...
    (Run 'diff -u /root/git/xfstests/tests/generic/757.out /root/git/xfstests/results//default/generic/757.out.bad'  to see the entire diff)
Ran: generic/757
Failures: generic/757
Failed 1 of 1 tests

# dmesg
...
[1258572.169378] XFS (sda6): Mounting V5 Filesystem a0bf3918-1b66-4973-b03c-afd5197a6d21
[1258572.193037] XFS (sda6): Starting recovery (logdev: internal)
[1258572.201691] XFS (sda6): Corruption warning: Metadata has LSN (1:41116) ahead of current LSN (1:161). Please unmount and run xfs_repair (>= v4.3) to resolve.
[1258572.215850] XFS (sda6): Metadata CRC error detected at xfs_bmbt_read_verify+0x16/0xc0 [xfs], xfs_bmbt block 0x2000e8 
[1258572.226825] XFS (sda6): Unmount and run xfs_repair
[1258572.231796] XFS (sda6): First 128 bytes of corrupted metadata buffer:
[1258572.238411] 00000000: 42 4d 41 33 00 00 00 fb 00 00 00 00 00 04 00 9e  BMA3............
[1258572.246585] 00000010: 00 00 00 00 00 04 00 60 00 00 00 00 00 20 00 e8  .......`..... ..
[1258572.254766] 00000020: 00 00 00 01 00 00 a0 9c a0 bf 39 18 1b 66 49 73  ..........9..fIs
[1258572.262945] 00000030: b0 3c af d5 19 7a 6d 21 00 00 00 00 00 00 00 83  .<...zm!........
[1258572.271117] 00000040: 17 2f 1b e4 00 00 00 00 00 00 00 00 04 b1 2e 00  ./..............
[1258572.279291] 00000050: 00 00 00 4b 15 e0 00 01 80 00 00 00 04 b1 30 00  ...K..........0.
[1258572.287462] 00000060: 00 00 00 4b 16 00 00 4f 00 00 00 00 04 b1 ce 00  ...K...O........
[1258572.295635] 00000070: 00 00 00 4b 1f e0 00 01 80 00 00 00 04 b1 d0 00  ...K............
[1258572.303811] XFS (sda6): Filesystem has been shut down due to log error (0x2).
[1258572.311123] XFS (sda6): Please unmount the filesystem and rectify the problem(s).
[1258572.318791] XFS (sda6): log mount/recovery failed: error -74
[1258572.324798] XFS (sda6): log mount failed
[1258572.365169] XFS (sda5): Unmounting Filesystem eb4b7840-2c01-4306-9a6c-af2e7207a23f

> +		_scratch_unmount
> +	fi


>  	_check_scratch_fs
>  
>  	prev=$cur
> 

