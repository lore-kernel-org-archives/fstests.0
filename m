Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="came0Ge+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3896EB7
	for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700399675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZdTEjSzUe6k/H0N8U082A6liCPnVzJh2HMqnCEoLhK0=;
	b=came0Ge+A0qs+iAvXeCCEvyBlLiOlHdbuZXVl0BXHWVKkBCGKa/2Zy9zZcsjQm99eBPmgn
	Gr9hZc5fJCmPFp2dYhz6Qumr21kYg+f64072phu39J8agHsNhr6Zos3YnOsnEmmMSXOUHn
	NZunV+lh7i5qEdfKdTNYIXO9rMLm8oU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-eeGUWqCaPbiHBaw_-4aYiQ-1; Sun, 19 Nov 2023 08:14:33 -0500
X-MC-Unique: eeGUWqCaPbiHBaw_-4aYiQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b2e2487c6bso4769754b6e.2
        for <fstests@vger.kernel.org>; Sun, 19 Nov 2023 05:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700399672; x=1701004472;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdTEjSzUe6k/H0N8U082A6liCPnVzJh2HMqnCEoLhK0=;
        b=O60HK+F8zc03tYtIu9ydBuyU7Ef1xvn5FdDtVOaliUc0d1SyyPTSmUGhGa5xsHKyF7
         kzvJfI8UJgMdaywiIXiEE4JZcaTbTQo2bPcUgdsS+Ofp2pKqGgq6dlfeCarIZq5Lea+d
         81yhzXXebRYCAWdeyDDGrqXdbOh/wU7Ho2RaRtPY54xvdzWAHeHQGE+lwfbkqCCAmC+A
         vtGagsvmd7yWw8T9BWqTAq3Dmkw8CL96aO2nmEpbeT4oXbA1q6TCBKnFX5m0e+b0l69a
         7FoMbsco1oLlz2a9lHsZPNm3O085ZGq1fapGgey2cgU5VSwlGObyJ8ZavIbcLGYYTgzn
         6+eA==
X-Gm-Message-State: AOJu0YyaGixVIHmCBYGA3bjGR502i1EU58T3iG/OiNwDIJ/wmiIRjLjh
	vr+ENtbJhYgMTyhPhO1SrEFOoL48PnFEy9r3m7IEcbvc+rJ5u3O7rbPQzl1cXOFWCgxwQOLAlxs
	2t+IkZrlaDhL9gs9F7Q==
X-Received: by 2002:a05:6808:2207:b0:3ab:85a1:fb04 with SMTP id bd7-20020a056808220700b003ab85a1fb04mr7181389oib.9.1700399672403;
        Sun, 19 Nov 2023 05:14:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiSh1KD3r35kDwKJR34VVkQR9hu52JICZyqdAOSSqO/Z5ZIw0T3ETQCvSDSbaN0W7Y47OVhA==
X-Received: by 2002:a05:6808:2207:b0:3ab:85a1:fb04 with SMTP id bd7-20020a056808220700b003ab85a1fb04mr7181369oib.9.1700399672104;
        Sun, 19 Nov 2023 05:14:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e17-20020a635011000000b005bcea1bf43bsm4341829pgb.12.2023.11.19.05.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 05:14:31 -0800 (PST)
Date: Sun, 19 Nov 2023 21:14:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, amir73il@gmail.com,
	ritesh.list@gmail.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231119131427.topibmy2xdi36a7x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231028070123.971548-1-libaokun1@huawei.com>
 <20231117142451.mhjdsgbqljzkvzuv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <d8478c10-56f0-614a-776e-f721048a534f@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8478c10-56f0-614a-776e-f721048a534f@huawei.com>

On Sat, Nov 18, 2023 at 11:08:10AM +0800, Baokun Li wrote:
> On 2023/11/17 22:24, Zorro Lang wrote:
> > Hi Baokun,
> > 
> > Thanks for this new coverage, some review points as below ...
> > 
> Hi Zorro,
> 
> Thank you for your careful review！
> 
> > >   tests/ext4/062     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/ext4/062.out |  2 ++
> > >   2 files changed, 55 insertions(+)
> > >   create mode 100755 tests/ext4/062
> > >   create mode 100644 tests/ext4/062.out
> > > 
> > > diff --git a/tests/ext4/062 b/tests/ext4/062
> > > new file mode 100755
> > > index 00000000..0ae4ed80
> > > --- /dev/null
> > > +++ b/tests/ext4/062
> > > @@ -0,0 +1,53 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. 062
> > > +#
> > > +# Append writes to a file approaching 16T and observe if a kernel crash is
> > > +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> > > +# This is a regression test for commit
> > > +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick insert
> >                                     ^^^
> >                                     prealloc
> I'll add this.
> > > +
> > > +# real QA test starts here
> > > +_supported_fs ext4
> > > +_fixed_by_kernel_commit bc056e7163ac \
> > > +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> > > +
> > > +_require_xfs_io_command "falloc"
> > > +_require_xfs_io_command "open"
> > > +_require_xfs_io_command "pwrite"
> > I think we don't need to check the "open" and "pwrite" operations,
> > if you don't need special option for them.
> OK!
> > > +_require_scratch_size_nocheck $((100 * 1024))   # 100MB in KB
> > I think 100MB is small enough, don't need this check.
> All right!
> > > +
> > > +# Initalize a 4k 100M ext4 fs
> > > +dev_size=$((100 * 1024 * 1024))
> > > +MKFS_OPTIONS="-b 4096 $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> > > +	>>$seqres.full 2>&1 || _fail "mkfs failed"
> > Can we use bsize=$(_get_file_block_size ....) to get the real block size,
> > to avoid use a specific mkfs option?
> > If so, my second question is if this case can be a generic case. The test
> > steps look common enough, I'm glad to see what will happen on other
> > filesystems through this test.
> The reason for specifying 4096 for formatting here is that mkfs.ext4
> specifies a
> default block size of 1024 when the disk image is 100M.

Is the reproducer related with the block size. If it's not, we can use
"bsize=$(_get_file_block_size $SCRATCH_MNT)" to get the block size, and change
later 4096 to $bsize.

> 
> Although these operations appear to be generic scenarios, the reproduction
> of
> this problem relies on ext4's pre-allocation mechanism. Block allocation
> requests
> are scaled up in ext4_mb_normalize_request(), and the extra blocks are used
> for
> preallocation to reduce fragmentation. Therefore, this test case is placed
> only in
> the ext4 test suite.

Sure it's a reproducer for ext4, but it can be run for other filesystems
which support falloc and finsert. And:
  _require_xfs_io_command "falloc"
  _require_xfs_io_command "finsert"
will make sure the current FSTYP supports these two features. So it can
be a bug coverage for ext4, and a generic test case for other fs.

> > 
> > > +
> > > +_scratch_mount
> > > +
> > > +# Reserve 1M space
> > > +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full 2>&1
> > > +
> > > +# Create a file with logical block numbers close to overflow
> > > +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
> > > +$XFS_IO_PROG -f -c "finsert 1M 16777203M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
> > _require_xfs_io_command "finsert"
> Okay.
> > 
> > > +
> > > +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> > > +$XFS_IO_PROG -f -c "falloc 0 80388096" "${SCRATCH_MNT}/fill" >> $seqres.full 2>&1
> > Can we make sure this step fill the whole free space? There's a helper in
> > common/populate named _fill_fs, please check if it's what you want?
> The remaining space for a 100M 4k ext4 image after the previous operations
> is
> 80388096, so we can confirm that we can fill the entire free space here.
> Of course, using _fill_fs is also workable, but it's faster to do it in a
> single fallocate.

I'm not sure how the reservation works, if there're 90M free space, and you
try to reserve 90+M, will once fallocate calling trys to reserve each free
blocks, before returning error? If it's not, I think the _fill_fs might be
what you want.

Thanks,
Zorro

> > > +
> > > +# Remove reserved space to gain free space for allocation
> > > +rm -f ${SCRATCH_MNT}/tmp
> > > +
> > > +# Trying to allocate two blocks triggers BUG_ON.
> > > +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full 2>&1
> > Oh, you need open -d option, that means you need direct IO, so you need:
> > _require_odirect
> 
> Indeed!
> 
> > And all above xfs_io commands, include falloc, finsert, open and pwrite.
> > You can redirect the stdout to $seqres.full, but better *not* to change
> > the stderr, for we can find errors if they fail (except that expected ENOSPC).
> Ok, I'll remove the unnecessary "2>&1"!
> > > +
> > > +umount "${SCRATCH_MNT}"
> > The $SCRATCH_MNT will be unmounted at the end of the testing, don't need to do
> > it manually, except this's a necessary step of the reproducer.
> Okay, I will remove it.
> > 
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/062.out b/tests/ext4/062.out
> > > new file mode 100644
> > > index 00000000..a1578f48
> > > --- /dev/null
> > > +++ b/tests/ext4/062.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 062
> > > +Silence is golden
> > > -- 
> > > 2.31.1
> > > 
> > > 
> > 
> Thanks!
> -- 
> With Best Regards,
> Baokun Li
> .
> 

