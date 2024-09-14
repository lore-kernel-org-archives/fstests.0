Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0171CFBC
	for <fstests@vger.kernel.org>; Sat, 14 Sep 2024 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726288817; cv=none; b=gl+lDYyUq86PeCYMlV9ER//848pOet6Cd/JgLA93lJqEhqAkL4IGcAvefRgAxzGAdukYb/9+jDIq/23sJW68zomJZXHOYN/eJWrCktrHXbFJYz8VH7wlmlqA4KBka/u1KJ1EluiIJ1quLDEP8FNDXJiGK0vWIGws7SRvWyXxQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726288817; c=relaxed/simple;
	bh=dtOH0nLPvAsIoQXUXVWB6ZjWLUttpedWielnp9KUGUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IornkmN9nXfInaO+7kEpzUyv/0Z9+yNEitM0NR/lMJJ56hqAPamgMpCDPQLEvK6ScoEQ9h3k5exVexyYD2hjhAqu4cI3wA3Z+r0LXz7BjAofA3Z7BLvuwnYCK93ibVPHfKgupODnCmYO8231uVzd3iwCSiOh/4u60AbtERuu1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDT2JWHL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDT2JWHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726288813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=knbmzB1+xLY0hr0zrTvjnrc4RImKzMZ3r6RGNZTWxXo=;
	b=KDT2JWHLNq7ttKMARBQZewhPbzWPvUXGyHgm+UevXqBLDC78roHA036Q/kcbIuATh1lGNd
	Gxvc1Fbz9PIXFjZxNbMSu2etxdv4JCDoMeXa0zuiVmrh+hXe5xJbWcb4mW+tXkvQr7+PFL
	o6lX6GPHuw3TshdWnooxe5ZJ0uyxPbQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-p-UkhO5KMiSg0jKIkYftyA-1; Sat, 14 Sep 2024 00:40:11 -0400
X-MC-Unique: p-UkhO5KMiSg0jKIkYftyA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718db8e61bfso4763197b3a.0
        for <fstests@vger.kernel.org>; Fri, 13 Sep 2024 21:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726288810; x=1726893610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knbmzB1+xLY0hr0zrTvjnrc4RImKzMZ3r6RGNZTWxXo=;
        b=a8Kh4liCeF+1b+slK/hvd/wJSME8AkQ0FIxiqgY2CF04xkKU6ndSOUT7UCzoYzj+Qy
         +HcNb6ljUY8MK5ihd2poOty0fZj8HFsMYiQmpncFL79KanYSvGby64FCOglvN0k8c2lW
         tcadeverHzl0UmfJfh+z4Rn1X3HpMDxrGbhUOf6BGE8oQFX7LkPy4q7+WI5FIRBU84C/
         K5FDyNxpbXnrMxZZFMdqX3wfMbETwWvy2JnJTTSzu4CvVFwmNTnpnl3moUI1r2FZmLtr
         tw3KBsuHmKJ8p7cDom4dHBF/MR1ahhZAnUOFsevyhijWflQoO54WHx22+0GNwyYU/BSD
         RENw==
X-Gm-Message-State: AOJu0Yx+/UZS9rdsUHSdxeDd5d3kluLOAf00aeCRUswOKlpjAUK2fE0l
	b6Jgd81LufQeW8SCBz98a/lQyujaLU6Q7L3+kvdcTSNFPdETpbMhLeMSaNN8DfJd0+ZjPG3O/gT
	Nl8Ka8PgrW19q/1jd38oOSoONQUiTM7i7/Tum/0K6XHxR4XXyV5g0anAj8GoTXl9dEg==
X-Received: by 2002:a05:6a00:218f:b0:70d:2892:402b with SMTP id d2e1a72fcca58-7192608123fmr14733389b3a.7.1726288809689;
        Fri, 13 Sep 2024 21:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLj/8w+OkOlWhEeFf0j36sd8+qdEbj8sOcdiFgTp8PElaNDw5lUsmWUwr8ZINFQck6rZFufg==
X-Received: by 2002:a05:6a00:218f:b0:70d:2892:402b with SMTP id d2e1a72fcca58-7192608123fmr14733362b3a.7.1726288809210;
        Fri, 13 Sep 2024 21:40:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944abb69esm346870b3a.67.2024.09.13.21.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 21:40:08 -0700 (PDT)
Date: Sat, 14 Sep 2024 12:40:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
	Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [External] : Re: [PATCH] ext4: Regression test for corruption
 during on-line resize
Message-ID: <20240914044005.k2ruita22xevrefy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240911102045.71870-1-srivathsa.d.dara@oracle.com>
 <20240911125734.44wtifmoyvd74ptq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <DM6PR10MB43477AC7B8B80A38A7155898A0642@DM6PR10MB4347.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR10MB43477AC7B8B80A38A7155898A0642@DM6PR10MB4347.namprd10.prod.outlook.com>

On Thu, Sep 12, 2024 at 05:53:17AM +0000, Srivathsa Dara wrote:
> Hi Zorro,
> 
> > > Regression test for:
> > > 	a6b3bfe176e8 ext4: fix corruption during on-line resize
> > > 
> > > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> > > ---
> > >  tests/ext4/060     | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/ext4/060.out |  2 ++
> > >  2 files changed, 45 insertions(+)
> > >  create mode 100755 tests/ext4/060
> > >  create mode 100644 tests/ext4/060.out
> > > 
> > > diff --git a/tests/ext4/060 b/tests/ext4/060 new file mode 100755 
> > > index 00000000..440748ea
> > > --- /dev/null
> > > +++ b/tests/ext4/060
> > > @@ -0,0 +1,43 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 060
> > > +#
> > > +# This test ensures that kernel avoids FS corruption while online # 
> > > +resizing an ext4 filesystem with disabled resize_inode feature.
> > > +#
> > > +# The commit a6b3bfe176e8 ("ext4: fix corruption during on-line 
> > > +resize") # stops the corruption.
> > > +#
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest auto resize quick
> > > +
> > > +_supported_fs ext4
> > > +_fixed_by_kernel_commit a6b3bfe176e8 \
> > > +	"ext4: fix corruption during on-line resize"
> > > +
> > > +_require_command "$RESIZE2FS_PROG" resize2fs _require_command 
> > > +"$E2FSCK_PROG" e2fsck _require_scratch_size_nocheck $((9* 1024 * 
> > > +1024))
> > > +
> > > +# Initialize an EXT4 filesystem with the resize_inode feature 
> > > +disabled, # and a size of 128MiB less than 8GiB, i.e., short of 1 
> > > +block group in # an 8GiB filesystem.
> > > +
> > > +dev_size=$((8* 1024 * 1024 * 1024 - 128 * 1024 * 1024)) 
> > > +MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> > > +	>>$seqres.full 2>&1
> > 
> > Just for sure, is the 8G fs size a necessary requirement to reproduce the bug?
> > Is it related with the block size (e.g. different blocksize need different fs size for testing)?
> 
> Yes, the issue was that, before the fix, while performing an online
> resize of a filesystem with the resize_inode feature disabled, the
> kernel would corrupt the first block of the last group in the 0th meta_bg.
> 
> If the block size is 1024, each meta_bg has 16 (1024/64) block groups.
> The last blockgroup of the 0th meta_bg is 15, and the block that gets
> corrupted is the 122,880th block, which is the first block of the 15th block group.
> 
> If the block size is 2048, each meta_bg has 32 (2048/64) block groups.
> The last blockgroup of the 0th meta_bg is 31, and the block that gets
> corrupted is the 507,904th block, which is the first block of the 31st block group.
> 
> If the block size is 4096, each meta_bg has 64 (4096/64) block groups.
> The last blockgroup of the 0th meta_bg is 63, and the block that gets
> corrupted is the 2,064,384th block, which is the first block of the 63rd block group.
> 
> The corruption occurred because, when updating backup group descriptors,
> the kernel failed to check whether the group descriptor being updated belonged
> to the meta_bg layout or not, leading to an incorrect block being updated.
> Hence, the corruption.
> 
> To reproduce the issue, the initial filesystem's descriptor block must have
> some available space, and the resize operation should increase the filesystem
> size enough to cross the meta_bg boundary.
> 
> In this case, the initial filesystem size was chosen as 8GiB minus 128MiB,
> so that its descriptor block has space to accommodate an additional block group.
> The filesystem is then resized to 9GiB ( 8GiB is the meta_bg boundary).

Actually I hope to check the MKFS_OPTIONS with you, I saw you try to carry on the
MKFS_OPTIONS, MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS". If
MKFS_OPTIONS="-b 65536" (or others), can this bug still be reproduced? If not, we
can drop the old MKFS_OPTIONS, just set MKFS_OPTIONS="-O ^resize_inode". Or we
can keep it.

> 
> > 
> > > +
> > > +_scratch_mount
> > > +
> > > +# Perform online-resize
> > > +$RESIZE2FS_PROG $SCRATCH_DEV 9G >> $seqres.full 2>&1
> > > +
> > > +$E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "Filesystem corrupted"
> > 
> > Do you want to test online resize or online fsck or both? (Does ext4 support online fsck?)
> 
> I want to test only the online resize. No, EXT4 doesn't support online fsck.
> However, e2fsck with the -fn option reports corruption even if the device
> is mounted.

As EXT4 doesn't support online fsck, better to unmount before fscking. To avoid other
interference.

Thanks,
Zorro

> 
> Thanks,
> Srivathsa
> 
> > 
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/ext4/060.out b/tests/ext4/060.out new file mode 
> > > 100644 index 00000000..8ffce4de
> > > --- /dev/null
> > > +++ b/tests/ext4/060.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 060
> > > +Silence is golden
> > > --
> > > 2.39.3
> > > 
> > >
> 

