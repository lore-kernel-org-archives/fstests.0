Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797E2D640E
	for <fstests@vger.kernel.org>; Wed,  1 Oct 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351825; cv=none; b=U0VxTUf3l0TKS4RgXcreCHyXvkJlaTPKNFmTLjv0sqT7YPCMb71Hj+nD5xL1icFb/JGxipy+6sG/vkQZ0bxfbcEkZnN5IP2qRM0tNKFkFla2lQmj0uHrEIPWFVnk8H6nJR4mXPONjIICxoOQ/S8KVIkkUXjFmOLAxqTJSngM1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351825; c=relaxed/simple;
	bh=gBW9n3UmTPGAQUDi+gbNyfb55lgWozTxwk93rb0G4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbfzhnyjJDr6kAonWQ6d1IMw5GodtHKaXjvCRhXlbH3oYQuxAo858O7kHpia2VN0RRqBNksjnT3ojOzD5qe82aXVxay/pjMUZqA8Sr3L9HPNTF6hOxRrVgjXOIzVSCANfvr1e4VpyezO8ynKIUevgtpQFw+TqPwX5cJvreO0vMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvEPvh5t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvEPvh5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759351821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU4OUGmDueHDubH6UYEl/dqcmZLyHQrJAoBxNBC66X4=;
	b=HvEPvh5tDBhJxqrhctvI7mePMscHMO4seEhQG30rbaEx7n7YnNU/Tzbd79CXPfqvFr58MU
	9iYgiidKF3OzHRIU85X3sPMXlD1yZDigWxiaOA+fZMw/k5hFDUSWLec2q2S8NXg2nqdQWE
	YB0YOlBTnrwB/lUky6KbVUNk9vKQ9zs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-YZTd3RnuOdyr_Eygz57bHg-1; Wed, 01 Oct 2025 16:50:17 -0400
X-MC-Unique: YZTd3RnuOdyr_Eygz57bHg-1
X-Mimecast-MFC-AGG-ID: YZTd3RnuOdyr_Eygz57bHg_1759351817
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55735710f0so351429a12.2
        for <fstests@vger.kernel.org>; Wed, 01 Oct 2025 13:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759351817; x=1759956617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU4OUGmDueHDubH6UYEl/dqcmZLyHQrJAoBxNBC66X4=;
        b=YldXwWcOU0Mduzxg5HNDDuRPq/28DD9ROrf9/dQ8h/q0EYCcnXOIOQTJ0zOS4Lfsv1
         dLhblVgylKRhvxrkvIVEYI+4hL7JbG0Wp+3ATSgXfGTjgBkda+NE0tyLR2lJV8j82hvy
         xCHd/unxpe9QHdlzmgAsnbofvvFFWiWHdRoTz1fvRAhrz6vjghts6ToJw7vBrj/Zodmi
         Z7Y7GRQyDi3fBsSwFJS/bqEnRgbQlgKs1GgXETywd6v5K6Oe+BosIm2JgKcgE/Jm0u9f
         gTuK/lGE4dJLSUmyNsRTxBhCznNyWmtZK9ZhT9dkJdicamfMXQNI9/bgTKEYMUeceqRe
         bx6g==
X-Forwarded-Encrypted: i=1; AJvYcCWPsIHhZoYnMiR3/VhJckGaYtmivr2hGU2PvT0O+vxQ3/+JtRPYGkh484qi54OcvRwTlSvk/cSp@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQT8vkDJdefkbF9ZQq8PnfR7NHUdF7W4qKNe/DmCl8ruRgVTL
	Nz0ES2Px8UrK2JUslfN1G/RAw2zZGTxIZdc8KjLNFiNb2s7CWuhRbVVjv0VTsA4Lch3JwAyln3L
	6VmL+BGYgn/bcg+gRIg0MRqk1ZIIeqHAifsalZ7EL0DLGpdnYDzFH/FCDnnI=
X-Gm-Gg: ASbGnctwtCbgV7jGbtCkNgZ1wGiMuQEeJLTlymdkb/b5WiQFYgY15tE9Fih+hJ4IZ+7
	tt2DQxei3vlfYKVIPrM7BraNZyux052vIRQh4eWM3wsf/ufc5X8UVEDCHXJBaJH77C40Y/sGnmu
	CcHFQGg7lc61LSD+nAQgX0CxXquwy9C3DO+LTL0HMkShI7EnnrkJG+2QDwfByNbUJecvsXZwXXQ
	HZ/rvYHosS5mD/Sctmx4j1TJf6BusswBW0ZRjn63ScHcC7eiscBbnxM65D2Li/U1B1Ut51GgJLo
	/z7B1f70GEvjG8YUAppGKP1EGOXp5vduGIE9MMA4Gi1DFOA7DfxmY7Zgr6ZGqWhClAGJo3ct1LD
	GrpABk9ma+w==
X-Received: by 2002:a05:6a20:9143:b0:246:7032:2c1d with SMTP id adf61e73a8af0-321d1e6274bmr7130197637.23.1759351816468;
        Wed, 01 Oct 2025 13:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGod+bCznb818N+m/C20fkkTWwDBMqUXtmxkwzz5AMzxnmucX2zTYVkikM9vyHpeXECWzMLdA==
X-Received: by 2002:a05:6a20:9143:b0:246:7032:2c1d with SMTP id adf61e73a8af0-321d1e6274bmr7130165637.23.1759351815891;
        Wed, 01 Oct 2025 13:50:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4cfbesm375872a12.28.2025.10.01.13.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 13:50:15 -0700 (PDT)
Date: Thu, 2 Oct 2025 04:50:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't
 support the block size
Message-ID: <20251001205011.dgi6w3fr5udkcx55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250918224327.12979-1-wqu@suse.com>
 <20250918224327.12979-2-wqu@suse.com>
 <20250928145453.wyztv2kvfpgmlw3k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <471b4e77-a89a-4cc2-aafe-0c04e36036c9@gmx.com>

On Mon, Sep 29, 2025 at 06:12:17AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/9/29 00:24, Zorro Lang 写道:
> > On Fri, Sep 19, 2025 at 08:13:25AM +0930, Qu Wenruo wrote:
> > > [FALSE ALERT]
> > > When testing btrfs bs > ps support, the test cases btrfs/012 and
> > > btrfs/136 fail like the following:
> > > 
> > >   FSTYP         -- btrfs
> > >   PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
> > >   MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> > >   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> > > 
> > >   btrfs/012       [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/012.out.bad)
> > >       --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
> > >       +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:32:55.185922173 +0930
> > >       @@ -1,7 +1,11 @@
> > >        QA output created by 012
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +mkdir: cannot create directory '/mnt/scratch/stressdir': File exists
> > >       +umount: /mnt/scratch: not mounted.
> > >        Checking converted btrfs against the original one:
> > >       -OK
> > >       ...
> > >       (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/xfstests/results//btrfs/012.out.bad'  to see the entire diff)
> > > 
> > >   btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/136.out.bad)
> > >       --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
> > >       +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:00:00.395280850 +0930
> > >       @@ -1,2 +1,10 @@
> > >        QA output created by 136
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +umount: /mnt/scratch: not mounted.
> > >       +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
> > >       +       dmesg(1) may have more information after failed mount system call.
> > >       +umount: /mnt/scratch: not mounted.
> > >       ...
> > >       (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/xfstests/results//btrfs/136.out.bad'  to see the entire diff)
> > > 
> > > [CAUSE]
> > > Currently ext* doesn't support block size larger than page size, thus
> > > at mkfs time it will output the following warning:
> > > 
> > >   Warning: blocksize 8192 not usable on most systems.
> > >   mke2fs 1.47.3 (8-Jul-2025)
> > >   Warning: 8192-byte blocks too big for system (max 4096), forced to continue
> > > 
> > > Furthermore at ext* mount time it will fail with the following dmesg:
> > > 
> > >   EXT4-fs (loop0): bad block size 8192
> > > 
> > > [FIX]
> > > Check if the mount of the newly created ext* succeeded.
> > > 
> > > If not, since the only extra parameter for mkfs is the block size, we
> > > know it's some block size ext* not yet supported, and skip the test
> > > case.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/012 | 3 +++
> > >   tests/btrfs/136 | 3 +++
> > >   2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/tests/btrfs/012 b/tests/btrfs/012
> > > index f41d7e4e..665831b9 100755
> > > --- a/tests/btrfs/012
> > > +++ b/tests/btrfs/012
> > > @@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >   	_notrun "Could not create ext4 filesystem"
> > >   # Manual mount so we don't use -t btrfs or selinux context
> > >   mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
> > > +if [ $? -ne 0 ]; then
> > > +	_notrun "block size $BLOCK_SIZE is not supported by ext4"
> > > +fi
> > 
> > Hmm... the mount failure maybe not caused by the "$BLOCK_SIZE is not supported",
> > I'm wondering if this _notrun might ignore real bug. How about check the
> > "blocksize < pagesize" at least?
> 
> The only extra parameter passed to mkfs.ext* is "-b $BLOCKSIZE", and if it's
> really some bug inside e2fsprog and it only affects bs > ps, we're still
> going to miss the bug.
> 
> Is there any proper way to reliably check the supported block size of ext*?
> Like some sysfs knobs?

If there's not a proper way to check ext4 supports LBS, how about check
blocksize < pagesize" before _notrun directly, e.g:

  pz=$(_get_page_size)
  if [ $? -ne 0 -a $BLOCKSIZE -gt $pz ]

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > >   echo "populating the initial ext fs:" >> $seqres.full
> > >   mkdir "$SCRATCH_MNT/$BASENAME"
> > > diff --git a/tests/btrfs/136 b/tests/btrfs/136
> > > index 65bbcf51..6b4b52e4 100755
> > > --- a/tests/btrfs/136
> > > +++ b/tests/btrfs/136
> > > @@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
> > >   # mount and populate non-extent file
> > >   mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
> > > +if [ $? -ne 0 ]; then
> > > +	_notrun "block size $BLOCK_SIZE is not supported by ext3"
> > > +fi
> > >   populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
> > >   _scratch_unmount
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> > 
> 

