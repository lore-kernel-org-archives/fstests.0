Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMBJT5eo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C5B7
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700400073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/RXbAZ7q71NgMMJc5dyqbkFIdGU1dRv9B2ebLPGQYg=;
	b=ZMBJT5eoFSy9tJvQGABK1pZKhGj7ZUqzsQj0KFhZZb71qOkiKhHkwyjEqMnL3eIA81gEwi
	yL8QFTJJmsZ8ZA76rZedka0s+VKGbbozbF3iFB4kv/BraRcuQju4dLqxd7srGDPsTfBxES
	PMsblA7VPLP29e4V+MDHqWAzk/4xdnQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-fdbTEdbgPqaGGkIK8EvOpQ-1; Sun, 19 Nov 2023 08:21:11 -0500
X-MC-Unique: fdbTEdbgPqaGGkIK8EvOpQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso4031310b3a.2
        for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700400069; x=1701004869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/RXbAZ7q71NgMMJc5dyqbkFIdGU1dRv9B2ebLPGQYg=;
        b=qSQepEcBqiieCUyNkIPTd2AOz37XjLfG6A1rAE2Hc++WdekACqRvPTXnyxjHBZH7cJ
         sFpll9cpVo8nmeSaM0ndcJ0k59B/LcuRGNTDgk1KF2XFp9QrRFjrQvISlBJQZTcbBPnB
         5je6UNRptonZ6i3YeznqsayHFcL2ydbP/hNS28sI4mNvO57KBqd7tBDpgUwMIqhl54r7
         H5Cb8LWLqggYTv3nypVE3tb7uG5yml0yPNL8xirTeJ/S7UkyMu13OSazJMj2zak8KT/R
         RShlBFl7cTaaX7rrNxVZSTSk7nVlyaTGBlB/5Ntt1K1U+9ImHknIiiFEbqSkgxrWgzsQ
         nJxg==
X-Gm-Message-State: AOJu0Yw1qgwUWROVxYvObJCYQQ22tnX+pCeOwxEwNvQQPwVdAvWVX2ES
	rSK86epoQXLKhVw5j/ZNpomhbiOXEGRxvqB+N5SS+EjpdXS4ofrJLzxQe3aY0/h1Zgd6/D5xjHj
	CJnAWc2SDDkQBTXXnmQ==
X-Received: by 2002:a05:6a00:1895:b0:6c3:3795:dd66 with SMTP id x21-20020a056a00189500b006c33795dd66mr4266399pfh.16.1700400069577;
        Sun, 19 Nov 2023 05:21:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpDJ5qQKILmMXRtNi1OD/fUuZ8AIebh3dTzl9TD143nc2eRsDsc0jiCO4V75L6GnFp+HTMSw==
X-Received: by 2002:a05:6a00:1895:b0:6c3:3795:dd66 with SMTP id x21-20020a056a00189500b006c33795dd66mr4266378pfh.16.1700400069117;
        Sun, 19 Nov 2023 05:21:09 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t18-20020a056a0021d200b006cb997a3210sm141447pfj.193.2023.11.19.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:21:08 -0800 (PST)
Date: Sun, 19 Nov 2023 21:21:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH fstests v2] xfs: test refilling AGFL after lots of btree
 splits
Message-ID: <20231119132105.vqqrlkl4df76da4k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <68cd85697855f686529829a2825b044913148caf.1698699188.git.osandov@fb.com>
 <fe622bff22bca23648ed1154faeadce3ed51ad3b.1698699498.git.osandov@osandov.com>
 <20231101064543.uruh3ljicwnedw7x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231101155630.GA1203404@frogsfrogsfrogs>
 <20231117143232.jool55gt5zysmm55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20231117220732.GG36175@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117220732.GG36175@frogsfrogsfrogs>

On Fri, Nov 17, 2023 at 02:07:32PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 17, 2023 at 10:32:32PM +0800, Zorro Lang wrote:
> > On Wed, Nov 01, 2023 at 08:56:30AM -0700, Darrick J. Wong wrote:
> > > On Wed, Nov 01, 2023 at 02:45:43PM +0800, Zorro Lang wrote:
> > > > On Mon, Oct 30, 2023 at 02:00:15PM -0700, Omar Sandoval wrote:
> > > > > This is a regression test for patch "xfs: fix internal error from AGFL
> > > > > exhaustion"), which is not yet merged. Without the fix, it will fail
> > > > > with a "Structure needs cleaning" error.
> > > > > 
> > > > > Signed-off-by: Omar Sandoval <osandov@osandov.com>
> > > > > ---
> > > > > Changes since v1 [1]:
> > > > > 
> > > > > - Fixed to check whether mkfs.xfs supports -m rmapbt.
> > > > > - Changed bare $XFS_DB calls to _scratch_xfs_db.
> > > > > - Expanded comment about what happens without the fix.
> > > > > 
> > > > > I didn't add a check for whether everything ended up in AG 0, because it
> > > > > wasn't clear to me what to do in that case. We could skip the test, but
> > > > > it also doesn't hurt to run it anyways.
> > > > > 
> > > > > 1: https://lore.kernel.org/linux-xfs/c7be2fe66a297316b934ddd3a1368b14f39a9f22.1698190540.git.osandov@osandov.com/
> > > > > 
> > > > >  tests/xfs/601     | 68 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/xfs/601.out |  2 ++
> > > > 
> > > > The xfs/601 has been taken by:
> > > >   39f88c55 ("generic: test FALLOC_FL_UNSHARE when pagecache is not loaded")
> > > > 
> > > > I'll change this case to another number.
> > > > 
> > > > ...
> > > > Hi Darrick, I just noticed that commit has "generic", but that's a case in
> > > > tests/xfs, and there's not "_supported_fs xfs" in xfs/601. Do you want to
> > > > move it to be a generic case?
> > > 
> > > Yes, the existing xfs/601 regression test (kernel commit 35d30c9cf127)
> > > can become a generic test; and then this one can take its place.
> > 
> > If you need to move current xfs/601 to generic/, better to have another patch.
> > I'll merge this patch in xfs/ at first. Then you can do that moving in your next
> > "random fix" patchset, or I can send a patch to do that.
> 
> <shrug> I'll ./mvtest and send the resulting patch next week unless you
> beat me to it.

Don't worry, this's a "peace and love" mailing list ;-)

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > >  2 files changed, 70 insertions(+)
> > > > >  create mode 100755 tests/xfs/601
> > > > >  create mode 100644 tests/xfs/601.out
> > > > > 
> > > > > diff --git a/tests/xfs/601 b/tests/xfs/601
> > > > > new file mode 100755
> > > > > index 00000000..68df6ac0
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/601
> > > > > @@ -0,0 +1,68 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > > > > +#
> > > > > +# FS QA Test 601
> > > > > +#
> > > > > +# Regression test for patch "xfs: fix internal error from AGFL exhaustion".
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto prealloc punch
> > > > > +
> > > > > +. ./common/filter
> > > > > +
> > > > > +_supported_fs xfs
> > > > > +_require_scratch
> > > > 
> > > > _require_xfs_io_command "fpunch" ?
> > > > 
> > > > I can help to add that, others look good to me.
> > > > 
> > > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > > > 
> > > > > +_require_test_program punch-alternating
> > > > > +_fixed_by_kernel_commit XXXXXXXXXXXX "xfs: fix internal error from AGFL exhaustion"
> > > > > +
> > > > > +# Disable the rmapbt so we only need to worry about splitting the bnobt and
> > > > > +# cntbt at the same time.
> > > > > +opts=
> > > > > +if $MKFS_XFS_PROG |& grep -q rmapbt; then
> > > > > +	opts="-m rmapbt=0"
> > > > > +fi
> > > > > +_scratch_mkfs $opts | _filter_mkfs > /dev/null 2> "$tmp.mkfs"
> > > > > +. "$tmp.mkfs"
> > > > > +_scratch_mount
> > > > > +
> > > > > +alloc_block_len=$((_fs_has_crcs ? 56 : 16))
> > > > > +allocbt_leaf_maxrecs=$(((dbsize - alloc_block_len) / 8))
> > > > > +allocbt_node_maxrecs=$(((dbsize - alloc_block_len) / 12))
> > > > > +
> > > > > +# Create a big file with a size such that the punches below create the exact
> > > > > +# free extents we want.
> > > > > +num_holes=$((allocbt_leaf_maxrecs * allocbt_node_maxrecs - 1))
> > > > > +$XFS_IO_PROG -c "falloc 0 $((9 * dbsize + num_holes * dbsize * 2))" -f "$SCRATCH_MNT/big"
> > > > > +
> > > > > +# Fill in any small free extents in AG 0. After this, there should be only one,
> > > > > +# large free extent.
> > > > > +_scratch_unmount
> > > > > +mapfile -t gaps < <(_scratch_xfs_db -c 'agf 0' -c 'addr cntroot' -c btdump |
> > > > > +	$SED_PROG -rn 's/^[0-9]+:\[[0-9]+,([0-9]+)\].*/\1/p' |
> > > > > +	tac | tail -n +2)
> > > > > +_scratch_mount
> > > > > +for gap_i in "${!gaps[@]}"; do
> > > > > +	gap=${gaps[$gap_i]}
> > > > > +	$XFS_IO_PROG -c "falloc 0 $((gap * dbsize))" -f "$SCRATCH_MNT/gap$gap_i"
> > > > > +done
> > > > > +
> > > > > +# Create enough free space records to make the bnobt and cntbt both full,
> > > > > +# 2-level trees, plus one more record to make them split all the way to the
> > > > > +# root and become 3-level trees. After this, there is a 7-block free extent in
> > > > > +# the rightmost leaf of the cntbt, and all of the leaves of the cntbt other
> > > > > +# than the rightmost two are full. Without the fix, the free list is also
> > > > > +# empty.
> > > > > +$XFS_IO_PROG -c "fpunch $dbsize $((7 * dbsize))" "$SCRATCH_MNT/big"
> > > > > +"$here/src/punch-alternating" -o 9 "$SCRATCH_MNT/big"
> > > > > +
> > > > > +# Do an arbitrary operation that refills the free list. Without the fix, this
> > > > > +# will allocate 6 blocks from the 7-block free extent in the rightmost leaf of
> > > > > +# the cntbt, then try to insert the remaining 1 block free extent in the
> > > > > +# leftmost leaf of the cntbt. But that leaf is full, so this tries to split the
> > > > > +# leaf and fails because the free list is empty, returning EFSCORRUPTED.
> > > > > +$XFS_IO_PROG -c "fpunch 0 $dbsize" "$SCRATCH_MNT/big"
> > > > > +
> > > > > +echo "Silence is golden"
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/xfs/601.out b/tests/xfs/601.out
> > > > > new file mode 100644
> > > > > index 00000000..0d70c3e5
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/601.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 601
> > > > > +Silence is golden
> > > > > -- 
> > > > > 2.41.0
> > > > > 
> > > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> 

