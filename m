Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0379DC
	for <fstests@vger.kernel.org>; Sun,  4 Feb 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707030975; cv=none; b=pntuximeqcrMq4nVigBVg/tVzS5O4pg7IoOVIq3/f/aNvAedVYIHZJ1VJ6rREUvvwLC23djgLe8UvB2Lk06g+bTGYRbsYv2fD9/ZUcCW7/OfXdIdVBbJBs/2VMTsyHKtMMT0LDN3Gw51hcaYJcAVRcZiLw2YqViqsw1KCfsx+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707030975; c=relaxed/simple;
	bh=dYeOQG+QUHxdtjaxKBk9OOGcGFH7+9lzVPeiLo6Ynl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj/uMK4UfW30Cf3fWI92rB1fi7daJkw+jjZAsqAtQzmrz7ROx5H5TkdySAKbgJ/jKQib2rpe4qwTBonu5BrQcOdNf96v+Fz4mT3/ybz5MTa8D5n0ErhBqGrp+Pyxm3339rCdGH/NfxHOWpCdGNwhdrsGvA+54skFRBfkXAE1IWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9u65cXO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9u65cXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707030972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlK3YajkS6vAuRFI/v29CUReV4AqGYEhTRG/C9e3Odk=;
	b=h9u65cXOFc3hTzjR6Ldgs3TueUlXnM3bJOZ8ojikqXag48VoE6q9j5nJ66ABhNs7uPEBbd
	S5fWF6cynkbTd79s2lze6U99Z3Qni9E+/RAhgWfMCkE2MJLPuAD+dtlEiCS7e1qLnt0gTh
	M6yR21qcfEw7GXDaA/vFkaf5d7w4P78=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-mKUpf5RgPjmDubv3sjl1gA-1; Sun, 04 Feb 2024 02:16:11 -0500
X-MC-Unique: mKUpf5RgPjmDubv3sjl1gA-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6e03bf3e3b0so178799b3a.1
        for <fstests@vger.kernel.org>; Sat, 03 Feb 2024 23:16:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707030970; x=1707635770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlK3YajkS6vAuRFI/v29CUReV4AqGYEhTRG/C9e3Odk=;
        b=i3EvEYlFRuEoLkjNS2YNWq2rt0AFJ0H7F08+eE8pgiN5eihctDN6Xpqlr5YKh0fKuS
         kArZhdPP6oNA9mmFgRzTM+pkY4/n4LnsABd9aXHesrWZuPrpNZXYWRl+1dU66PaIgLjW
         e7lFGzL4q06L+r6sCPa3Y+qPy1e1NYoAHBRlsyQwf013cQFwQhEY6iO2I4/JYsvBjwQV
         Qn4M4+wygLLxPoYKaM/+Q6WRcfXW7hD7v18feHyK+nekJzXZh6jDZEOw2WHryEH/tByM
         5AQsjZ9E/Y1iHZ2WN6mzCrJpbblPGOIUovQxZP9qHEk5vrNRj3Es7cv+AOgYiHUoh4AZ
         4Zbg==
X-Gm-Message-State: AOJu0YwFZ1VS7AhPc3yR5yVHdceUqQT17OkxpOwNpkeLoSc8h/W5lRmi
	Bu1wBN56gZahVKj+S014p1Dj4OM0V4NWjiWy9S562TivwK9aBIqkW6fAyRBWQbnLFsE4RKssmCP
	OO2GGs2PRbpfwIVcDn56uay/JLqzOwuVD3i0M9R5Vkb+i+8uhSSCwOlc=
X-Received: by 2002:a62:ab04:0:b0:6da:ed17:bfa7 with SMTP id p4-20020a62ab04000000b006daed17bfa7mr2780472pff.6.1707030970395;
        Sat, 03 Feb 2024 23:16:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz/NKkl+W2C5dKEdzs7ZlWJPOOhNuQ8E4n6DDL8xAVhQIZcdfQ9KblOK/7Yvm0v007PhT/Sw==
X-Received: by 2002:a62:ab04:0:b0:6da:ed17:bfa7 with SMTP id p4-20020a62ab04000000b006daed17bfa7mr2780456pff.6.1707030970006;
        Sat, 03 Feb 2024 23:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXms7r7HKG+sNWXoTWgqWUwNJTr8YYCEs5aVdj2A6Db4W4Ct4fbKRRyTxejE9gxRhYinyEgx1zfbLZPUVRj9ODjknvSwJYSUS9NLVusVYJKvDUnCePVQlcNVptjqK7vWrzM1cxDR/R5IRU=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm4490513pfe.19.2024.02.03.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 23:16:09 -0800 (PST)
Date: Sun, 4 Feb 2024 15:16:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>,
	kernel-team@fb.com, fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs: Remove btrfs/303
Message-ID: <20240204071605.qt6famqusr7til43@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
 <20240202131120.q35fe45cmu5e3dqz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7MsG8pLsrEeKOhtXPMw3psw3pFbTTn5k-LGLxLo2oCBg@mail.gmail.com>

On Fri, Feb 02, 2024 at 02:51:09PM +0000, Filipe Manana wrote:
> On Fri, Feb 2, 2024 at 1:11 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Tue, Jan 23, 2024 at 11:56:59AM -0800, Boris Burkov wrote:
> > > This test was reproducing a bug triggered by creating a subvolume qgroup
> > > before creating the subvolume itself with a snapshot.
> > >
> > > The kernel patch:
> > > btrfs: forbid creating subvol qgroups
> > >
> > > explicitly prevents that and makes it fail with EINVAL. I could "fix"
> > > this test by expecting the EINVAL message in the output, but at that
> > > point it would simply be a test that creating a subvolume and
> > > snapshotting it works with qgroups, which is adequately tested by other
> > > tests which focus on accurately measuring shared/exclusive usage in
> > > various snapshot/reflink scenarios. To avoid confusion, I think it is
> > > best to simply delete this test.
> > >
> > > Signed-off-by: Boris Burkov
> > > ---
> >
> > Just a reminder, this's a test deletion. To avoid test coverage decrease,
> > I'd like to give it more time to get more reviewing of btrfs list. If no
> > one has any concern, I'll merge it :)
> 
> It's fine, it's the right thing to do.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

OK, thanks, I think two RVBs without any objection is good to this patch, I'll
merge it.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > >  tests/btrfs/303     | 77 ---------------------------------------------
> > >  tests/btrfs/303.out |  2 --
> > >  2 files changed, 79 deletions(-)
> > >  delete mode 100755 tests/btrfs/303
> > >  delete mode 100644 tests/btrfs/303.out
> > >
> > > diff --git a/tests/btrfs/303 b/tests/btrfs/303
> > > deleted file mode 100755
> > > index 410460af5..000000000
> > > --- a/tests/btrfs/303
> > > +++ /dev/null
> > > @@ -1,77 +0,0 @@
> > > -#! /bin/bash
> > > -# SPDX-License-Identifier: GPL-2.0
> > > -# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > > -#
> > > -# FS QA Test 303
> > > -#
> > > -# A regression test to make sure snapshot creation won't cause transaction
> > > -# abort if there is already an existing qgroup.
> > > -#
> > > -. ./common/preamble
> > > -_begin_fstest auto quick snapshot subvol qgroup
> > > -
> > > -. ./common/filter
> > > -
> > > -_supported_fs btrfs
> > > -_require_scratch
> > > -
> > > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > -     "btrfs: do not abort transaction if there is already an existing qgroup"
> > > -
> > > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > -_scratch_mount
> > > -
> > > -# Create the first subvolume and get its id.
> > > -# This subvolume id should not change no matter if there is an existing
> > > -# qgroup for it.
> > > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> > > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > > -     "$SCRATCH_MNT/snapshot">> $seqres.full
> > > -
> > > -init_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > > -
> > > -if [ -z "$init_subvolid" ]; then
> > > -     _fail "Unable to get the subvolid of the first snapshot"
> > > -fi
> > > -
> > > -echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
> > > -
> > > -_scratch_unmount
> > > -
> > > -# Re-create the fs, as btrfs won't reuse the subvolume id.
> > > -_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
> > > -_scratch_mount
> > > -
> > > -$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
> > > -_qgroup_rescan $SCRATCH_MNT >> $seqres.full
> > > -
> > > -# Create a qgroup for the first subvolume, this would make the later
> > > -# subvolume creation to find an existing qgroup, and abort transaction.
> > > -$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seqres.full
> > > -
> > > -# Now create the first snapshot, which should have the same subvolid no matter
> > > -# if the quota is enabled.
> > > -$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
> > > -$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
> > > -     "$SCRATCH_MNT/snapshot" >> $seqres.full
> > > -
> > > -# Either the snapshot create failed and transaction is aborted thus no
> > > -# snapshot here, or we should be able to create the snapshot.
> > > -new_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
> > > -
> > > -echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
> > > -
> > > -if [ -z "$new_subvolid" ]; then
> > > -     _fail "Unable to get the subvolid of the first snapshot"
> > > -fi
> > > -
> > > -# Make sure the subvolumeid for the first snapshot didn't change.
> > > -if [ "$new_subvolid" -ne "$init_subvolid" ]; then
> > > -     _fail "Subvolumeid for the first snapshot changed, has ${new_subvolid} expect ${init_subvolid}"
> > > -fi
> > > -
> > > -echo "Silence is golden"
> > > -
> > > -# success, all done
> > > -status=0
> > > -exit
> > > diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> > > deleted file mode 100644
> > > index d48808e60..000000000
> > > --- a/tests/btrfs/303.out
> > > +++ /dev/null
> > > @@ -1,2 +0,0 @@
> > > -QA output created by 303
> > > -Silence is golden
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> 

