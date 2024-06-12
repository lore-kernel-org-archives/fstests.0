Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE44C63
	for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179262; cv=none; b=IQw+Sc5fWehKnvAeHzeLkJCYh9Nzts8Cvsj9bXlXV/Ri2MQ10t/xBDsXT1aN6sTxbnm4tEU2cQU5MecI6WrxG9aoleHWKsjZRUfwroveSV+TR3l6BKDA1ExZkruLByYzKhgrolAuWBwGKxPCmjWbu30Rkb0/zfkWcKe3TmGcqU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179262; c=relaxed/simple;
	bh=0OWZytV7iidTSRsiJbmntqWHMzCgSbj+2IHoc91k3X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9654zaWAA8gl4kvQLP36La6ytRe1p7I07EAn9jZmSjxipihlEc8i5irhoYhjKGf0HgjiFMB8ocHmqNsPqcC9gLgeJiol4YrPLbCdfeq0zIMVJP1vyr54x4Z2ysPITf+CycdM2/i8uYTN+fIdby4fRp9oEDheD+B+dK4yWTZBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxiZFkj1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxiZFkj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718179260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/SC79B0SQx0Kv68DpQnR4beG6Hiq5QD/FW1/evjIEo=;
	b=HxiZFkj1fMf5lkZU/wdfPudc1YHecKu4KeIT022VwMRAZv2HP5t+DiC9VZ52LUSQcVxNS0
	OvUY9SyARfeJ/OFsb6msP/AAJNjqqy5x/P+dMprysNPDn3UhxDAo/pZm47am0tbEFApUMI
	WoiOaaXLuhwkL0tPQLhbWgRUwNzQGD4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-ZDZkuD0NMc6Cofj3wMf6CQ-1; Wed, 12 Jun 2024 04:00:58 -0400
X-MC-Unique: ZDZkuD0NMc6Cofj3wMf6CQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6c72c8b9603so5415614a12.2
        for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 01:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718179257; x=1718784057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/SC79B0SQx0Kv68DpQnR4beG6Hiq5QD/FW1/evjIEo=;
        b=n6wwfTKBKg+3/agTpz+tyRMc2p61xg5o9R8MGJSkm13/MJ1MhYjglKIN0raGL+paHR
         /u7mFWHk/TDr9MV0yx1rOelcYCa/7LL8lNuAeZk8smtqTLulr57Ka6Yueq6u8j+tiE1H
         raPtqiSVaGRS/ADRx5+CcphIPEoHLnJWH22T+SkLF2uVdwz7i9JeIZizIMhmvd3NKFyS
         ckYiDEL/evq697+lR4C14nrN3dGIaAFJdHS2YcjFClIUvPBhgwLeHgRQMAww5ep49Hg1
         8I88d4WwJG6l9cytX6LRlbQAv5NCN3COfiBrWPuOuXwf3Ebl3CKf1aM3ztCsD5pz7D9E
         6UlA==
X-Forwarded-Encrypted: i=1; AJvYcCXWU2msEkPKBiw+0GLe32Ks4i1klvr6Y21TsNg6oXwjML1DtNYhyS4A4p0cwWjCGT4NRyZJ06KBwSF245PjmfMuhQO78LEc7A==
X-Gm-Message-State: AOJu0YzpZHHo8WbdJ0XWIsBn5VtkbbLWG61dPkNN7NUTj8j3uYuUTlnp
	25WpD056A18Lo6EKJqMP6XOJytfik6ikGu9CU0Lb+9+D8lfYKh5ti3ZgIEWpNM9nt5+cooqATR7
	yZMqZliAGKjzRn8qF/xQ6gImK9LNMM2kj0pBKD8HRVvQruD/0D0vV2X8=
X-Received: by 2002:a05:6a20:8423:b0:1b8:7df1:595b with SMTP id adf61e73a8af0-1b8a9ba7d01mr1293375637.21.1718179256869;
        Wed, 12 Jun 2024 01:00:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAPrr/MJx8mrt70uE7M9aB9/SWIUme1NLj1rWoKuRef2sjVdMtlSpkqcr6UXpxn4s/+VwzgQ==
X-Received: by 2002:a05:6a20:8423:b0:1b8:7df1:595b with SMTP id adf61e73a8af0-1b8a9ba7d01mr1293331637.21.1718179256174;
        Wed, 12 Jun 2024 01:00:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705a16c7803sm4123812b3a.144.2024.06.12.01.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:00:55 -0700 (PDT)
Date: Wed, 12 Jun 2024 16:00:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: patches@lists.linux.dev, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
	ziy@nvidia.com, vbabka@suse.cz, seanjc@google.com,
	willy@infradead.org, david@redhat.com, hughd@google.com,
	linmiaohe@huawei.com, muchun.song@linux.dev, osalvador@suse.de,
	p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de,
	john.g.garry@oracle.com
Subject: Re: [PATCH 3/5] fstests: add fsstress + compaction test
Message-ID: <20240612080048.dnbc3rzmeo7jtubv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240611030203.1719072-1-mcgrof@kernel.org>
 <20240611030203.1719072-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611030203.1719072-4-mcgrof@kernel.org>

On Mon, Jun 10, 2024 at 08:02:00PM -0700, Luis Chamberlain wrote:
> Running compaction while we run fsstress can crash older kernels as per
> korg#218227 [0], the fix for that [0] has been posted [1] that patch
> was merged on v6.9-rc6 fixed by commit d99e3140a4d3 ("mm: turn
> folio_test_hugetlb into a PageType"). However even on v6.10-rc2 where
> this kernel commit is already merged we can still deadlock when running
> fsstress and at the same time triggering compaction, this is a new
> issue being reported now this through patch, but this patch also
> serves as a reproducer with a high confidence. It always deadlocks.
> If you enable CONFIG_PROVE_LOCKING with the defaults you will end up
> with a complaint about increasing MAX_LOCKDEP_CHAIN_HLOCKS [1], if
> you adjust that you then end up with a few soft lockup complaints and
> some possible deadlock candidates to evaluate [2].
> 
> Provide a simple reproducer and pave the way so we keep on testing this.
> 
> Without lockdep enabled we silently deadlock on the first run of the
> test without the fix applied. With lockdep enabled you get a splat about
> the possible deadlock on the first run of the test.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=218227
> [1] https://gist.github.com/mcgrof/824913b645892214effeb1631df75072
> [2] https://gist.github.com/mcgrof/926e183d21c5c4c55d74ec90197bd77a
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/rc             |  7 +++++
>  tests/generic/750     | 62 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/750.out |  2 ++
>  3 files changed, 71 insertions(+)
>  create mode 100755 tests/generic/750
>  create mode 100644 tests/generic/750.out
> 
> diff --git a/common/rc b/common/rc
> index e812a2f7cc67..18ad25662d5c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -151,6 +151,13 @@ _require_hugepages()
>  		_notrun "Kernel does not report huge page size"
>  }
>  
> +# Requires CONFIG_COMPACTION
> +_require_vm_compaction()
> +{
> +	if [ ! -f /proc/sys/vm/compact_memory ]; then
> +	    _notrun "Need compaction enabled CONFIG_COMPACTION=y"
> +	fi
> +}
>  # Get hugepagesize in bytes
>  _get_hugepagesize()
>  {
> diff --git a/tests/generic/750 b/tests/generic/750
> new file mode 100755
> index 000000000000..334ab011dfa0
> --- /dev/null
> +++ b/tests/generic/750
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Luis Chamberlain.  All Rights Reserved.
> +#
> +# FS QA Test 750
> +#
> +# fsstress + memory compaction test
> +#
> +. ./common/preamble
> +_begin_fstest auto rw long_rw stress soak smoketest
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $runfile
> +	rm -f $tmp.*
> +	kill -9 $trigger_compaction_pid > /dev/null 2>&1
> +	$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +
> +	wait > /dev/null 2>&1
> +}
> +
> +# Import common functions.
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +
> +_require_scratch
> +_require_vm_compaction
> +_require_command "$KILLALL_PROG" "killall"
> +
> +# We still deadlock with this test on v6.10-rc2, we need more work.
> +# but the below makes things better.
> +_fixed_by_git_commit kernel d99e3140a4d3 \
> +	"mm: turn folio_test_hugetlb into a PageType"
> +
> +echo "Silence is golden"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount >> $seqres.full 2>&1
> +
> +nr_cpus=$((LOAD_FACTOR * 4))
> +nr_ops=$((25000 * nr_cpus * TIME_FACTOR))
> +fsstress_args=(-w -d $SCRATCH_MNT -n $nr_ops -p $nr_cpus)
> +
> +# start a background trigger for memory compaction
> +runfile="$tmp.compaction"
> +touch $runfile
> +while [ -e $runfile ]; do
> +	echo 1 > /proc/sys/vm/compact_memory
> +	sleep 5
> +done &
> +trigger_compaction_pid=$!
> +
> +test -n "$SOAK_DURATION" && fsstress_args+=(--duration="$SOAK_DURATION")
> +
> +$FSSTRESS_PROG $FSSTRESS_AVOID "${fsstress_args[@]}" >> $seqres.full
> +wait > /dev/null 2>&1

Won't this "wait" wait forever (except a ctrl+C), due to no one removes
the $runfile?

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/generic/750.out b/tests/generic/750.out
> new file mode 100644
> index 000000000000..bd79507b632e
> --- /dev/null
> +++ b/tests/generic/750.out
> @@ -0,0 +1,2 @@
> +QA output created by 750
> +Silence is golden
> -- 
> 2.43.0
> 
> 

