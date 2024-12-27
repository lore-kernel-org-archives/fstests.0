Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC301428F3
	for <fstests@vger.kernel.org>; Fri, 27 Dec 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284101; cv=none; b=KsUUdu2nG0+Z2KguLduIhdyB1+N7dlTgE+lp/XdUk9dbxTNxcTFbfd683MKRsEIsmH2F3+yLwiTj7oMYBCSqzhoTof4S2zyyqI0mv2KgzG2nVViti/YO663YBkFVXF/UOwIYgHZ7J8YiqBPupbdGQPx3oNXbuKf/6I4KMyG57LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284101; c=relaxed/simple;
	bh=0PQvQUthfVcmALz1wJRVd8k8k8ZQ0rT5yKCfUqG+HIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMTZ8USckqnzbKr8G5WzpHDWDNyTdWqIhjPXmOzjmdOQ1JLssnRO8jrpCD60P58gx0af4OdDsmPf/k9QBEgLiykwvexsQWyPDgrjqtecEMC/MEV+QPvIJBEEzZ64ot75FSTH90tc9voGTMMAmqhyO9flHKocJJ4n29gspzS8JFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFTQpBz/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFTQpBz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735284098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTdDZUtw2Ka0vLXbecitBmQbRYS1xtRV2yfPiransTE=;
	b=YFTQpBz/PClXmawjOxDNuGBHM7beTMfG2q3VPysnFjqb39AJBMqT3EQq2l0qXeMkvS5CxY
	7VEiMdIz/5y3TxISIxn3Jxmf7bAYZ5v7Xs1lwsG8XKXrpOyzSJP4aUQNlYM7vr1GrK9chn
	p6NdzGvpRqFdGLVHRnMuAk2ZgzFI5Tg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-FnxcGEYUM3qbxwEAbjnfVw-1; Fri, 27 Dec 2024 02:21:36 -0500
X-MC-Unique: FnxcGEYUM3qbxwEAbjnfVw-1
X-Mimecast-MFC-AGG-ID: FnxcGEYUM3qbxwEAbjnfVw
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21648ddd461so114598585ad.0
        for <fstests@vger.kernel.org>; Thu, 26 Dec 2024 23:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735284095; x=1735888895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTdDZUtw2Ka0vLXbecitBmQbRYS1xtRV2yfPiransTE=;
        b=vEgJgLa7/uQdBvlTHoqO4U7nfXjO8db9mZAA+HxJjv7yd37VvpCJKiBtu0IYsSEfSM
         bM3d0f1eT4mT4AUeEAnJcIc1tOiROgWDhdxcl3+v2ZlEf2emvR4dlG1QmQDYoaNnIL/e
         kuxjnS7A9zLxF9u1faZX5aTChKZaofzw/P/gFQVX/m78jsNQuBb7Gm2LgKLCc0HfKm4M
         THz/BRpxw69XPcoGbMHJTLNZiXdd+2QpLSTdW+ECsazKG86yCkvll8fpF0vga561nx9o
         m5O3p886vlwd73g5a6maVrQ4C6b+L/vuan1sGfPp8X+P9rsEYH9LqmhNHyrm5XnHL9Tw
         mwGw==
X-Forwarded-Encrypted: i=1; AJvYcCXzA5wwyhkRpQ2QSv8NUcGzy79fMs7eD8l1hgp61zGDlLhTIX9huFj5ExoPM/Qvtuxv6NYEMM8Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuw8rR7FO5so5eQAul9wy2Sj2u5mfu0nL1P0W37EQNoT1VHtjk
	I/gWiSIeXyGPbKF9UzMVnf3DtVECJWkD6z/S4ReFfcQXejGxbdb3rBxAAyS3tlQisXn2uRmLVvL
	H4GUYEs9wsiyBKPVztSP2kZGeorD22j0AYRVEqPUZZmQO69AfgA/zHVI89MWOjaU=
X-Gm-Gg: ASbGncvJXhsyx3ikHVCXkXaD8nYlppEih2nhM9vRvhNcEbPnisCWHwGiAwsVafjXJoP
	pwf9IdcbudqilcqrZUve9OYEhn0RCxzAiz5mt7MiBIaER81BQoHRkpmGbXP0Ta7o609SWOtdqFP
	RJ4JkJcKHVB94AmP8fexEJdMTVeUalZO2AaoJjb32B4QbIkFmJASaiaBtSX1uOh09+Ng2Bj2701
	QYT456ZJBTpr5EG5Vk02XBGCyN+aWCSzHt8KWYL2WnrP+0+ndaRiXiq3CRxDmxnaWVqy+kozDdw
	GVxDvu/S23F/CohVKMvDxg==
X-Received: by 2002:a05:6a20:258e:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1e5e07eed86mr37314810637.28.1735284095202;
        Thu, 26 Dec 2024 23:21:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGqtd9+hI2bhQ8GbhtjQjnJ+9D00ZELi7HpVEX5suJMoPY0wJRKzQlCNcs+NS7JZHQ4NGgqg==
X-Received: by 2002:a05:6a20:258e:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1e5e07eed86mr37314788637.28.1735284094854;
        Thu, 26 Dec 2024 23:21:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fe5fbsm14432988b3a.142.2024.12.26.23.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 23:21:34 -0800 (PST)
Date: Fri, 27 Dec 2024 15:21:30 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 2/2] f2fs/008: test snapshot creation/deletion on lvm
 device
Message-ID: <20241227072130.3spzr4hlkaqakt2x@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241221082345.196029-1-chao@kernel.org>
 <20241221082345.196029-2-chao@kernel.org>
 <20241224095821.ylfv622fifsk3tsv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <38a448c9-5cd4-482e-8411-a801995199c3@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a448c9-5cd4-482e-8411-a801995199c3@kernel.org>

On Thu, Dec 26, 2024 at 09:18:36PM +0800, Chao Yu wrote:
> On 2024/12/24 17:58, Zorro Lang wrote:
> > On Sat, Dec 21, 2024 at 04:23:45PM +0800, Chao Yu wrote:
> > > This patch introduce a regression testcase to check whether
> > > f2fs can handle discard correctly once underlying lvm device
> > > changes to not support discard after user creates snapshot
> > > on it.
> > > 
> > > Related bug was fixed by commit bc8aeb04fd80 ("f2fs: fix to
> > > drop all discards after creating snapshot on lvm device")
> > > 
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v3:
> > > - rebase to last for-next branch
> > > - update according to Zorro's comments.
> > >   tests/f2fs/008     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/f2fs/008.out |  2 ++
> > >   2 files changed, 59 insertions(+)
> > >   create mode 100755 tests/f2fs/008
> > >   create mode 100644 tests/f2fs/008.out
> > > 
> > > diff --git a/tests/f2fs/008 b/tests/f2fs/008
> > > new file mode 100755
> > > index 00000000..b85e321c
> > > --- /dev/null
> > > +++ b/tests/f2fs/008
> > > @@ -0,0 +1,57 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> > > +#
> > > +# FS QA Test No. f2fs/008
> > > +#
> > > +# This is a regression test to check whether f2fs can handle
> > > +# discard correctly once underlying lvm device changes to not
> > > +# support discard after user creates snapshot on it.
> > > +#
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest auto quick rw
> > > +
> > > +_fixed_by_kernel_commit bc8aeb04fd80 \
> > > +        "f2fs: fix to drop all discards after creating snapshot on lvm device"
> > > +
> > > +_require_scratch_nolvm
> > > +_require_block_device $SCRATCH_DEV
> > > +_require_command "$LVM_PROG" lvm
> > > +
> > > +lvname=lv_$seq
> > > +vgname=vg_$seq
> > > +testfile=$SCRATCH_MNT/testfile
> > > +
> > > +_cleanup()
> > > +{
> > > +	_unmount $SCRATCH_MNT >>$seqres.full 2>&1
> > > +	$LVM_PROG lvremove -ff /dev/mapper/$lvname-snapshot $vgname >>$seqres.full 2>&1
> > > +	$LVM_PROG lvremove -ff /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> > > +	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
> > > +	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
> > > +	_udev_wait --removed /dev/mapper/$vgname-$lvname
> > > +	cd /
> > > +	rm -f $tmp.*
> > > +}
> > > +
> > > +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> > > +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > > +$LVM_PROG lvcreate -L 1024m -n $lvname $vgname >>$seqres.full 2>&1
> > 
> > The lvcreate might be blocked by:
> >    "WARNING: f2fs signature detected on /dev/vg_008/lv_008 at offset 1024. Wipe it? [y/n]:"
> 
> Oh, I didn't encounter this... is it due to I use low version lvm tool?

I tried to run this test twice, the second test hang there, then I found it.

> 
> lvm version
>   LVM version:     2.03.11(2) (2021-01-08)
>   Library version: 1.02.175 (2021-01-08)
>   Driver version:  4.48.0
> 
> > 
> > So better to use "lvcreate -y" or "yes | ...".

`lvcreate -y` is good, but I'm not sure which lvm version starts to support
this option. So the "yes | ..." might have better compatibility.

Thanks,
Zorro

> 
> Sure.
> 
> Thanks,
> 
> > 
> > Thanks,
> > Zorro
> > 
> > > +_udev_wait /dev/mapper/$vgname-$lvname
> > > +
> > > +_mkfs_dev /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> > > +_mount -o discard /dev/mapper/$vgname-$lvname $SCRATCH_MNT >>$seqres.full 2>&1
> > > +
> > > +dd if=/dev/zero of=$testfile bs=1M count=20 >>$seqres.full 2>&1
> > > +sync
> > > +rm -f $testfile
> > > +sync
> > > +
> > > +# create a snapshot on lvm device
> > > +$LVM_PROG lvcreate -L 1024m -s -n $lvname-snapshot /dev/mapper/$vgname-$lvname >>$seqres.full 2>&1
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +status=0
> > > +exit
> > > diff --git a/tests/f2fs/008.out b/tests/f2fs/008.out
> > > new file mode 100644
> > > index 00000000..dd68d5a4
> > > --- /dev/null
> > > +++ b/tests/f2fs/008.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 008
> > > +Silence is golden
> > > -- 
> > > 2.40.1
> > > 
> > 
> 

