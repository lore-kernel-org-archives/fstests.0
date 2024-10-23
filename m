Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7102A48
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729653010; cv=none; b=eRcnSsRkUn0cKU60o82LEqAMAo8ueHxjIIn9pung314HGBYS0YHnqSL8s2rp41oMZCtUHbM+fPBd08UPOc0HaJ+Ws2w91uA9AguzCgBtdKiNAu9o9q8JKkalQkw3UUsTzGLz8yPHmo2DiF2u7a3u3RAAPB75I/+h+gz0+f+NZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729653010; c=relaxed/simple;
	bh=cdVYzxA9V0mqTvdRL5WzspOt0khZ+4J6SlntaCXK0nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJCbRizphRv0d33M3QR4e5Ien+W5Etrk8nd/A9v32tlQodVRIdmIQD+OEgdayBlI5/69OeC9dVRZF/KJk6Ml4XX0UQhgToonXZyFBt188H6y2Y3lXyRiUBfTqz3l9nAN+UdQLzFyHQxVyQ2ZBkerZgkcyDLZSsq2UDGHfmArl4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUPkfmW0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUPkfmW0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729653006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ChFLDrze5/mqU1OQW4F/3+zfzN2ESjZs15mIH13gjY8=;
	b=gUPkfmW0tDlEmXJgpp6cLIZMeYQs7lK9Lh3hzv53k9I7W95FANyy2lWgIYTRGEw5eKHEuc
	RSFN3rZc21AlW4H9ImeooQBezmRnwolACCkNeK2z2KcMOtcYD3p1WxQ7RGmJTknIgR1v+1
	lgBrwAQBDNrOPOgrEm2aJwCTSNMfkYc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-OF2YYBYmM_mD1m0YXDeLfg-1; Tue, 22 Oct 2024 23:10:05 -0400
X-MC-Unique: OF2YYBYmM_mD1m0YXDeLfg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20e56815e1cso63692485ad.3
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 20:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729653004; x=1730257804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChFLDrze5/mqU1OQW4F/3+zfzN2ESjZs15mIH13gjY8=;
        b=tLD1OzVoSqoGyb8rUrCpLh86hc4Mm2GeOJ5fdT0Lx+Ozt9QrXLGls0+f6SQpAdJl0N
         PVeL9w1TJGkKbHaj3MbXIk6NUOWoRlgBD98FX/UNccLWUE8mzdkPKZtQDrxVBBc1dXg6
         Xlee9iQUkKyUDMf0x5cEpBQ2O28g/q2sTFLak44yOJu8sjZbWiyTVQbQCnCzz7Mm+Mbg
         OUjwT4NpCxCWIu6QZHmGFUeQ3RDeO2zCO71r7kFHQOA9L+gT/kzpcK3Bl/+0Y/5mFdZd
         slRSzuJP+rbxlzLd2kK0oIIonbtJS5yqAS2Dau4lJ3wilrS4WxmyNFbyhVauDAfphoth
         w0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnbvcoZM2DMKFaZt/+HKB11UhSaXIMOaW1Aj2oO4aksPYLE8cIq+KBtaYJ0CeJhlZ1IwDshPqa@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCW7nOX2SYIAk7irdzjAaTfo/In4hWlNVAhW/ulBKs0FV790U
	Md3s3JWZ0lbEhGsByb7ddocCN1eB30QZHvOWcqOyMcqOBfC1ocVJrXnzScrwQtAlXusbAM5ZUzB
	l+xGJ4c7KOhENhVFgipWJPR8xfg5h4solOOCJSnO0xys3DMC1LRm7Kzw=
X-Received: by 2002:a17:902:ce88:b0:20c:a44b:3221 with SMTP id d9443c01a7336-20fa9dfebdbmr20107155ad.15.1729653004084;
        Tue, 22 Oct 2024 20:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqwBzYOQQDsSCIZb3ftnY/93Ymddn4E8R4OUmogkkBqai5duRoFN+bqyo9b7IHOnmD6WF4mQ==
X-Received: by 2002:a17:902:ce88:b0:20c:a44b:3221 with SMTP id d9443c01a7336-20fa9dfebdbmr20106995ad.15.1729653003735;
        Tue, 22 Oct 2024 20:10:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd367sm49175955ad.146.2024.10.22.20.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:10:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:09:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3] btrfs: add test for cleaner thread under seed-sprout
Message-ID: <20241023030958.c5beiy5uwzpn62l7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20ebca40c55ed9207b6ea77aa50e93f3baf698ad.1729101127.git.boris@bur.io>
 <ef523540-c7b3-4827-ae9f-ea55130f5060@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef523540-c7b3-4827-ae9f-ea55130f5060@oracle.com>

On Sat, Oct 19, 2024 at 06:19:20AM +0800, Anand Jain wrote:
> On 17/10/24 01:54, Boris Burkov wrote:
> > We have a longstanding bug that creating a seed sprout fs with the
> > ro->rw transition done with
> > 
> > mount -o remount,rw $mnt
> > 
> > instead of
> > 
> > umount $mnt
> > mount $sprout_dev $mnt
> > 
> > results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
> > critical btrfs cleaner thread.
> > 
> > This test reproduces that bug and detects it by creating and deleting a
> > subvolume, then triggering the cleaner thread. The expected behavior is
> > for the cleaner thread to delete the stale subvolume and for the list to
> > show no entries. Without the fix, we see a DELETED entry for the subvol.
> > 
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v3:
> > - add volume group
> > - switch to SCRATCH_DEV/SPARE_DEV
> > - filter scratch devs from mount/findmnt output instead of suppressing.
> >    This adds the expected read only message that comes with mounting seed
> >    devices to the golden output, and makes the ro/rw check more natural.
> > v2:
> > - update to real copyright info
> > - add extra rw->ro transition checks
> > - remove unnecessary _require_test
> > ---
> >   tests/btrfs/323     | 47 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/323.out |  4 ++++
> >   2 files changed, 51 insertions(+)
> >   create mode 100755 tests/btrfs/323
> >   create mode 100644 tests/btrfs/323.out
> > 
> > diff --git a/tests/btrfs/323 b/tests/btrfs/323
> > new file mode 100755
> > index 000000000..4e389d66a
> > --- /dev/null
> > +++ b/tests/btrfs/323
> > @@ -0,0 +1,47 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 323
> > +#
> > +# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick seed remount
> 
> volume
> 
> Zorro, can you pls add it while merging.

Sure, thanks Anand!

> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Thanks
> Anand
> 
> 
> > +
> > +. ./common/filter
> > +_require_command "$BTRFS_TUNE_PROG" btrfstune
> > +_require_scratch_dev_pool 2
> > +
> > +_fixed_by_kernel_commit XXXXXXXX \
> > +	"btrfs: do not clear read-only when adding sprout device"
> > +
> > +_scratch_dev_pool_get 1
> > +_spare_dev_get
> > +
> > +# create a read-only fs based off a read-only seed device
> > +_scratch_mkfs >>$seqres.full
> > +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> > +_scratch_mount 2>&1 | _filter_scratch
> > +_btrfs device add -f $SPARE_DEV $SCRATCH_MNT >>$seqres.full
> > +
> > +# switch ro to rw, checking that it was ro before and rw after
> > +findmnt -n -O ro -o TARGET $SCRATCH_MNT | _filter_scratch
> > +_mount -o remount,rw $SCRATCH_MNT
> > +findmnt -n -O rw -o TARGET $SCRATCH_MNT | _filter_scratch
> > +
> > +# do stuff in the seed/sprout fs
> > +_btrfs subvolume create $SCRATCH_MNT/subv
> > +_btrfs subvolume delete $SCRATCH_MNT/subv
> > +
> > +# trigger cleaner thread without remounting
> > +_btrfs filesystem sync $SCRATCH_MNT
> > +
> > +# expect no deleted subvolumes remaining
> > +$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
> > +
> > +_spare_dev_put
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> > new file mode 100644
> > index 000000000..1ca2e4b13
> > --- /dev/null
> > +++ b/tests/btrfs/323.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 323
> > +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> > +SCRATCH_MNT
> > +SCRATCH_MNT
> 
> 

