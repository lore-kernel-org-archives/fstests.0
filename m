Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535077E792
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763192257; cv=none; b=X0PKG9fK2n2Nq4zt7sfwDvCPBVay7+xU+s5FPObcwtuRzMRgM8zveqvnTlAwpRT6o4FIqwoRrmP8jYHHkAfCcegzDLkSA+xghoHIR1aNx2uluYPPbX+qUTNt9FFPd3/PPhtdtkLeDffnvxwT6yqU0vPZSViA4mPCcFTiIDfXS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763192257; c=relaxed/simple;
	bh=Q+EJgoV9OGNkgW6m/Rt5higpv0j5DfYxCG92xNr5Ngc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnQPayJE6uyIJjTKrNqsurJfGMm8uItrg6hbBS8X5BvEN79zn5jkjbTdDDeROGXCXKQ+3zt5O2U4fe7e1qK+1iavagqZiGVy3soI9J8ncCLuSGqbqAsaVYKIaPLByF+sz9a/zSgkYD0chU5rAmUMmpv2iF9JyLMRDA7J9NZSiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W17uF3zb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cE3O9eZS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W17uF3zb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE3O9eZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763192254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
	b=W17uF3zbve3FJU+iRwnEGks6Ytg4P7F5O4sHFIiyzRtE9/yXpL5hewY/Aa6Yi+Mbu8AwhD
	sNS3fX0xneTr3Y2NhoOAj1UdmB7DIlYczVuw69hX1p9hO3lyObHn4om/vWzKCDUnCAoh5l
	l6PvDiE6ilVXYVDG8Nl9b0cOWvi3Scs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-PuBejNybOSeDR1KyQmj_Eg-1; Sat, 15 Nov 2025 02:37:31 -0500
X-MC-Unique: PuBejNybOSeDR1KyQmj_Eg-1
X-Mimecast-MFC-AGG-ID: PuBejNybOSeDR1KyQmj_Eg_1763192251
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956cdcdc17so30821765ad.3
        for <fstests@vger.kernel.org>; Fri, 14 Nov 2025 23:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763192250; x=1763797050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
        b=cE3O9eZSoESYpfpAgTww4doDkO6jwirzPfzN7KUwETsBjJfui1eK8miB59ZN02HQ/4
         3T0l1AYGJDBCkD6Ro2LWvB2NAXxwBIGzcfEXfKn8IEzorAquMtDie5Vc1LsYcavllhUv
         +9AyEOi5Ya0pCduTB3vbbyseMW4DdpxmAnuq1/NVLEiBDBouBeHKwHg4S1/rxPwHO1/p
         QiJymjI3KxWwAucDS9Rk1Vf9omBJ80UXk4JRExcdrA+HODeZvtOSHGImIhE0949kBdwk
         VoVmzKjXZqimDoqiO80yJ3juIdKZGg0N+5dVyAT6zMcUtRRz1lh4HQAAkCSfgwuqQF/0
         jt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763192250; x=1763797050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpt7AJNJ29x1IN4z7g8Oew2mK6ZG5cMHvoRNgZWqvX4=;
        b=umhtLrPT+Tz3eWQyC9eQKruBOpcbSAOTJ9j9PM9agdU3q9PhSd+BHFCQyzlH/4s4B4
         zImjLQ+Z3TR6RzaBxmWRsUbHkEvWvLRDa/b/S/Hoj3+0BZKd9uW9/JI+AnQxIegMIENS
         DyPSTdLRlOMft8H/NOTzonIif5PNlLxutY3RXMoKkJwkt+QkvFro+VKiL+DPDSrm3n69
         lSVK/ICR8bS5cbBnfi3pdOZEMmhJw7LUfGyA7b1z6nk9uwWLVhbsiRcfAIs1XjUol92m
         nq+8QucDZeN/xHAQIz6G/UdLRBtW65c+XT5TjzgyFUEMyieK7T3dEfN1Sc8f6McwS7mB
         CiWA==
X-Gm-Message-State: AOJu0Yx6TdUAmu21Ui+YzQ/Z3zCU60FeBTnat33TUS+4FeQnaR3YgjN/
	7U7tha/Ld+6fh3jtJGe0ZbAtd51uIjgDQs8bSpUu3CSE3qmT5FbKHPyE8osJMUcH9+6ur5DHQQX
	EfduwTpeeh57sfY7CiEW5jCa+PGQP86hVHviSxSgdCP9H8Bx/kPONdTQK/aqei4X6Gh8=
X-Gm-Gg: ASbGnctrN36/7pOmEK5XG6gy1as/yva1LHNisofvhSxJzOF1tHuKCj0DLM2i/7VzNP1
	e7QClqizUvWYvmkuxVR7qNGCetpZ2rRvzHH1iNSQhsnGPp5oaf6FUdzDbL6TbXb2OEq7e/mjD1R
	vo2cQEE9a2+WA2WkjouxjS5ZVEsFG1d2fT6gURMOGO5CXbjnMgBFH0r5McNizXSL4rEGjY863j7
	kKc+vBWcZAaHtcQ/5mLIS29Gcak9VPD7VEz57/Drtq+2ehx3LR1U/RsMRH3AD15DNeo/PjDgHpe
	Nul/XpDbC/WZ/XYLlmUo+7ghtxui/e59gOL7MeQ0bAH9c4dOZVFV1LA2VWN8oyQ2+ZUFRDyWz1q
	HrLyJfUAMZPfLaO/kTdf0OzqieIbGqIH6mJb02beURz5lGQM/Sw==
X-Received: by 2002:a17:902:ef51:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2986a6d0e8fmr72746215ad.18.1763192249880;
        Fri, 14 Nov 2025 23:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6hQKUeF6Jq+BIeWcwDmoIem2yUQBwotEdn/Us91MrAC17FzqEJUBOiCoK8CdxwDvRH6Wubg==
X-Received: by 2002:a17:902:ef51:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-2986a6d0e8fmr72746025ad.18.1763192249369;
        Fri, 14 Nov 2025 23:37:29 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23849esm77120015ad.5.2025.11.14.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 23:37:28 -0800 (PST)
Date: Sat, 15 Nov 2025 15:37:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test incremental send after deleting directories
 with many hardlinks
Message-ID: <20251115073724.6qgcuijwutisrtu4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8d1b819511b4c93b5ba0b3137090f5c28a952364.1761844883.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1b819511b4c93b5ba0b3137090f5c28a952364.1761844883.git.fdmanana@suse.com>

On Thu, Oct 30, 2025 at 05:22:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send works after we removed directories that have
> large number of hardlinks for the same file (so that we have extrefs).
> 
> This is a regression test for the kernel commit 1fabe43b4e1a ("btrfs:
> send: fix duplicated rmdir operations when using extrefs").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This patch is good to me, it can reproduce the bug on v6.18-rc1, then test
passed on v6.18-rc4 (which contains the bug fix). As there's not any review
point/objection from btrfs list after 2 weeks, I'd like to merge this patch
in next fstests release.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/338     | 93 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/338.out |  3 ++
>  2 files changed, 96 insertions(+)
>  create mode 100755 tests/btrfs/338
>  create mode 100644 tests/btrfs/338.out
> 
> diff --git a/tests/btrfs/338 b/tests/btrfs/338
> new file mode 100755
> index 00000000..0cc29c7c
> --- /dev/null
> +++ b/tests/btrfs/338
> @@ -0,0 +1,93 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 338
> +#
> +# Test that an incremental send works after we removed directories that have
> +# large number of hardlinks for the same file (so that we have extrefs).
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $send_files_dir
> +}
> +
> +_require_test
> +_require_scratch
> +_require_fssum
> +
> +_fixed_by_kernel_commit 1fabe43b4e1a \
> +	"btrfs: send: fix duplicated rmdir operations when using extrefs"
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +first_stream="$send_files_dir/1.send"
> +second_stream="$send_files_dir/2.send"
> +first_fssum="$send_files_dir/snap1.fssum"
> +second_fssum="$send_files_dir/snap2.fssum"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
> +_scratch_mount
> +
> +# Create two directories which will have many hardlinks for the same file, a
> +# large number that triggers the use of extrefs. This way we will get many
> +# extref items in the subvolume tree, with a very high likelyhood that not
> +# all hardlinks for directory "a" are consecutive in the tree, that they are
> +# interspersed with extref items for hardlinks to directory "b".
> +#
> +# Example:
> +#
> +#        item 0 key (259 INODE_EXTREF 2309449) itemoff 16257 itemsize 26
> +#                index 6925 parent 257 namelen 8 name: foo.6923
> +#        item 1 key (259 INODE_EXTREF 2311350) itemoff 16231 itemsize 26
> +#                index 6588 parent 258 namelen 8 name: foo.6587
> +#        item 2 key (259 INODE_EXTREF 2457395) itemoff 16205 itemsize 26
> +#                index 6611 parent 257 namelen 8 name: foo.6609
> +#        (...)
> +#
> +# Refer to the kernel commit's changelog for more details.
> +mkdir $SCRATCH_MNT/a
> +mkdir $SCRATCH_MNT/b
> +
> +touch $SCRATCH_MNT/a/foo
> +for ((i = 1; i <= 1000; i++)); do
> +	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/a/foo.$i
> +	ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo.$i
> +done
> +
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
> +
> +# Now delete the directories and all the links inside them.
> +rm -fr $SCRATCH_MNT/a
> +rm -fr $SCRATCH_MNT/b
> +
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
> +
> +_btrfs send -f $first_stream $SCRATCH_MNT/snap1
> +_btrfs send -f $second_stream -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
> +
> +$FSSUM_PROG -A -f -w $first_fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -A -f -w $second_fssum -x $SCRATCH_MNT/snap2/snap1 \
> +	$SCRATCH_MNT/snap2
> +
> +# Create a new fs and apply both send streams.
> +_scratch_unmount
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
> +_scratch_mount
> +
> +_btrfs receive -f $first_stream $SCRATCH_MNT
> +_btrfs receive -f $second_stream $SCRATCH_MNT
> +
> +$FSSUM_PROG -r $first_fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -r $second_fssum $SCRATCH_MNT/snap2
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/btrfs/338.out b/tests/btrfs/338.out
> new file mode 100644
> index 00000000..7ea61817
> --- /dev/null
> +++ b/tests/btrfs/338.out
> @@ -0,0 +1,3 @@
> +QA output created by 338
> +OK
> +OK
> -- 
> 2.47.2
> 
> 

